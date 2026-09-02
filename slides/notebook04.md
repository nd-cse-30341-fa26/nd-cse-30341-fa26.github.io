---
title: "Notebook 04: Processes"
description: "Processes"
author: Peter Bui
keywords: lecture,osp,processes
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook04.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Processes

---

# Questions

<div class="font-large">

1. What is a <strong class="success">process</strong>?

2. How do we <strong class="caution">coordinate</strong> multiple <strong
   class="success">processes</strong>?

3. How do we <strong class="warning">switch</strong> from one <strong
   class="success">process</strong> to another?

4. What <strong class="info">system calls</strong> can we use with <strong
   class="success">processes</strong>?

5. What <strong class="special">states</strong> can a <strong
   class="success">process</strong> be in?

</div>

---

# Process: <span class="gold">Overview</span>

<div class="columns-2-1">

<div>

A <strong class="success">process</strong> is a <strong> ________________________________</strong>;

it is a unit of <strong class="warning"> ________________________________</strong>

(*resources*, *privileges*, etc.).

- <strong class="success"> ____________________________</strong>

    <strong>_____________________________________________</strong>

- <strong class="caution"> ____________________________</strong>

    <strong>_____________________________________________</strong>

- <strong class="info"> ____________________________</strong>

    <strong>_____________________________________________</strong>

</div>

<div class="slide-centered">

<img src="static/img/slides04-process-machine-state-blank.png" width="300">

</div>

</div>

---

# Process: <span class="gold">Linux</span>

<div class="font-large">

1. View <strong class="success">process</strong> list.

2. Examine [struct task_struct].

3. Explore <strong class="success">process</strong> information.

</div>

[Linux]: https://kernel.org/
[struct task_struct]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/sched.h?h=linux-6.18.y#n820

---

# Process: <span class="gold">DOS + Doom</span>

<div class="centered font-large">

What are the <strong class="success">advantages</strong> and <strong
class="danger">disadvantages</strong> of the<br><strong class="info">DOS
programming model</strong>?

</div>

<br>

<div class="centered">

<img src="https://upload.wikimedia.org/wikipedia/en/d/de/Doom_ingame_1.png" class="framed">

</div>

---

# Process: <span class="gold">Time-Sharing</span>

The <strong class="caution">operating system</strong>
<strong class="success"> ____________________________</strong> the

<strong class="info"> __________________________</strong> via the
<strong class="success">process</strong> abstraction:

<div class="centered">

<br>
<br>
<br>

<img src="static/img/slides04-process-time-sharing-blank.png" width="1000">

</div>

Each <strong> _______________________</strong> is associated with a <strong
class="success">process</strong>, which

gets a certain <strong class="special"> ______________________________</strong> or share of the

<strong class="info"> _______________________________</strong>.

---

# Process: <span class="gold">Multitasking</span>

<div class="columns">

<div class="margin-top-0-5">

## <strong class="danger"> _____________________</strong>

<div class="centered">

The <strong class="caution">operating system</strong>

<strong> ________________ </strong> the <strong class="success">processes</strong>

to be fair and voluntarily

<strong> ________________ </strong>
the <strong class="info">processor</strong>.

</div>

<div class="centered">

<img src="https://www.homecomputermuseum.nl/wp-content/uploads/2018/08/Apple-Front-1200x1054.jpg" width="300" class="bordered">

</div>

</div>

<div class="margin-top-0-5">

## <strong class="success"> _____________________</strong>

<div class="centered">

The <strong class="caution">operating system</strong> sets a

<strong class="info"> ______________________</strong> to

periodically <strong> __________________</strong>

the running <strong class="success">process</strong> and

<strong> ___________________</strong> to another.

</div>

<div class="centered margin-top-0-5">

<img src="https://photos5.appleinsider.com/gallery/61542-127138-imac-xl.jpg" width="300" class="bordered">

</div>

</div>

</div>

---

# Process: <span class="gold">Skit</span>

<div class="columns">

<div class="success font-smaller">

<i>

Closed on Sunday, you're my Chick-fil-A

Closed on Sunday, you my Chick-fil-A

Hold the selfies, put the 'Gram away

Get your family, y'all hold hands and pray

When you got daughters, always keep 'em safe

Watch out for vipers, don't let them indoctrinate

</i>

</div>

<div class="danger font-smaller">

<i>

Closed on Sunday, you my Chick-fil-A

You're my number one, with the lemonade

Raise our sons, train them in the faith

Through temptations, make sure they're wide awake

Follow Jesus, listen and obey

No more livin' for the culture, we nobody's slave

</i>

</div>

</div>

---

# Process: <span class="gold">Context Switch</span>

<div class="columns-1-2">

<div class="slide-centered">

When a

<strong class="info"> _____________________</strong>

goes off, the

<strong class="caution"> ______________________</strong>

has the option of performing a

<strong class="special"> ______________________</strong>

(ie. *switch from one <strong
class="success">process</strong> to another*).

</div>

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides04-process-context-switch-blank.png" width="720">

</div>

</div>

---

# Process: <span class="gold">States</span>

A <strong class="success">process</strong> can be in one of the following
<strong class="special">states</strong> during its lifespan:

<div class="centered">

<br>
<br>

<img src="static/img/slides04-process-states-blank.png" width="1000">

</div>

---

# Process: <span class="gold">Life Cycle</span>

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides04-process-life-cycle-blank.png" width="725">

</div>

---

# Process: [hello-n.c]

<div class="slide-centered font-large muted">

<i>Demonstrate [forking] and [waiting] in [hello-n.c].</i>

</div>

[hello-n.c]: https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture04/hello-n.c
[forking]: https://man7.org/linux/man-pages/man2/fork.2.html
[waiting]: https://man7.org/linux/man-pages/man2/wait.2.html
