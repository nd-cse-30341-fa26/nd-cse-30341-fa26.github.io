---
title: "Slides 19: I/O Devices"
description: "I/O Devices"
author: Peter Bui
keywords: lecture,osp,i/o devices,disks"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides19.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## I/O Devices

---

# Questions

<div class="font-large">

1. What is the challenge of <strong class="info">persistence</strong>?

2. How does the <strong class="caution">operating system</strong> mediate data
   transfers between the <strong class="info">CPU</strong> and <strong
   class="danger">disk storage</strong>?

3. What are the <strong class="success">advantages</strong> and <strong
   class="danger">disadvantages</strong> of <strong class="warning">hard
   disks</strong> versus <strong class="caution">solid state drives</strong>?

</div>

---

# Review: <span class="gold">Memory Hierarchy</span>

<div class="slide-centered">

<a href="https://gist.github.com/hellerbarde/2843375">
<img src="https://camo.githubusercontent.com/21e9781dff39ae0055959d1c686278591144f412c759dc77ebe1843e25376024/687474703a2f2f692e696d6775722e636f6d2f6b307431652e706e67" class="framed">
</a>

</div>

---

<!-- _class: lead -->

# I/O Devices

---

# I/O Devices: <span class="gold">System Architecture</span> (<i class="muted">Old</i>)

<div class="slide-centered">

<img src="static/img/slides19-io-system-architecture-old.svg">

</div>

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

<img src="static/img/slides19-io-memory-mapped-io.svg">

<br>

<div class="alert info-bg centered font-smaller">

<strong class="caution">Status</strong>, <strong
class="caution">Command</strong> and <strong class="caution">Data</strong> are
**device registers** that are mapped to certain **physical memory addresses**.

</div>

</div>

<div>

```python
# Wait until device is not busy
while STATUS == BUSY: pass

# Write data and command to registers
Write(DATA, data)
Write(COMMAND, command)

# Wait until request is done
while STATUS == BUSY; pass
```

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
    <td><b>Programmed I/O (PIO)</b></td>
    <td>OS is directly involved data movement</td>
    <td>Simple and works</td>
    <td>Wastes CPU time polling</td>
</tr>
<tr class="caution-bg">
    <td><b>Interrupts</b></td>
    <td>OS issues command and later handles interrupt on completion</td>
    <td>Allows for overlap</td>
    <td>Can be wasteful due to context switch, interrupt storm</td>
</tr>
<tr class="success-bg">
    <td><b>Direct Memory Access (DMA)</b></td>
    <td>OS programs DMA engine to handle data transfers</td>
    <td>Allows for overlap</td>
    <td>Need more hardware, synchronization</td>
</tr>
</tbody>
</table>

---

# I/O Devices: <span class="gold">Device Drivers</span>

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

# I/O Devices: <span class="gold">Linux Utilities</span>

<br>

<table class="bordered font-smaller">
<thead>
    <th class="special-bg">Command</th>
    <th class="special-bg">Description</th>
</thead>
<tbody>
<tr class="info-bg">
    <td><b>lsblk</b></td>
    <td>List mounted file systems</td>
</tr>
<tr class="info-bg">
    <td><b>blkid</b></td>
    <td>List block device information</td>
</tr>
<tr class="success-bg">
    <td><b>mount</b></td>
    <td>Show which file systems are mounted</td>
</tr>
<tr class="caution-bg">
    <td><b>df</b></td>
    <td>Show how much free space we have</td>
</tr>
<tr class="caution-bg">
    <td><b>du</b></td>
    <td>Show how much space a file or directory is using</td>
</tr>
<tr class="warning-bg">
    <td><b>parted / fdisk / cfdisk</b></td>
    <td>Manage disk partitions</td>
</tr>
<tr class="warning-bg">
    <td><b>mkfs.ext{2,3,4}</b></td>
    <td>Format Linux file system</td>
</tr>
<tr class="danger-bg">
    <td><b>fsck</b></td>
    <td>Check and repair file system</td>
</tr>
</tbody>
</table>

---

<!-- _class: lead -->

# Hard Disks

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
    <td><b>Platter</b></td>
    <td>Magnentic surface on which data is stored</td>
</tr>
<tr class="success-bg">
    <td><b>Spindle</b></td>
    <td>Platters are bound together around this component which has a motor</td>
</tr>
<tr class="caution-bg">
    <td><b>Track</b></td>
    <td>Data is encoded in these concentric circles</td>
</tr>
<tr class="warning-bg">
    <td><b>Disk Head</b></td>
    <td>This is used to read / write data to and from the platter</td>
</tr>
<tr class="danger-bg">
    <td><b>Disk Arm</b></td>
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

- We must account for <strong class="danger">rotational delay</strong> (<i
  class="muted">single-track latency</i>)

- We must account for <strong class="danger">seek time</strong> (<i
  class="muted">moving disk head from one track to another</i>)

- We must account for <strong class="danger">settling time</strong> (<i
  class="muted">time required to guarantee correct location</i>)

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

1. <strong class="success">Acceleration</strong>: <strong class="danger">disk
   arm</strong> starts moving

2. <strong class="warning">Coasting</strong>: <strong class="danger">disk
   arm</strong> moving at full speed

3. <strong class="caution">Deceleration</strong>: <strong class="danger">disk
   arm</strong> slows down

4. <strong class="danger">Settling</strong>: <strong class="danger">disk
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
    <td><b>Shortest Seek Time First</b></td>
    <td>Orders the queue of I/O requests by track and picks the nearest tracks to complete first</td>
    <td>Starvation</td>
</tr>
<tr class="caution-bg">
    <td><b>Elevator</b></td>
    <td>Sweep across the disk and service requests as it moves across the tracks</td>
    <td>Ignores Rotation</td>
</tr>
<tr class="success-bg">
    <td><b>Shortest Position Time First</b></td>
    <td>Selects the track with the shortest access time, factoring in seek and rotational time</td>
    <td>Difficult to implement at OS level</td>
</tr>
</tbody>
</table>

```bash
cat /sys/block/sda/queue/scheduler
```

---

<!-- _class: lead -->

# Solid State Drives

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

