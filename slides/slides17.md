---
title: "Slides 17: TLBs, Multi-Level Page Tables"
description: "TLBs, Multi-Level Page Tables"
author: Peter Bui
keywords: lecture,osp,address space,paging,tlbs"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides17.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## TLBS, Multi-Level Page Tables

---

# Questions

<div class="font-large">

1. What <strong class="danger">problem</strong> do <strong
   class="special">TLBs</strong> address and how do they solve it?

2. What <strong class="danger">problem</strong> do <strong
   class="primary">multi-level page tables</strong> address and how do they
   solve it?

</div>

---

# Fundamental Theorem of SE

> "We can solve any <strong class="danger">problem</strong> by introducing an <strong class="warning">extra
> level of indirection</strong>." -- [David Wheeler]

- **Pointers**     -> **Data**
- **Polymorphism** -> **Methods**
- **Paths**        -> **Inodes**
- **Domains**      -> **IP Addresses**

> "But that usually will create another <strong class="danger">problem</strong>." -- [David
> Wheeler]

[David Wheeler]: https://en.wikipedia.org/wiki/David_Wheeler_(computer_scientist)

---

<div class="slide-centered">

<img src="static/img/slides17-paging-overview.svg" height="625px">

</div>

---

<div class="columns-2-1">

<div class="slide-centered">

<img src="static/img/slides17-paging-page-table.svg" height="625px">

</div>

<div class="font-small">

<div class="centered">

We have one <strong class="primary">page table</strong> per <strong
class="success">process</strong>, which is stored in <strong
class="info">physical memory</strong>.

</div>

- <strong class="danger">Problem</strong>: Each <strong class="warning">virtual
  memory translation</strong> (<i class="muted">memory access</i>) requires `2`
  <strong class="info">physical memory accesses</strong>

    <strong class="success"><i>Fix with TLBs</i></strong>

- <strong class="danger">Problem</strong>: Each <strong class="primary">page
  table</strong> has a mapping for every <strong class="warning">virtual
  page</strong> to <strong class="info">physical page frame</strong>, which can
  be quite large.

    <strong class="success"><i>Fix with Multi-Level Page Table</i></strong>

</div>

</div>

---

# TLBs: <span class="gold">Memory Access</span> (<i class="muted">Overview</i>)

<div class="columns">

<div class="margin-top-0-5">

## <span class="danger">Problem</span>

Each <strong class="warning">virtual memory</strong> access requires <strong class="danger">two
fetches</strong> from <strong class="info">physical memory</strong>.

- The **first** for the <strong class="primary">PTE</strong> to perform the
  <strong class="warning">address translation</strong>.

- The **second** for the data itself.

</div>

<div class="margin-top-0-5">

## <span class="success">Solution</span>

Add a <strong class="success">cache</strong> called the <strong
class="special">translation-lookaside buffer (TLB)</strong> to the <strong
class="info">MMU</strong> and use it to store <strong class="warning">address
translations</strong>:

<br>

<div class="alert success-bg centered">

<i>Upon <strong class="warning">virtual memory reference</strong>, check <strong
class="special">TLB</strong> for translation, and if present use that without
consulting <strong class="primary">page table</strong>.</i>

</div>

</div>

</div>

---

# TLBs: <span class="gold">Memory Access</span> (<i class="muted">Updated</i>)

```python
VPN = (VirtualAddress & VPN_MASK) >> VPN_SHIFT

if TLBLookup(VPN) is None:                              # If not in TLB
    PTEAddress = PTBR + (VPN * sizeof(PTE))             # Lookup PTE
    PTE = AccessMemory(PTEAddress)                      # Fetch PTE from Physical Memory

    if not PTE.Valid:                       raise SegmentationFault
    elif not CanAccess(PTE.ProtectBits):    raise ProtectionFault
    else:                                   TLBInsert(VPN, PTE.PFN, PTE.ProtectBits)

TLBEntry        = TLBLookup(VPN)                        # Use TLB entry
Offset          = VirtualAddress & OFFSET_MASK
PhysicalAddress = (TLBEntry.PFN << PFN_SHIFT) | Offset  # Perform translation
Register        = AccessMemory(PhysicalAddress)         # Fetch Data from Physical Memory
```

