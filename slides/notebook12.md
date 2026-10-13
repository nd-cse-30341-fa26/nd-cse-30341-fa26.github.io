---
title: "Notebook 12: Concurrency Bugs"
description: "Concurrency Bugs"
author: Peter Bui
keywords: lecture,osp,threads,concurrency bugs,race condition,deadlock
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides12.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Concurrency Bugs

---

# Questions

<div class="font-large">

1. What are some common <strong class="danger">concurrency bugs</strong>?

2. What are some ways to <strong class="success">prevent</strong> or <strong
   class="success">avoid</strong> such bugs?

</div>

---

# Bug: <span class="gold"> ________________________________</span>

<table class="bordered">
<thead>
    <th class="success-bg">Thread 1</th>
    <th class="success-bg">Thread 2</th>
</thead>
<tbody>
<tr>
<td class="caution-bg" width="600px">

```python
if buf_index + len < BUFSIZ:
    memcpy(buf[buf_index], log, len)
```

</td>
<td class="caution-bg" width="600px">

```python
buf_index += len
```

</td>
</tr>
</tbody>
</table>

<table class="bordered">
<thead>
    <th class="success-bg">Thread 1</th>
    <th class="success-bg">Thread 2</th>
</thead>
<tbody>
<tr>
<td class="caution-bg" width="600px">

```python
lock()
y = calculate()
unlock()

lock()
if (y == 0): y = 1  # Avoid division by zero
unlock()
```

</td>
<td class="caution-bg" width="600px">

```python
lock()
a = x / y
unlock()
```

</td>
</tr>
</tbody>
</table>

---

# Bug: <span class="gold"> ________________________________</span>

<table class="bordered">
<thead>
    <th class="success-bg">Thread 1</th>
    <th class="success-bg">Thread 2</th>
</thead>
<tbody>
<tr>
<td class="caution-bg" width="600px">

```python
mq.incoming = queue_create()
```

</td>
<td class="caution-bg" width="600px">

```python
if mq.incoming:
    data = queue_pop(mq.incoming)
```

</td>
</tr>
</tbody>
</table>

<table class="bordered">
<thead>
    <th class="success-bg">Thread 1</th>
    <th class="success-bg">Thread 2</th>
</thead>
<tbody>
<tr>
<td class="caution-bg" width="600px">

```python
while True:
    queue_push(mq, request)
```

</td>
<td class="caution-bg" width="600px">

```python
queue_delete(mq.incoming)
```

</td>
</tr>
</tbody>
</table>

---

# Bug: <span class="gold"> ________________________________</span>

Occurs when each <strong class="primary">thread</strong> is waiting for another
to give up a resource and none can run.  Usually this is because there is a

<strong class="warning"> __________________</strong> in the graph of dependencies.

<br>

<table class="bordered">
<thead>
    <th class="success-bg">Thread 1</th>
    <th class="success-bg">Thread 2</th>
</thead>
<tbody>
<tr>
<td class="caution-bg" width="600px">

```python
Lock(Mask)
Lock(Sanitizer)
```

</td>
<td class="caution-bg" width="600px">

```python
Lock(Sanitizer)
Lock(Mask)
```

</td>
</tr>
</tbody>
</table>

---

# Bug: <span class="gold"> ________________________________</span>

<strong class="danger">Livelock</strong> occurs when multiple <strong
class="primary">threads</strong> are actively attempting to

acquire resources, but <strong class="warning"> __________________________</strong>.

<table class="bordered">
<thead>
    <th class="success-bg">Thread 1</th>
    <th class="success-bg">Thread 2</th>
</thead>
<tbody>
<tr>
<td class="caution-bg" width="600px">

```python
while True:
    Lock(Mask)
    # Check if other resource is already locked
    if Locked(Sanitizer):
        Unlock(Mask)
        continue
    Lock(Sanitizer)
    ...
    Unlock(Sanitizer)
    Unlock(Mask)
```

</td>
<td class="caution-bg" width="600px">

```python
while True:
    Lock(Sanitizer)
    # Check if other resource is already locked
    if Locked(Mask):
        Unlock(Sanitizer)
        continue
    Lock(Mask)
    ...
    Unlock(Mask)
    Unlock(Sanitizer)
```

</td>
</tr>
</tbody>
</table>

---

# Bug: <span class="gold">Dining Philosophers</span>

<div class="columns">

<div>

There are **five philosophers** eating dinner...

<img src="https://spin.atomicobject.com/wp-content/uploads/dining-philosophers.jpg" class="framed float-right" width="225px">

- There are only **five forks**.

- To eat, each person needs a **left** and **right fork**.

<div class="alert warning-bg centered">

<br>
<br>
<br>

</div>

</div>

<div>

```python
def philosopher(p):
    while True:
        think(p)
        get_forks(p)
        eat(p)
        put_forks(p)

def get_forks(p):
    sem_wait(forks[left(p)])
    sem_wait(forks[right(p)])

def put_forks(p):
    sem_post(forks[left(p)])
    sem_post(forks[right(p)])
```

</div>

</div>

---

# Bug: <span class="gold">Deadlock Conditions</span>

<table class="bordered">
<tbody>
<tr>
<td class="special-bg" width="600px">

<b> ______________________________</b>

Threads claim exclusive control of resources.

<br>
</td>
<td class="caution-bg" width="600px">

<b> ______________________________</b>

Resources cannot be forcibly removed from threads holding them.
</td>
</tr>
<tr>
<td class="warning-bg">

<b> ______________________________</b>

Threads hold resources while waiting for additional resources.

<br>
</td>
<td class="danger-bg">

<b> ______________________________</b>

There exists a circular chain of threads such that each thread holds one or
more resources needed by another.
</td>
</tr>
</tbody>
</table>

---

# Project 02: <span class="gold">DPAC</span>
