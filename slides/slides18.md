---
title: "Slides 18: Swapping"
description: "Swapping"
author: Peter Bui
keywords: lecture,osp,virtual memory,swapping"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides18.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Swapping

---

# Questions

<div class="font-large">

1. How does the <strong class="caution">operating system</strong> provide the
   <strong class="special">illusion</strong> of <strong
   class="success">infinite virtual memory</strong>?

2. How does the <strong class="caution">operating system</strong> handle
   <strong class="warning">page faults</strong>?

3. What exactly is <strong class="danger">thrashing</strong>?

</div>

---

# Virtual Memory: <span class="gold">Infinite Allocation</span>

```c
#include <stdio.h>
#include <stdlib.h>

#define N 30

int main(int argc, char *argv[]) {
    while (1) {
        int *a = malloc(sizeof(int)*(1<<N));    // Allocate memory on the heap
        for (int i = 0; i < (1<<N); i++) {      // Use Allocation
            a[i] = i;
        }
    }
    return 0;
}
```

---

# Virtual Memory: <span class="gold">Memory Hierarchy</span>

<div class="slide-centered">

<a href="https://gist.github.com/hellerbarde/2843375">
<img src="https://camo.githubusercontent.com/21e9781dff39ae0055959d1c686278591144f412c759dc77ebe1843e25376024/687474703a2f2f692e696d6775722e636f6d2f6b307431652e706e67" class="framed">
</a>

</div>

---

# Swapping: <span class="gold">Overview</span>

The <strong class="special">swap space</strong> is a portion of <strong
class="info">disk</strong> reserved for moving <strong
class="warning">pages</strong> back and forth:

<div class="centered">

<img src="static/img/slides18-swapping-overview.svg">

</div>

- Used to hold <strong class="warning">pages</strong> of currently running
  <strong class="success">processes</strong>.

- <strong class="special">Present bit</strong> in <strong
  class="primary">PTE</strong> tracks whether or not <strong
  class="warning">page</strong> is in <strong class="info">physical
  memory</strong>.

---

# Swapping: <span class="gold">Page Fault</span>

If a <strong class="warning">page</strong> is not present in <strong
class="info">physical memory</strong>, then the <strong
class="info">hardware</strong> triggers a <strong class="warning">page
fault</strong> that the <strong class="caution">operating system</strong>
handles.

1. If <strong class="warning">page</strong> is not present and has been swapped
   to <strong class="info">disk</strong>, then <strong
   class="caution">OS</strong> looks up location in <strong
   class="primary">PTE</strong> and loads it from <strong class="special">swap
   space</strong>.

2. If there are no free <strong class="info">page frames</strong> in <strong
   class="info">physical memory</strong>, then we need to <strong
   class="danger">evict</strong> one so we can replace it.

---

# Swapping: <span class="gold">Memory Access</span>

1. Extract <strong class="warning">VPN</strong> from <strong
   class="warning">virtual address</strong>

2. If <strong class="warning">VPN</strong> in <strong
   class="special">TLB</strong>

    - Then perform checks and access <strong class="info">physical memory</strong>

3. Otherwise, read <strong class="primary">PTE</strong> from <strong
   class="primary">page table</strong>

    - If <strong class="warning">page</strong> is not <strong
      class="special">valid</strong>, then raise <strong
      class="warning">Segmentation Fault</strong>

    - If <strong class="warning">page</strong> is <strong
      class="special">protected</strong>, then raise <strong
      class="warning">Protection Fault</strong>

    - If <strong class="warning">page</strong> is <strong
      class="special">present</strong>

        - Then update <strong class="special">TLB</strong> and retry

    - Otherwise, raise <strong class="warning">Page Fault</strong>
---

# Swapping: <span class="gold">Eviction</span>

<div class="columns-2-1">

<div>

Instead of waiting until memory is entirely full, the <strong
class="caution">operating system</strong> may use a <strong
class="success">high watermark</strong> and a <strong class="danger">low
watermark</strong> to decide when to <strong class="danger">evict pages</strong>.

- A <strong class="special">swap daemon</strong> runs in the background and
  ensures the number of free <strong class="warning">pages</strong> is between
  the <strong class="danger">low</strong> and <strong
  class="success">high</strong> watermarks.

- We can cluster or group <strong class="danger">evictions</strong> for higher
  <strong class="success">throughput</strong>.

</div>

<div class="centered">

<img src="static/img/slides18-swapping-eviction.svg">

</div>

</div>

---

# Swapping: <span class="gold">Page Replacement</span>

