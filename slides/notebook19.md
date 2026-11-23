---
title: "Notebook 19: I/O Devices"
description: "I/O Devices"
author: Peter Bui
keywords: notebook,osp,i/o devices,disks"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook19.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## I/O Devices

---

# Review: <span class="gold">OS Themes</span>

1. <strong class="success">_______________________________________________________________</strong>

    <br>
    <br>
    <br>

2. <strong class="danger">______________________________________________________________</strong>

    <br>
    <br>
    <br>

3. <strong class="info">______________________________________________________________</strong>

---

# I/O Devices: <span class="gold">System Architecture</span> (<i class="muted">New</i>)

<div class="slide-centered">

<img src="static/img/slides19-io-system-architecture-new.svg">

</div>

---

# I/O Devices: <span class="gold">Memory Mapped I/O</span>

The <strong class="caution">OS</strong> interacts with a typical <strong
class="info">I/O device</strong> in the following manner:

<br>

<div class="columns">

<div class="centered">

<img src="static/img/slides19-io-memory-mapped-io-blank.svg">

</div>

<div>

</div>

</div>

---

# I/O Devices: <span class="gold">Protocol</span>

There are multiple methods of transfering data between
<strong class="info">memory</strong> and <strong class="danger">disk storage</strong>:

<table class="bordered font-smaller">
<thead>
    <th class="special-bg">Method</th>
    <th class="special-bg">Description</th>
    <th class="special-bg">Pros</th>
    <th class="special-bg">Cons</th>
</thead>
<tbody>
<tr class="danger-bg">
    <td width="250px"><b><br><br><br></b></td>
    <td width="300px"><br></td>
    <td width="275px"><br></td>
    <td width="275px"><br></td>
</tr>
<tr class="caution-bg">
    <td width="250px"><b><br><br><br></b></td>
    <td width="300px"><br></td>
    <td width="275px"><br></td>
    <td width="275px"><br></td>
</tr>
<tr class="success-bg">
    <td width="250px"><b><br><br><br></b></td>
    <td width="300px"><br></td>
    <td width="275px"><br></td>
    <td width="275px"><br></td>
</tr>
</tbody>
</table>

---

# I/O Devices: <span class="gold">Device Drivers</span>

---

# I/O Devices: <span class="gold">LKM</span>

