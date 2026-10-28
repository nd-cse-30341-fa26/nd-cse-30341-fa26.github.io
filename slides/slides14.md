---
title: "Slides 14: Free-Space Management, Heap Allocation"
description: "Free-Space Management, Heap Allocation"
author: Peter Bui
keywords: lecture,osp,address space,free-space management,heap allocation
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides14.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Free-Space Management,<br>Heap Allocation

---

# Questions

<div class="font-large">

1. Who needs to <strong class="caution">keep track of memory</strong>?

2. What <strong class="primary">data structures</strong> do we use to <strong
   class="caution">keep track of memory</strong>?

3. What are some <strong class="special">strategies</strong> for <strong
   class="caution">managing memory</strong>?

</div>

---

# Review: <span class="gold">Hardware Support</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="info">Hardware</span>

Provides specialized <strong class="special">hardware (MMU)</strong> that
translates <strong class="success">virtual address</strong> to <strong
class="info">physical address</strong>:

- Checks boundaries

- Triggers <strong class="danger">exceptions</strong>

</div>

<div class="margin-top-0-5">

## <span class="warning">Base and Bounds</span>

A simple mechanism is having a <strong class="warning">base register</strong>
and a <strong class="warning">bounds register</strong>:

<strong class="info">Physical Address</strong> = <strong
class="warning">Base</strong> + <strong class="success">Virtual
Address</strong>

<div class="centered">

<i>This allows us to <strong class="success">dynamically relocate</strong> a
process to anywhere in memory.</i>

</div>

</div>

</div>

---

# Review: <span class="gold">OS Responsibilities</span>

<table class="bordered font-smaller">
<thead>
<th class="info-bg">Responsibility</td>
<th class="info-bg">Notes</td>
</thead>
<tbody>
<tr>
<td class="success-bg"><b>Memory Accounting</b></td>
<td class="success-bg">

- Allocate memory for new **processes**

- Reclaim memory from terminated **processes**

- Use a **data structure** to track allocations

</td>
</tr>
<tr>
<td class="caution-bg"><b>Hardware Management</b></td>
<td class="caution-bg">

- Save and restore hardware information during a **context switch**

</td>
</tr>
<tr>
<td class="danger-bg"><b>Exception Handling</b></td>
<td class="danger-bg">

- Register **exception** handler on bootup

- Handle **exception** on invalid memory access

</td>
</tr>
</tbody>
</table>

---

# Challenge: <span class="gold">External Fragmentation</span>

Because memory is divided into blocks, we may have <strong class="danger">non-contiguous free
space</strong>.

<br>

<div class="centered">

<img src="static/img/slides14-external-fragmentation.svg">

</div>

<div class="centered">

Not enough <strong class="danger">contiguous space</strong> in a single block although we have
enough <strong class="success">free space</strong> overall.

<i><strong class="danger">External Fragmentation</strong> = <b>1 - (Largest
Free Block / All Free Space)</b></i>

</div>

---

# Challenge: <span class="gold">Internal Fragmentation</span>

Suppose we <strong class="caution">over-allocate</strong> a block (*for
alignment, optimization, etc.*).

<br>

<div class="centered">

<img src="static/img/slides14-internal-fragmentation.svg">

</div>

<div class="centered">

We <strong class="danger">waste space</strong> due to <strong
class="caution">over-allocation</strong>.

<i><strong class="warning">Internal Fragmentation</strong> = <b>All Unused / Heap Size</b></i>

</div>

---

# Mechanisms: <span class="gold">Splitting & Coalescing</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="special">Splitting</span>

Instead of always asking for more memory, we can <strong
class="special">reuse</strong> a block of free space.

<br>

<div class="centered">

<img src="static/img/slides14-splitting.svg">

</div>

</div>

<div class="margin-top-0-5">

## <span class="comment">Coalescing</span>

When we free memory, we can check if there are contiguous free blocks and
<strong class="comment">coalesce</strong> or <strong
class="comment">merge</strong> them.

<div class="centered">

<img src="static/img/slides14-merging.svg">

</div>

</div>

</div>

---

<!-- _class: lead -->

# Free List

---

# Free List: <span class="gold">Overview</span>

