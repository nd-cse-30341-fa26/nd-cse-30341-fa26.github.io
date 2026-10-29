---
title: "Notebook 14-A: Memory API, Free-Space Management"
description: "Memory, API, Free-Space Management"
author: Peter Bui
keywords: notebook,osp,memory API,free-space management,heap allocation"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook14.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Memory API<br>Free-Space Management

---

<!-- _class: lead -->

# Memory API

---

# Memory API: <span class="gold">Review</span>

<div class="slide-centered font-large">

Break into groups of `2` or `3` and<br>prepare for <strong class="success">team
trivia</strong>!

</div>

---

# Memory API: <span class="gold">Allocation</span>

> How do we <strong class="success">allocate</strong> an array of `1,000,000` ints?

---

# Memory API: <span class="gold">Deallocation</span>

> How do we <strong class="danger">deallocate</strong> that array of ints?

---

# Memory API: <span class="gold">Common Error A</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
char *buffer;
fgets(buffer, BUFSIZ, stdin);
```

---

# Memory API: <span class="gold">Common Error B</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
char *src = "Smile like you mean it";
char *dst = malloc(strlen(src));

strcpy(dst, src);
```

---

# Memory API: <span class="gold">Common Error C</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
char *s = malloc(100*sizeof(char));

puts(s);
```

---

# Memory API: <span class="gold">Common Error D</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
for (int i = 1; i < argc; i++) {
    char *s = strdup(argv[i]);
    process(s);
}
```

---

# Memory API: <span class="gold">Common Error E</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
for (int i = 1; i < argc; i++) {
    char *s = strdup(argv[i]);
    process(s); free(s); puts(s);
}
```

---

# Memory API: <span class="gold">Common Error F</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
for (int i = 1; i < argc; i++) {
    char *s = strdup(argv[i]);
    if (check(s)) { free(s); }
    free(s);
}
```

---

