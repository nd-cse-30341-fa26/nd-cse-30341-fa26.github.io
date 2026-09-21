---
title: "Slides 10: Condition Variables"
description: "Condition Variables"
author: Peter Bui
keywords: lecture,osp,threads,condition variables,concurrent data structure,producer consumer
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides10.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Condition Variables

---

# Questions

<div class="font-large">

1. Why do we need <strong class="caution">condition variables</strong>?

2. How do we use <strong class="caution">condition variables</strong> to build
   <strong class="primary">concurrent data structures</strong>?

</div>

---

<!-- _class: lead -->

# Condition Variables

---

# Condition Variables: <span class="gold">Overview</span>

A <strong class="caution">condition variable</strong> is an explicit <strong
class="special">queue</strong> that <strong class="primary">threads</strong>
can place themselves in when some state of execution is not as desired:

- Rather than <strong class="danger">busy waiting</strong> to check a
  condition, a <strong class="primary">thread</strong> can put itself to sleep
  by <strong class="caution">yielding</strong>.

- When another <strong class="primary">thread</strong> updates the condition,
  it can <strong class="warning">signal</strong> another <strong
  class="primary">thread</strong> to wake-up.

---

# Condition Variables: <span class="gold">Pattern</span>

We use a <strong class="caution">condition variable</strong> in conjunction with a
<strong class="warning">lock</strong>:

<div class="columns-1-2">

<div>

- Before we <strong class="warning">wait</strong>, must have the <strong
  class="warning">lock</strong>.

- When we <strong class="warning">wait</strong>, we release the <strong
  class="warning">lock</strong> and go to sleep.

- When we wake-up from a <strong class="warning">signal</strong>, we re-acquire
  the <strong class="warning">lock</strong>.

</div>

<div>

```c
// Receiver
pthread_mutex_lock(&Lock);          // Acquire lock
while (!Ready) {                    // Wait until ready and notified
    // 1. Release lock
    // 2. Go to sleep
    pthread_cond_wait(&Cond, &Lock);
    // 3. Wake-up
    // 4. Acquire lock
}
pthread_mutex_unlock(&Lock);        // Release lock

// Sender
pthread_mutex_lock(&Lock);          // Acquire lock
Ready = true;                       // Update variable
pthread_cond_signal(&Cond);         // Notify another thread
pthread_mutex_unlock(&Lock);	    // Release lock
```

</div>

---

# Condition Variables: <span class="gold">Tips</span>

Here are some **tips** when using <strong class="caution">condition
variables</strong>:

- We need to use <strong class="caution">while loops</strong> around our
  conditions to deal with <strong class="danger">spurious wake-ups</strong> (<i
  class="muted">wake-up before condition has changed</i>).

- <strong class="primary">pthread_cond_signal</strong> wakes up (*at least*)
  `1` <strong class="primary">thread</strong>, while <strong
  class="primary">pthread_cond_broadcast</strong> wakes <strong
  class="danger">all</strong> <strong class="primary">threads</strong> (*should
  be avoided else thundering herd*).

- Always hold the <strong class="warning">lock</strong> when calling <strong
  class="primary">pthread_cond_wait</strong> or <strong
  class="primary">pthread_cond_signal</strong> with a <strong
  class="caution">condition variable</strong>.

---

<!-- _class: lead -->

# Concurrent<br>Data Structures

---

# Concurrent DS: <span class="gold">Overview</span>

To construct a <strong class="primary">concurrent data structure</strong>, we will need to
utilize both <strong class="warning">locks</strong> and <strong class="caution">condition
variables</strong>:

- <strong class="warning">Locks</strong> protect <strong
  class="danger">critical sections</strong> (ie. <i class="muted">avoid race
  conditions</i>).

- <strong class="caution">Condition variables</strong> allow us to <strong
  class="warning">wait</strong> and <strong class="warning">singal</strong>
  <strong class="primary">threads</strong> based on different states (ie.  <i
  class="muted">avoid busy waiting</i>).

---

# Concurrent DS: <span class="gold">Producer / Consumer</span>

In this classic <strong class="success">concurrency</strong> problem, we have
one more <strong class="success">producers</strong> generating data that one or
more <strong class="danger">consumers</strong> must process:

<div class="columns-1-1-1">

<div class="middled">

```python
def Producer(queue):
    while True:
        if len(queue) < queue.maxlen:
            data = produce()
            queue.push(data)

def Consumer(queue):
    while True:
        if queue:
            data = queue.pop()
            consume(data)
```

</div>

<div class="middled centered">

<br>

<img src="static/img/slides10-producer-consumer.svg" width="400px">

</div>

<div class="middled">

<div class="alert danger-bg centered">

This version is full of **race conditions**!

</div>

</div>

</div>

<br>

---

# Concurrent DS: <span class="gold">Monitor Pattern</span>

Solve this problem with a <strong class="primary">monitor</strong> that uses
<strong class="warning">locks</strong> and <strong class="caution">condition
variables</strong> internally to provide safe access to <strong
class="danger">shared resources</strong>.

<div class="columns-1-1-1">

<div class="middled">

```python
def Producer(queue):
    while True:
        data = produce()
        queue.push(data)

def Consumer(queue):
    while True:
        data = queue.pop()
        consume(data)
```

</div>

<div class="middled centered">

<img src="static/img/slides10-monitor.svg" width="400px">

<br>

<div class="alert success-bg centered font-small">

Abstract the details of **synchronization** behind the interface of a <strong
class="primary">concurrent data structure</strong>.

</div>

</div>

<div class="middled">

```python
class Buffer:
    mutex:      Mutex   = PThreadMutex()
    produced:   CondVar = PThreadCondVar()
    consumed:   CondVar = PThreadCondVar()
    queue:      deque   = deque(maxlen=100)

    def push(self, data):
        self.mutex.lock()

        while len(self.queue) == self.queue.maxlen:
            self.consumed.wait(self.lock)

        self.queue.push(data)
        self.produced.signal()
        self.mutex.unlock()

    def pop(self):
        self.mutex.lock()

        while not self.queue:
            self.produced.wait(self.lock)

        data = queue.pop()
        self.consumed.signal()
        self.mutex.unlock()

        return data
```

</div>

</div>

---

# Concurrent DS: [queue.c]

Let's build a `C` version of this problem that utilizes a fixed-sized <strong
class="primary">array</strong> as the underlying buffer between the <strong
class="success">producer</strong> and <strong
class="danger">consumers</strong>:

- [Queue 0]: Lock-less and racy

- [Queue 1]: Deadlocked somehow

- [Queue 2]: Mostly working

- [Queue 3]: Best solution

[queue.c]: https://github.com/nd-cse-30341-fa26/examples/tree/master/lecture10
[Queue 0]: https://github.com/nd-cse-30341-fa26/examples/tree/master/lecture10/queue0.c
[Queue 1]: https://github.com/nd-cse-30341-fa26/examples/tree/master/lecture10/queue1.c
[Queue 2]: https://github.com/nd-cse-30341-fa26/examples/tree/master/lecture10/queue2.c
[Queue 3]: https://github.com/nd-cse-30341-fa26/examples/tree/master/lecture10/queue3.c