Ideally, we would <strong class="success">minimize the amount of
misses</strong>, and thus want to <strong class="danger">evict pages</strong>
that will be accessed the <strong class="special">*furthest in the
future*</strong>.

Unfortunately, this is difficult to determine, so we consider different
<strong class="warning">replacement policies</strong>:

- <strong class="danger">FIFO</strong>: Pretty poor since it doesn't consider
  importance of <strong class="warning">page</strong>.

- <strong class="caution">Random</strong>: Sometimes really good, sometimes
  really bad, typically mid.

---

# Swapping: <span class="gold">LRU</span>

In <strong class="success">LRU</strong>, we keep track of the history of
<strong class="warning">page</strong> accesses and use that information to
inform our selection:

- With <strong class="success">LRU</strong>, we <strong
  class="danger">evict</strong> the least recently used <strong
  class="warning">page</strong>.

- To determine the least recently used <strong class="warning">page</strong>,
  we must update some sort of <strong class="primary">data structure</strong>
  or time field whenever a <strong class="warning">page</strong> is accessed
  (<i class="muted">so on every memory reference</i>).

<br>

<div class="alert danger-bg centered">

This is **expensive**, so we need a way to **approximate** it...

</div>

---

# Swapping: <span class="gold">Clock</span>

<div class="columns">

<div>

The <strong class="info">hardware</strong> sets a <strong class="special">used
bit</strong> whenever a <strong class="warning">page</strong> is accessed.

- <strong class="caution">OS</strong> arranges <strong
  class="warning">pages</strong> in a <strong class="primary">circular
  list</strong>.

- A <strong class="special">clock hand</strong> points to <strong
  class="warning">current page</strong>.

-  When replacement occurs, <strong class="caution">OS</strong> checks <strong class="special">use
   bit</strong> of <strong class="warning">current page</strong>:

    - If `1`, <strong class="special">clear bit</strong> and go to <strong
      class="warning">next page</strong>.

    - Otherwise, <strong class="danger">evict</strong>.

</div>

<div>

<div class="centered">

<img src="static/img/slides18-swapping-clock.svg">

</div>

<div class="alert special-bg font-smaller">

1. Start at <strong class="warning">Page 1</strong>, **clear** it.<br>
2. Go to <strong class="warning">Page 2</strong>, **clear** it.<br>
3. Go to <strong class="warning">Page 3</strong>, <strong class="danger">evict</strong> it.

</div>

</div>

</div>

</div>

---

# Swapping: <span class="gold">Page Selection</span>

To decide when to bring a <strong class="warning">page</strong> into <strong
class="info">physical memory</strong>, the <strong
class="caution">operating</strong> system can employ two strategies:

1. <strong class="caution">Demand paging</strong>: Bring <strong
   class="warning">pages</strong> into <strong class="info">physical
   memory</strong> when they are accessed.

2. <strong class="success">Prefetching</strong>: Bring <strong
   class="warning">pages</strong> into <strong class="info">physical
   memory</strong> ahead of time.

<br>

<div class="alert info-bg centered">

[readahead(2)](http://man7.org/linux/man-pages/man2/readahead.2.html)

</div>

---

# Swapping: <span class="gold">Thrashing</span>

Suppose the amount of memory requested by running <strong
class="success">processes</strong> (ie. <strong class="caution">working
set</strong>) exceeds the available <strong class="info">physical
memory</strong>...

<br>

<div class="columns">

<div>

- <strong class="danger">Evict page out</strong>
- <strong class="special">Swap page in</strong>
- <strong class="danger">Evict page out</strong>
- <strong class="special">Swap page in</strong>
- <strong class="danger">Evict page out</strong>
- <strong class="special">Swap page in</strong>

</div>

<div class="middled">

<div class="alert danger-bg centered">

This condition of constantly <strong class="special">swapping</strong> is called **thrashing**.

</div>

</div>

---

# Swapping: <span class="gold">Laziness</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="caution">Demand Zeroring</span>

Rather than automatically allocating a <strong class="warning">page</strong>
and zeroing it when it is requested, the <strong class="caution">OS</strong>
waits until the <strong class="info">page is actually accessed</strong> to
clear it.

</div>

<div class="margin-top-0-5">

## <span class="success">Copy-on-Write</span>

Rather than copying a <strong class="warning">page</strong> from one <strong
class="success">address space</strong> to another, share the <strong
class="warning">page</strong> in <strong class="caution">read-only
mode</strong> and only perform the copy if a <strong
class="danger">write</strong> occurs.

</div>

</div>
