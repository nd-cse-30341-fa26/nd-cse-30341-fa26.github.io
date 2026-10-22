---
title: "Slides 13: Address Space, Translation, API"
description: "Address Space, Address Translation, Memory API"
author: Peter Bui
keywords: lecture,osp,address space, address translation,memory API
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides13.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Address Space and Translation,<br>Memory API

---

# Questions

<div class="font-large">

1. What is an <strong class="success">address space</strong>?

2. What is <strong class="warning">virtual memory</strong>?

3. How do we <strong class="info">allocate</strong> memory?

4. What are some common memory <strong class="danger">errors</strong>?

</div>

---

# Virtual Memory: <span class="gold">Motivation</span>

<div class="columns">

<div class="centered margin-top-0-5">

## <span class="danger">Batch</span>

</div>

<div class="centered margin-top-0-5">

## <span class="success">Interactive</span>

</div>

</div>

<div class="centered margin-top-0-5">

<img src="static/img/slides13-motivation.svg">

</div>

<div class="centered margin-top-0-5">

With the development of <strong class="success">multi-programming</strong> and
<strong class="caution">time-sharing</strong>, we needed a way to <strong
class="danger">protect</strong> programs from each other and to effectively
<strong class="warning">switch</strong> between them.

</div>

---

<!-- _class: lead -->

# Address Space

---

# Address Space: <span class="gold">Virtualization</span>

The <strong class="caution">operating system</strong> provides each <strong
class="success">process</strong> an <strong
class="special">abstraction</strong> of <strong class="info">memory</strong>
called the <strong class="success">address space</strong>.

<div class="centered margin-top-0-5">

<img src="static/img/slides13-address-space-virtualization.svg">

</div>

---

# Address Space: [addresses.c]

```c
int Global = 0;

int main(int argc, char *argv[]) {
    int local = 1;
    printf("Location of STACK: %14p\n", &local);
    printf("Location of HEAP:  %14p\n", malloc(1));
    printf("Location of DATA:  %14p\n", &Global);
    printf("Location of CODE:  %14p\n", main);
    return EXIT_SUCCESS;
}
```

- What are the <strong class="caution">relative addresses</strong>?
- What <strong class="warning">addresses change</strong>? Why?

[addresses.c]: https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture13/addresses.c

---

<!-- _class: lead -->

# Address Translation

---

# Address Translation: <span class="gold">Overview</span>

<div class="columns">

<div>

Each **address** in our program is actually a <strong class="warning">virtual
address</strong> that must be <strong class="success">translated</strong> to a
<strong class="info">physical address</strong>.

This <strong class="special">virtualization</strong> allows us to <strong
class="caution">relocate</strong> a <strong class="success">process</strong> to
any location in <strong class="info">memory</strong>.

</div>

<div>

<div class="alert caution-bg">

#### <span class="primary">Goals</span>

1. <strong class="caution">Transparency</strong>

    Invisible to application.

    <br>

2. <strong class="success">Efficiency</strong>

    As little overhead as possible.

    <br>

3. <strong class="danger">Protection</strong>

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
application whenever you need to <strong class="warning">load</strong> it into memory.

- No <strong class="danger">protection</strong>

- Difficult to <strong class="caution">relocate</strong>

- Expensive upfront costs

</div>

<div class="margin-top-0-5">

## <span class="success">Dynamic</span>

A better approach is to use <strong class="info">special hardware</strong>
features to perform <strong class="primary">on-demand translation</strong>.

<br>

- Can provide <strong class="danger">protection</strong>

- Can be updated

- Pay cost as you go

</div>

</div>

---

# Address Translation: <span class="gold">Base & Bounds</span>

One simple method of <strong class="success">hardware-based address
translation</strong> is the <strong class="warning">base and bounds</strong>
method:

- The CPU has a <strong class="special">base register</strong> which holds the
  starting point in <strong class="info">physical memory</strong>, and a
  <strong class="special">bounds register</strong> which holds the ending point
  in <strong class="info">physical memory</strong>.

- The <strong class="info">physical address</strong> can be <strong
  class="success">translated</strong> by computing the following:

<div class="centered font-large">

<strong class="info">Physical Address</strong> = <strong
class="special">Base</strong> + <strong class="success">Virtual
Address</strong>

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
    <td class="info-bg centered">32 KB</td>
</tr>
<tr>
    <td class="success-bg centered">1 KB</td>
    <td class="info-bg centered">33 KB</td>
</tr>
<tr>
    <td class="success-bg centered">5000</td>
    <td class="info-bg centered">37768</td>
