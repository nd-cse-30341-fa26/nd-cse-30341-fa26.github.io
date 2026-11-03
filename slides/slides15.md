---
title: "Slides 15: Segmentation"
description: "Segmentation"
author: Peter Bui
keywords: lecture,osp,address space,segmentation"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides15.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Segmentation

---

# Questions

<div class="font-large">

1. What is the <strong class="danger">lie</strong> the <strong
   class="caution">OS</strong> tells <strong class="success">processes</strong>
   regarding <strong class="info">memory</strong>?

2. What are the <strong class="danger">problems</strong> with <strong
   class="warning">base and bounds</strong>?

3. How does <strong class="warning">segmentation</strong> address these <strong
   class="danger">problems</strong>?

4. How do we translate a <strong class="warning">virtual address</strong> to a
   <strong class="info">physical address</strong>?

</div>

---

# Base and Bounds: <span class="gold">Problems</span>

<div class="columns-2-1">

<div>

<strong class="warning">Base and bounds</strong> has two main <strong
class="danger">problems</strong>:

1. It is <strong class="caution">wasteful</strong> since there is a lot of
   <strong class="danger">unused space</strong> between the <strong
   class="info">sttack</strong> and <strong class="success">heap</strong>.

2. It does not support <strong class="success">address spaces</strong> larger
   than <strong class="info">physical memory</strong>.

</div>

<div class="centered">

<img src="static/img/slides15-base-and-bounds-problems.svg">

</div>

</div>

---

# Segmentation: <span class="gold">Overview</span>

<div class="columns-2-1">

<div>

<strong class="warning">Segmentation</strong> is a generalized form of <strong
class="warning">base and bounds</strong>:

- Each component in the <strong class="success">address space</strong> is
  considered a separate <strong class="caution">segment</strong>.

- Each <strong class="caution">segment</strong> has its own <strong
  class="warning">base and bounds registers</strong>.

</div>

<div class="centered">

<img src="static/img/slides15-segmentation-overview.svg">

</div>

</div>

---

# Segmentation: <span class="gold">Segments</span>

Because our <strong class="success">address space</strong> is split into
separate <strong class="caution">segments</strong>, we have some additional
issues and opportunities:

- <strong class="primary">Code Sharing</strong>: We can now share common
  <strong class="danger">code segments</strong> (<strong><i class="muted">ie.
  multiple instances of programs</i></strong>)

- <strong class="comment">Growth Direction</strong>: While most <strong
  class="caution">segments</strong> such as <strong
  class="success">heap</strong> grow in positive direction, the <strong
  class="info">stack</strong> grows downwards.

---

# Segmentation: <span class="gold">Hardware Information</span>

To support <strong class="warning">segmentation</strong>, the <strong
class="info">MMU</strong> now needs to know the following information:

<table class="bordered">
<thead>
    <th class="special-bg">Segment</th>
    <th class="special-bg">Base</th>
    <th class="special-bg">Size</th>
    <th class="special-bg">Growth Positive?</th>
    <th class="special-bg">Protection</th>
</thead>
<tbody>
<tr class="danger-bg">
    <td>Code</td>
    <td>32K</td>
    <td>2K</td>
    <td>1</td>
    <td>Read-Execute</td>
</tr>
<tr class="caution-bg">
    <td>Data</td>
    <td>34K</td>
    <td>2K</td>
    <td>1</td>
    <td>Read-Write</td>
</tr>
<tr class="success-bg">
    <td>Heap</td>
    <td>36K</td>
    <td>2K</td>
    <td>1</td>
    <td>Read-Write</td>
</tr>
<tr class="info-bg">
    <td>Stack</td>
    <td>28K</td>
    <td>2K</td>
    <td>0</td>
    <td>Read-Write</td>
</tr>
</tbody>
</table>

<strong class="caution">Operating system</strong> must track this information
for every <strong class="success">process</strong> and save and restore it on
each <strong class="special">context switch</strong>.

---

# Segmentation: <span class="gold">Address Translation</span>

Given the following `16-bit` <strong class="warning">virtual address</strong>:

<div class="centered">

<img src="static/img/reading08-address.svg">

</div>

1. What is the <strong class="danger">largest possible segment size</strong>?

2. What is the <strong class="success">maximum possible offset value</strong>?

3. Which <strong class="caution">segment</strong> is this <strong
   class="warning">virtual address</strong> located in?

4. What is the <strong class="info">physical address</strong> of
   this <strong class="warning">virtual address</strong>?

---

# Segmentation: <span class="gold">Problems</span>

<div class="columns-2-1">

<div>

Unfortunately, <strong class="warning">segmentation</strong> suffers from a major
<strong class="danger">problem</strong>:

> <strong class="danger">External fragmentation</strong>: the
> variable sized <strong class="warning">segments</strong> leads to many tiny
> <strong class="caution">holes</strong>.

- We can compact <strong class="caution">segments</strong>, but that is <strong
  class="danger">expensive</strong>.

- We can rely on <strong class="primary">free-list</strong> management
  algorithms, but they can only <strong class="caution">minimize
  fragmentation</strong>.

</div>

<div class="centered">

<img src="static/img/slides15-segmentation-problem.svg">

</div>

</div>
