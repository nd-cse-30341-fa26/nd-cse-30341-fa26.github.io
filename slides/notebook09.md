---
title: "Notebook 09: Locks"
description: "Locks"
author: Peter Bui
keywords: notebook,osp,threads,locks
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook09.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Locks

---

# Review: <span class="gold">Processes, Events, Threads</span>

<table class="bordered">
<thead>
    <th class="success-bg">Processes</th>
    <th class="caution-bg">Events</th>
    <th class="info-bg">Threads</th>
</thead>
<tbody>
<tr>
    <td class="success-bg" width="400px"><br><br><br><br><br><br><br><br><br><br><br><br></td>
    <td class="caution-bg" width="400px"><br><br><br><br><br><br><br><br><br><br><br><br></td>
    <td class="info-bg" width="400px"><br><br><br><br><br><br><br><br><br><br><br><br></td>
</tr>
</tbody>
</table>

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

Use a <strong class="warning">lock</strong> or
<strong class="warning"> _______________________________</strong>
to guard a

<strong class="danger"> ______________________________</strong>,
which is <strong class="caution">region of code</strong> that

<strong class="danger"> ______________________________</strong>.


```c

_________________________________________________    // Declare lock

_________________________________________________    // Initialize lock

_________________________________________________    // Acquire lock

_________________________________________________    // __________________________

_________________________________________________    // Release lock
```

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

<br>

1. <strong class="caution"> _______________________________________</strong>

    Does it actually provide <strong class="warning">mutual exclusion</strong>?

    <br>

2. <strong class="info">    _______________________________________</strong>

    Does it give each <strong class="primary">thread</strong> a fair shot at
    acquiring the <strong class="warning">lock</strong>?

    <br>

3. <strong class="success"> _______________________________________</strong>

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

    <br><strong> __________________________</strong>

2. <strong class="info">Fairness</strong>

    <br><strong> __________________________</strong>

3. <strong class="success">Performance</strong>

    <br><strong> __________________________</strong>

</div>

</div>

---

# Locks: <span class="gold">Implementation</span> (<i class="muted">Spin Lock</i>)

A better way is to implement a <strong class="warning">spin lock</strong>:

<div class="columns-2-1">

<div>

```python
class Mutex:
    #
    # _________________________________________
    flag: int = 0

    def Lock(self):
        #
        # _____________________________________
        while self.flag == 1: pass
        self.flag = 1

    def Unlock(self):
        #
        # _____________________________________
        self.flag = 0
```

</div>

<div class="margin-top-0-5">

<strong class="danger">Problems</strong>

1. <strong class="caution">Correctness</strong>

    <br><strong> __________________________</strong>

2. <strong class="success">Performance</strong>

    <br><strong> __________________________</strong>

</div>

</div>

---

# Locks: <span class="gold">Test and Set</span>

To effectively implement a <strong class="warning">lock</strong>, we need
special <strong class="info">hardware instructions</strong> that provide
<strong class="special">atomic exchanges</strong>:

```python
def TestAndSet(old_ptr: int*, new_value: int):
                            #
    old_value = *old_ptr    # _______________________________________________
                            #
    *old_ptr  = new_value   # _______________________________________________
                            #
    return old_value        # _______________________________________________
```

<br>

<div class="alert info-bg centered">

The above three lines all happen in one instruction<br>

(<strong class="special"> _____________________________________</strong>)

</div>

---

# Locks: <span class="gold">Test and Set</span> (<i class="muted">Spin Lock</i>)

With the <strong class="info">TestAndSet</strong> instruction, we can implement
a better <strong class="warning">spin lock</strong>.

<div class="columns-2-1">

<div>

```python
class Mutex:
    # 0: available, 1: unavailable
    flag: int = 0

    def Lock(self):
        #
        # _____________________________________
        while TestAndSet(self.flag, 1) == 1:
            pass # Spin until lock is available

    def Unlock(self):
        # Clear lock
        self.flag = 0
```

</div>

<div class="margin-top-0-5">

<strong class="danger">Problems</strong>

1. <strong class="success">Performance</strong>

    <br><strong> __________________________</strong>

</div>

</div>

---

# Locks: <span class="gold">Yielding</span> (<i class="muted">Spin Lock</i>)

One way to reduce the cost of <strong class="danger">busy waiting</strong> is
to simply <strong class="caution">yield</strong> as we spin:

<div class="columns-2-1">

<div>

```python
class Mutex:
    # 0: available, 1: unavailable
    flag: int = 0

    def Lock(self):
        # Test and Set lock atomically
        while TestAndSet(self.flag, 1) == 1:
            #
            # ______________________________
            yield()

    def Unlock(self):
        # Clear lock
        self.flag = 0
```

</div>

<div class="margin-top-0-5">

<strong class="danger">Problems</strong>

1. <strong class="info">Fairness</strong>

    <br><strong> __________________________</strong>

2. <strong class="success">Performance</strong>

    <br><strong> __________________________</strong>

</div>

</div>
