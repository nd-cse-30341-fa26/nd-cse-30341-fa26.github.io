---
title: "Notebook 13: Address Space, Translation, API"
description: "Address Space, Address Translation, Memory API"
author: Peter Bui
keywords: notebook,osp,address space, address translation,memory API
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook13.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Address Space and Translation,<br>Memory API

---

# Logistics

<div class="font-large">

- <strong class="danger">Exam 02</strong>

- <strong class="success">Exam 02 - Redemption</strong>

- <strong class="info">Reading 07</strong>

- <strong class="caution">Project 01</strong>

- <strong class="caution">Project 02</strong>

- <strong class="caution">Project 03</strong>

</div>

---

# Review: <span class="gold">OS Themes</span>

<div class="font-large">

1. <b> _________________________</b> <b> _________________________</b>

    <br>
    <br>

2. <b> _________________________</b> <b> _________________________</b>

    <br>
    <br>

3. <b> _________________________</b> <b> _________________________</b>

</div>

---

# Virtual Memory: <span class="gold">Motivation</span>

<div class="columns">

<div class="centered margin-top-0-5">

#### <span class="danger"> ___________________</span>

</div>

<div class="centered margin-top-0-5">

#### <span class="success"> ___________________</span>

</div>

</div>

<div class="centered margin-top-0-5">

<img src="static/img/slides13-motivation-blank.svg">

</div>

<div class="centered margin-top-0-5">

With the development of <strong class="success"> ____________________</strong> and
<strong class="caution"> ________________</strong>,

we needed a way to <strong class="danger"> ______________________</strong>
programs from each other

and to effectively <strong class="warning"> ___________________</strong> between them.

</div>

---

# Virtual Memory: <span class="gold"> _______________________</span>

<div class="centered margin-top-0-5">

<img src="static/img/slides13-address-space-virtualization-blank.svg">

</div>

---

# Virtual Memory: <span class="gold">Challenges</span>

<div class="font-large">

1. <b> _________________________</b> <b> _________________________</b>

    <br>
    <br>
    <br>
    <br>

2. <b> _________________________</b> <b> _________________________</b>

</div>

---

# Address Translation: <span class="gold">Overview</span>

<div class="columns">

<div>

Each **address** in our program is

actually a <strong class="warning"> _____________________</strong>

that must be <strong class="success">translated</strong> to a

<strong class="info"> ________________________</strong>.

This <strong class="special">virtualization</strong> allows us to

<strong class="caution"> _______________</strong> a <strong
class="success">process</strong> to any

location in <strong class="info">memory</strong>.

</div>

<div>

<div class="alert caution-bg">

#### <span class="primary">Goals</span>

1. <strong class="caution"> ___________________________</strong>

    Invisible to application.

    <br>

2. <strong class="success"> ___________________________</strong>

    As little overhead as possible.

    <br>

3. <strong class="danger">  ___________________________</strong>

    Must isolate programs from each other.

</div>

</div>

</div>

---

# Address Translation: <span class="gold">Relocation</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="danger">Static</span>

One way to achieve this <strong class="caution">relocation</strong> is to modify your
application whenever you need to

<strong class="warning"> _________________</strong> it into memory.

- <b> ____________________________</b>

    <br>

- <b> ____________________________</b>

    <br>

- <b> ____________________________</b>

</div>

<div class="margin-top-0-5">

## <span class="success">Dynamic</span>

A better approach is to use

special <strong class="info"> _______________</strong> features

to perform <strong class="primary"> ____________________</strong>.

- <b> ____________________________</b>

    <br>

- <b> ____________________________</b>

    <br>

- <b> ____________________________</b>

</div>

</div>

---

# Address Translation: <span class="gold">Base & Bounds</span>

One simple method of <strong class="success">hardware-based address
translation</strong> is the <strong class="warning">base and bounds</strong>
method:

- The CPU has a <strong class="warning"> ____________________</strong> which holds the

  <b> _______________</b> in <strong class="info">physical memory</strong>, and a
  <strong class="warning"> ________________</strong> which

  holds the <b> __________________</b> in <strong class="info">physical memory</strong>.

  <br>

- The <strong class="info">physical address</strong> can be <strong
  class="success">translated</strong> by computing the following:

<div class="centered">

<strong class="info">Physical Address</strong> = <strong
class="warning"> ____________________</strong> + <strong class="success"> ________________________</strong>

</div>

---

# Address Translation: <span class="gold">Example</span>

Suppose we had an <strong class="success">address space</strong> of `8KB` that has been
loaded at <strong class="info">physical address</strong> `32KB`:

<table class="bordered">
<thead>
    <th class="success-bg">Virtual Address</th>
    <th class="info-bg">Physical Address</th>
</thead>
<tbody>
<tr>
    <td class="success-bg centered">0 KB</td>
    <td class="info-bg centered"></td>
</tr>
<tr>
    <td class="success-bg centered">1 KB</td>
    <td class="info-bg centered"></td>
</tr>
<tr>
    <td class="success-bg centered">5000</td>
    <td class="info-bg centered"></td>
</tr>
<tr>
    <td class="success-bg centered">9000</td>
    <td class="info-bg centered" width="400px"></td>
</tr>
</tbody>
</table>

---

<!-- _class: lead -->

# Memory API

---

# Memory API: <span class="gold">Review</span>

<div class="slide-centered font-large">

Break into groups of `2` or `3` and<br>prepare for <strong class="success">team
trivia</strong>!

</div>

---

# Memory API: <span class="gold">Allocation</span>

> How do we <strong class="success">allocate</strong> an array of `1,000,000` ints?

---

# Memory API: <span class="gold">Deallocation</span>

> How do we <strong class="danger">deallocate</strong> that array of ints?

---

# Memory API: <span class="gold">Common Error A</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
char *buffer;
fgets(buffer, BUFSIZ, stdin);
```

---

# Memory API: <span class="gold">Common Error B</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
char *src = "Smile like you mean it";
char *dst = malloc(strlen(src));

strcpy(dst, src);
```

---

# Memory API: <span class="gold">Common Error C</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
char *s = malloc(100*sizeof(char));

puts(s);
```

---

# Memory API: <span class="gold">Common Error D</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
for (int i = 1; i < argc; i++) {
    char *s = strdup(argv[i]);
    process(s);
}
```

---

# Memory API: <span class="gold">Common Error E</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
for (int i = 1; i < argc; i++) {
    char *s = strdup(argv[i]);
    process(s); free(s); puts(s);
}
```

---

# Memory API: <span class="gold">Common Error F</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
for (int i = 1; i < argc; i++) {
    char *s = strdup(argv[i]);
    if (check(s)) { free (s); }
    free(s);
}
```

---

# Memory API: <span class="gold">Common Error G</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
for (int i = 1; i < argc; i++) {
    char *s = argv[i];
    process(s);
    free(s);
}
```
---

# Memory API: <span class="gold">Where is My Mind?</span>

<strong class="info">Dr. Thain</strong> wants you to write a <strong
class="danger">compiler</strong>.  He tells you don't worry about managing
memory, just allocate as much as you want and <strong class="warning">don't
bother to free anything</strong>.  You look at him in <strong
class="caution">horror</strong> and are ready to <strong
class="danger">roast</strong> him on **Slack / X**.  Are you <strong
class="success">justified</strong>?
