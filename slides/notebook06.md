---
title: "Notebook 06: Scheduling (MLFQ, Lottery)"
description: "Scheduling, MLFQ, Lottery"
author: Peter Bui
keywords: lecture,osp,scheduling,mlfq,lottery
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook06.html
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

# Scheduling: <span class="gold">Example 1</span>

Jobs <strong class="success">A</strong>, <strong class="info">B</strong>, and
<strong class="caution">C</strong> arrive at time `0` and run for `10` seconds
each:

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/notebook06-example-1.svg">

</div>

<table class="bordered">
<thead>
    <th>Metric</th>
    <th>FIFO</th>
    <th>Round Robin</th>
</thead>
<tbody>
<tr class="danger-bg" height="100px">
    <td class="centered">Turnaround</td>
    <td width="500px"></td>
    <td width="500px"></td>
</tr>
<tr class="success-bg" height="100px">
    <td class="centered">Response</td>
    <td width="500px"></td>
    <td width="500px"></td>
</tr>
</tbody>
</table>

---

# Scheduling: <span class="gold">Example 2</span>

<div class="font-smaller">

Jobs <strong class="success">A</strong>, <strong class="info">B</strong>, and
<strong class="caution">C</strong> arrive at time `0`.  <strong
class="success">A</strong> runs for `10` seconds and <strong
class="info">B</strong> and <strong class="caution">C</strong> for `1` second:

</div>

<div class="centered">

<img src="static/img/notebook06-example-2.svg">

</div>

<table class="bordered">
<thead>
    <th>Metric</t>
    <th>FIFO</td>
    <th>Round Robin</td>
</thead>
<tbody>
<tr class="danger-bg" height="100px">
    <td class="centered">Turnaround</td>
    <td width="500px"></td>
    <td width="500px"></td>
</tr>
<tr class="success-bg" height="100px">
    <td class="centered">Response</td>
    <td width="500px"></td>
    <td width="500px"></td>
</tr>
</tbody>
</table>

---

# Scheduling: <span class="gold">Example 3</span> (<i class="muted">SJF</i>)

<div class="font-smaller">

Jobs <strong class="success">A</strong>, <strong class="info">B</strong>, and
<strong class="caution">C</strong> arrive at time `0`.  <strong
class="success">A</strong> runs for `10` seconds and <strong
class="info">B</strong> and <strong class="caution">C</strong> for `1` second:

</div>

<div class="centered">

<img src="static/img/notebook06-example-3.svg">

</div>

<table class="bordered">
<thead>
    <th>Metric</t>
    <th>FIFO</td>
    <th>Round Robin</td>
</thead>
<tbody>
<tr class="danger-bg" height="100px">
    <td class="centered">Turnaround</td>
    <td width="500px"></td>
    <td width="500px"></td>
</tr>
<tr class="success-bg" height="100px">
    <td class="centered">Response</td>
    <td width="500px"></td>
    <td width="500px"></td>
</tr>
</tbody>
</table>

---

# Scheduling: <span class="gold">FIFO vs Round Robin</span>

<div class="columns margin-top-0-5">

<div class="centered">

#### FIFO

</div>

<div class="centered">

#### Round Robin

</div>

</div>

---

<!-- _class: lead -->

# Multi-Level<br>Feedback Queue

---

# MLFQ: <span class="gold">Overview</span>

A <strong class="special">Multi-Level Feedback Queue (MLFQ)</strong> tries to
optimize both <strong class="danger">turnaround time</strong> and <strong
class="success">response time</strong>:

- Like <strong class="gold">FIFO</strong>, it tries to complete

    <strong class="warning"> ___________________________________________________________</strong>.

- Like <strong class="gold">Round Robin</strong>, it tries to be

    <strong class="warning"> ___________________________________________________________</strong>.

- Unlike either, it will factor incorporate
    <strong class="info"> __________________</strong>

    and will adjust
    <strong class="info"> _________________________________</strong> over time.

---

# MLFQ: <span class="gold">Priority Levels</span>

<div class="columns-2-1">

<div>

To accomplish this, <strong class="special">MLFQ</strong> uses <strong
class="special">multiple queues</strong>, where each <strong
class="special">queue</strong> represents a particular <strong
class="caution">priority level</strong>:

<div class="font-smaller">

1. <strong> _______________________________________________</strong>

    <br>

2. <strong> _______________________________________________</strong>

    <br>

3. <strong> _______________________________________________</strong>

    <br>

4. <strong> _______________________________________________</strong>

    <br>

5. <strong> _______________________________________________</strong>

</div>

</div>

<div>

<img src="static/img/slides06-mlfq-priority-levels-blank.svg" height="600px">

</div>

</div>

---

# MLFQ: <span class="gold">Example</span> (<i class="muted">Single Long Job</i>)

<div class="centered">

<br>

<img src="static/img/slides06-mlfq-single-long-job-blank.svg">

<br>

<i class="font-smaller">

A **single long job** is broken up into discrete
<strong class="info"> ____________________________</strong>.

Over time, the job
<strong class="danger"> _____________________________________________</strong>
to allow new jobs an opportunity to run.</i>

