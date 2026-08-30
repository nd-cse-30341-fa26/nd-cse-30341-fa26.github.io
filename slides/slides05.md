---
title: "Slides 05: Scheduling (FIFO, Round Robin)"
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

# Scheduling: <span class="gold">Overview</span>

Whenever we need to decide which <strong class="success">process</strong> to
run next, we invoke the <strong class="caution">scheduler</strong>:

1. A <strong class="success">process</strong> <strong
   class="danger">terminates</strong>

2. A <strong class="success">process</strong> <strong
   class="warning">blocks</strong>

3. A <strong class="info">timer interrupt</strong> (<i class="muted">preemptive
   multitasking</i>)

<br>

<div class="alert info-bg centered">

The decision making process is called a<br><strong class="warning">scheduling
policy</strong> or <strong class="warning">discipline</strong>.

</div>

---

# Scheduling: <span class="gold">Workload</span>

To make <strong class="warning">scheduling policies</strong>, we need to consider our
<strong class="danger">workload</strong>, or collection of <strong class="success">processes</strong>
running on our system.

Let's start with the following <strong class="caution">assumptions</strong>:

1. Each job runs for the <strong class="caution">same amount of time</strong>.

2. All jobs <strong class="caution">arrive at the same time</strong>.

3. Once started, <strong class="caution">each job runs to completion</strong>.

4. All jobs <strong class="caution">only use the CPU (no I/O)</strong>.

5. The <strong class="caution">run-time</strong> of each job is <strong class="caution">known</strong>.

<div class="alert info-bg centered">

As we explore different <strong class="warning">scheduling policies</strong>,
we will need to address these <strong class="caution">assumptions</strong> and
eventually relax or drop them.

</div>

---

# Scheduling: <span class="gold">Metrics</span>

To compare different <strong class="warning">scheduling policies</strong>, we
need to consider different <strong class="caution">metrics</strong>:

<br>

<div class="columns">

<div class="alert danger-bg centered">

#### <span class="danger">Turnaround Time</span><br>(<i class="muted">Throughput</i>)

<strong class="font-smaller">

T<sub>turnaround</sub> = T<sub>completion</sub> - T<sub>arrival</sub>

</strong>

<br>

How soon does the job<br><strong class="danger">complete</strong>?

</div>

<div class="alert success-bg centered">

#### <span class="success">Response Time</span><br>(<i class="muted">Latency</i>)

<strong class="font-smaller">

T<sub>response</sub> = T<sub>firstrun</sub> - T<sub>arrival</sub>

</strong>

<br>

How soon does the job<br><strong class="success">start</strong>?

</div>

</div>

---

# Scheduling: <span class="gold">Multiprocessor</span>

<div class="columns-1-2 margin-top-0-5">

<div>

#### <span class="danger">Issues</span>

- Cache coherence
- Cache affinity
- Synchronization

#### <span class="caution">Tricks</span>

- Migration
- Work Stealing

</div>

<div>

#### <span class="primary">Single-Queue</span>

Put all jobs into a **single queue** and assign jobs to particular CPUs.

<br>

<div class="alert warning-bg centered font-small">

Poor affinity and scaling

</div>

<br>

#### <span class="gold">Multi-Queue</span>

Distribute jobs across **multiple queues** (*one per CPU*).

<br>

<div class="alert warning-bg centered font-small">

Load imbalance and complexity

</div>

</div>

</div>

---

<!-- _class: lead -->

# FIFO

---

# FIFO: <span class="gold">Overview</span>

A basic <strong class="warning">scheduling policy</strong> is <strong
class="gold">First In, First Out (FIFO)</strong>:

<br>

<div class="centered">

<img src="static/img/slides05-fifo-overview.png">

</div>

<br>

<div class="alert warning-bg centered">

<i>Execute the jobs in the order in which they arrive.</i>

</div>

---

# FIFO: <span class="gold">Algorithm</span>

```python
# This assumes that the Schedule has two queues:
#   .running    This is a list of running processes
#   .waiting    This is a list of processes ready to run
def ScheduleFIFO(s: Scheduler):
    # As long as we have less running processes than we have
    # CPUs and there waiting processes, then transfer a process
    # from the waiting queue to the running queue
    while s.running.size() < NCPUS and s.waiting.size():
        process = s.waiting.pop()
        StartProcess(process)   # TODO: Error handling
        s.running.push(process)
```

---

# FIFO: <span class="gold">Example</span>

Jobs <strong class="success">A</strong>, <strong class="info">B</strong>, and
<strong class="caution">C</strong> arrive at time `0` and run for `5` seconds
each:

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/slides05-fifo-example.png">

</div>

<div class="columns">

<div class="alert danger-bg centered">

#### <span class="danger">Average Turnaround Time</span>

(5 + 10 + 15) / 3 = 10 s/job

</div>

<div class="alert success-bg centered">

#### <span class="success">Average Response Time</span>

(0 + 5 + 10) / 3 = 5 s/job

</div>

</div>

---

# FIFO: <span class="gold">Convoy Effect</span>

Job <strong class="success">A</strong> arrives at time `0` and runs for `30`
seconds, while <strong class="info">B</strong> and <strong
class="caution">C</strong> also arrive at time `0` but run for `5` seconds:

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/slides05-fifo-convoy.png">

</div>

<div class="columns">

<div class="alert danger-bg centered">

#### <span class="danger">Average Turnaround Time</span>

(30 + 35 + 40) / 3 = 35 s/job

