---
title: "Slides 06: Scheduling (MLFQ, Lottery)"
description: "Scheduling, MLFQ, Lottery"
author: Peter Bui
keywords: lecture,osp,scheduling,mlfq,lottery
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides06.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Scheduling<br>(<i class="muted">MLFQ</i>, <i class="muted">Lottery</i>)

---

# Questions

<div class="font-large">

1. What are the <strong class="success">strengths</strong> and <strong
   class="danger">weaknesses</strong> of:

    - <strong class="gold">FIFO</strong> Scheduling
    - <strong class="gold">Round Robin</strong> Scheduling

2. How does <strong class="special">MLFQ</strong> address these <strong
   class="danger">weaknesses</strong>?

3. How does <strong class="special">Lottery</strong> address these <strong
   class="danger">weaknesses</strong>?

</div>

---

<!-- _class: lead -->

# Multi-Level<br>Feedback Queue

---

# MLFQ: <span class="gold">Overview</span>

A <strong class="special">Multi-Level Feedback Queue (MLFQ)</strong> tries to
optimize both <strong class="danger">turnaround time</strong> and <strong
class="success">response time</strong>:

- Like <strong class="gold">FIFO</strong>, it tries to complete <strong
  class="warning">shortest jobs first</strong>.

- Like <strong class="gold">Round Robin</strong>, it tries to be <strong
  class="warning">fair</strong>.

- Unlike either, it will factor incorporate <strong class="info">I/O</strong>
  and will adjust <strong class="info">priority levels</strong> over time.

---

# MLFQ: <span class="gold">Priority Levels</span>

<div class="columns-2-1">

<div>

To accomplish this, <strong class="special">MLFQ</strong> uses <strong
class="special">multiple queues</strong>, where each <strong
class="special">queue</strong> represents a particular <strong
class="caution">priority level</strong>:

<div class="font-smaller">

1. If <strong class="info">Priority</strong>(`A`) > <strong
   class="info">Priority</strong>(`B`), `A` runs.

2. If <strong class="info">Priority</strong>(`A`) == <strong
   class="info">Priority</strong>(`B`), `A` and `B` run in <strong
   class="gold">Round Robin</strong>.

3. A job is initially placed in the <strong class="info">highest priority
   level</strong>.

4. Once a job <strong class="warning">uses up its time allotment</strong> at a
   given level, its <strong class="info">priority</strong> is reduced (*ie. it
   is moves down one level*)

5. After some time period `S`, <strong class="warning">move all jobs</strong>
   in the system to the <strong class="special">topmost queue</strong>.

</div>

</div>

<div class="centered">

<img src="static/img/slides06-mlfq-priority-levels.png" height="600px">

</div>

</div>

---

# MLFQ: <span class="gold">Example</span> (<i class="muted">Single Long Job</i>)

<div class="centered">

<br>

<img src="static/img/slides06-mlfq-single-long-job.png">

<br>

<i>A **single long job** is broken up into discrete <strong class="info">time
slices</strong>.<br>Over time, the job <strong class="danger">reduces in
priority</strong> to allow new jobs an opportunity to run.</i>

</div>

---

# MLFQ: <span class="gold">Example</span> (<i class="muted">Long vs Short</i>)

<div class="centered">

<br>

<img src="static/img/slides06-mlfq-long-vs-short.png">

<br>

<i>When a **short job** arrives, it will start in the <strong
class="special">topmost queue</strong> and be ran first.  This allows for
**short jobs** have a fast <strong class="danger">turnaround</strong> and
<strong class="success">response time</strong>.</i>

</div>

---

# MLFQ: <span class="gold">Example</span> (<i class="muted">I/O vs CPU</i>)

<div class="centered">

<br>

<img src="static/img/slides06-mlfq-io-vs-cpu.png">

<br>

<i>Jobs that are mostly <strong class="info">I/O</strong> will maintain a
<strong class="special">higher priority</strong> since they do not use up their
<strong class="warning">CPU allotment</strong> as quickly as <strong
class="info">compute jobs</strong>.  This is good for <strong
class="caution">interactive jobs</strong> that require good <strong
class="success">response times</strong>.</i>

</div>

---

# MLFQ: <span class="gold">Priority Boost</span>

<div class="columns-1-1-1">

<div class="centered margin-top-0-5">

#### <span class="danger">Problem</span>

If a job is always in a lower <strong class="info">priority level</strong>
relative to other jobs, it will <strong class="danger">starve</strong> because
it will not have an opportunity to run.

</div>

<div class="centered">

<img src="static/img/slides06-mlfq-priority-boost.png" height="600px">

</div>

<div class="centered margin-top-0-5">

#### <span class="success">Solution</span>

Periodically provide a <strong class="warning">priority boost</strong> by
moving all jobs to the <strong class="special">topmost queue</strong>.

Exact time is a <strong class="hljs-comment">voodoo constant</strong> because
there isn't an objective way to set it.

</div>

</div>

---

# MLFQ: <span class="gold">Accounting</span>

To determine when a job should be moved down a <strong
class="special">queue</strong> (*ie.  lower its <strong
class="info">priority</strong>*), we keep track of how much of a <strong
class="warning">time slice</strong> or <strong
class="warning">allotment</strong> the job has used.

<div class="columns-1-2">

<div class="font-smaller">

- When a <strong class="warning">time allotment</strong> is used up, we lower
  the <strong class="info">priority</strong>.

- We allocate more time for jobs in lower <strong class="special">priority
  queues</strong>.

</div>

<div class="centered">

<br>

<img src="static/img/slides06-mlfq-accounting.png" height="375px">

</div>

</div>

---

# MLFQ: <span class="gold">Algorithm</span>

