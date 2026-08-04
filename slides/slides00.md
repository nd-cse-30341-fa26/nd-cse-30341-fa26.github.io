---
title: "Lecture 00: Syllabus"
description: "Course Syllabus for CSE 30341 Operating System Principles (Fall 2026)"
author: Peter Bui
keywords: lecture,osp,syllabus
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/lecture00.html
theme: domer-slides:
---

<!-- _class: lead -->

# CSE 30341

## Syllabus

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
    <img src="static/img/whoami.png" class="padding-10">
</div>

---

# Motivation: <span class="gold">In The News...</span>

<div class="slide-centered">

![w:350px](static/img/lecture00-news-windows.png)
![w:350px](static/img/lecture00-news-macos.png)
![w:350px](static/img/lecture00-news-linux.png)

</div>

---

# Motivation: <span class="gold">The Journey Continues...</span>

<div class="slide-centered">
    <img src="static/img/cse-curriculum.png" class="padding-10">
</div>

---

# Motivation: <span class="gold">House of Cards</span>

<div class="slide-centered">
    <img src="static/img/house-of-cards-slides00.png" class="padding-10">
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
            <td class="centered">Zulip</td>
            <td><a href="https://zulip.ndlug.org">https://zulip.ndlug.org</a></td>
        </tr>
        <tr class="caution-bg">
            <td class="centered">Email</td>
            <td><a href="mailto:fa26-cse-30341-01-group@nd.edu">fa26-cse-30341-01-group@nd.edu</a></td>
        </tr>
    </tbody>
</table>

**Note**: [Zulip] is our <strong class="success"> primary communications
platform</strong> and you will be automatically be <strong
class="danger">invited to appropriate the course channels</strong>.

[Zulip]: https://zulip.ndlug.org

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
      <td class="centered">10 &times; 1</td>
    </tr>
    <tr class="caution-bg">
      <td class="centered"><span class="badge caution-btn">Projects</span></td>
      <td>Quarterly group projects.</td>
      <td class="centered">4 &times; 5</td>
    </tr>
    <tr class="danger-bg">
      <td class="centered"><span class="badge danger-btn">Exams</span></td>
      <td>Quarterly in-person exams.</td>
      <td class="centered">3 &times; 15, 25</td>
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