</div>

<div class="alert success-bg centered">

#### <span class="success">Average Response Time</span>

(0 + 30 + 35) / 3 ~ 22 s/job

</div>

</div>

<div class="font-smaller">

<br>

<div class="alert warning-bg centered">

If we relax <strong class="caution">Assumption 1</strong>, we see that <strong
class="gold">FIFO</strong> is susceptible to the<br><strong class="danger">Convoy
Effect</strong>, where a large job bottlenecks many smaller jobs.

</div>

</div>

---

# FIFO: <span class="gold">Shortest Job First</span>

One way to combat the <strong class="danger">Convoy Effect</strong>, is to rank our
<strong class="gold">FIFO</strong> such that we always select the <strong class="warning">shortest job first
(SJF)</strong>.

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/slides05-fifo-sjf.png">

</div>

<div class="columns">

<div class="alert danger-bg centered">

#### <span class="danger">Average Turnaround Time</span>

(5 + 10 + 40) / 3 ~ 18 s/job

</div>

<div class="alert success-bg centered">

#### <span class="success">Average Response Time</span>

(0 + 5 + 10) / 3 = 5 s/job

</div>

</div>

---

# FIFO: <span class="gold">Convoy Effect</span> (<i class="muted">Again</i>)

Job <strong class="success">A</strong> arrives at time `0` and runs for `30`
seconds, while <strong class="info">B</strong> and <strong
class="caution">C</strong> also arrive at time `5` but run for `5` seconds:

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/slides05-fifo-convoy.png">

</div>

<div class="columns">

<div class="alert danger-bg centered font-small">

#### <span class="danger">Average Turnaround Time</span>

(30 + (35-5) + (40-5)) / 3 ~ 31 s/job

</div>

<div class="alert success-bg centered font-small">

#### <span class="success">Average Response Time</span>

(0 + (30-5) + (35-5)) / 3 ~ 18 s/job

</div>

</div>

<div class="font-smaller">

<br>

<div class="alert warning-bg centered">

If we relax <strong class="caution">Assumption 2</strong>, we see that <strong
class="gold">FIFO with SJF</strong> is<br>still susceptible to the <strong
class="danger">Convoy Effect</strong>.

</div>

</div>

---

# FIFO: <span class="gold">Summary</span>

- <strong class="gold">FIFO</strong> is relatively <strong
  class="caution">straightforward</strong>.

- <strong class="gold">FIFO</strong> generally has good <strong
  class="danger">turnaround time</strong>.

- <strong class="gold">FIFO</strong> generally has poor <strong
  class="success">response time</strong>.

- <strong class="gold">FIFO</strong> can suffer from problems with the <strong
  class="danger">Convoy Effect</strong>.

---

<!-- _class: lead -->

# Round Robin

---

# Round Robin: <span class="gold">Overview</span>

Instead of <strong class="caution">running jobs to completion</strong>, we use
a periodic <strong class="info">timer interrupt</strong> to rotate through
<strong class="success">processes</strong>:

<br>

<div class="centered">

<img src="static/img/slides05-rdrn-overview.png">

</div>

<br>

<div class="alert warning-bg centered">

<i>Each <strong class="success">process</strong> is executed for a certain
<strong class="caution">time slice</strong><br>before another <strong
class="success">process</strong> is selected.</i>

</div>

<div class="font-smaller"><br></div>

<div class="alert success-bg centered font-small">

This is a <strong class="warning">fair policy</strong> since it evenly divides
the <strong class="info">processor</strong> among active <strong
class="success">processes</strong>.

</div>

---

# Round Robin: <span class="gold">Algorithm</span>

```python
# TODO: Handle errors in managing processes
ScheduleRoundRobin(s: Scheduler):
    # Move a process from running queue to waiting queue
    if s.running.size() == NCPUS:
        process = s.running.pop()
        PauseProcess(process)       # Preempt! by pausing process
        s.waiting.push(process)

    # Move processes from waiting queue to running queue
    while s.running.size() < NCPUS and s.waiting.size():
        process = s.waiting.pop()
        if process.pid == 0:
            StartProcess(process)   # Start new process
        else:
            ResumeProcess(process)  # Resume old process

        s.running.push(process)
```

---

# Round Robin: <span class="gold">Example</span>

Jobs <strong class="success">A</strong>, <strong class="info">B</strong>, and
<strong class="caution">C</strong> arrive at time `0` and run for `5` seconds
each:

<div class="font-smaller"><br></div>

<div class="centered">

<img src="static/img/slides05-rdrn-overview.png">

</div>

<div class="columns">

<div class="alert danger-bg centered">

#### <span class="danger">Average Turnaround Time</span>

(13 + 14 + 15) / 3 = 14 s/job

</div>

<div class="alert success-bg centered">

#### <span class="success">Average Response Time</span>

(0 + 1 + 2) / 3 = 1 s/job

</div>

</div>

---

# Round Robin: <span class="gold">Summary</span>


- <strong class="gold">Round Robin</strong> is relatively <strong
  class="caution">straightforward</strong>.

- <strong class="gold">Round Robin</strong> generally has poor <strong
  class="danger">turnaround time</strong>.

- <strong class="gold">Round Robin</strong> generally has good <strong
  class="success">response time</strong>.

- <strong class="gold">Round Robin</strong> requires <strong
  class="info">preemption</strong>.

- <strong class="gold">Round Robin</strong> has some <strong
  class="warning">overhead</strong>.
