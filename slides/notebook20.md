---
title: "Notebook 20: RAID"
description: "RAID"
author: Peter Bui
keywords: notebook,osp,disks,raid"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook20.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## RAID

---

# Blaze of Fire: <span class="gold">Hard Drive Reliability</span>

<div class="columns-2-1">

<div class="slide-centered">

<a href="https://www.backblaze.com/blog/backblaze-drive-stats-for-q2-2026/">
<img src="https://backblazeprod.wpenginepowered.com/wp-content/uploads/2026/09/Q2-2026-Drive-Stats-_-Infographic-1024x864.png" class="framed" width="700px">
</a>

</div>

<div>

## <span class="info">Hard Drives</span>

</div>

</div>

---

# RAID: <span class="gold">Overview</span>

In a <strong class="warning">RAID</strong> system, we combine <b>
_______________________________</b> into a

<b> ______________________</b> that appears as a <b> _________________________</b>.

<br>

<div class="columns">

<div>

</div>

<div class="centered">

<img src="https://www.synology.com/img/products/detail/FS200T/img_og_image.jpg" class="framed" width="500px">

</div>

</div>

---

# RAID: <span class="gold">0</span> (<i class="muted">Striping</i>)

We can organize data blocks into rows called <strong class="success">
______________________</strong> and spread these across <strong
class="info">multiple disks</strong>.

<table class="bordered centered">
<thead>
    <th class="info-bg">Disk A</th>
    <th class="info-bg">Disk B</th>
    <th class="info-bg">Disk C</th>
    <th class="info-bg">Disk D</th>
</thead>
<tbody>
<tr>
    <td class="caution-bg" width="250px"><b><br></b></td>
    <td class="success-bg" width="250px"><b><br></b></td>
    <td class="danger-bg" width="250px"><b><br></b></td>
    <td class="special-bg" width="250px"><b><br></b></td>
</tr>
<tr>
    <td class="caution-bg" width="250px"><b><br></b></td>
    <td class="success-bg" width="250px"><b><br></b></td>
    <td class="danger-bg" width="250px"><b><br></b></td>
    <td class="special-bg" width="250px"><b><br></b></td>
</tr>
<tr>
    <td class="caution-bg" width="250px"><b><br></b></td>
    <td class="success-bg" width="250px"><b><br></b></td>
    <td class="danger-bg" width="250px"><b><br></b></td>
    <td class="special-bg" width="250px"><b><br></b></td>
</tr>
<tr>
    <td class="caution-bg" width="250px"><b><br></b></td>
    <td class="success-bg" width="250px"><b><br></b></td>
    <td class="danger-bg" width="250px"><b><br></b></td>
    <td class="special-bg" width="250px"><b><br></b></td>
</tr>
</tbody>
</table>

---

# RAID: <span class="gold">1</span> (<i class="muted">Mirroring</i>)

We can <strong class="special">mirror</strong> a block across <strong
class="info">multiple disks</strong> to add <strong class="special">
________________</strong>:

<table class="bordered centered">
<thead>
    <th class="info-bg">Disk A</th>
    <th class="info-bg">Disk B</th>
    <th class="info-bg">Disk C</th>
    <th class="info-bg">Disk D</th>
</thead>
<tbody>
<tr>
    <td class="caution-bg" width="250px"><b><br></b></td>
    <td class="caution-bg" width="250px"><b><br></b></td>
    <td class="success-bg" width="250px"><b><br></b></td>
    <td class="success-bg" width="250px"><b><br></b></td>
</tr>
<tr>
    <td class="special-bg" width="250px"><b><br></b></td>
    <td class="special-bg" width="250px"><b><br></b></td>
    <td class="danger-bg" width="250px"><b><br></b></td>
    <td class="danger-bg" width="250px"><b><br></b></td>
</tr>
<tr>
    <td class="caution-bg" width="250px"><b><br></b></td>
    <td class="caution-bg" width="250px"><b><br></b></td>
    <td class="success-bg" width="250px"><b><br></b></td>
    <td class="success-bg" width="250px"><b><br></b></td>
</tr>
<tr>
    <td class="special-bg" width="250px"><b><br></b></td>
    <td class="special-bg" width="250px"><b><br></b></td>
    <td class="danger-bg" width="250px"><b><br></b></td>
    <td class="danger-bg" width="250px"><b><br></b></td>
</tr>
</tbody>
</table>

---

# RAID: <span class="gold">Parity</span>

Rather than storing a copy of data, we can store a <strong
class="special">parity block</strong>

which serves as an <strong class="warning"> _____________________________________</strong>:

<table class="bordered centered">
<thead>
    <th class="special-bg">C0</th>
    <th class="special-bg">C1</th>
    <th class="special-bg">C2</th>
    <th class="special-bg">C3</th>
    <th class="special-bg">Parity</th>
</thead>
<tbody>
<tr class="caution-bg">
<td>0</td>
<td>0</td>
<td>1</td>
<td>1</td>
<td width="600px"><br></td>
</tr>
<tr class="success-bg">
<td>0</td>
<td>1</td>
<td>0</td>
<td>0</td>
<td width="600px"><br></td>
</tr>
</tbody>
</table>

---

# RAID: <span class="gold">5</span> (<i class="muted">Parity Blocks</i>)

<strong class="warning">RAID 5</strong> requires at least `3` <strong
class="info">disks</strong>, and rotates the <strong
class="special">parity</strong> across each <strong class="info">disk</strong>
in the <strong class="warning">array</strong>.

<br>

<div class="columns">

<div class="centered">

<img src="static/img/slides20-raid-5.svg" width="600px">

</div>

<div>

</div>

</div>

---

# RAID: <span class="gold">10</span> (<i class="muted">____________ + ___________</i>)

---

# RAID: <span class="gold">Warnings</span>

While <strong class="warning">RAID</strong> is a great way to build <strong
class="success">faster</strong>, <strong class="info">bigger</strong>, and more
<strong class="special">reliable storage systems</strong>, it doesn't address
every problem:

- <strong class="warning">RAID</strong> recovery time is arduous.

- <strong class="warning">RAID</strong> doesn't handle <strong
  class="danger">disk corruption</strong> (*or even detects it*).

- <strong class="warning">RAID</strong> is not a <strong class="success">backup
  system</strong>.