</tr>
<tr>
    <td class="success-bg centered">9000</td>
    <td class="info-bg centered"><i class="danger">Fault (Out of Bounds)</i></td>
</tr>
</tbody>
</table>

---

# Address Translation: <span class="gold">Requirements</span>

<table class="bordered">
<thead>
    <th class="special-bg font-smaller">Requirements</th>
    <th class="caution-bg font-smaller">Notes</th>
</thead>
<tbody>
<tr>
    <td class="info-bg font-smaller centered"><b>Privileged Mode</b></td>
    <td class="caution-bg font-smaller">Prevent user mode processes from executing privileged operations.</td>
</tr>
<tr>
    <td class="info-bg font-smaller centered"><b>Base / Bound Registers</b></td>
    <td class="caution-bg font-smaller">Need pair of registers to support address translation and bounds checks.</td>
</tr>
<tr>
    <td class="info-bg font-smaller centered"><b>Translate Virtual Addresses</b></td>
    <td class="caution-bg font-smaller">Need hardware to do translations and check limits.</td>
</tr>
<tr>
    <td class="success-bg font-smaller centered"><b>Update Base / Bound Registers</b></td>
    <td class="caution-bg font-smaller">OS must be able to set base and bounds registers.</td>
</tr>
<tr>
    <td class="success-bg font-smaller centered"><b>Register Exception Handlers</b></td>
    <td class="caution-bg font-smaller">OS must be able to tell hardware what code to run if exception occurs.</td>
</tr>
<tr>
    <td class="danger-bg font-smaller centered"><b>Raise Exceptions</b></td>
    <td class="caution-bg font-smaller">OS must be notified when processes try to access privileged instructions or out-of-bounds memory.</td>
</tr>
</tbody>
</table>

---

<!-- _class: lead -->

# Memory API

---

# Memory API: <span class="gold">Review</span>

<div class="slide-centered font-large">

Break into groups of `3` or `4` and<br>prepare for <strong class="success">team
trivia</strong>!

</div>

---

# Memory API: <span class="gold">Allocation</span>

> How do we <strong class="success">allocate</strong> an array of `1,000,000` ints?

<br>

```c
int *a = malloc(1000000 * sizeof(int));
```

---

# Memory API: <span class="gold">Deallocation</span>

> How do we <strong class="danger">deallocate</strong> that array of ints?

<br>

```c
free(a);
```

---

# Memory API: <span class="gold">Common Error A</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
char *buffer;
fgets(buffer, BUFSIZ, stdin);
```

<br>
<br>

<div class="alert danger-bg centered">

<i>Forgot to allocate memory, so we <strong class="danger">segfault</strong>.</i>

</div>

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

<br>
<br>

<div class="alert danger-bg centered">

<i>Did not allocate enough memory, so <strong class="danger">buffer
overflow</strong>.</i>

</div>

---

# Memory API: <span class="gold">Common Error C</span>

> What is the <strong class="danger">memory error</strong> in the following
> code?

<br>

```c
char *s = malloc(100*sizeof(char));

puts(s);
```

<br>
<br>

<div class="alert danger-bg centered">

<i>Did not initialize memory, so <strong class="danger">uninitialized
read</strong>.</i>

</div>

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

<br>
<br>

<div class="alert danger-bg centered">

<i>Forgot to free memory, so <strong class="danger">memory leak</strong>.</i>

</div>

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

<br>
<br>

<div class="alert danger-bg centered">

<i>Freed before we are done, so <strong class="danger">dangling pointer</strong>.</i>

</div>

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

<br>
<br>

<div class="alert danger-bg centered">

<i>Try to free something more than once, so <strong class="danger">double free</strong>.</i>

</div>

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

<br>

<div class="alert danger-bg centered">

<i>Try to free something that wasn't dynamically allocated, so <strong
class="danger">invalid free</strong>.</i>

</div>

---

# Memory API: <span class="gold">Where is My Mind?</span>

<strong class="info">Dr. Thain</strong> wants you to write a <strong
class="danger">compiler</strong>.  He tells you don't worry about managing
memory, just allocate as much as you want and <strong class="warning">don't
bother to free anything</strong>.  You look at him in <strong
class="caution">horror</strong> and are ready to <strong
class="danger">roast</strong> him on **Slack / X**.  Are you <strong
class="success">justified</strong>?

<br>
<br>
<br>

<div class="alert info-bg centered">

<i>We have <strong class="warning">two levels of memory management</strong>:<br>at
the <strong class="caution">OS level</strong>, and at the <strong
class="success">process level</strong>.</i>

<i><strong class="danger">When a process exits, all of its memory is returned<br>
to the OS even if it was not freed by the process.</strong></i>

</div>
