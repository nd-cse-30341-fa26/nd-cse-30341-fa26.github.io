---
title: "Lecture 02: OS Taxonomy, History, Themes"
description: "OS Taxonomy, History, and Themes"
author: Peter Bui
keywords: lecture,osp,taxonomy,history,themes
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides02.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## OS Taxonomy, History, Themes

---

# Questions

1. What are different types of <strong class="primary">operating
   systems</strong>?

2. How have <strong class="primary">operating systems</strong> <strong
   class="caution">evolved</strong> over time?

3. What are the three main <strong class="success">themes</strong> in <strong
   class="primary">operating systems</strong>?

---

<!-- _class: lead -->

# OS Taxonomy

---

# By Purpose: <span class="gold">Mainframes and Servers</span>

<div class="columns">

<div class="margin-top-0-5">

## <strong class="danger">Mainframe</strong>

Process many jobs or tasks at once (*time-sharing, transaction processing, batch*)

<br>

<div class="centered">
    <img src="https://images.computerhistory.org/revonline/images/500004505-03-01.jpg?w=400" class="framed" width="400">
</div>

</div>

<div class="margin-top-0-5">

## <strong class="success">Server</strong>

Provide services to multiple users (*print, filesharing, web, etc.*)

<br>
<br>
<br>

<div class="centered">
    <img src="https://i.dell.com/is/image/DellContent//content/dam/images/products/servers/poweredge/r440/dellemc-per440-8x2-5-lcd-above-ff.psd?fmt=png-alpha&pscan=auto&scl=1&hei=402&wid=1344&qlt=100,1&resMode=sharp2&size=1344,402&chrss=full" width="520">
</div>

</div>

</div>

---

# By Purpose: <span class="gold">Personal and Handheld</span>

<div class="columns">

<div class="margin-top-0-5">

## <strong class="special">Personal</strong>

Support a single user (like your *laptop* or *desktop*)

<br>
<br>

<div class="centered">
    <img src="https://i.dell.com/is/image/DellContent//content/dam/ss2/product-images/dell-client-products/notebooks/latitude-notebooks/14-7420-2in1/media-gallery/la7420t_ctb_00030rf120_bk_5000x5000_gettyimages-1197597312_revised.psd?fmt=png-alpha&pscan=auto&scl=1&wid=4652&hei=2777&qlt=100,1&resMode=sharp2&size=4652,2777&chrss=full&imwidth=420" width="420">
</div>

</div>

<div class="margin-top-0-5">

## <strong class="caution">Handheld</strong>

Usually found in *PDAs* or *mobile phones*

<div class="centered">
    <img src="https://p4-ofp.static.pub//fes/cms/2024/08/28/82b5rafgf57ap23fcdgtk1i9hxek5u880251.png" width="400">
</div>

</div>

</div>

---

# By Purpose: <span class="gold">Embedded and Real-time</span>

<div class="columns">

<div class="margin-top-0-5">

## <strong class="primary">Embedded</strong>

Run on resource constrained devices that are not usually used for general
purpose computing (*TVs, cars, microwaves, etc.*)

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/QNX-Logo-QNX-CORAL-RGB.svg/960px-QNX-Logo-QNX-CORAL-RGB.svg.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail" width="450">

</div>

<div class="margin-top-0-5">

## <strong class="warning">Real-time</strong>

Provide absolute guarantees that a certain action will occur by a certain time.

<br>

<div class="centered">
<img src="https://www.windriver.com/sites/default/files/styles/hero_1024x480/public/posts/VxWorks-logo.png?itok=v8iPm_Lb" width="450">
</div>

</div>

</div>


---

# By Structure: <span class="gold">Monolithic, Microkernel</span>

<div class="columns">

<div class="margin-top-0-5">

## <strong class="danger">Monolithic</strong>

A **single** program running in **kernel** mode.

</div>

<div class="margin-top-0-5">

## <strong class="success">Microkernel</strong>

**Multiple** programs working together with the help of a *privileged*
**intermediary**.

</div>

</div>

<div class="centered">

<a title="Wooptoo, Public domain, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:OS-structure.svg"><img alt="Différences entre systèmes d&#039;exploitation à noyau monolithique et à micro-noyau" src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/OS-structure.svg/960px-OS-structure.svg.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail" class="framed" width="675"></a>

