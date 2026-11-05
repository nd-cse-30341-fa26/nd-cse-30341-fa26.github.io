---
title: "Notebook 15: Segmentation"
description: "Segmentation"
author: Peter Bui
keywords: notebook,osp,address translation,segmentation"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook15.html
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

# Virtualization: <span class="gold">Lies</span>

<div class="columns-3-1">

<div>

</div>

<div class="centered">

<img src="static/img/slides15-segmentation-overview-blank.svg">

</div>

</div>

---

# Segmentation: <span class="gold">Overview</span>

<div class="columns-3-1">

<div>

<strong class="warning">Segmentation</strong> is a <b> _________________</b>

form of <strong class="warning"> __________________________</strong>:

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

<br>

- <strong class="primary"> _____________________</strong>:
    <b> _________________________________________</b>

    <br>

    <b> ________________________________________________________________</b>

    <br>

- <strong class="comment"> _____________________</strong>:
    <b> _________________________________________</b>

    <br>

    <b> ________________________________________________________________</b>

    <br>

---

# Segmentation: <span class="gold">Hardware Information</span>

To support <strong class="warning">segmentation</strong>, the <strong
class="info"> ________________</strong> needs the following:

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
    <td class="centered">Code</td>
    <td class="centered">32K</td>
    <td class="centered">2K</td>
    <td class="centered">1</td>
    <td class="centered">Read-Execute</td>
</tr>
<tr class="caution-bg">
    <td class="centered">Data</td>
    <td class="centered">34K</td>
    <td class="centered">2K</td>
    <td class="centered">1</td>
    <td class="centered">Read-Write</td>
</tr>
<tr class="success-bg">
    <td class="centered">Heap</td>
    <td class="centered">36K</td>
    <td class="centered">2K</td>
    <td class="centered">1</td>
    <td class="centered">Read-Write</td>
</tr>
<tr class="info-bg">
    <td class="centered">Stack</td>
    <td class="centered">28K</td>
    <td class="centered">2K</td>
    <td class="centered">0</td>
    <td class="centered">Read-Write</td>
</tr>
</tbody>
</table>

<strong class="caution">Operating system</strong> must track this information
for every <strong class="success"> _____________</strong>

and save and restore it on each
<strong class="special"> ___________________________________</strong>.

---

# Segmentation: <span class="gold">Address Translation</span> (<i class="muted">1</i>)

Given the following `16-bit` <strong class="warning">virtual address</strong>:

<div class="centered">

<img src="static/img/reading08-address.svg">

</div>

1. What is the <strong class="danger">largest possible segment size</strong>?

    <br>
    <br>

2. What is the <strong class="success">maximum possible offset value</strong>?

---

# Segmentation: <span class="gold">Address Translation</span> (<i class="muted">2</i>)

Given the following `16-bit` <strong class="warning">virtual address</strong>:

<div class="centered">

<img src="static/img/reading08-address.svg">

</div>

3. Which <strong class="caution">segment</strong> is this <strong
   class="warning">virtual address</strong> located in?

    <br>
    <br>

4. What is the <strong class="info">physical address</strong> of
   this <strong class="warning">virtual address</strong>?

---

# Segmentation: <span class="gold">Problems</span>

<div class="columns-3-1">

<div>

</div>

<div class="centered">

<img src="static/img/slides15-segmentation-problem.svg">

</div>

</div>
