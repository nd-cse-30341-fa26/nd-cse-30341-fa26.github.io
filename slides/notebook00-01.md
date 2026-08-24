---
title: "Notebook 00, 01: Syllabus, Computer Hardware"
description: "Course Syllabus, Computer Hardware, Boot Sequence"
author: Peter Bui
keywords: lecture,osp,syllabus,hardware,boot sequence
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook00-01.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Syllabus

---

<!-- _class: lead -->

# Introduction

---

# Introduction: <span class="gold">Ice Breaker</span>

<div class="font-large">

1. What is your <span class="green">**name**</span>?

2. What do you wish to <span class="yellow">**learn**</span> in this class?

3. What is the most interesting thing you <span class="red">**read**</span> this summer?

</div>

---

# Introduction: <span class="gold">Whoami</span>

<div class="slide-centered">
    <img src="static/img/slides00-whoami.png" class="padding-10">
</div>

---

<!-- _class: lead -->

# Motivation

---

# Motivation: <span class="gold">In The News...</span>

<div class="slide-centered">

<img src="static/img/slides00-news-windows.png" class="framed" width="347">
<img src="static/img/slides00-news-macos.png" class="framed" width="350">
<img src="static/img/slides00-news-linux.png" class="framed" width="350">

</div>

---

# Motivation: <span class="gold">The Journey Continues...</span>

<div class="slide-centered">
    <img src="static/img/slides00-cse-curriculum.png" class="padding-10">
</div>

---

# Motivation: <span class="gold">House of Cards</span>

<div class="slide-centered">
    <img src="static/img/slides00-house-of-cards-blank.png" class="padding-10">
</div>

---

# Motivation: <span class="gold">Questions</span>

<div class="font-large">

1. What exactly is an <span class="yellow">**operating system**</span>?

2. What <span class="green">**services**</span> does it provide?

3. How does it provide these <span class="green">**services**</span>?

4. Do we (<span class="gray">*really*</span>) need an <span
   class="yellow">**operating system**</span>?

</div>

---

<!-- _class: lead -->

# Syllabus

---

# Syllabus: <span class="gold">Communication</span>

<div class="slide-centered">

<table class="bordered">
    <thead>
        <th>Platform</th>
        <th>URL</th>
    </thead>
    <tbody>
        <tr class="info-bg">
            <td class="centered">Website</td>
            <td><a href="https://yld.me/cse-30341-fa26">https://yld.me/cse-30341-fa26</a></td>
        </tr>
        <tr class="success-bg">
            <td class="centered">Slack</td>
            <td><a href="https://nd-cse.slack.com/messages/cse-30341-fa26">#cse-30341-fa26</a></td>
        </tr>
        <tr class="caution-bg">
            <td class="centered">Email</td>
            <td><a href="mailto:fa26-cse-30341-01-group@nd.edu">fa26-cse-30341-01-group@nd.edu</a></td>
        </tr>
    </tbody>
</table>

**Note**: [Slack] is our <strong class="success"> primary communications
platform</strong> and you will be automatically be <strong
class="danger">invited to appropriate the course channels</strong>.

[Slack]: https://nd-cse.slack.com

</div>

---

# Syllabus: <span class="gold">Grading</span>

<div class="slide-centered">

<table class="bordered">
  <thead>
    <th>Component</th>
    <th>Description</th>
    <th>Points</th>
  </thead>
  <tbody>
    <tr class="info-bg">
      <td class="centered"><span class="badge primary-btn">Readings</span></td>
      <td>Weekly individual assignments.</td>
      <td class="centered">11 &times; 1</td>
    </tr>
    <tr class="caution-bg">
      <td class="centered"><span class="badge caution-btn">Projects</span></td>
      <td>Quarterly group projects.</td>
      <td class="centered">4 &times; 4</td>
    </tr>
    <tr class="warning-bg">
      <td class="centered"><span class="badge warning-btn">Interviews</span></td>
      <td>Quarterly individual interviews.</td>
      <td class="centered">4 &times; 2</td>
    </tr>
    <tr class="danger-bg">
      <td class="centered"><span class="badge danger-btn">Exams</span></td>
      <td>Quarterly in-person exams.</td>
      <td class="centered">3 &times; 15, 20</td>
    </tr>
    <tr class="success-bg">
      <td class="centered" style="font-weight: bold;">Total</td>
      <td></td>
      <td class="centered" style="font-weight: bold;">100</td>
    </tr>
  </tbody>
</table>

</div>

---

# Syllabus: <span class="gold">Course Topics</span>

<div class="columns">
<div>

1. <strong class="success">System Calls and Processes</strong>

    - History
    - System Calls
    - Processes
    - Scheduling

2. <strong class="danger">Concurrency with Threads</strong>

    - Threads
    - Locks and Condition Variables
    - Semaphores
    - Design Patterns

</div>

<div>