</div>

---

# By Structure: <span class="gold">Tanenbaum vs Torvalds</span>

<div class="columns-1-5-1">

<div class="centered">

<a title="Jantangring, CC BY-SA 4.0 &lt;https://creativecommons.org/licenses/by-sa/4.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Andrew_S._Tanenbaum_2012.jpg"><img alt="Andrew S. Tanenbaum 2012" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Andrew_S._Tanenbaum_2012.jpg/250px-Andrew_S._Tanenbaum_2012.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail" width="90" class="framed-danger"></a>

<br>
<br>
<br>
<br>

<a title="Jantangring, CC BY-SA 4.0 &lt;https://creativecommons.org/licenses/by-sa/4.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Andrew_S._Tanenbaum_2012.jpg"><img alt="Andrew S. Tanenbaum 2012" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Andrew_S._Tanenbaum_2012.jpg/250px-Andrew_S._Tanenbaum_2012.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail" width="90" class="framed-danger"></a>

</div>

<div class="font-small margin-top-0-5">

<div class="danger">

While I could go into a long story here about the relative
merits of the two designs, suffice it to say that among the people who actually
design operating systems, the **debate is essentially over**. <strong
class="danger">Microkernels have won</strong>. The only real argument for
monolithic systems was **performance**, and there is now enough evidence
showing that microkernel systems can be just as fast as monolithic systems that
it is now all over but the shoutin.

</div>

<div class="success text-right">

True, linux is **monolithic**, and I agree that **microkernels** are nicer.
With a less argumentative subject, I'd probably have agreed with most of what
you said.  From a theoretical (and aesthetical) standpoint linux looses.  If
the GNU kernel had been ready last spring, I'd not have bothered to even start
my project: the fact is that it wasn't and still isn't. <strong
class="success">Linux wins heavily on points of being available now</strong>.

</div>

<div class="danger">

I still maintain the point that designing a monolithic kernel in 1991 is a
fundamental error.  **Be thankful you are not my student**.  You would **not
get a high grade** for such a design **:-)**

</div>

<br>
<br>

<div class="success text-right">

**That's ok**. Einstein got **lousy grades** in math and physics.

</div>

</div>

<div class="centered">

<br>
<br>
<br>
<br>

<a title="Krd (photo)Von Sprat (crop/extraction), CC BY-SA 3.0 &lt;https://creativecommons.org/licenses/by-sa/3.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:LinuxCon_Europe_Linus_Torvalds_03_(cropped).jpg"><img alt="Linus Torvalds" src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/LinuxCon_Europe_Linus_Torvalds_03_%28cropped%29.jpg/250px-LinuxCon_Europe_Linus_Torvalds_03_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail" width="90" class="framed-success"></a>

<br>
<br>
<br>

<a title="Krd (photo)Von Sprat (crop/extraction), CC BY-SA 3.0 &lt;https://creativecommons.org/licenses/by-sa/3.0&gt;, via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:LinuxCon_Europe_Linus_Torvalds_03_(cropped).jpg"><img alt="Linus Torvalds" src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/LinuxCon_Europe_Linus_Torvalds_03_%28cropped%29.jpg/250px-LinuxCon_Europe_Linus_Torvalds_03_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail" width="90" class="framed-success"></a>

</div>

</div>

---

<!-- _class: lead -->

# OS History

---

# OS History: <span class="gold">Numerical Analysis</span>

<div class="centered margin-top-0-5">

<img src="https://media.datacenterdynamics.com/media/images/eniac4.width-880.png" class="framed">

The <strong class="caution">operating system</strong> did not exist yet...

</div>

---

# OS History: <span class="gold">Batch Systems</span>

<div class="centered margin-top-0-5">

<iframe width="900" height="369" src="https://www.youtube.com/embed/1C5lc2GIisQ" title="Hidden Figures Scene: Dorothy fixes the IBM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

<strong class="caution">Operating systems</strong> (*usually some sort of library*) were
charged with <strong class="success">processing batches of tasks</strong> (*compile, load,
run, output*).

</div>

---

# OS History: <span class="gold">Multiprogramming</span>

<div class="columns">

<div>

- <strong class="success">Multiprogramming</strong>: Enable multiple tasks to run **concurrently**

- <strong class="danger">Memory Protection</strong>: Disallow one task from **manipulating
  data** of another task