To track all of the block allocations, we can use a <strong
class="primary">free list</strong>, which is a <strong class="primary">linked
list</strong> of all the space reservations (*can contain both <strong
class="caution">active</strong> and <strong class="success">free</strong>
blocks or just the <strong class="success">free</strong> blocks*).

- <strong class="caution">Operating system</strong> must track <strong
  class="info">system memory</strong> allocations.

- Individual <strong class="success">processes</strong> must also keep track of
  <strong class="success">heap allocations</strong>.

- Must be wary of <strong class="danger">fragmentation</strong>.

---

# Free List: <span class="gold">Block Structure</span>

<div class="columns-2-1">

<div>

We can view memory as <strong class="info">one large array</strong>.  To keep
track of allocated blocks, we <strong class="caution">embed</strong> a <strong
class="success">block header</strong> in front of each block:

```c
typedef struct block block;

struct block {
    size_t  size; /* Size of data allocation */
    block * next; /* Pointer to next block */
    bool    free; /* Whether or not block is free */
};
```

</div>

<div class="centered">

<img src="static/img/slides14-block-structure.svg">

</div>

</div>

---

# Free List: <span class="gold">Allocation</span>

<div class="columns-2-1">

<div>

Whenever we get a <strong class="warning">request</strong> for memory, we must reserve a
block:

> If a <strong class="caution">previously allocated block</strong> is <strong
> class="success">free</strong> and <strong class="success">large
> enough</strong>, we can use that one.  Otherwise, we need to <strong
> class="warning">allocate</strong> a new block.

Whenever we <strong class="warning">release</strong> memory, we simply mark that block as
<strong class="success">free</strong>.

</div>

<div class="centered">

<img src="static/img/slides14-block-structure.svg">

</div>

</div>


---

# Free List: <span class="gold">First Fit</span>

<div class="columns-3-1">

<div>

When searching for a <strong class="success">free block</strong>, we can:

> Find the <strong class="caution">first block that is big enough</strong> and
> return that block to the user.

<br>

<div class="alert info-bg">

To allocate a `12 byte` block, we would use <strong class="warning">Block
A</strong> (*fast, but possibly sub-optimal*).

</div>

</div>

<div class="slide-centered">

<img src="static/img/slides14-first-fit.svg">

</div>

</div>

---

# Free List: <span class="gold">Next Fit</span>

<div class="columns-3-1">

<div>

When searching for a <strong class="success">free block</strong>, we can:

> <strong class="caution">Keep track of the last block we search</strong>, and perform
> <strong class="special">First Fit</strong> from there.

<br>

<div class="alert info-bg">

To allocate a `12 byte` block, if we last searched <strong class="warning">Block A</strong>,
we would use <strong class="warning">Block B</strong> (*fast, better distribution, but still
sub-optimal*).

</div>

</div>

<div class="slide-centered">

<img src="static/img/slides14-next-fit.svg">

</div>

</div>

---

# Free List: <span class="gold">Best Fit</span>

<div class="columns-3-1">

<div>

When searching for a <strong class="success">free block</strong>, we can:

> Search all free blocks for the <strong class="caution">best possible fit</strong>.

<br>

<div class="alert info-bg">

To allocate a `12 byte` block, we would use <strong class="caution">Block C</strong>
(*optimal, but slow and prone to many holes*).

</div>

</div>

<div class="slide-centered">

<img src="static/img/slides14-best-fit.svg">

</div>

</div>

---

# Free List: <span class="gold">Worst Fit</span>

<div class="columns-3-1">

<div>

When searching for a <strong class="success">free block</strong>, we can:

> Search all free blocks for the <strong class="caution">worst possible
> fit</strong> (<b><i class="muted">largest fit</i></b>).

<br>

<div class="alert info-bg">

To allocate a `12 byte` block, we would use <strong class="warning">Block
B</strong> (*non-optimal but avoids having many small gaps, slow*).

</div>

</div>

<div class="slide-centered">

<img src="static/img/slides14-next-fit.svg">

</div>

</div>

---

# Free List: <span class="gold">Segregated Lists</span>

Instead of having a single <strong class="primary">free list</strong>, we can have
<strong class="caution">separate lists</strong> for common object sizes:

> Requests for these common object sizes come from these <strong
> class="caution">segregated lists</strong>, while everything else comes from
> the <strong class="primary">general memory allocator</strong>.