We can create <strong class="special">device drivers</strong> as a [Loadable Kernel
Module](https://en.wikipedia.org/wiki/Loadable_kernel_module), which can be
loaded and unloaded at run-time:

<br>

<table class="bordered">
<thead>
    <th class="special-bg">Command</th>
    <th class="special-bg">Action</th>
</thead>
<tbody>
<tr class="info-bg">
    <td><b>lsmod</b></td>
    <td>List kernel modules</td>
</tr>
<tr class="success-bg">
    <td><b>modinfo</b></td>
    <td>Get module information</td>
</tr>
<tr class="caution-bg">
    <td><b>insmod / modprobe</b></td>
    <td>Install / load kernel module</td>
</tr>
<tr class="danger-bg">
    <td><b>rmmod</b></td>
    <td>Remove kernel module</td>
</tr>
</tbody>
</table>

---

# Hard Disks: <span class="gold">Geometry</span>

<br>

<div class="columns-1-2">

<div class="slide-centered">

<img src="https://lnx.cx/docs/vdg-2/html/images/disk-structure.png" width="400px">

</div>

<div>

<table class="bordered font-smaller">
<thead>
    <th class="special-bg">Term</th>
    <th class="special-bg">Description</th>
</thead>
<tbody>
<tr class="info-bg">
    <td width="275px"><b><br><br></b></td>
    <td>Magnentic surface on which data is stored</td>
</tr>
<tr class="success-bg">
    <td width="275px"><b><br><br></b></td>
    <td>Platters are bound together around this component which has a motor</td>
</tr>
<tr class="caution-bg">
    <td width="275px"><b><br><br></b></td>
    <td>Data is encoded in these concentric circles</td>
</tr>
<tr class="warning-bg">
    <td width="275px"><b><br><br></b></td>
    <td>This is used to read / write data to and from the platter</td>
</tr>
<tr class="danger-bg">
    <td width="275px"><b><br><br></b></td>
    <td>This moves the head to the desired track</td>
</tr>
</tbody>
</table>

</div>

</div>

---

# Hard Disks: <span class="gold">Operations</span>

Since <strong class="info">platters</strong> are constantly spinning, to read
and write data we need to move the <strong class="danger">disk arm</strong> so
that the <strong class="warning">disk head</strong> is in the appropriate
location:

- We must account for <strong class="danger">
  ___________________________________________</strong> (<i
  class="muted">single-track latency</i>)

- We must account for <strong class="danger">
  ___________________________________________</strong> (<i class="muted">moving
  disk head from one track to another</i>)

- We must account for <strong class="danger">
  ___________________________________________</strong> (<i class="muted">time
  required to guarantee correct location</i>)

---

# Hard Disks: <span class="gold">Seeking</span>

<div class="columns">

<div>

During a hard disk <strong class="danger">seek</strong> operation, we have the
following phases:

<br>

<div class="centered">

<img src="https://flylib.com/books/2/944/1/html/2/files/04fig01.gif" class="framed">

</div>

</div>

<div>

1. <strong class="success"> _________________________</strong>: <strong class="danger">disk
   arm</strong> starts moving

2. <strong class="warning"> _________________________</strong>: <strong class="danger">disk
   arm</strong> moving at full speed

3. <strong class="caution"> _________________________</strong>: <strong class="danger">disk
   arm</strong> slows down

4. <strong class="danger">  _________________________</strong>: <strong class="danger">disk
   arm</strong> positioned over <strong class="caution">track</strong>

</div>

</div>

---

# Hard Disks: <span class="gold">Scheduling</span>

As with <strong class="success">processes</strong>, the <strong
class="caution">operating system</strong> can schedule <strong class="info">I/O
operations</strong>:

<table class="bordered font-smaller">
<thead>
    <th class="special-bg">Name</th>
    <th class="special-bg">Description</th>
    <th class="special-bg">Problems</th>
</thead>
<tbody>
<tr class="danger-bg">
    <td class="centered"><b>Shortest Seek Time First</b></td>
    <td>Orders the queue of I/O requests by track and picks the nearest tracks to complete first</td>
    <td width="400px"><br></td>
</tr>
<tr class="caution-bg">
    <td class="centered"><b>Elevator</b></td>
    <td>Sweep across the disk and service requests as it moves across the tracks</td>
    <td width="400px"><br></td>
</tr>
<tr class="success-bg">
    <td class="centered"><b>Shortest Position Time First</b></td>
    <td>Selects the track with the shortest access time, factoring in seek and rotational time</td>
    <td width="400px"><br></td>
</tr>
</tbody>
</table>

---

# Solid State Drives: <span class="gold">Overview</span>

<div class="columns">

<div>

Rather than use <strong class="danger">slow spinning platters</strong>, we can
use <strong class="success">fast non-volatile NAND memory</strong> to store
data.

<br>

- <strong class="success">Faster</strong>
- <strong class="success">Energy efficient</strong>

- <strong class="danger">More expensive</strong>
- <strong class="danger">Unknown reliability</strong>

</div>

<div class="slide-centered">

<img
src="https://media.istockphoto.com/id/501446267/vector/solid-state-drive-diagram.jpg"
class="framed" height="500px">

</div>

</div>

---

# Solid State Drives: <span class="gold">Garbage Collection</span>

Rather than overwrite data, we always write new <strong
class="warning">pages</strong> of data and periodically collect any <strong
class="danger">garbage</strong>:

<br>

<div class="centered">

<img src="https://i.extremetech.com/imagery/content-types/00KKObY3jkU1JS7GJSOl61N/images-5.png" height="400px" class="framed">

</div>

---

# Solid State Drives: <span class="gold">Wear Leveling</span>

Since each individual memory cell has a <strong class="danger">limited number of write
cycles</strong>, we must avoid repeated writing to the same area.

- To support this feature, the <strong class="info">device</strong> provides a
  <strong class="warning">logical block address</strong> to the <strong
  class="caution">OS</strong> and associates these <strong
  class="warning">LBAs</strong> to <strong class="info">physical
  blocks</strong>.

- The <strong class="success">controller</strong> can then move data to
  different <strong class="info">physical blocks</strong> to spread out the
  writes while maintaining the <strong class="warning">logical block address
  space</strong>.