---

# TLBs: <span class="gold">Hardware Information</span>

The <strong class="info">MMU</strong> usually uses a <strong
class="success">fully associative cache</strong> (<i class="muted">entries can
go anywhere and the whole cache must be searched</i>) and usually stores
entries in the following format:

```
VPN -> PFN | Other Bits
```

Where other bits could be <strong class="special">valid bits</strong>, <strong
class="special">protection bits</strong>, <strong class="special">dirty
bits</strong>, <strong class="special">address space identifier</strong>, etc.

<br>

<div class="alert info-bg centered">

There may be multiple levels of <strong class="info">TLBs</strong> where the smaller ones are
<strong class="success">fully associative</strong> and the large ones are <strong class="success">set
associative</strong>.

</div>

---

# TLBs: <span class="gold">Context Switch</span>

On each <strong class="warning">context switch</strong>, the <strong class="caution">operating
system</strong> must either:

<br>

<div class="alert danger-bg">

1. **Flush** the <strong class="info">TLB</strong> to mark all entries as
   invalid so that we don't use a wrong <strong
   class="warning">translation</strong>.

</div>

<br>

<div class="centered">
<b>OR</b>
</div>

<br>

<div class="alert success-bg">

2. Set the <strong class="special">ASID</strong> register to the current
   <strong class="caution">PID</strong> so that the <strong
   class="info">MMU</strong> knows which entries are valid.

</div>

---

# TLBs: <span class="gold">Locality</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="special">Spatial Locality</span>

This is the idea that if we access memory at address `x`, then we will most
likely access memory <strong class="special">near</strong> `x` soon in the future.

<br>
<br>

<div class="alert special-bg centered">

Accessing elements in an **array** sequentially.

</div>

</div>

<div class="margin-top-0-5">

## <span class="caution">Temporal Locality</span>

This is the idea that if we access an instruction or data item, then we will
most likely access it <strong class="caution">again</strong> soon in the
future.

<br>

<div class="alert caution-bg centered">

Accessing same **variable** in a **loop**.

</div>

</div>

</div>

---

# TLBs: <span class="gold">Handling Misses</span>

On a <strong class="danger">miss</strong>, the <strong class="info">MMU</strong> raises an
<strong class="warning">exception</strong> and thus triggers a <strong class="caution">trap
handler</strong>:

- The <strong class="caution">operating system kernel</strong> then looks up corresponding
  <strong class="primary">page table entry</strong> and updates the <strong class="info">TLB</strong>.

- Need to be careful of <strong class="danger">infinite TLB misses</strong>.

---

# Multi-Level: <span class="gold">Page Table Size</span> (<i class="muted">Problem</i>)

<div class="margin-top-0-5">

## <span class="danger">Problem</span>

Simple <strong class="primary">array-based (linear) page tables</strong> are
<strong class="danger">too big</strong> and take up far <strong
class="danger">too much memory</strong>.

- We could make <strong class="caution">pages bigger</strong>, but then we would have to
  deal with <strong class="danger">internal fragmentation</strong>.

- We could use a <strong class="warning">hybrid approach with segmentation</strong>, but then
  we would still have problems with <strong class="danger">external fragmentation</strong> (<i
  class="muted">variable size page tables</i>)

</div>

---

<div class="columns-1-2">

<div class="slide-centered">

<img src="static/img/slides17-multi-level-problem.svg" height="625px">

</div>

<div>

This is an example of an <strong class="primary">array-based (linear) page table</strong>:

- Each <strong class="primary">PTE</strong> the <strong
  class="info">PFN</strong> corresponding to the <strong
  class="warning">VPN</strong> and bits.

