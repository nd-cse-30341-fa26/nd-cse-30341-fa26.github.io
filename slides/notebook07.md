---
title: "Notebook 07: Event-based Concurrency"
description: "Event-based Concurrency"
author: Peter Bui
keywords: notebook,osp,events,concurrency
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook07.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Event-based Concurrency

---

# Questions

<div class="font-large">

1. What exactly is <strong class="success">concurrency</strong>? <strong
   class="danger">parallelism</strong>?

    - What are some <strong class="caution">examples</strong>?

    - What are some <strong class="special">challenges</strong>?

2. How do we <strong class="caution">overlap I/O and compute</strong> within a single
   <strong class="success">process</strong>?

    - What <strong class="warning">system calls</strong> can we use?

    - How do we use these <strong class="warning">system calls</strong>?

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

<div class="centered">

Whenever we structure a

problem such that we have

<strong class="caution"> ______________________________</strong>, 

we have 

<strong class="success"> ______________________________</strong>.

</div>

<div class="centered">

Whenever we have the 

<strong class="info"> ______________________________</strong>

to simultaneously execute

<strong class="caution"> ______________________________</strong>, 

we have 

<strong class="danger"> ______________________________</strong>.

</div>

</div>

---

# Concurrency: <span class="gold">Internal</span>

<div class="columns">

<div>

<div class="centered">
<br>
<img src="static/img/slides07-process.svg">
</div>

<br>

### <strong class="success">Concurrent tasks</strong>

1. <strong> ___________________________</strong>

    <br>

2. <strong> ___________________________</strong>

</div>

<div>

In addition to <strong class="caution">inter-process concurrency</strong>, we
can also have <strong class="success">internal concurrency</strong> within a
single <strong class="success">process</strong>:

1. <strong> ___________________________</strong>

    <br>

2. <strong> ___________________________</strong>
    
    <br>

3. <strong> ___________________________</strong>

</div>

</div>

---

# Concurrency: <span class="gold">Threads</span>

<div class="columns-2-1">

<div>

We can implement <strong class="success">internal concurrency</strong> by 

dividing a
<strong class="success"> _____________________________</strong>

into 
<strong class="caution"> __________________________________</strong>.

<br>

#### Review: <strong class="success">Machine State</strong>

1. <strong> ________________________________</strong> [ ]

    <br>

2. <strong> ________________________________</strong> [ ]
    
    <br>

3. <strong> ________________________________</strong> [ ]

</div>

<div class="centered">
<br>
<img src="static/img/slides07-threads-blank.svg" height="500px">
</div>

</div>

---

# Concurrency: <span class="gold">Interview Question</span>

<div class="columns">

<div>

**Given**

```c
int f() {
    int i;
    ...
}
```

<div class="centered">

If <strong class="caution">two threads</strong> run `f()`,<br>is there <strong
class="danger">sharing</strong>?

</div>

</div>

<div>

**Given**

```c
int g(char *s) {
    *s = ____;
    ...
}
```

<div class="centered">

If <strong class="caution">two threads</strong> run `g()`,<br>is there <strong
class="danger">sharing</strong>?

</div>

</div>

</div>

---

# Concurrency: <span class="gold">Sharing Problem</span>

<div class="columns">

<div>

1. <strong> ___________________________</strong>

    <br>
    <br>

2. <strong> ___________________________</strong>
    
    <br>
    <br>

3. <strong> ___________________________</strong>

</div>

<div>

1. <strong> ___________________________</strong>

    <br>
    <br>

2. <strong> ___________________________</strong>
    
    <br>
    <br>

3. <strong> ___________________________</strong>


</div>

</div>

---

<!-- _class: lead -->

# Event-based Concurrency

---

# Events: <span class="gold">Overview</span>

If we only need to
<strong class="caution"> ____________________________________________</strong>, 
we can use <strong class="primary">events</strong> to
provide <strong class="success">concurrency</strong> without <strong
class="danger">parallelism</strong>:

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

# Events: [counter.c]

> Implement a `counter` program that periodically **increments a counter** and
> and provides a **shell prompt** that allows the user to view the state of the
> `counter`, reset the `counter` and exit the program.

[counter.c]: https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture07/counter.c
