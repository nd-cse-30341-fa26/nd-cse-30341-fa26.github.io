---
title: "Notebook 08: Events vs Threads"
description: "Events vs Threads"
author: Peter Bui
keywords: notebook,osp,concurrency,events,threads
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook08.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Events vs Threads

---

# Motivation

We want to create an application, `counter`, that does the following:

- Periodically **increments a `counter`**.

- Provides a **shell prompt** that allows the user to enter in a **`command`**:

<table class="bordered">
<thead>
    <th class="info-bg">Command</th>
    <th class="success-bg">Description</th>
</thead>
<tbody>
<tr>
    <td class="info-bg centered"><b>count</b></td>
    <td class="success-bg">Returns the current value of <code>counter</code></td>
</tr>
<tr>
    <td class="info-bg centered"><b>reset</b></td>
    <td class="success-bg">Resets counter to <code>0</code></td>
</tr>
<tr>
    <td class="info-bg centered"><b>exit</b></td>
    <td class="success-bg">Quit program</td>
</tr>
</tbody>
</table>

---

# Events: <span class="gold">Overview</span>

If we only need to
<strong class="caution"> ____________________________________________</strong>,

we can use <strong class="primary">events</strong> to provide
<strong class="success"> ___________________________</strong>
without

<strong class="danger"> ____________________________</strong>:

<div class="columns-2-1">

<div>

<br>

- <strong> _____________________________________</strong>

    <br>

- <strong> _____________________________________</strong>

    <br>

- <strong> _____________________________________</strong>

</div>

<div class="centered">
<br>
<img src="static/img/slides07-event-loop.svg" height="300px">
</div>

</div>

---

<!-- _class: lead -->

# Events: [counter.c](https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture07/counter.c)

---

# Events vs Threads

<br>

<table class="bordered">
<thead>
    <th class="caution-bg"></th>
    <th class="success-bg">Pros</th>
    <th class="danger-bg">Cons</th>
</thead>
<tbody>
<tr>
    <td class="caution-bg centered"><b>Events</b></td>
    <td class="success-bg" width="450px" height="150px"><br><br><br></td>
    <td class="danger-bg" width="450px" height="150px"><br><br><br></td>
</tr>
<tr>
    <td class="caution-bg centered"><b>Threads</b></td>
    <td class="success-bg" width="450px" height="150px"><br><br><br></td>
    <td class="danger-bg" width="450px" height="150px"><br><br><br></td>
</tr>
</tbody>
</table>

---

# Threads: <span class="gold">Overview</span>

We can implement <strong class="primary">thread-based concurrency</strong> by using the

<strong> __________________________________</strong>, which defines functions for:

<div class="columns">

<div>

<br>

- <strong class="warning">___________________________</strong>

    <br>

- <strong class="warning">___________________________</strong>

    <br>

- <strong class="warning">___________________________</strong>

    <br>

- <strong class="warning">___________________________</strong>

</div>

<div class="centered margin-top-0-5">

<img src="static/img/slides08-pthreads-overview-blank.svg">

</div>

</div>

---

# Threads: <span class="gold">Analogs</span>

<table class="bordered">
<thead>
    <th class="caution-bg">Action</th>
    <th class="success-bg">Process</th>
    <th class="info-bg">Thread</th>
</thead>
<tbody>
<tr>
    <td class="caution-bg centered"><b>Create new task</b></td>
    <td class="success-bg" width="400px" height="100px"><br><br></td>
    <td class="info-bg" width="400px" height="100px"><br><br></td>
</tr>
<tr>
    <td class="caution-bg centered"><b>Wait for task</b></td>
    <td class="success-bg" width="400px" height="100px"><br><br></td>
    <td class="info-bg" width="400px" height="100px"><br><br></td>
</tr>
<tr>
    <td class="caution-bg centered"><b>Lock critical section</b></td>
    <td class="success-bg" width="400px" height="100px"><br><br></td>
    <td class="info-bg" width="400px" height="100px"><br><br></td>
</tr>
<tr>
    <td class="caution-bg centered"><b>Notify another task</b></td>
    <td class="success-bg" width="400px" height="100px"><br><br></td>
    <td class="info-bg" width="400px" height="100px"><br><br></td>
</tr>
</tbody>
</table>

---

# Threads: <span class="gold"> ____________________________</span>

(+) <strong class="success"> _____________________________</strong>

(+) <strong class="success"> _____________________________</strong>

<br>

<div class="centered">

<img src="static/img/slides08-pthreads-many-to-one.svg">

</div>

<div class="float-right">

(-) <strong class="danger"> ______________________________</strong>

(-) <strong class="danger"> ______________________________</strong>

</div>

---

# Threads: <span class="gold"> ____________________________</span>

(+) <strong class="success"> _____________________________</strong>

(+) <strong class="success"> _____________________________</strong>

<br>

<div class="centered">

<img src="static/img/slides08-pthreads-one-to-one.svg">

</div>

<div class="float-right">

(-) <strong class="danger"> ______________________________</strong>

(-) <strong class="danger"> ______________________________</strong>

</div>

---

# Threads: <span class="gold"> ____________________________</span>

(+) <strong class="success"> _____________________________</strong>

(+) <strong class="success"> _____________________________</strong>

<br>

<div class="centered">

<img src="static/img/slides08-pthreads-many-to-many.svg">

</div>

<div class="float-right">

(-) <strong class="danger"> ______________________________</strong>

(-) <strong class="danger"> ______________________________</strong>

</div>

---

<!-- _class: lead -->

# Threads: [counter.c](https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture08/counter.c)

---

# Threads: <span class="gold">Disassembly</span>

<div class="columns margin-top-0-5">

<div>

## <strong class="danger">Background Thread</strong>

Counter++

</div>

<div>

## <strong class="success">Foreground Thread</strong>

Counter = 0

</div>

</div>