- Because the <strong class="primary">page table</strong> itself is in <strong
  class="info">memory</strong>, we can group sequences of <strong
  class="primary">PTEs</strong> into <strong class="info">pages</strong>.

    For instance, the first `4` <strong class="primary">PTEs</strong> belong to
    the first <strong class="warning">page</strong> (of the <strong
    class="primary">page table</strong>), which is located at <strong
    class="info">physical page frame</strong> `200`.

- This data structure has a lot of <strong class="danger">wasted space</strong> since we
  allocate <strong class="warning">pages</strong> for invalid <strong class="primary">PTEs</strong>.

</div>

</div>

---

# Multi-Level: <span class="gold">Page Table Size</span> (<i class="muted">Solution</i>)

<div class="centered">

<img src="static/img/slides17-multi-level-solution.svg" height="325px">

</div>

This is an example of a <strong class="primary">multi-level page table</strong>:

- A <strong class="caution">page directory</strong>, with <strong
  class="caution">page directory entries (PDEs)</strong> tracks whether a
  <strong class="warning">page</strong> of a <strong
  class="primary">PTEs</strong> is valid and which <strong
  class="info">PFN</strong> it maps to.

- Any invalid <strong class="warning">pages</strong> of the <strong
  class="primary">page table</strong> remain <strong
  class="danger">unallocated</strong>.

---

<div class="centered">

<img src="static/img/slides17-multi-level-solution2.svg" height="375px">

</div>

Convert <strong class="primary">page table array</strong> into <strong
class="primary">multi-level tree</strong>:

1. Split <strong class="primary">page table array</strong> into <strong
   class="warning">page</strong> sized blocks (<i class="muted">nodes</i>).

2. Keep track of these <strong class="warning">pages</strong> in <strong
   class="caution">page directory</strong> (<i class="muted">root</i>).

3. <strong class="warning">Pages</strong> with invalids <strong
   class="primary">PTEs</strong> can remain <strong
   class="danger">unallocated</strong> (<i class="muted">thus saving
   space</i>).

---

# Multi-Level: <span class="gold">Checklist</span>

Given a <strong class="special">virtual memory system</strong> with certain
<strong class="warning">virtual address size</strong>, <strong
class="info">physical address size</strong>, and <strong class="warning">page
size</strong>:

<div class="columns">

<div class="font-smaller">

1. How many **bytes** can we address?
2. How many **pages** do we need?
3. How many **bits** in <strong class="special">VPN</strong>?
4. How many **bits** in <strong class="warning">offset</strong>?
5. How much **memory** does <strong class="primary">page table</strong> require?
6. How many <strong class="warning">pages</strong> does <strong class="primary">page table</strong> require?
7. How many <strong class="primary">PTEs</strong> per <strong class="warning">page</strong>?

</div>

<div class="font-smaller">

8. How many <strong class="caution">PDEs</strong> in <strong class="caution">page directory</strong>?
9. How many **bits** in index <strong class="caution">page directory</strong>?
10. How many **bits** in index <strong class="primary">page table</strong>?
11. How much **memory** does <strong class="caution">page directory</strong> require?
12. How many <strong class="warning">pages</strong> does <strong class="caution">page directory</strong> require?

</div>

</div>

---

# Multi-Level: <span class="gold">Summary</span>

<div class="columns">

<div class="margin-top-0-5">

## <span class="success">Pros</span>

- Only allocates <strong class="primary">page table</strong> space in
  proportion to the amount of <strong class="success">address space</strong> in
  use.

- Easier to place into <strong class="info">physical memory</strong> due to
  <strong class="warning">page</strong>-sized units.

</div>

<div class="margin-top-0-5">

## <span class="danger">Cons</span>

- Requires additional <strong class="danger">loads from memory</strong> to
  perform <strong class="warning">translation</strong> (<i
  class="muted">time-space trade-off</i>).

- Adds additional <strong class="danger">complexity</strong> in order to improve memory usage.

</div>

</div>
