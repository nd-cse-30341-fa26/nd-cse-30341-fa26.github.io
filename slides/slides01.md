---
title: "Lecture 01: Computer Hardware, Boot Sequence"
description: "Computer Hardware, Boot Sequence"
author: Peter Bui
keywords: lecture,osp,hardware,boot
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides01.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Computer Hardware, Boot Sequence

---

# House of Cards

<div class="slide-centered">
    <img src="static/img/slides00-house-of-cards.png" class="padding-10">
</div>

---

<!-- _class: lead -->

# Computer Hardware

---

# Computer Hardware: <span class="gold">A Computer is ...</span>

A general purpose <strong class="caution">information processing</strong>
machine.

<br>

<div class="centered">
    <img src="static/img/slides01-personal-computers.png" class="bordered">
</div>

A <strong class="caution">digital computer</strong> is an electronic device that
processes <strong class="special">binary data</strong>.

---

# Computer Hardware: <span class="gold">Architecture</span>

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides01-logical-construction.png">

</div>

---

# Computer Hardware: <span class="gold">Devices</span>

<div class="columns">

<div class="slide-centered">

<a title="Fred the Oyster, CC BY-SA 4.0 &lt;https://creativecommons.org/licenses/by-sa/4.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Chipset_schematic.svg"><img width="475" alt="Chipset schematic" src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Chipset_schematic.svg/500px-Chipset_schematic.svg.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail"></a>

</div>

<div class="slide-centered">

A modern <strong class="caution">computer</strong> is a collection of smaller
<strong class="special">specialized</strong> computing devices that <strong
class="success">work together</strong> by <strong
class="danger">communicating</strong> using a variety of protocols and
interfaces.

</div>

</div>

---

# Computer Hardware: <span class="gold">Processor</span>

<div class="columns">

<div>

The <strong class="caution">central processing unit (*CPU*)</strong> is the
<strong class="success">“brains”</strong> of the computer:

- Does <strong class="success">arithmetic</strong>, moves <strong
  class="caution">data</strong> around, <strong class="info">controls</strong>
  the operation of everything else

- Limited set of <strong class="success">operations</strong>; but fast
  (*billions per second*)

</div>

<div class="slide-centered">
    <img src="https://www.apple.com/newsroom/images/2025/10/apple-unleashes-m5-the-next-big-leap-in-ai-performance-for-apple-silicon/article/Apple-M5-chip-251015_inline.jpg.large.jpg" class="framed" width="420">
</div>

</div>

---

# Computer Hardware: <span class="gold">Memory</span>

<div class="columns">

<div class="slide-centered">

<a title="An-d, CC BY-SA 3.0 &lt;https://creativecommons.org/licenses/by-sa/3.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Swissbit_2GB_PC2-5300U-555.jpg"><img width="420" alt="Swissbit DDR2-555 RAM." src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Swissbit_2GB_PC2-5300U-555.jpg/960px-Swissbit_2GB_PC2-5300U-555.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail" class="framed"></a>

</div>

<div>

<strong class="caution">Random Access Memory (*RAM*)</strong> stores <strong
class="success">information</strong> that is in active use by the <strong
class="caution">processor</strong>:

- Contents can be modified by <strong class="caution">CPU</strong>

- Contents include both <strong class="special">data</strong> and <strong
  class="success">instructions</strong>

- Contents are <strong class="danger">volatile</strong>
</div>

</div>


---

# Computer Hardware: <span class="gold">Storage</span>

<strong class="caution">Persistent storage devices</strong> store <strong
class="success">information</strong> even when <strong class="warning">powered
off</strong>:

<br>

<div class="columns">

<div class="centered">
<a title="Bubba73, CC BY-SA 4.0 &lt;https://creativecommons.org/licenses/by-sa/4.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Hatachi_500_GB_hard_drive,_2011.jpg"><img width="420" alt="Hatachi 500GB hard drive, from 2001" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Hatachi_500_GB_hard_drive%2C_2011.jpg/960px-Hatachi_500_GB_hard_drive%2C_2011.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail" class="framed"></a>
</div>

<div class="centered middled">
<a title="Jacek Halicki, CC BY-SA 4.0 &lt;https://creativecommons.org/licenses/by-sa/4.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:2023_Dysk_SSD_Kingston_NV2_2TB.jpg"><img width="420" alt="Kingston NV2 2TB solid-state drive" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/2023_Dysk_SSD_Kingston_NV2_2TB.jpg/960px-2023_Dysk_SSD_Kingston_NV2_2TB.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail" class="framed"></a>
</div>

</div>

- <strong class="danger">Hard drives</strong> (*magnetic disks*)

- <strong class="success">Solid state drives</strong> (*NAND flash memory*)

---

# Computer Hardware: <span class="gold">Input / Output</span>

<strong class="caution">I/O devices</strong> allow the user to <strong
class="warning">input</strong> data and enable the computer to provide <strong
class="special">output</strong> back to the user:

<br>

<div class="columns">

<div class="centered">

<img src="https://m.media-amazon.com/images/I/61zFTeuq7HL._AC_UF894,1000_QL80_.jpg" height="300" class="framed">

</div>

<div class="centered middled">

<img src="https://i.pcmag.com/imagery/reviews/04ozusma5fziurhifa312hy-4-hero-image-gallery.fit_scale.size_1050x594.v1569477526.jpg" height="300" class="framed">

</div>

</div>

- Keyboards, mice, network cards, etc.

- Displays, printers, etc.

---

# Computer Hardware: <span class="gold">Components</span>

<div class="columns-2-1">

<div>

<strong class="success">Identify</strong> the following <strong
class="caution">components</strong> in the provided computers:

