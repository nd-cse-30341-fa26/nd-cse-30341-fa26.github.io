---
title: "Slides 09: Locks"
description: "Locks"
author: Peter Bui
keywords: lecture,osp,threads,locks
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides09.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Locks

---

# Questions

<div class="font-large">

1. Why do we need <strong class="warning">locks</strong>?

2. When should we use <strong class="warning">locks</strong>?

3. How does a <strong class="warning">lock</strong> work?

    - How do we evaluate a <strong class="warning">lock</strong>?

    - How do we implement a <strong class="warning">lock</strong>?

    - Are <strong class="warning">locks</strong> sufficient for <strong
      class="success">concurrent</strong> applications?

</div>

---

# Locks: <span class="gold">PThreads</span>

To guard a <strong class="danger">critical section</strong>, we utilize <strong
class="warning">locks</strong> or <strong class="warning">mutual
exclusion</strong> via <strong class="primary">pthread_mutex_lock</strong> and
<strong class="primary">pthread_mutex_unlock</strong>:

```c
pthread_mutex_t Lock;               // Declare lock
pthread_mutex_init(&Lock, NULL);    // Initialize lock

pthread_mutex_lock(&Lock);          // Acquire lock
access_shared_resource();           // Perform critical section
pthread_mutex_unlock(&Lock);        // Release lock
```

<br>

<div class="alert centered warning-bg">

**Note**: we should perform **error checking**.

</div>

---

# Locks: [prime]

> Implement a program that computes the number of **prime numbers** between `1`
> and `400,000`.

<div class="font-large">

1. <strong class="info">Single-thread</strong>

2. <strong class="caution">Locks</strong>

3. <strong class="success">Lock-less</strong>

</div>

[prime]: https://github.com/nd-cse-30341-fa26/examples/tree/master/lecture09

---

# Locks: <span class="gold">Evaluation</span>

To evaluate a <strong class="warning">lock</strong> implementation, we need to
consider the following three <strong class="special">metrics</strong>:

1. <strong class="caution">Correctness</strong>

    Does it actually provide <strong class="warning">mutual exclusion</strong>?

2. <strong class="info">Fairness</strong>

    Does it give each <strong class="primary">thread</strong> a fair shot at
    acquiring the <strong class="warning">lock</strong>?

3. <strong class="success">Performance</strong>

    How much overhead is added by using the <strong
    class="warning">lock</strong>?

---

# Locks: <span class="gold">Disabling Interrupts</span>

One way to implement <strong class="warning">locks</strong> is to simply <strong class="danger">disable
interrupts</strong>:

<div class="columns">

<div>

```python
class Mutex:
    def Lock(self):
        DisableInterrupts()

    def Unlock(self):
        EnableInterrupts()
```

</div>


<div class="margin-top-0-5">

<strong class="danger">Problems</strong>

1. <strong class="caution">Correctness</strong>

    *Possibly lose interrupts.*

2. <strong class="info">Fairness</strong>

    *Need to trust users.*

3. <strong class="success">Performance</strong>

    *Doesn't scale to multiple processors.*

</div>

</div>

---

# Locks: <span class="gold">Implementation</span> (<i class="muted">Spin Lock</i>)

A better way is to implement a <strong class="warning">spin lock</strong>:

<div class="columns-2-1">

<div>

```python
class Mutex:
    flag: int = 0             # 0: available, 1: unavailable

    def Lock(self):
        while self.flag == 1: # Test lock
            pass              # Spin until lock is available
        self.flag = 1         # Set lock

    def Unlock(self):
        self.flag = 0         # Clear lock
```

</div>

<div class="margin-top-0-5">

<strong class="danger">Problems</strong>

1. <strong class="caution">Correctness</strong>

    *Race condition*

2. <strong class="success">Performance</strong>

    *Busy waiting*

</div>

</div>

---

# Locks: <span class="gold">Test and Set</span>