</div>

---

# MLFQ: <span class="gold">Example</span> (<i class="muted">Long vs Short</i>)

<div class="centered">

<br>

<img src="static/img/slides06-mlfq-single-long-job-blank.svg">

<br>

<i class="font-smaller">

When a **short job** arrives, it will start in the
<strong class="special"> _________________</strong> and be

ran first.  This allows for **short jobs** have fast

<strong class="danger"> ___________________________</strong> and
<strong class="success"> ___________________________</strong>.</i>

</div>

---

# MLFQ: <span class="gold">Example</span> (<i class="muted">I/O vs CPU</i>)

<div class="centered">

<br>

<img src="static/img/slides06-mlfq-single-long-job-blank.svg">

<br>

<i class="font-smaller">

Jobs that are mostly <strong class="info">I/O</strong> will maintain a
<strong class="special"> ________________________</strong> since

they do not use up their
<strong class="warning"> __________________</strong> as quickly as
<strong class="info"> ________________</strong>.

This is good for
<strong class="caution"> __________________</strong> that require good
<strong class="success"> __________________</strong>.

</i>

</div>

---

# MLFQ: <span class="gold">Priority Boost</span>

<div class="columns-1-2-1">

<div class="centered margin-top-0-5">

#### <span class="danger">Problem</span>

If a job is always in a lower <strong class="info">priority level</strong>
relative to other jobs, it will <strong class="danger">starve</strong> because
it will not have an opportunity to run.

</div>

<div>

<img src="static/img/slides06-mlfq-priority-levels-blank.svg" height="600px">

</div>

<div class="centered margin-top-0-5">

#### <span class="success">Solution</span>

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

- When a <strong class="warning">time allotment</strong> is used up,

    <strong class="info"> ________________________</strong>.

- We allocate more time for jobs in lower

    <strong class="special"> ________________________</strong>.

</div>

<div class="centered">

<br>

<img src="static/img/slides06-mlfq-single-long-job-blank.svg" height="325px">

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

    <p><i>
    It prioritizes
    <strong class="caution"> _____________________________________________</strong>

    over
    <strong class="info"> ______________________________________________________</strong>.
    </i></p>

- <strong class="special">MLFQ</strong> devolves into
    <strong class="gold"> ________________________________________</strong>.

- <strong class="special">MLFQ</strong> involves some tricks and
    <strong class="hljs-comment"> _____________________________</strong>.

- <strong class="special">MLFQ</strong> (*or some variant*) has been used in
  real world operating systems.

---

<!-- _class: lead -->

# Exercises

---

# Exercise: <span class="gold">Scheduling</span> (<i class="muted">FIFO</i>)

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

<table class="bordered">
<tbody>
<tr class="caution-bg" height="70px">
    <td><b>Waiting</b></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
</tr>
<tr class="success-bg" height="70px">
    <td><b>Running</b></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
</tr>
<tr class="info-bg">
    <td></td>
    <td><b>00</b></td>
    <td><b>10</b></td>
    <td><b>20</b></td>
    <td><b>30</b></td>
    <td><b>40</B></TD>
    <td><b>50</b></td>
    <td><b>60</b></td>
</tr>
</tbody>
</table>

<div class="centered">

**Sketch** out exactly when each process runs, and for how long given the<br>
<strong class="gold">FIFO</strong> scheduling policy.

</div>

</div>

---

# Exercise: <span class="gold">Scheduling</span> (<i class="muted">Round Robin</i>)

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

<table class="bordered">
<tbody>
<tr class="caution-bg" height="70px">
    <td><b>Waiting</b></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
</tr>
<tr class="success-bg" height="70px">
    <td><b>Running</b></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
</tr>
<tr class="info-bg">
    <td></td>
    <td><b>00</b></td>
    <td><b>10</b></td>
    <td><b>20</b></td>
    <td><b>30</b></td>
    <td><b>40</B></TD>
    <td><b>50</b></td>
    <td><b>60</b></td>
</tr>
</tbody>
</table>

<div class="centered">

**Sketch** out exactly when each process runs, and for how long given the<br>
<strong class="gold">Round Robin</strong> scheduling policy.

</div>

</div>

---

# Exercise: <span class="gold">Scheduling</span> (<i class="muted">MLFQ</i>)

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

<table class="bordered">
<tbody>
<tr class="success-bg" height="70px">
    <td><b>Q0</b> (<i class="muted">10</i>)</td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
</tr>
<tr class="caution-bg" height="70px">
    <td><b>Q1</b> (<i class="muted">20</i>)</td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
</tr>
<tr class="warning-bg" height="70px">
    <td><b>Q2</b> (<i class="muted">40</i>)</td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
    <td width="125px"></td>
</tr>
<tr class="info-bg">
    <td></td>
    <td><b>00</b></td>
    <td><b>10</b></td>
    <td><b>20</b></td>
    <td><b>30</b></td>
    <td><b>40</B></TD>
    <td><b>50</b></td>
    <td><b>60</b></td>
</tr>
</tbody>
</table>

</div>

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