# Memory API: <span class="gold">Common Error G</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
for (int i = 1; i < argc; i++) {
    char *s = argv[i];
    process(s);
    free(s);
}
```

---

# Memory API: <span class="gold">Where is My Mind?</span>

<strong class="info">Dr. Thain</strong> wants you to write a <strong
class="danger">compiler</strong>.  He tells you don't worry about managing
memory, just allocate as much as you want and <strong class="warning">don't
bother to free anything</strong>.  You look at him in <strong
class="caution">horror</strong> and are ready to <strong
class="danger">roast</strong> him on **Slack / X**.  Are you <strong
class="success">justified</strong>?

---

<!-- _class: lead -->

# Free-Space Management

---

# Review: <span class="gold">Virtual Memory</span>

<div class="columns">

<div class="margin-top-0-5">

<strong> ________________________________</strong>

<br>

1. <b> ____________________________</b>

    <br>

2. <b> ____________________________</b>

</div>

<div class="margin-top-0-5">

<strong> ________________________________</strong>

<br>

1. <b> ____________________________</b>

    <br>

2. <b> ____________________________</b>

</div>

</div>

<br>

<div class="centered">

<b> _____________________</b> = <b> ___________________</b> + <b> ______________________</b>

</div>

---

# Review: <span class="gold">OS Responsibilities</span>

<table class="bordered">
<thead>
    <th class="info-bg">Responsibility</th>
    <th class="info-bg">Notes</th>
</thead>
<tbody>
<tr>
    <td class="success-bg" width="400px" height="125px">&nbsp;</td>
    <td class="success-bg" width="700px"><br><br>&nbsp;</td>
</tr>
<tr>
    <td class="caution-bg" width="400px" height="125px">&nbsp;</td>
    <td class="caution-bg" width="700px"><br><br>&nbsp;</td>
</tr>
<tr>
    <td class="danger-bg" width="400px" height="125px">&nbsp;</td>
    <td class="danger-bg" width="700px"><br><br>&nbsp;</td>
</tr>
</tbody>
</table>

---

# Challenge: <span class="gold"> ____________________________</span>

Because memory is divided into **blocks**, we may have

<b>_______________________________________________________</b>.

<br>

<table class="framed">
<tbody>
<tr>
    <td class="caution-bg" width="300px" height="100px"><br><br>&nbsp;</td>
    <td class="caution-bg" width="300px" height="100px"><br><br>&nbsp;</td>
    <td class="caution-bg" width="300px" height="100px"><br><br>&nbsp;</td>
</tr>
</tbody>
</table>

---

# Challenge: <span class="gold"> ____________________________</span>

Suppose we <b>________________________________________________</b> a block.

<br>

<table class="framed">
<tbody>
<tr>
    <td class="caution-bg" width="300px" height="100px"><br><br>&nbsp;</td>
    <td class="caution-bg" width="300px" height="100px"><br><br>&nbsp;</td>
    <td class="caution-bg" width="300px" height="100px"><br><br>&nbsp;</td>
</tr>
</tbody>
</table>

---

# Mechanisms: <span class="gold"> Splitting & Coalescing</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="special">Splitting</span>

<br>

<div class="centered">

<img src="static/img/notebook14-splitting.svg">

</div>

</div>

<div class="margin-top-0-5">

## <span class="comment">Coalescing</span>

<br>

<div class="centered">

<img src="static/img/notebook14-merging.svg">

</div>

</div>

</div>

---

# Free List: <span class="gold">Overview</span>

To track the block allocations, we can use a <strong class="primary">free
list</strong>, which is a

<strong class="primary"> _________________________</strong> of all the space
reservations

(*can contain both <strong class="caution">active</strong> and <strong
class="success">free</strong> blocks or just the <strong
class="success">free</strong> blocks*).

<br>

- <b>________________________________________________________________</b>

    <br>

- <b>________________________________________________________________</b>

    <br>

- <b>________________________________________________________________</b>

---

# Free List: <span class="gold">Block Structure</span>

<div class="columns-2-1">

<div>

We can view memory as <strong class="info"> _____________________</strong>.
To keep track of allocated blocks, we <strong class="caution">embed</strong> a
<strong class="success">block header</strong> in front of each block:

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

<table class="framed">
<tbody>
<tr><td class="caution-bg" width="300px" height="500px"><br><br><br><br><br><br><br><br><br><br><br>&nbsp;</td></tr>
</tbody>
</table>

</div>

</div>

---

# Free List: <span class="gold">Allocation</span>

<div class="columns-3-1">

<div>

Whenever we get a <strong class="warning">request</strong> for memory, we must

<b> _____________________________________________________</b>

> If a <strong class="caution">previously allocated block</strong> is <strong
> class="success"> ______________</strong>
>
> and <strong class="success"> _______________________</strong>, we can use that one.
>
> Otherwise, we need to <strong class="warning"> ______________</strong> a new block.

Whenever we <strong class="warning">release</strong> memory, we simply mark that block

as <strong class="success"> ________________</strong>.

</div>

<div class="centered">

<img src="static/img/notebook14-block-structure.svg">

</div>

</div>

---

# Free List: <span class="gold">First Fit</span>

<div class="columns-3-1">

<div>

When searching for a <strong class="success">free block</strong>, we can:

> Find the <strong class="caution"> _____________________________________</strong>
>
> and return that block to the user.

<br>

<div class="alert info-bg centered">

When allocating a `12 byte` block, we would select

<strong class="warning"> ___________________________</strong>.

</div>

</div>

<div class="slide-centered">

<img src="static/img/notebook14-fits.svg">

</div>

</div>

---

# Free List: <span class="gold">Next Fit</span>

<div class="columns-3-1">

<div>

When searching for a <strong class="success">free block</strong>, we can:

> <strong class="caution"> _________________________________</strong>, and perform
>
> <strong class="special"> _________________________________</strong> from there.

<br>

<div class="alert info-bg centered">

When allocating a `12 byte` block, we would select

<strong class="warning"> ___________________________</strong>.

</div>

</div>

<div class="slide-centered">

<img src="static/img/notebook14-fits.svg">

</div>

</div>

---

# Free List: <span class="gold">Best Fit</span>

<div class="columns-3-1">

<div>

When searching for a <strong class="success">free block</strong>, we can:

> <strong class="caution"> ______________________________________________</strong>.

<br>

<div class="alert info-bg centered">

When allocating a `12 byte` block, we would select

<strong class="warning"> ___________________________</strong>.

</div>

</div>

<div class="slide-centered">

<img src="static/img/notebook14-fits.svg">

</div>

</div>

---

# Free List: <span class="gold">Worst Fit</span>

<div class="columns-3-1">

<div>

When searching for a <strong class="success">free block</strong>, we can:

> <strong class="caution"> ______________________________________________</strong>.

<br>

<div class="alert info-bg centered">

When allocating a `12 byte` block, we would select

<strong class="warning"> ___________________________</strong>.

</div>

</div>

<div class="slide-centered">

<img src="static/img/notebook14-fits.svg">

</div>

</div>