To effectively implement a <strong class="warning">lock</strong>, we need
special <strong class="info">hardware instructions</strong> that provide
<strong class="special">atomic exchanges</strong>:

```python
def TestAndSet(old_ptr: int*, new_value: int):
	old_value = *old_ptr    # Fetch old value at old pointer
	*old_ptr  = new_value   # Store new value into old pointer
	return old_value        # Return old value
```

<br>

<div class="alert info-bg centered">

The above three lines all happen in<br>one instruction (<i
class="special">atomically</i>)

</div>

---

# Locks: <span class="gold">Test and Set</span> (<i class="muted">Spin Lock</i>)

With the <strong class="info">TestAndSet</strong> instruction, we can implement
a better <strong class="warning">spin lock</strong>.

<div class="columns-2-1">

<div>

```python
class Mutex:
    flag: int = 0        # 0: available, 1: unavailable

    def Lock(self):      # Test and Set lock atomically
        while TestAndSet(self.flag, 1) == 1:
            pass         # Spin until lock is available

    def Unlock(self):
        self.flag = 0    # Clear lock
```

</div>

<div class="margin-top-0-5">

<strong class="danger">Problems</strong>

1. <strong class="success">Performance</strong>

    *Busy waiting*

</div>

</div>

---

# Locks: <span class="gold">Avoid Spinning</span>

Although correct, this <strong class="warning">spin lock</strong> still has
problems due to <strong class="danger">busy waiting</strong>:

1. <strong class="success">Performance</strong>

    If we can't acquire <strong class="warning">lock</strong>, we may spin the
    whole time slice, wasting <strong class="info">CPU resources</strong>.

2. <strong class="info">Fairness</strong>

    It is possible for a lower priority <strong class="primary">thread</strong>
    from blocking a higher priority <strong class="primary">thread</strong>
    from running (aka <i><strong class="danger">priority
    inversion</strong></i>)

---

# Locks: <span class="gold">Yielding</span> (<i class="muted">Spin Lock</i>)

One way to reduce the cost of <strong class="danger">busy waiting</strong> is
to simply <strong class="caution">yield</strong> as we spin:

<div class="columns-2-1">

<div>

```python
class Mutex:
    flag: int = 0        # 0: available, 1: unavailable

    def Lock(self):      # Test and Set lock atomically
        while TestAndSet(self.flag, 1) == 1:
            yield()      # Give up the CPU

    def Unlock(self):
        self.flag = 0    # Clear lock
```

</div>

<div class="margin-top-0-5">

<strong class="danger">Problems</strong>

1. <strong class="info">Fairness</strong>

    *Starvation*

2. <strong class="success">Performance</strong>

    *Context switches*

</div>

</div>

---

# Locks: <span class="gold">Queues</span> (<i class="muted">Spin Lock</i>)

Another way to reduce the cost of <strong class="danger">busy waiting</strong> is to use a
<strong class="special">queue</strong> of <strong class="primary">threads</strong> to **wakeup**:

1. Use <strong class="caution">park()</strong> to put a calling <strong
   class="primary">thread</strong> to sleep.

2. Use <strong class="caution">unpark()</strong> to wake a particular <strong
   class="primary">thread</strong>.

3. Use a <strong class="special">queue</strong> to maintain list of <strong
   class="primary">threads</strong> to wakeup.

4. Pass <strong class="warning">lock</strong> to awoken <strong
   class="primary">thread</strong>.

---

# Locks: <span class="gold">Summary</span>

<strong class="warning">Locks</strong> can be tricky to implement and utilize correctly:

- To implement them efficiently, we need support from both the <strong
  class="info">hardware</strong> and the <strong class="caution">operating
  system</strong>.

- To utilize them effectively, we need to identify the <strong
  class="danger">critical section</strong> and use <strong
  class="warning">locks</strong> only when absolutely necessary.

<div class="alert warning-bg centered">

To avoid <strong class="danger">busy waiting</strong> we will need to utilize<br>
<strong class="caution">condition variables</strong>.

</div>