```python
ScheduleMLFQ(s: Scheduler):
    # Preempt a running job
    if not s.running.empty():
        p     = s.running.pop()
        level = ExceededThreshold(p) ? min(p.priority + 1, MAX_LEVELS - 1) : p.priority
        Pausejob(p)
        MovejobToSchedulerLevel(s, p, level)

    # Apply periodic priority boost
    if TimeForPriorityBoost(s):
        for level in s.levels[1:]:
            while not level.empty():
                p = level.pop()
                MovejobToSchedulerLevel(s, p, 0)
    ...
```

---

# MLFQ: <span class="gold">Algorithm</span> (<i class="muted">Continued</i>)

```python
    # Move jobes from waiting queue to top priority level
    while s.waiting.size():
        p = s.waiting.pop()
        MovejobToSchedulerLevel(s, p, 0)

    # Start or resume jobes by moving from levels to running
    for level in s.levels:
        while level.size() and s.running.size() < NCPUS:
            p = level.pop()

            if p.pid == 0:
                Startjob(p)
            else:
                Resumejob(p)

            s.running.push(p)
```

---

# MLFQ: <span class="gold">Summary</span>

- <strong class="special">MLFQ</strong> is an attempt to optimize for both
  <strong class="danger">turnaround time</strong> and <strong
  class="success">response time</strong>.

    <i>It prioritizes <strong class="caution">new, short, and I/O heavy
    jobs</strong> over long <strong class="info">CPU intensive
    jobs</strong>.</i>

- <strong class="special">MLFQ</strong> devolves into <strong
  class="gold">Round Robin</strong>.

- <strong class="special">MLFQ</strong> involves some <strong
  class="hljs-comment">"voodoo magic"</strong> and some tricks.

- <strong class="special">MLFQ</strong> (*or some variant*) has been used in
  real world operating systems.

---

<!-- _class: lead -->

# Lottery

---

# Lottery: <span class="gold">Overview</span>

Instead of directly optimizing for metrics such as <strong
class="danger">turnaround time</strong> or <strong class="success">response
time</strong>, we can aim to <strong class="warning">guarantee that each job
has a certain percentage of CPU time</strong>:

- Each job is given a set of <strong class="success">tickets</strong>, which
  represent a share of a resource.

- Periodically hold a <strong class="special">lottery</strong> to determine who
  gets the resource.

---

# Lottery: <span class="gold">Example</span>

<div class="centered">

<br>

<img src="static/img/slides06-lottery-example.png" height="425px">

<i>Each job has a set of <strong class="success">tickets</strong>.  To select
the next job, a <strong class="special">lottery</strong> is head and the job
with that <strong class="success">ticket</strong> is chosen.</i>

</div>

---

# Lottery: <span class="gold">Mechanisms</span>

We also have a few **mechanisms** for augmenting the <strong
class="warning">lottery</strong>:

1. <strong class="caution">Ticket currency</strong>: allow users to subdivide
   set of <strong class="success">tickets</strong> among its jobs.

2. <strong class="warning">Ticket transfer</strong>: allow a job to temporarily
   hand off its <strong class="success">tickets</strong> to another job.

3. <strong class="danger">Ticket inflation</strong>: allow a job to temporarily
   raise or lower the number of <strong class="success">tickets</strong> it
   owns.

---

# Lottery: <span class="gold">Algorithm</span>

```python
ScheduleLottery(s: Scheduler):
    if not s.running.empty():
        p = s.running.pop()
        PauseProcess(p)
        s.waiting.push(p)

    while s.waiting.size() and s.running.size() < s.ncpus:
        counter, winner = 0, GetRandom(0, s.total_tickets)

        for process in s.waiting:
            counter += process.tickets
            if counter < winner:
                continue

            if process.pid == 0:
                StartProcess(process)
            else:
                ResumeProcess(process)

            s.running.push(process)
            break
```

---

# Lottery: <span class="gold">Summary</span>

- Simple strategy and effective if the goal is <strong
  class="success">proportional sharing</strong>.

- However, <strong class="danger">ticket allocation</strong> remains an open
  problem.

- Randomness can be replaced with <strong class="hljs-comment">stride
  scheduling</strong>.

- Not in widespread use (*but [CFS] is and shares similar goals*).

[CFS]: https://en.wikipedia.org/wiki/Completely_Fair_Scheduler

---

<!-- _class: lead -->

# Scheduling

---

# Scheduling: <span class="gold">Example</span>

<div class="font-smaller">

Consider a single-CPU, a timeslice of `10 ms`, and the following
<strong class="success">processes</strong>:

<div class="centered">

<table class="bordered">
<thead>
    <th>Process</th>
    <th>Arrival Time</th>
    <th>Run Time</th>
</thead>
<tbody>
<tr class="info-bg">
    <td>A</td>
    <td>0 ms</td>
    <td>30 ms</td>
</tr>
<tr class="success-bg">
    <td>B</td>
    <td>10 ms</td>
    <td>20 ms</td>
</tr>
<tr class="caution-bg">
    <td>C</td>
    <td>20 ms</td>
    <td>10 ms</td>
</tr>
</tbody>
</table>

</div>

1. **Sketch** out exactly when each process runs, and for how long given the
   <strong class="gold">FIFO</strong> scheduling policy.

2. **Sketch** out exactly when each process runs, and for how long given the
   <strong class="gold">RDRN</strong> scheduling policy.

3. **Sketch** out exactly when each process runs, and for how long given the
   <strong class="gold">MLFQ</strong> scheduling policy. You may assume that
   `Q0` has a timeslice of `10 ms`, `Q1` has a timeslice of `20 ms`, and `Q2`
   has a timeslice of `40 ms`.

</div>
