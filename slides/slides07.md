---
title: "Slides 07: Concurrency"
description: "Concurrency"
author: Peter Bui
keywords: lecture,osp,concurrency
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides07.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Concurrency

---

# Questions

<div class="font-large">

1. What is <strong class="success">concurrency</strong>?

2. What is <strong class="danger">parallelism</strong>?

3. What are some <strong class="caution">examples</strong>?

4. What are some <strong class="special">challenges</strong>?

</div>

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

<!-- _class: lead -->

# Concurrency

---

# Concurrency: <span class="gold">Overview</span>

<div class="columns">

<div>

Whenever we structure a problem such that we have <strong
class="caution">multiple streams of execution</strong>, we have <strong
class="success">concurrency</strong>.

<br>
<br>

<div class="centered">
<img src="static/img/slides07-client-server-single.svg">
</div>

</div>

<div>

Whenever we have the <strong class="info">hardware resources</strong> to
simultaneously execute <strong class="caution">multiple streams of
executions</strong>, we have <strong class="danger">parallelism</strong>.

<br>

<div class="centered">
<img src="static/img/slides07-client-server-multi.svg">
</div>

</div>

</div>

---

# Concurrency: <span class="gold">Internal</span>

<div class="columns">

<div>

In addition to <strong class="caution">inter-process concurrency</strong>, we
can also have <strong class="success">internal concurrency</strong> within a
single <strong class="success">process</strong>:

1. <strong class="danger">Signals</strong>

2. <strong class="warning">Mixing I/O and Computation</strong>

3. <strong class="special">Background vs foreground</strong>

</div>

<div>

<div class="centered">
<img src="static/img/slides07-process.svg">
</div>

<br>

### <strong class="success">Concurrent tasks</strong>

1. **Update** counter

2. **Handle** shell commands

</div>

</div>

---

# Concurrency: <span class="gold">Threads</span>

<div class="columns-2-1">

<div>

We can implement <strong class="success">internal concurrency</strong> by dividing a
<strong class="success">process</strong> into <strong class="caution">multiple streams of
execution</strong>.

- <strong class="special">Shared process state</strong>, except

    - Separate **registers**
    - Separate **stack**
    - Separate **thread control block**

- Enables <strong class="success">concurrency</strong>
- Enables <strong class="danger">parallelism</strong>

</div>

<div class="centered">
<br>
<img src="static/img/slides07-threads.svg" height="500px">
</div>

</div>

---

# Concurrency: <span class="gold">Sharing Problem</span>

<div class="columns-2-1">

<div>

1. <strong class="danger">Shared Data</strong>

    Multiple tasks which to access <strong class="special">common
    resource</strong> concurrently.

2. <strong class="info">Uncontrolled Scheduling</strong>

    No control over when a task runs, so access is <strong class="warning">not
    ordered</strong>.

3. <strong class="success">Need For Atomicity</strong>

    Want operation where we will not be <strong
    class="danger">interrupted</strong>.

</div>

<div class="centered">
<br>
<img src="static/img/slides07-sharing-problem.svg" height="300px">

<b><i class="danger">Unrestricted<br>Access</i></b>

</div>

</div>

---

# Concurrency: <span class="gold">Threaded Solution</span>

<div class="columns-2-1">

<div>

1. <strong class="danger">Critical Section</strong>

    A body of code that accesses a <strong class="special">shared
    resource</strong>.

2. <strong class="info">Race Condition</strong>

    Arises if multiple tasks enter <strong class="danger">critical
    section</strong> at the same time.

3. <strong class="success">Mutual Exclusion</strong>

    A means of guaranteeing that only a single <strong
    class="info">thread</strong> enters a <strong class="danger">critical
    section</strong>.

</div>

<div class="centered">
<br>
<img src="static/img/slides07-threaded-solution.svg" height="300px">

<b><i class="success">Restricted<br>Access</i></b>

</div>

</div>
