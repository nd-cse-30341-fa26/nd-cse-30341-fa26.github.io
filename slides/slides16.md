---
title: "Slides 16: Paging"
description: "Paging"
author: Peter Bui
keywords: lecture,osp,address space,paging"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides16.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Paging

---

# Questions

<div class="font-large">

1. What are the key <strong class="danger">problems</strong> with <strong
   class="warning">segmentation</strong>?

2. How does <strong class="warning">paging</strong> address these <strong
   class="danger">problems</strong>?

3. What exactly is a <strong class="warning">page</strong>? <strong
   class="info">page frame</strong>? <strong class="primary">page
   table</strong>?

4. How do we translate a <strong class="warning">virtual address</strong> to a
   <strong class="info">physical address</strong>?

</div>

---

# Paging: <span class="gold">Overview</span>

<div class="columns-2-1">

<div>

Rather than chop memory up into <strong class="danger">variable sized pieces</strong>,
<strong class="warning">paging</strong> uses <strong class="caution">fixed-sized</strong> units called
<strong class="warning">pages</strong>:


- Each <strong class="success">process</strong> has an <strong
  class="success">address space</strong> that consists of <strong
  class="caution">fixed-size</strong> <strong class="warning">virtual
  pages</strong>.

- Each <strong class="warning">virtual page</strong> maps to a <strong
  class="info">physical page frame</strong> (*of the same size*).

</div>

<div class="centered">

<img src="static/img/slides16-paging-overview.svg">

</div>

</div>

---

# Paging: <span class="gold">Page Table</span>

Each <strong class="success">process</strong> has a <strong
class="primary">page table</strong> that stores the <strong
class="caution">mapping</strong> of each <strong class="warning">virtual page
number</strong> to the corresponding <strong class="info">physical page
frame</strong>.

<table class="bordered">
<thead>
    <th class="special-bg">Bit</th>
    <th class="special-bg">Information</th>
</thead>
<tbody>
<tr class="success-bg">
    <td>Valid</td>
    <td>Is the <strong class="caution">mapping</strong> valid?</td>
</tr>
<tr class="danger-bg">
    <td>Protection</td>
    <td>Can we read, write, or execute data in <strong class="warning">page</strong>?</td>
</tr>
<tr class="info-bg">
    <td>Present</td>
    <td>Is the <strong class="warning">page</strong> in <strong class="info">physical memory</strong>?</td>
</tr>
<tr class="caution-bg">
    <td>Reference</td>
    <td>Has the <strong class="warning">page</strong> been accessed?</td>
</tr>
</tbody>
</table>

In addition to the <strong class="caution">mapping</strong>, each <strong
class="primary">page table entry (PTE)</strong> may contain the bits of
information above.

---

# Paging: <span class="gold">Address Translation</span>

Given the <strong class="warning">virtual address</strong>, `36`, answer the following questions:

<div class="centered">

<img src="static/img/reading09-address.svg">

</div>

1. Which <strong class="warning">page</strong> is this address located?

2. Which <strong class="info">page frame</strong> is this address located?

3. What is the <strong class="warning">offset</strong> of this address?

4. What is the <strong class="info">physical address</strong>?

---

# Paging: <span class="gold">Memory Usage</span>

Suppose we had a `32-bit` machine with `4KB` <strong class="warning">pages</strong>:

1. How many <strong class="warning">pages</strong> can a <strong
   class="success">process</strong> have?

2. How many **bits** do we need for the <strong class="special">VPN</strong>?

3. How many **bits** do we need for the <strong class="warning">offset</strong>?

4. How large is the <strong class="primary">page table</strong> (*assuming each
   <strong class="primary">PTE</strong> is `4` bytes*)?

---

# Paging: <span class="gold">Memory Access</span>

```python
# Extract VPN from Virtual Address
VPN = (VirtualAddress & VPN_MASK) >> VPN_SHIFT

# Form the address of the page-table entry (PTE)
PTEAddress = PTBR + (VPN * sizeof(PTE))

# Fetch the PTE
PTE = AccessMemory(PTEAddress)

# Check if process can access the page
if not PTE.Valid:                       raise SegmentationFault
elif not CanAccess(PTE.Protection):     raise ProtectionFault
else:
	Offset          = VirtualAddress & OFFSET_MASK
	PhysicalAddress = (PTE.PFN << PFN_SHIFT) | Offset
	Register        = AccessMemory(PhysicalAddress)
```

---

# Paging: <span class="gold">Problems</span>

While better than <strong class="warning">segmentation</strong> when it comes to
<strong class="danger">external fragmentation</strong>, <strong class="warning">paging</strong> suffers from
the following problems:

1. <strong class="danger">Overhead</strong>: Because each <strong
   class="success">process</strong> requires a <strong class="primary">page
   table</strong> and each table can be quite large, <strong
   class="warning">paging</strong> incurs <strong class="danger">high memory
   usage</strong>.

2. <strong class="caution">Indirection</strong>: Because each memory access
   requires us to lookup the corresponding <strong
   class="primary">PTE</strong>, we need to perform `2` <strong
   class="info">physical memory</strong> accesses per <strong
   class="warning">virtual address</strong>.