1. <strong class="success">Processor</strong>

2. <strong class="caution">Memory</strong>

3. <strong class="danger">Storage</strong>

4. <strong class="special">I/O</strong>


</div>

<div class="slide-centered margin-top-0-5">

<img src="https://www.techspot.com/articles-info/254/images/18b.jpg" width="240" class="framed">

<img src="https://c1.neweggimages.com/productimage/nb640/11-153-127-02.jpg" width="240" class="framed">

<img src="https://i.ebayimg.com/images/g/MEcAAOSwvnRkMj6B/s-l400.jpg" width="240" class="framed">

</div>

</div>

---

<!-- _class: lead -->

# Boot Sequence

---

# Boot Sequence: <span class="gold">BIOS / UEFI</span>

<div class="columns-1-3">

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides01-boot-sequence.png">

</div>

<div>

The <strong class="info">Basic I/O System (*BIOS*)</strong> or <strong
class="info">Unified Extensible Firmeware Interface (*UEFI*)</strong> is the
first program (ie. <strong class="special">*firmware*</strong>) that is
executed by the <strong class="caution">processor</strong> when the computer is
powered on:

- Usually stored in <strong class="danger">ROM</strong>

- Performs some basic <strong class="caution">system integrity</strong> checks

- Searches for <strong class="danger">device to boot</strong> or <strong
  class="success">primary bootloader</strong>

</div>

</div>

---

# Boot Sequence: <span class="gold">MBR / GPT</span>

<div class="columns-1-3">

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides01-boot-sequence.png">

</div>

<div>

The <strong class="danger">Master Boot Record (MBR)</strong> or <strong
class="danger">GUID Partition Table (GPT)</strong> is a special <strong
class="primary">data structure</strong> that records the organization of the
<strong class="danger">storage</strong> device.

<a href="https://www.freecodecamp.org/news/linux-boot-process-in-rhel/"><img src="https://www.freecodecamp.org/news/content/images/2024/01/image--1--1.png" class="framed float-right" width="200"></a>

- The <strong class="primary">partition table</strong> maps how the storage
  device is divided into separate <strong class="warning">partitions</strong>

- <strong class="danger">MBR</strong> is limited to <strong
  class="special">4</strong> <strong class="warning">partitions</strong>, while <strong
  class="danger">GPT</strong> is limited to <strong
  class="special">128</strong> <strong class="warning">partitions</strong>

- <strong class="danger">MBR</strong> contains a small *primary* <strong
  class="success">bootloader</strong> program whose job is to locate the active
  boot <strong class="special">partition</strong> and launch the next <strong
  class="success">bootloader</strong>

</div>

</div>

---

# Boot Sequence: <span class="gold">Bootloader</span>

<div class="columns-1-3">

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides01-boot-sequence.png">

</div>

<div>

The *secondary* <strong class="success">bootloader</strong> is a program that
loads the <strong class="caution">operarting system kernel</strong> and an
optional <strong class="caution">RAM</strong> disk.

- Because this program is not restricted to the <strong
  class="danger">MBR</strong>, it can be larger and support features such as
  multiple filesystem support and graphical menus

- The <strong class="caution">RAM</strong> disk is a *temporary* <strong
  class="caution">in-memory</strong> <strong
  class="primary">filesystem</strong> with essential **drivers** and **tools**
  for loading the physical <strong class="danger">storage devices</strong>

- **Examples**: [GRUB], [systemd-boot], [Limine]


[GRUB]: https://www.gnu.org/software/grub/
[systemd-boot]: https://www.freedesktop.org/software/systemd/man/latest/systemd-boot.html
[Limine]: https://github.com/limine-bootloader/limine

</div>

</div>

---

# Boot Sequence: <span class="gold">Kernel</span>

<div class="columns-1-3">

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides01-boot-sequence.png">

</div>

<div>

The <strong class="success">kernel</strong> is the core of the <strong
class="primary">operating system</strong> whose job is to provide <strong
class="caution">abstractions</strong> such as *processes*, *threads*, *virtual
memory*, and *filesystems* such that <strong
class="special">applications</strong> can efficiently utilize the underlying
<strong class="info">hardware</strong> and interact with each other.

On **Linux** and **macOS**, to see the **kernel** messages since **boot**, use:

```bash
# Print kernel messages
$ dmesg
```

</div>

</div>

---

# Boot Sequence: <span class="gold">Init</span>

<div class="columns-1-3">

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides01-boot-sequence.png">

</div>

<div>

<strong class="special">Init</strong> is the first user-space application and
is in charge of **configuring**, **executing**, and **supervising** user-space
daemons and services.

- <strong class="success">System Bootstrapping</strong>: Mount file systems,
  configure networking, start services

- <strong class="caution">Service Management</strong>: Starts, stops, and monitors
  system services

- <strong class="danger">Process Reaping</strong>: Adopts orphan <strong
  class="success">processes</strong> and cleans up their resources when
  terminated

**Examples**: **sysvinit**, [systemd], [openrc], [runit]

[systemd]: https://systemd.io/
[openrc]: https://github.com/OpenRC/openrc
[runit]: https://smarden.org/runit/

</div>

</div>

---

# An Operating System is ...

A set of <strong class="caution">abstractions</strong> (*processes*, *threads*,
*virtual memory*, *filesystems*) that enable <strong
class="special">applications</strong> to effectively and efficiently utilize
<strong class="info">hardware</strong> resources and interact with each other.

<img src="static/img/house-of-cards.png" class="float-right" width="500">

- <strong class="info">Computer Architecture</strong>

- <strong class="caution">Data Structures</strong>

- <strong class="success">Algorithms</strong>