3. <strong class="info">Virtual Memory</strong>

    - Address Spaces
    - Segmentation
    - Paging
    - Swapping

4. <strong class="caution">Filesystems</strong>

    - I/O Devices
    - RAID
    - FFS
    - Consistency and Integrity
</div>
</div>

---

# Syllabus: <span class="gold">CSE Honor Code</span>

For the assignments in this class, you are allowed to <strong
class="success">consult printed and online resources</strong> and to <strong
class="success">discuss the class material with other students</strong>. You
may also consult <strong class="caution">AI Tools such as CoPilot, ChatGPT, or
Gemini</strong> for help explaining concepts, debugging problems, or as a
reference.

<table class="bordered">
    <thead>
        <th></th>
        <th>Resources</th>
        <th>Solutions</th>
    </thead>
    <tbody>
        <tr>
            <td class="centered default-bg"><strong>Consulting</strong></td>
            <td class="centered success-bg">Allowed</td>
            <td class="centered danger-bg">Not Allowed</td>
        </tr>
        <tr>
            <td class="centered default-bg"><strong>Copying</strong></td>
            <td class="centered caution-bg">Cite</td>
            <td class="centered danger-bg">Not Allowed</td>
        </tr>
    </tbody>
</table>


<strong class="warning">Viewing, copying, or consulting solutions</strong>,
such as those from other students, previous semesters, or generated by <strong
class="danger">AI Tools is never allowed</strong>.

---

# Syllabus: <span class="gold">The Hacker Ethic</span>

<div class="columns">
<div class="slide-centered">

<strong class="gold">Hackers</strong> believe that <strong
class="success">essential lessons</strong> can be learned about the systems—about
the world—<strong class="caution">from taking things apart</strong>, seeing
how they work, and <strong class="info">using this knowledge to create
new and more interesting things</strong>.

</div>

<div class="slide-centered">

<strong class="gold">Hackers</strong> should be judged by their <strong
class="success">hacking</strong>, not criteria such as <strong
class="danger">degrees, age, race, sex, or position</strong>.

</div>
</div>

---

<!-- _class: lead -->

# Computer Hardware

---

# Computer Hardware: <span class="gold">A Computer is ...</span>

A general purpose <strong class="caution">_________________________</strong>
machine.

<br>

<div class="centered">
    <img src="static/img/slides01-personal-computers.png" class="bordered">
</div>

A <strong class="caution">________________________</strong> is an electronic device that

processes <strong class="special">_________________________</strong>.

---

# Computer Hardware: <span class="gold">Architecture</span>

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides01-logical-construction-blank.png">

</div>

---

# Computer Hardware: <span class="gold">Devices</span>

<div class="columns">

<div class="slide-centered">

<a title="Fred the Oyster, CC BY-SA 4.0 &lt;https://creativecommons.org/licenses/by-sa/4.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Chipset_schematic.svg"><img width="475" alt="Chipset schematic" src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Chipset_schematic.svg/500px-Chipset_schematic.svg.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail"></a>

</div>

<div class="slide-centered">

A modern <strong class="caution">computer</strong> is a collection of smaller

<strong class="special">________________________</strong>

computing devices that

<strong class="success">________________________</strong>

by

<strong class="danger">________________________</strong>

using a variety of protocols and interfaces.

</div>

</div>

---

# Computer Hardware: <span class="gold">Components</span>

<div class="columns-2-1">

<div>

<strong class="success">Identify</strong> the following <strong
class="caution">components</strong> in the provided computers:

1. <strong class="success">Processor</strong>

2. <strong class="caution">Memory</strong>

3. <strong class="danger">Storage</strong>

4. <strong class="special">I/O</strong>


</div>

<div class="slide-centered margin-top-0-5">

<img src="https://www.techspot.com/articles-info/254/images/18b.jpg" width="240" class="framed">

<img src="https://c1.neweggimages.com/productimage/nb640/11-153-127-02.jpg" width="240" class="framed">

<img src="https://i.ebayimg.com/images/g/MEcAAOSwvnRkMj6B/s-l400.jpg" width="240" class="framed">

</div>

</div>

---

<!-- _class: lead -->

# Boot Sequence

---

# Boot Sequence: <span class="gold">BIOS / UEFI</span>

<div class="columns-1-3">

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides01-boot-sequence-blank.png">

</div>

<div>

---

# An Operating System is ...

A set of <strong class="caution">________________________</strong>

(*processes*, *threads*, *virtual memory*, *filesystems*) that enable

<strong class="special">________________________ </strong> to effectively and efficiently utilize

<strong class="info">________________________</strong> resources and interact with each other.

<br>

<img src="static/img/house-of-cards.png" class="float-right" width="500">


- <strong class="info">________________________</strong>

    <br>

- <strong class="caution">________________________</strong>

    <br>

- <strong class="success">________________________</strong>

    <br>
