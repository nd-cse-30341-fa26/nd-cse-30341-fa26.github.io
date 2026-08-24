---
title: "Slides 03: System Calls"
description: "System Calls"
author: Peter Bui
keywords: lecture,osp,system calls
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides03.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## System Calls

---

# Questions

1. What is a <strong class="warning">system call</strong>?

2. What is the difference between <strong class="success">user</strong> and
   <strong class="danger">kernel</strong> mode?

3. What is a <strong class="info">trap</strong> and how is a <strong
   class="caution">trap table</strong> used to handle <strong
   class="warning">system calls</strong>?

---

# House of Cards

<div class="slide-centered">
    <img src="static/img/house-of-cards.png">
</div>

---

# System Calls: <span class="gold">Overview</span>

A <strong class="info">system call</strong> occurs when a <strong
class="success">user application</strong> requests a <strong
class="warning">service, operation, or resource</strong> from the <strong
class="danger">operating system kernel</strong>.

<div class="columns">

<div class="font-small">

- <strong class="caution">I/O operations</strong>

    - open/close
    - read/write

- <strong class="caution">File manipulation</strong>

    - stat
    - access

- <strong class="caution">Process control</strong>

    - fork/exec/wait
    - kill/signal

- <strong class="caution">Network communication</strong>

    - socket
    - listen/bind
    - connect

</div>

<div class="centered font-smaller margin-top-0-5">

<br>

<img src="static/img/slides03-system-call.png" width=600>

<strong class="danger">/usr/include/{bits,sys}/syscall.h</strong>

</div>

</div>

---

# System Calls: <span class="gold">Tracing</span>

We can trace the <strong class="info">system calls</strong> requested by an
<strong class="special">application</strong> by using the <strong
class="warning">strace</strong> utility:

<div class="columns">

```bash
# Trace all system calls
$ strace ./program

# Trace an existing process
$ strace -p pid

# Trace only open system calls
$ strace -e open ./program

# Summarize trace with table of counts
$ strace -c ./program
```

<div class="centered margin-top-0-5">

<a href="https://medium.com/@adminstoolbox/debugging-using-strace-efda7d65be1d"><img src="https://miro.medium.com/v2/resize:fit:640/format:webp/1*RhH4SczOSZ_dFUQ5id-4Fg.png" width=600 class="framed"></a>

</div>

</div>

---

# System Calls: <span class="gold">User vs Kernel Mode</span>

Modern <strong class="info">processors (*CPUs*)</strong> have a security model
where programs are separated into different <strong class="special">protection
rings</strong> or <strong class="special">modes</strong>.

<div class="columns">

<div class="centered margin-top-0-5">

<a title="Hertzsprung at English Wikipedia, CC BY-SA 3.0
&lt;http://creativecommons.org/licenses/by-sa/3.0/&gt;, via Wikimedia Commons"
href="https://commons.wikimedia.org/wiki/File:Priv_rings.svg"><img width="420"
alt="Privilege rings for the x86 architecture, along with their common uses."
src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Priv_rings.svg/960px-Priv_rings.svg.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail"></a>

</div>

<div class="middled">

During a <strong class="warning">system call</strong> the <strong
class="info">processor</strong> transitions from <strong class="success">user
mode (*Ring 3*)</strong> to <strong class="danger">kernel mode (*Ring
0*)</strong>.

</div>

</div>

<div class="centered">

*<strong class="caution">Invalid accesses</strong> to <strong
class="warning">controlled resources</strong> from <strong
class="success">outer rings</strong> can be handled by programs running in the
<strong class="danger">inner rings</strong>.*

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
    <th>Async/Sync</th>
    <th>Return Behavior</th>
</thead>
<tbody>
    <tr class="info-bg">
        <td>Interrupt</td>
        <td>Signal from I/O device</td>
        <td>Async</td>
        <td>Always return to next instruction</td>
    </tr>
    <tr class="warning-bg">
        <td><strong>Trap</strong></td>
        <td><strong>Intentional exception</strong></td>
        <td><strong>Sync</strong></td>
        <td><strong>Always return to next instruction</strong></td>
    </tr>
    <tr class="special-bg">
        <td>Fault</td>
        <td>Potentially recoverable error</td>
        <td>Sync</td>
        <td>Might return to next instruction</td>
    </tr>
    <tr class="danger-bg">
        <td>Abort</td>
        <td>Nonrecoverable error</td>
        <td>Sync</td>
        <td>Never returns</td>
    </tr>
</tbody>
</table>

<div class="centered">

When these <strong class="info">events</strong>, the <strong
class="info">processor</strong> consults the <strong class="caution">interrupt
vector table</strong> or <strong class="caution">trap table</strong> to
determine what to do next<br>(*what <strong class="caution">handler</strong> code
to execute*).

</div>

---

# System Calls: <span class="gold">Traps</span>

To perform a <strong class="info">system call</strong>, a <strong
class="special">user application</strong> performs a <strong
class="warning">trap</strong> to **interrupt** the <strong
class="info">processor</strong> and force it to look up the appropriate <strong
class="caution">handler function</strong> in the <strong class="caution">trap
table</strong>.

<div class="columns-2-1">

<div class="centered margin-top-0-5">

<img src="static/img/slides03-system-call-trap.png" width=690>

</div>

<div class="centered middled">

The <strong class="caution">trap table</strong> is loaded during <strong
class="danger">boot</strong> by the <strong class="caution">kernel</strong>,
which registers which <strong class="caution">handler functions</strong> to
execute based on the <strong class="info">system call</strong> number.

</div>

</div>