- <strong class="caution">Time-Sharing</strong>: Split processing time among
  **multiple users**

</div>

<div class="slide-centered">

<img src="https://gunkies.org/w/images/1/14/CISLMultics.jpg" class="framed" width="400" alt="Multics">

<img src="https://cdn-blog.adafruit.com/uploads/2022/03/Untitled-55.png" class="framed" width="400" alt="PDP-11">

</div>

</div>

---

# OS History: <span class="gold">Personal Computers</span>

<div class="slide-centered">

<img src="static/img/slides02-os-family-tree.png">

</div>

---

<!-- _class: lead -->

# OS Themes

---

# OS Themes: <span class="gold">An Operating System is...</span>

A <strong class="caution">body of software</strong> that enables other programs
to interact with each other and the <strong class="info">physical hardware
resources</strong> in an efficient manner.  To do this, it utilizes:

- <strong class="success">Virtualization</strong>

- <strong class="danger">Concurrency</strong>

- <strong class="info">Persistence</strong>

---

# OS Themes: <span class="gold">Virtualization</span>

This is when the <strong class="caution">OS</strong> takes a <strong class="info">physical resource</strong>
and transforms it into a more general, powerful, and easy-to-use
<strong class="success">abstraction</strong>.

<div class="columns">

<div>

```bash
# Create spin script
$ cat > spin.sh <<EOF
#!/bin/sh
while true; do
    echo $1
    sleep 1
done
EOF

# Make script executable
$ chmod +x spin.sh
```
</div>

<div>

```bash
# Run multiple processes
$ ./spin.sh A & \
  ./spin.sh B & \
  ./spin.sh C & \
  ./spin.sh D

# Observe output...
```
</div>

</div>

---

# OS Themes: <span class="gold">Concurrency</span>

This is when you have multiple tasks <strong class="success">executing</strong> and
<strong class="caution">utilizing resources</strong> in **overlapping time periods**.

<div class="columns">

<div>

```bash
# Create inc script
$ cat > inc.sh <<EOF
#!/bin/sh
[ ! -r count ] && echo 0 > count

while true; do
    c=$(cat count)
    echo $(($c + 1)) | tee count
    sleep 1
done
EOF
```
</div>

<div>

```bash
# Run multiple processes
$ ./inc.sh A & \
  ./inc.sh B & \
  ./inc.sh C & \
  ./inc.sh D

# Observe output...
```
</div>

</div>

---

# OS Themes: <span class="gold">Persistence</span>

This is the ability to <strong class="caution">access</strong> and <strong
class="warning">store</strong> data in a <strong
class="success">reliable</strong> and <strong
class="success">efficient</strong> manner.

<div class="columns">

<div>

```c
// For each command line argument, open the
// file and perform cat on the file descriptor
int main(int argc, char *argv[]) {
    if (argc == 1) return cat_fd(STDIN_FILENO);

    int result = 0;
    for (int i = 1; i < argc; i++) {
    	int fd  = open(argv[i], O_RDONLY);
    	result += (fd >= 0)
    	        ? cat_fd(fd)
    	        : EXIT_FAILURE;
    }

    return result;
}
```
</div>

<div>

```c
// Read a chunk from the file descriptor
// and write it to stdout
int cat_fd(int fd) {
    char buffer[BUFSIZ];
    int nread;

    while ((nread = read(fd, buffer, BUFSIZ)) > 0) {
    	write(STDOUT_FILENO, buffer, nread);
    }

    return close(fd);
}
```

<div class="centered">

[examples/slides02/cat.c](https://github.com/nd-cse-30341-fa26/examples/slides02/cat.c)

</div>

</div>

</div>


---

# OS Themes: <span class="gold">Hardware / OS Symbiosis</span>

Computer <strong class="info">hardware</strong> provides both <strong
class="danger">limitations</strong> and <strong
class="success">opportunities</strong> for the <strong
class="caution">operating system</strong>, which is in charge of managing these
resources efficiently on behalf of the <strong
class="special">applications</strong>.

<div class="centered margin-top-0-5">
<img src="static/img/house-of-cards.png" width="500">
</div>

As <strong class="info">hardware</strong> evolves, so must the <strong
class="caution">operating system</strong> in order for it to take advantage of
new developments and expose them to <strong
class="special">applications</strong>.