- <strong class="success">Pro</strong>: <strong class="danger">External
  fragmentation</strong> is less of a concern and management is fast.

- <strong class="danger">Con</strong>: Additional complications, <strong
  class="warning">internal fragmentation</strong>.

---

<!-- _class: lead -->

# Heap Allocation

---

# Heap Allocation: <span class="gold">Overview</span>


<div class="columns-2-3">

<div>

The <strong class="success">heap</strong> inside the <strong class="success">address space</strong> of each
<strong class="success">process</strong> must be managed:


- The <strong class="caution">kernel</strong> keeps track of memory across all
  <strong class="success">processes</strong>.

- <strong class="warning">malloc</strong> keeps track of <strong
  class="success">heap</strong> memory for each <strong
  class="success">process</strong>.

<div class="alert info-bg centered">

We can use a <strong class="primary">free list</strong> to manage the <strong
class="success">heap</strong>.

</div>

</div>

<div class="slide-centered">

<img src="static/img/slides13-address-space-virtualization.svg">

</div>

</div>

---

# Heap Allocation: <span class="gold">sbrk</span>

To request memory from the <strong class="caution">kernel</strong>, we can use the [sbrk]
<strong class="warning">system call</strong>.

<br>

<div class="columns-1-1-1">

<div class="middled">

```c
// Get end of heap
void *curr = sbrk(0);
```

</div>

<div class="middled centered">

<img src="static/img/slides14-sbrk.svg">

</div>

<div class="middled">

```c
// Grow heap
void *prev = sbrk(16);
```

</div>

</div>

[sbrk]: https://man7.org/linux/man-pages/man2/brk.2.html

---

# Heap Allocation: [malloc0.c] (<i class="muted">Basic</i>)

<div class="columns">

<div>

```c
void *malloc(size_t size) {
    void *block = sbrk(size);

    if (block == (void *)-1) {
        return NULL;
    }

    return block;
}

void free(void *ptr) {
}
```

</div>

<div class="middled">

<br>

<div class="alert success-bg">

- Simple, but fast and *works*!

</div>

<br>

<div class="alert danger-bg">

- Doesn't actually keep **track** of anything

- Doesn't **release** memory

- Doesn't keep blocks **aligned**

</div>

</div>

</div>

[malloc0.c]: https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture14/malloc0.c

---

# Heap Allocation: [malloc1.c] (<i class="muted">Better</i>)

[malloc1.c]: https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture14/malloc1.c

1. <strong class="warning">Align</strong> each allocation to the nearest
   multiple of `8` (**sizeof(double)**).

   <br>

2. Use <strong class="primary">free list</strong> with embedded block:

    - <strong class="caution">Only track blocks</strong> that are <strong
      class="success">free</strong> (*available*).

    - To <strong class="warning">allocate</strong>, <strong
      class="success">search</strong> <strong class="primary">free
      list</strong> for a suitable block and remove it from <strong
      class="primary">free list</strong>, otherwise grow heap by <strong
      class="warning">allocating</strong> a block.

    - To <strong class="warning">release</strong>, <strong
      class="success">insert</strong> block into <strong class="primary">free
      list</strong>.

---

# Heap Allocation: [Project 03]

[Project 03]: project03.html

<div class="columns">

<div class="middled">

```c
typedef struct block Block;

struct block {          // Embedded block header
    size_t capacity;    // Number of bytes allocated (aligned)
    size_t size;        // Number of bytes used
    Block *prev;        // Pointer to previous block
    Block *next;        // Pointer to next block
    chat   data[];      // Label for user accessible data
};
```

<div class="font-smaller">

- Need to implement <strong class="warning">releasing</strong>, <strong
  class="special">splitting</strong> and <strong
  class="hljs-comment">merging</strong> blocks.

- Need to implement <strong class="warning">searching</strong> (<strong
  class="special">First Fit</strong>, <strong class="special">Best
  Fit</strong>, <strong class="special">Worst Fit</strong>), <strong
  class="warning">inserting</strong>, and <strong
  class="warning">removing</strong> to and from <strong class="primary">free
  list</strong>.

</div>

</div>

<div class="slide-centered">

<img src="static/img/project03-freelist.svg" width="600px">

</div>

</div>
