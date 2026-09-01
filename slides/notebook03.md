---
title: "Notebook 03: System Calls"
description: "System Calls"
author: Peter Bui
keywords: notebook,osp,system calls
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook03.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## System Calls

---

# Questions

<div class="font-large">

1. What is a <strong class="warning">system call</strong>?

2. What is the difference between <strong class="success">user</strong> and
   <strong class="danger">kernel</strong> mode?

3. What is a <strong class="info">trap</strong> and how is a <strong
   class="caution">trap table</strong> used to handle <strong
   class="warning">system calls</strong>?

</div>

---

# House of Cards

<div class="slide-centered">
    <img src="static/img/slides00-house-of-cards-blank.png">
</div>

---

# System Calls: <span class="gold">Overview</span>

A <strong class="info">system call</strong> occurs when a
<strong class="special">_________________________</strong> requests a

<strong class="warning">service or resource</strong> from the
<strong class="caution">_________________________</strong>.

<div class="centered">

<table class="bordered">
<tbody>
<tr class="success-bg"><td height="60px"><b>I/O</b></td><td width="700px"></td></tr>
<tr class="caution-bg"><td height="60px"><b>File</b></td><td></td></tr>
<tr class="info-bg"><td height="60px"><b>Directory</b></td><td></td></tr>
</tbody>
</table>

<br>

<div class="alert warning-bg font-smaller">

To track the <strong class="warning">system calls</strong> made by an
application, we can use:

<strong class="info">_________________________</strong>.

</div>

</div>

---

# System Calls: <span class="gold">Demonstration</span>

<div class="slide-centered font-large muted">

<i>Demonstrate [hello.c], [hello-asm.s], [hello-asm-64.s].</i>

</div>

[hello.c]: https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture03/hello.c
[hello-asm.s]: https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture03/hello-asm.s
[hello-asm-64.s]: https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture03/hello-asm-64.s

---

# System Calls: <span class="gold">Address Space</span>

<div class="slide-centered">

<img src="static/img/notebook03-address-space-blank.png">

</div>

---

# System Calls: <span class="gold">User vs Kernel Mode</span>

An <strong class="caution">interrupt</strong>, <strong
class="caution">trap</strong>, or <strong class="caution">exception</strong> is an
<strong class="caution">_________________________</strong>

that forces the <strong class="info">_________________________</strong> to transition from

<strong class="success"> ____________________</strong> mode
to <strong class="danger"> ____________________</strong> mode.

<br>
<br>

<div class="centered">

<img src="static/img/notebook03-user-vs-kernel-mode-blank.png">

</div>

---

# System Calls: <span class="gold">Processor Events</span>

A variety of <strong class="warning">events</strong> or <strong
class="warning">exceptions</strong> can cause a **transition** from <strong
class="success">user mode</strong> to <strong class="danger">kernel
mode</strong>:

<table class="bordered font-small">
<thead>
    <th>Class</th>
    <th>Cause</th>
    <th>Sync?</th>
    <th>Return Behavior</th>
</thead>
<tbody>
    <tr class="info-bg">
        <td width="200px"></td>
        <td>Signal from I/O device</td>
        <td>Async</td>
        <td>Always return to next instruction</td>
    </tr>
    <tr class="warning-bg">
        <td width="200px"></td>
        <td><strong>Intentional exception</strong></td>
        <td><strong>Sync</strong></td>
        <td><strong>Always return to next instruction</strong></td>
    </tr>
    <tr class="special-bg">
        <td width="200px"></td>
        <td>Potentially recoverable error</td>
        <td>Sync</td>
        <td>Might return to next instruction</td>
    </tr>
    <tr class="danger-bg">
        <td width="200px"></td>
        <td>Nonrecoverable error</td>
        <td>Sync</td>
        <td>Never returns</td>
    </tr>
</tbody>
</table>

<div class="centered">

When these <strong class="info">events</strong>, the <strong
class="info">processor</strong> consults the

<strong class="caution"> _________________________</strong>
or
<strong class="caution"> _________________________</strong>

to determine what to do next (*what <strong class="caution">handler</strong> code to execute*).

</div>

---

# System Calls: <span class="gold">Skit</span>

<div class="columns-3-1">

<div class="font-smaller">

1. <strong class="caution"> ________________________</strong> registers handlers in

    <strong class="warning"> ________________________</strong>.

    <br>

2. <strong class="success"> ________________________</strong>:

    - Records <strong class="warning"> _________________________</strong>

    - Records <strong class="warning"> _________________________</strong>

    - Triggers <strong class="info"> _________________________</strong>

    <br>

3. <strong class="info"> _________________________</strong> uses

    <strong class="warning"> _________________________</strong> to select handler.

    <br>

4. <strong class="caution"> _________________________</strong> performs handler.

</div>

<div class="centered font-smaller">

<table class="bordered">
<thead>
    <th class="info-bg">#</th>
    <th class="success-bg">Syscall</th>
</thead>
<tbody>
<tr>
    <td class="info-bg"><b>1</b></td>
    <td class="success-bg">read(n)<br><i class="font-small">Read passage</i></td>
</tr>
<tr>
    <td class="info-bg"><b>2</b></td>
    <td class="success-bg">write(s, n)<br><i class="font-small">Write passage</i></td>
</tr>
<tr>
    <td class="info-bg"><b>3</b></td>
    <td class="success-bg">kill(pid, sig)<br><i class="font-small">Send signal to process</i></td>
</tr>
<tr>
    <td class="info-bg"><b>4</b></td>
    <td class="success-bg">exit(status)<br><i class="font-small">Terminate process</i></td>
</tr>
</thead>
</tr>
</tbody>
</table>

</div>

</div>

---

# System Calls: <span class="gold">Traps</span>

<div class="columns-3-1">

<div class="centered">

<br>

<img src="static/img/slides03-system-call-trap-blank.png" width="800">

</div>

<div class="centered middled">

The <strong class="caution">trap table</strong> is loaded during <strong
class="danger"> _________________</strong> by the <strong
class="caution"> _________________</strong>, which registers which
<strong class="caution">handler functions</strong> to execute based on the
<strong class="info"> _________________</strong> number.

</div>

</div>
