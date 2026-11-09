---
title: "Notebook 16: Segmentation, Paging"
description: "Segmentation, Paging"
author: Peter Bui
keywords: notebook,osp,address translation,segmentation,paging"
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/notebook16.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Segmentation, Paging

---

# Segmentation: <span class="gold">Overview</span>

<div class="columns-3-1">

<div>

<strong class="warning">Segmentation</strong> is a <b> _________________</b>

form of <strong class="warning"> __________________________</strong>:

</div>

<div class="centered">

<img src="static/img/slides15-segmentation-overview.svg">

</div>

</div>

---

# Segmentation: <span class="gold">Segments</span>

Because our <strong class="success">address space</strong> is split into
separate <strong class="caution">segments</strong>, we have some additional
issues and opportunities:

<br>

- <strong class="primary"> _____________________</strong>:
    <b> _________________________________________</b>

    <br>

    <b> ________________________________________________________________</b>

    <br>

- <strong class="comment"> _____________________</strong>:
    <b> _________________________________________</b>

    <br>

    <b> ________________________________________________________________</b>

    <br>

---

# Segmentation: <span class="gold">Hardware Information</span>

To support <strong class="warning">segmentation</strong>, the <strong
class="info"> ________________</strong> needs the following:

<table class="bordered">
<thead>
    <th class="special-bg">Segment</th>
    <th class="special-bg">Base</th>
    <th class="special-bg">Size</th>
    <th class="special-bg">Growth Positive?</th>
    <th class="special-bg">Protection</th>
</thead>
<tbody>
<tr class="danger-bg">
    <td class="centered">Code</td>
    <td class="centered">32K</td>
    <td class="centered">2K</td>
    <td class="centered">1</td>
    <td class="centered">Read-Execute</td>
</tr>
<tr class="caution-bg">
    <td class="centered">Data</td>
    <td class="centered">34K</td>
    <td class="centered">2K</td>
    <td class="centered">1</td>
    <td class="centered">Read-Write</td>
</tr>
<tr class="success-bg">
    <td class="centered">Heap</td>
    <td class="centered">36K</td>
    <td class="centered">2K</td>
    <td class="centered">1</td>
    <td class="centered">Read-Write</td>
</tr>
<tr class="info-bg">
    <td class="centered">Stack</td>
    <td class="centered">28K</td>
    <td class="centered">2K</td>
    <td class="centered">0</td>
    <td class="centered">Read-Write</td>
</tr>
</tbody>
</table>

<strong class="caution">Operating system</strong> must track this information
for every <strong class="success"> _____________</strong>

and save and restore it on each
<strong class="special"> ___________________________________</strong>.

---

# Segmentation: <span class="gold">Address Translation</span>

Given the following `16-bit` <strong class="warning">virtual address</strong>:

<div class="centered">

<img src="static/img/reading08-address.svg">

</div>

1. What is the <strong class="danger">largest possible segment size</strong>?

2. What is the <strong class="success">maximum possible offset value</strong>?

3. Which <strong class="caution">segment</strong> is this <strong
   class="warning">virtual address</strong> located in?

4. What is the <strong class="info">physical address</strong> of
   this <strong class="warning">virtual address</strong>?

---

# Segmentation: <span class="gold">Problems</span>

<div class="columns-3-1">

<div>

</div>

<div class="centered">

<img src="static/img/slides15-segmentation-problem.svg">

</div>

</div>

---

# Paging: <span class="gold">Overview</span>

<div class="columns-3-1">

<div>

</div>

<div class="centered">

<img src="static/img/slides16-paging-overview.svg">

</div>

</div>

---

# Paging: <span class="gold">Page Table</span>

Each <strong class="success">process</strong> has a <strong
class="primary"> ________________</strong> that stores the <strong
class="caution"> ________________</strong>

of each <strong class="warning"> _________________</strong> to the corresponding
<strong class="info"> ___________________</strong>.

<table class="bordered">
<thead>
    <th class="special-bg">Bit</th>
    <th class="special-bg">Information</th>
</thead>
<tbody>
<tr class="success-bg">
    <td width="400px">&nbsp;</td>
    <td width="700px">&nbsp;</td>
</tr>
<tr class="danger-bg">
    <td width="400px">&nbsp;</td>
    <td width="700px">&nbsp;</td>
</tr>
<tr class="info-bg">
    <td width="400px">&nbsp;</td>
    <td width="700px">&nbsp;</td>
</tr>
<tr class="caution-bg">
    <td width="400px">&nbsp;</td>
    <td width="700px">&nbsp;</td>
</tr>
</tbody>
</table>

In addition to the <strong class="caution">mapping</strong>, each <strong
class="primary"> ______________________</strong> may contain

the bits of information above.

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

While better than <strong class="warning">segmentation</strong> when it comes
to <strong class="danger"> ___________________</strong>, <strong
class="warning">paging</strong> suffers from the following problems:
