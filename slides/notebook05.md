---
title: "Notebook 05: Scheduling (FIFO, Round Robin)"
description: "Scheduling, FIFO, Round Robin"
author: Peter Bui
keywords: lecture,osp,scheduling,fifo, round robin
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides05.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Scheduling<br>(<i class="muted">FIFO</i>, <i class="muted">Round Robin</i>)

---

# Questions

<div class="font-large">

1. What is the purpose of a <strong class="caution">scheduler</strong>?

2. When does a <strong class="caution">scheduler</strong> execute?

3. What are some common <strong class="warning">scheduling policies</strong>?

4. How do we <strong class="danger">evaluate</strong> a <strong
   class="warning">scheduling policy</strong>?

</div>

---

<!-- _class: lead -->

# Scheduling

---

# Scheduling: <span class="gold">Purpose</span>

> What is the purpose of a <strong class="success">scheduler</strong>?

---

# Process: <span class="gold">Life Cycle</span> (<i class="muted">Review</i>)

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides04-process-life-cycle-blank.png" width="725">

</div>

---

# Process: <span class="gold">States</span> (<i class="muted">Review</i>)

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides04-process-states-blank.png" width="1000">

</div>

---

# Process: <span class="gold">Context Switch</span> (<i class="muted">Review</i>)

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides04-process-context-switch-blank.png" width="720">

</div>

---

# Scheduling: <span class="gold">Overview</span>

> When does a <strong class="success">scheduler</strong> execute?

<br>

<div class="font-large">

1. <strong> ________________________________________________</strong>

    <br>

2. <strong> ________________________________________________</strong>

    <br>

3. <strong> ________________________________________________</strong>

</div>

---

# Scheduling: <span class="gold">Workload</span>

To make <strong class="warning">scheduling policies</strong>, we need to
consider our <strong class="danger">workload</strong>, or collection of <strong
class="success">processes</strong> running on our system.  Let's start with the
following <strong class="caution">assumptions</strong>:

1. <strong> ____________________________________________________________</strong>

    <br>

2. <strong> ____________________________________________________________</strong>

    <br>

3. <strong> ____________________________________________________________</strong>

    <br>

4. <strong> ____________________________________________________________</strong>

    <br>

5. <strong> ____________________________________________________________</strong>

---

# Scheduling: <span class="gold">Metrics</span>

To compare different <strong class="warning">scheduling policies</strong>, we
need to consider different <strong class="caution">metrics</strong>:

<div class="columns margin-top-0-5">

<div class="alert danger-bg centered">

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

</div>

<div class="alert success-bg centered">

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

</div>

</div>

---

<!-- _class: lead -->

<div class="centered">

<a href="https://www.youtube.com/embed/Psvf4qN8yao?si=fHLUDE41UUh-kPEH">
<img src="static/img/notebook05-scheduling-thumbnail.png">
</a>

---

<!-- _class: lead -->

# FIFO

---

# FIFO: <span class="gold">Overview</span>

<br>

<div class="centered">

<img src="static/img/slides05-fifo-overview.png">

</div>

---

# FIFO: <span class="gold">Algorithm</span>

---

# FIFO: <span class="gold">Example 1</span>

Jobs <strong class="success">A</strong>, <strong class="info">B</strong>, and
<strong class="caution">C</strong> arrive at time `0` and run for `5` seconds
each:

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/slides05-fifo-example.png">

</div>

---

# FIFO: <span class="gold">Example 2</span>

Job <strong class="success">A</strong> arrives at time `0` and runs for `30`
seconds, while <strong class="info">B</strong> and <strong
class="caution">C</strong> also arrive at time `0` but run for `5` seconds:

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/slides05-fifo-convoy.png">

</div>

<div class="columns">

---

# FIFO: <span class="gold">Example 3</span>

One way to combat the <strong class="danger">Convoy Effect</strong>, is to rank our
<strong class="gold">FIFO</strong> such that we always select the <strong class="warning">shortest job first
(SJF)</strong>.

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/slides05-fifo-sjf.png">

</div>

---

# FIFO: <span class="gold">Summary</span>

<div class="font-large">

1. <strong> ________________________________________________</strong>

    <br>

2. <strong> ________________________________________________</strong>

    <br>

3. <strong> ________________________________________________</strong>

    <br>

4. <strong> ________________________________________________</strong>

</div>

---

<!-- _class: lead -->

# Round Robin

---

# Round Robin: <span class="gold">Overview</span>

<br>

<div class="centered">

<img src="static/img/slides05-rdrn-overview.png">

</div>

---

# Round Robin: <span class="gold">Algorithm</span>

---

# Round Robin: <span class="gold">Example</span>

Jobs <strong class="success">A</strong>, <strong class="info">B</strong>, and
<strong class="caution">C</strong> arrive at time `0` and run for `5` seconds
each:

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/slides05-rdrn-overview.png">

</div>

---

# Round Robin: <span class="gold">Summary</span>

<div class="font-large">

1. <strong> ________________________________________________</strong>

    <br>

2. <strong> ________________________________________________</strong>

    <br>

3. <strong> ________________________________________________</strong>

    <br>

4. <strong> ________________________________________________</strong>

    <br>

5. <strong> ________________________________________________</strong>

</div>
