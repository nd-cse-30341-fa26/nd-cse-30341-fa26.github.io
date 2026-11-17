---
title: "Notebook 18: Swapping"
description: "Swapping"
author: Peter Bui
keywords: notebook,osp,virtual memory,swapping"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook18.html
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



---

# Swapping: <span class="gold">Overview</span>

The <strong class="special"> _____________</strong> is a portion of
<strong class="info"> _____________</strong> reserved for moving

<strong class="warning"> ___________________</strong> back and forth:

<div class="font-small"><br></div>

<div class="centered">

<img src="static/img/slides18-swapping-overview.svg">

</div>

- <b> ________________________________________________________________</b>

    <div class="font-small"><br></div>

- <b> ________________________________________________________________</b>

---

# Swapping: <span class="gold">Memory Access</span>

---

# Swapping: <span class="gold">Page Replacement</span>

Ideally, we would <strong class="success">minimize _____________________________</strong>,
and thus

want to <strong class="danger"> _____________________________</strong> that will be accessed the

<strong class="special"> _________________________________________</strong>.

Unfortunately, this is difficult to determine, so we consider different
<strong class="warning">replacement policies</strong>:

- <strong class="danger">  FIFO: _________________________________________________________</strong>

    <div class="font-small"><br></div>

- <strong class="caution"> Random: _______________________________________________________</strong>

    <div class="font-small"><br></div>

- <strong class="success"> LRU: __________________________________________________________</strong>

---

# Swapping: <span class="gold">Clock</span>

<div class="columns">

<div>

</div>

<div>

<div class="centered">

<img src="static/img/slides18-swapping-clock-blank.svg">

</div>

</div>

</div>

</div>

---

# Swapping: <span class="gold">Page Selection</span>

To decide when to bring a <strong class="warning">page</strong> into <strong
class="info">physical memory</strong>, the <strong
class="caution">operating</strong> system can employ two strategies:

1. <strong class="caution">Demand paging: _________________________________________________</strong>

    <div class="font-small"><br></div>

2. <strong class="success">Prefetching: ___________________________________________________</strong>

<br>

<div class="alert info-bg centered">

[readahead(2)](http://man7.org/linux/man-pages/man2/readahead.2.html)

</div>

---

# Swapping: <span class="gold">Danger</span>

Suppose the amount of memory requested by running <strong
class="success">processes</strong> (ie. <strong class="caution">working
set</strong>) exceeds the available <strong class="info">physical
memory</strong>...

<br>

<div class="columns-1-2">

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

<br>
<br>
<br>
<br>

</div>

</div>

---

# Swapping: <span class="gold">Laziness</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="caution">Demand Zeroring</span>

</div>

<div class="margin-top-0-5">

## <span class="success">Copy-on-Write</span>

</div>

</div>
