---
title: "Slides 20: RAID"
description: "RAID"
author: Peter Bui
keywords: lecture,osp,disks,raid"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides20.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## RAID

---

# Questions

<div class="font-large">

1. What <strong class="danger">problems</strong> does <strong
   class="warning">RAID</strong> address?

2. What different types of <strong class="warning">RAID</strong> are there and
   what are the <strong class="success">advantages</strong> and <strong
   class="danger">disadvantages</strong> of each?

</div>

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

- Can be <strong class="caution">slow</strong>.

- Can have <strong class="warning">limited capacity</strong>.

- Can <strong class="danger">fail</strong>.

</div>

</div>

---

# Abstraction Layers: <span class="gold">Device Driver</span>

To interface with different <strong class="warning">devices</strong>, the
<strong class="caution">operating system</strong> layers subsystems on top of
different hardware specific <strong class="special">device drivers</strong>:

<br>

<div class="centered">

<img src="static/img/slides19-io-device-drivers.svg">

</div>

<br>

<div class="alert info-bg centered">

A [large portion of kernel
code](https://commandlinux.com/statistics/linux-kernel-contributors-lines-of-code-statistics/)
is <strong class="special">device drivers</strong> such as
[ahci.c](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/ahci.c).

</div>

---

<!-- _class: lead -->

# Redundant Array of<br>Inexpensive Disks

---

# RAID: <span class="gold">Overview</span>

Rather than utilize sophisticated and complex storage systems, we can build a
<strong class="warning">storage array</strong> out of <strong
class="info">commodity storage devices</strong>:

<br>

<div class="columns">

<div>

- <strong class="success">Faster</strong>
- <strong class="info">Bigger</strong>
- <strong class="special">More Reliable</strong>

</div>

<div class="centered">

<img src="https://www.synology.com/img/products/detail/FS200T/img_og_image.jpg" class="framed" width="500px">

</div>

</div>

<br>

<div class="alert warning-bg centered">

Combine <strong class="info">multiple disks</strong> into a <strong
class="special">virtual disk</strong>!

</div>

---

# RAID: <span class="gold">Fault Model</span>

In a <strong class="warning">RAID system</strong>, we combine <strong
class="info">multiple disks</strong> into a <strong class="warning">single
array</strong> that appears as a <strong class="warning">virtual disk</strong>.

<br>

<div class="centered">

<img src="static/img/slides20-raid-fault-model.svg">

</div>

- This arrangement assumes a <strong class="danger">fail-stop model</strong>
  where disks can be either in a <strong class="success">working state</strong>
  or a <strong class="danger">failed state</strong>.

- This assumes we can easily determine the state of a disk and does not handle
  <strong class="warning">"silent" failures</strong> such as <strong
  class="danger">disk corruption</strong>.

---

# RAID: <span class="gold">Striping</span>

We can organize data blocks into rows called <strong
class="success">stripes</strong> and spread these across <strong
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
    <td class="caution-bg"><b>0</b></td>
    <td class="success-bg"><b>2</b></td>
    <td class="danger-bg"><b>4</b></td>
    <td class="special-bg"><b>6</b></td>
</tr>
<tr>
    <td class="caution-bg"><b>1</b></td>
    <td class="success-bg"><b>3</b></td>
    <td class="danger-bg"><b>5</b></td>
    <td class="special-bg"><b>7</b></td>
</tr>
<tr>
    <td class="caution-bg"><b>8</b></td>
    <td class="success-bg"><b>10</b></td>
    <td class="danger-bg"><b>12</b></td>
    <td class="special-bg"><b>14</b></td>
</tr>
<tr>
    <td class="caution-bg"><b>9</b></td>
    <td class="success-bg"><b>11</b></td>
    <td class="danger-bg"><b>13</b></td>
    <td class="special-bg"><b>15</b></td>
</tr>
</tbody>
</table>

<div class="font-smaller">

We may organize consecutive blocks into <strong class="warning">chunks</strong>:

- <strong class="caution">Smaller chunk size</strong> -> more <strong
  class="success">parallelism</strong>.

- <strong class="special">Larger chunk size</strong> -> less <strong
  class="danger">repositioning time</strong>.

</div>

---

# RAID: <span class="gold">0</span> (<i class="muted">Striping</i>)

<div class="columns">

<div class="slide-centered">

<img src="static/img/slides20-raid-0.svg">

</div>

<div>

In <strong class="warning">RAID 0</strong>, we <strong class="success">stripe</strong> data across
<strong class="info">multiple disks</strong>:

<table class="bordered font-small">
<tbody>
<tr class="success-bg">
<td><b>Performance</b></td>
<td>+ I/O in parallel</td>
</tr>
<tr class="info-bg">
<td><b>Capacity</b></td>
<td>+ <code>100%</code></td>
</tr>
<tr class="special-bg">
<td><b>Reliability</b></td>
<td>- <strong class="danger">No redundancy</strong></td>
</tr>
</tbody>
</table>

</div>

</div>

---

# RAID: <span class="gold">Mirroring</span>

We can copy or <strong class="special">mirror</strong> a block across <strong
class="info">multiple disks</strong> to add <strong
class="special">redundancy</strong>:

<table class="bordered centered">
<thead>
    <th class="info-bg">Disk A</th>
    <th class="info-bg">Disk B</th>
    <th class="info-bg">Disk C</th>
    <th class="info-bg">Disk D</th>
</thead>
<tbody>
<tr>
    <td class="caution-bg"><b>0</b></td>
    <td class="caution-bg"><b>0</b></td>
    <td class="success-bg"><b>1</b></td>
    <td class="success-bg"><b>1</b></td>
</tr>
<tr>
    <td class="special-bg"><b>2</b></td>
    <td class="special-bg"><b>2</b></td>
    <td class="danger-bg"><b>3</b></td>
    <td class="danger-bg"><b>3</b></td>
</tr>
<tr>
    <td class="caution-bg"><b>4</b></td>
    <td class="caution-bg"><b>4</b></td>
    <td class="success-bg"><b>5</b></td>
    <td class="success-bg"><b>5</b></td>
</tr>
<tr>
    <td class="special-bg"><b>6</b></td>
    <td class="special-bg"><b>6</b></td>
    <td class="danger-bg"><b>7</b></td>
    <td class="danger-bg"><b>7</b></td>
</tr>
</tbody>
</table>

<div class="font-smaller">

- When <strong class="success">reading</strong>, we can use either copy.

- When <strong class="danger">writing</strong>, we must perform writes to each <strong class="special">mirror</strong>.

</div>

---

# RAID: <span class="gold">1</span> (<i class="muted">Mirroring</i>)

<div class="columns">

<div class="slide-centered">

<img src="static/img/slides20-raid-1.svg">

</div>

<div>

In <strong class="warning">RAID 1</strong>, we <strong class="special">mirror</strong> data across
<strong class="info">at least two disks</strong>:

<table class="bordered font-small">
<tbody>
<tr class="success-bg">
<td><b>Performance</b></td>
<td>~ <b>Read</b> in parallel, but <b>write</b> to multiple disks</td>
</tr>
<tr class="info-bg">
<td><b>Capacity</b></td>
<td>- <code>50%</code></td>
</tr>
<tr class="special-bg">
<td><b>Reliability</b></td>
<td>+ Can now <strong class="danger">lose</strong> <code>half</code> of disks and still operate</td>
</tr>
</tbody>
</table>

</div>

</div>

---

# RAID: <span class="gold">Parity</span>

Rather than storing a copy of data, we can store a <strong class="special">parity
block</strong> which serves as an <strong class="warning">error detection code</strong>:

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
<td>XOR(0, 0, 1, 1) = 0</td>
</tr>
<tr class="success-bg">
<td>0</td>
<td>1</td>
<td>0</td>
<td>0</td>
<td>XOR(0, 1, 0, 0) = 1</td>
</tr>
</tbody>
</table>

- We need a <strong class="special">parity block</strong> for each <strong
  class="success">stripe</strong> of data.

- If we lose a block, we can use the <strong class="special">parity
  block</strong> to <strong class="warning">reconstruct</strong> missing
  portion.

---

# RAID: <span class="gold">5</span> (<i class="muted">Parity Blocks</i>)

<strong class="warning">RAID 5</strong> requires at least `3` <strong
class="info">disks</strong>, and rotates the <strong
class="special">parity</strong> across each <strong class="info">disk</strong>
in the <strong class="warning">array</strong>.

<br>

<div class="columns-2-1">

<div class="centered">

<img src="static/img/slides20-raid-5.svg" width="700px">

</div>

<div>

<table class="bordered font-small">
<tbody>
<tr class="success-bg">
<td><b>Performance</b></td>
<td>~ <b>Read</b> in parallel, but <b>write</b> to multiple disks</td>
</tr>
<tr class="info-bg">
<td><b>Capacity</b></td>
<td>~ At least <code>66%</code></td>
</tr>
<tr class="special-bg">
<td><b>Reliability</b></td>
<td>~ Can now <strong class="danger">lose</strong> <code>one</code> disk and still operate</td>
</tr>
</tbody>
</table>

</div>

</div>

---

# RAID: <span class="gold">10</span> (<i class="muted">Mirroring + Striping</i>)

<br>

<div class="columns-2-1">

<div class="centered">

<img src="static/img/slides20-raid-10.svg" width="700px">

</div>

<div>

<table class="bordered font-small">
<tbody>
<tr class="success-bg">
<td><b>Performance</b></td>
<td>+ I/O in parallel</td>
</tr>
<tr class="info-bg">
<td><b>Capacity</b></td>
<td>- <code>50%</code></td>
</tr>
<tr class="special-bg">
<td><b>Reliability</b></td>
<td>+ Can now <strong class="danger">lose</strong> <code>half</code> of disks and still operate</td>
</tr>
</tbody>
</table>

</div>

</div>

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
