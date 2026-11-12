---
title: "Notebook 17: TLBs, Multi-Level Page Tables"
description: "TLBs, Multi-Level Page Tables"
author: Peter Bui
keywords: notebook,osp,address space,paging,tlbs,multi-level"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook17.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## TLBS, Multi-Level Page Tables

---

<div class="slide-centered">

<img src="https://www.visitsouthbend.com/imager/files_idss_com/C532/62fb2879-accd-4fd2-bcd1-48aff9b0a7b8_b0799cbd572dd78746316d28b5c1bc75.jpg" height="670px">

</div>

---

# Questions

<div class="font-large">

1. What <strong class="danger">problem</strong> do <strong
   class="special">TLBs</strong> address and how do they solve it?

2. What <strong class="danger">problem</strong> do <strong
   class="primary">multi-level page tables</strong> address and how do they
   solve it?

</div>

---

<div class="columns-2-1">

<div class="slide-centered">

<img src="static/img/notebook17-paging-overview-blank.svg" height="525px">

</div>

<div class="font-small">

#### <span class="success">Observations</span>

1.  One <strong class="primary"> ___________________</strong>

    per <strong class="success"> ___________________</strong>

2. <strong class="primary">Page table</strong> is stored in

    <strong class="info"> _______________________</strong>

#### <span class="danger">Problems</span>

1. Each <strong class="warning">virtual address translation</strong> requires
   <code>______</code> <strong class="info">physical memory accesses</strong>.

    <br>
    <br>
    <br>

2. <strong class="primary">Page table</strong> requires a lot of
   <b>______________</b>

</div>

</div>

---

# TLBs: <span class="gold">Memory Access</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="danger">Problem</span>

Each <strong class="warning">virtual memory</strong> access requires <strong class="danger">two
fetches</strong> from <strong class="info">physical memory</strong>.

- <b>____________________________</b>

    <br>

- <b>____________________________</b>

</div>

<div class="margin-top-0-5">

## <span class="success">Solution</span>

Add a <strong class="success"> ______________</strong> called the <strong
class="special">translation-lookaside buffer (TLB)</strong> to the <strong
class="info">MMU</strong> and use it to store <strong class="warning">
________________________</strong>:

<br>

<div class="alert success-bg centered">

<i>Upon <strong class="warning">virtual memory reference</strong>, check <strong
class="special">TLB</strong> for translation, and if present use that without
consulting <strong class="primary">page table</strong>.</i>

</div>

</div>

</div>

---

# TLBs: <span class="gold">Hardware Information</span>

The <strong class="info">MMU</strong> usually uses a <strong class="success">
___________________________</strong> (<i class="muted">entries can go anywhere
and the whole cache must be searched</i>) and usually stores entries in the
following format:

```
VPN -> PFN | Other Bits
```

Where other bits could be <strong class="special">valid bits</strong>, <strong
class="special">protection bits</strong>, <strong class="special">dirty
bits</strong>, <strong class="special">address space identifier</strong>, etc.

<br>

<div class="alert info-bg centered">

<br>
<br>
<br>

</div>

---

# TLBs: <span class="gold">Locality</span>

> **Demonstrate**: [locality.c](https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture17/locality.c)

<div class="columns">

<div class="margin-top-0-5">

## <span class="special"> _______________________</span>

This is the idea that if we access memory at address `x`, then we will most
likely access memory <strong class="special">near</strong> `x` soon in the future.

<br>
<br>

<div class="alert special-bg centered">

<br>
<br>

</div>

</div>

<div class="margin-top-0-5">

## <span class="caution"> _______________________</span>

This is the idea that if we access an instruction or data item, then we will
most likely access it <strong class="caution">again</strong> soon in the
future.

<br>

<div class="alert caution-bg centered">

<br>
<br>

</div>

</div>

</div>

---

# TLBs: <span class="gold">Context Switch</span>

On each <strong class="warning">context switch</strong>, the <strong class="caution">operating
system</strong> must either:

<br>

<div class="alert danger-bg">

<br>
<br>
<br>

</div>

<br>

<div class="centered">
<b>OR</b>
</div>

<br>

<div class="alert success-bg">

<br>
<br>
<br>

</div>

---

# TLBs: <span class="gold">Handling Misses</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="info">Hardware</span>

On <strong class="danger">miss</strong>, <strong class="info">MMU</strong>
walks the <strong class="primary">page table</strong>, finds <strong
class="primary">PTE</strong>, and updates the <strong class="info">TLB</strong>
with translation as described previously.

<br>

<div class="alert info-bg centered">

<br>
<br>

</div>

</div>

<div class="margin-top-0-5">

## <span class="caution">Software</span>

On <strong class="danger">miss</strong>, <strong class="info">MMU</strong>
raises an <strong class="warning">exception</strong>, and triggers a <strong
class="caution">trap handler</strong>; <strong class="caution">OS</strong> then
looks up <strong class="primary">PTE</strong> and updates <strong
class="info">TLB</strong>.

<br>

<div class="alert caution-bg centered">

<br>
<br>

</div>

</div>

---

<div class="columns-1-2">

<div>

<img src="static/img/slides17-multi-level-problem-blank.svg" height="625px">

</div>

<div>

</div>

---

# Multi-Level: <span class="gold">Checklist</span>

<div class="columns">

<div class="font-smaller">

<div class="centered">

`14-bit` **Virtual Address**<br>
`16-bit` **Physical Address**

</div>

1. How many **bytes** can we address?
2. How many **pages** do we need?
3. How many **bits** in <strong class="special">VPN</strong>?
4. How many **bits** in <strong class="warning">offset</strong>?
5. How much **memory** does <strong class="primary">page table</strong> require?
6. How many <strong class="warning">pages</strong> does <strong class="primary">page table</strong> require?
7. How many <strong class="primary">PTEs</strong> per <strong class="warning">page</strong>?

</div>

<div class="font-smaller">

<div class="centered">

`64` byte **Page Size**<br>
`4`  byte **PTE/PDE**

</div>

8. How many <strong class="caution">PDEs</strong> in <strong class="caution">page directory</strong>?
9. How many **bits** in index <strong class="caution">page directory</strong>?
10. How many **bits** in index <strong class="primary">page table</strong>?
11. How much **memory** does <strong class="caution">page directory</strong> require?
12. How many <strong class="warning">pages</strong> does <strong class="caution">page directory</strong> require?

</div>

</div>

---

# Multi-Level: <span class="gold">Summary</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="success">Pros</span>

</div>

<div class="margin-top-0-5">

## <span class="danger">Cons</span>

</div>

</div>
