---
title: "Slides 04: Processes"
description: "Processes"
author: Peter Bui
keywords: lecture,osp,processes
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides04.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Processes

---

# Questions

1. What is a <strong class="success">process</strong>?

2. How do we <strong class="caution">coordinate</strong> multiple <strong
   class="success">processes</strong>?

3. How do we <strong class="warning">switch</strong> from one <strong
   class="success">process</strong> to another?

4. What <strong class="info">system calls</strong> can we use with <strong
   class="success">processes</strong>?


5. What <strong class="special">states</strong> can a <strong
   class="success">process</strong> be in?

---

<!-- _class: lead -->

# Process: <span class="gold">Abstraction</span>

---

# Process: <span class="gold">Machine State</span>

<div class="columns-2-1">

<div>

A <strong class="success">process</strong> is a **loaded** instance of a
program; it is a unit of <strong class="warning">allocation</strong>
(*resources*, *privileges*, etc.).

- <strong class="success">Memory Address Space</strong>: code, data, heap,
  stack.

- <strong class="caution">Kernel State</strong>: permissions, file descriptors,
  etc.

- <strong class="info">Execution Context</strong>: program counter, stack
  pointer, data registers.

</div>

<div class="slide-centered">

<img src="static/img/slides04-process-machine-state.png" width="300">

</div>

</div>

---

# Process: <span class="gold">Data Structure</span>

Inside the <strong class="caution">operating system kernel</strong>, there is a **data
structure** such as a **linked list** that keeps track of all the
<strong class="success">processes</strong>:

- Each <strong class="success">process</strong> is represented by a <strong
  class="special">process control block</strong> that stores its information
  (ie. <strong class="special">machine state</strong>):

- In [Linux], this **data structure** is known as the [struct task_struct].

    - [exit_code](https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/sched.h?h=linux-6.18.y#n967)
    - [children](https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/sched.h?h=linux-6.18.y#n1086)
    - [files](https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/sched.h?h=linux-6.18.y#n1193)
    - [thread](https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/sched.h?h=linux-6.18.y#n1669)


[Linux]: https://kernel.org/
[struct task_struct]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/sched.h?h=linux-6.18.y#n820

---

# Process: <span class="gold">Time-Sharing</span>

The <strong class="caution">operating system</strong> <strong
class="success">virtualizes</strong> the <strong
class="info">processor</strong> via the <strong
class="success">process</strong> abstraction:

<div class="centered">

<br>

<img src="static/img/slides04-process-time-sharing.png" height="240">

</div>

That is, each task is associated with a <strong
class="success">process</strong> that represents the state of the <strong
class="info">processor</strong>.  To allow multiple <strong
class="success">processes</strong> to make progress <strong
class="special">concurrently</strong>, the <strong class="caution">operating
system</strong> provides each <strong class="success">process</strong> a
certain <strong class="special">time slice</strong> or share of <strong
class="info">processor</strong> time.

---

# Process: <span class="gold">Multitasking</span>

<div class="columns">

<div class="margin-top-0-5">

## <strong class="danger">Cooperative</strong>

The <strong class="caution">operating system</strong> **trusts** the <strong
class="success">processes</strong> to behave reasonably and voluntarily
**yield** the <strong class="info">processor</strong> so others can execute.

<div class="centered margin-top-0-5">

<img src="https://www.homecomputermuseum.nl/wp-content/uploads/2018/08/Apple-Front-1200x1054.jpg" width="300" class="bordered">

</div>

</div>

<div class="margin-top-0-5">

## <strong class="success">Pre-emptive</strong>

The <strong class="caution">operating system</strong> sets a <strong
class="info">hardware timer interrupt</strong> to periodically **suspend** the
currently running <strong class="success">process</strong> and possibly
**switch** to another <strong class="success">process</strong>.

<div class="centered margin-top-0-5">

<img src="https://photos5.appleinsider.com/gallery/61542-127138-imac-xl.jpg" width="400" class="bordered">

</div>

</div>

</div>

---

# Process: <span class="gold">Context Switch</span>

<div class="columns-1-2">

<div class="slide-centered">

When a <strong class="info">hardware timer interrupt</strong> goes off, the
<strong class="caution">operating system</strong> has the option of performing
a <strong class="special">context switch</strong> (ie. *switch from one <strong
class="success">process</strong> to another*).

</div>

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides04-process-context-switch.png" width="720">

</div>

</div>

---

# Process: <span class="gold">States</span>

A <strong class="success">process</strong> can be in one of the following
<strong class="special">states</strong> during its lifespan:

<div class="columns">

<div class="centered">

<br>

<img src="static/img/slides04-process-states.png" width="550">

</div>

<div class="font-smaller">

- <strong class="success">Running</strong>: The <strong
  class="success">process</strong> has been **allocated** time on the <strong
  class="info">processor</strong> and is executing.

- <strong class="caution">Ready</strong>: The <strong
  class="success">process</strong> has no blocking <strong
  class="warning">system calls</strong> and is available to be scheduled.

- <strong class="danger">Waiting</strong>: The <strong
  class="success">process</strong> has a blocking <strong
  class="warning">system calls</strong> and is not able to make progress until
  it is finished.

</div>

---

<!-- _class: lead -->

# Process: <span class="gold">API</span>

---

# Process: <span class="gold">Life Cycle</span>

<div class="columns-1-2">

<div class="font-smaller">

1. <strong class="success">Parent process</strong> [forks] to create a new
   <strong class="warning">child process</strong>.

2. <strong class="warning">Child process</strong> performs actions, possible
   [execs] to run another program.

3. <strong class="success">Parent process</strong> [waits] for <strong
   class="warning">child process</strong>.

4. <strong class="warning">Child process</strong> [exits].

5. <strong class="success">Parent process</strong> receives <strong
   class="special">status code</strong> of <strong class="warning">child
   process</strong>.

</div>

<div class="slide-centered margin-top-0-5">

<img src="static/img/slides04-process-life-cycle.png" width="800">

</div>

</div>

[forks]: https://man7.org/linux/man-pages/man2/fork.2.html
[execs]: https://man7.org/linux/man-pages/man3/exec.3.html
[waits]: https://man7.org/linux/man-pages/man2/wait.2.html
[exits]: https://man7.org/linux/man-pages/man3/exit.3.html

---

# Process: <span class="gold">Fork</span>

[fork] creates a new <strong class="warning">child process</strong> based off
the <strong class="special">machine state</strong> of the current <strong
class="success">parent process</strong>.

<div class="columns">

<div>

```c
// Create new process
pid_t pid = fork();

if (pid == 0) {
    ... // Child
} else if (pid < 0) {
    ... // Parent (Error)
} else {
    ... // Parent (Success)
```

</div>

<div>

After a **successful** [fork], there are two **distinct** <strong
class="success">processes</strong> which have the **same** <strong
class="danger">code</strong>, but **different**:

- <strong class="success">Memory Address Space</strong>

- <strong class="caution">Kernel State</strong>

- <strong class="info">Execution Context</strong>

</div>

</div>

[fork]: https://man7.org/linux/man-pages/man2/fork.2.html

---

# Process: <span class="gold">Exec</span>

[exec] replaces the <strong class="danger">code</strong> in the <strong
class="success">address space</strong> of the current <strong
class="success">process</strong> and resets the <strong class="info">execution
context</strong>.

```c
char **argv = {"ls", "-l"}; // Command to run as a vector
pid_t  pid  = fork();       // Create child process

if (pid == 0) {             // Check if we are child process
    execvp(argv[0], argv);  // Execute command
    _exit(EXIT_FAILURE);    // Exit if exec fails
}
```

<div class="font-smaller">

[exec] is actually a family of **functions** which differ in how they expect
the **command** is passed to the function, whether or not to search the
**PATH**, or whether or not to include a custom **environment array**:

- [execl], [execlp], [execle]
- [execv], [execvp], [execvpe]

[exec]: https://man7.org/linux/man-pages/man3/exec.3.html
[execl]: https://man7.org/linux/man-pages/man3/exec.3.html
[execlp]: https://man7.org/linux/man-pages/man3/exec.3.html
[execle]: https://man7.org/linux/man-pages/man3/exec.3.html
[execv]: https://man7.org/linux/man-pages/man3/exec.3.html
[execvp]: https://man7.org/linux/man-pages/man3/exec.3.html
[execvpe]: https://man7.org/linux/man-pages/man3/exec.3.html

</div>

---

# Process: <span class="gold">Wait / Exit</span>

<div class="columns">

<div class="margin-top-0-5">

## <strong class="info">Wait</strong>

[wait] suspends <strong class="success">process</strong> until one of its
<strong class="warning">children</strong> has terminated and retrieves its
<strong class="special">status code</strong>.

```c
int status = EXIT_SUCCESS;
while (wait(&status) != pid) {
    ...
}
```

</div>

<div class="margin-top-0-5">

## <strong class="info">Exit</strong>

[exit] terminates a <strong class="success">process</strong> and sets its
<strong class="special">status code</strong>.

```c
// Exit without cleanup
_exit(EXIT_FAILURE);

// Cleanup and exit
exit(EXIT_SUCCESS);
```

[wait]: https://man7.org/linux/man-pages/man2/wait.2.html
[exit]: https://man7.org/linux/man-pages/man3/exit.3.html

</div>

</div>

---

# Process: <span class="gold">Signals</span>

<strong class="special">Signals</strong> are a means of notifying a
<strong class="success">process</strong> of an **event**.

- Each <strong class="special">signal</strong> delivers a <strong
  class="danger">small integer</strong> that represents a particular **event**.

- To deliver the **event**, the <strong class="caution">kernel</strong> will **interrupt**
  the normal execution of the target <strong class="success">process</strong>.

- To catch particular **events** and perform custom actions,
  <strong class="success">processes</strong> can register callback functions (ie. *handlers*)
  for certain **events**.

- After the *handlers* are executed, the <strong class="success">process</strong> will
  continue executing where it was interrupted.

---

# Process: <span class="gold">Kill / Sigaction</span>

<div class="columns">

<div class="margin-top-0-5">

## <strong class="info">Kill</strong>

To send a signal to a process, use [kill].

```c
// Send SIGTERM to process with specified PID
kill(pid, SIGTERM);
```

</div>

<div class="margin-top-0-5">

## <strong class="info">Sigaction</strong>

To **register** a <strong class="special">callback function</strong> for a
particular **event**, use [sigaction].

```c
// Register handler for SIGINT
struct sigaction sa = {
    .sa_handler = sigint_handler
};
sigaction(SIGINT, &sa, NULL);

// Handle SIGINT event
void sigint_handler(int signum) {
    puts("Can't stop!  Won't stop!");
}
```

[kill]: https://man7.org/linux/man-pages/man2/kill.2.html
[sigaction]: https://man7.org/linux/man-pages/man2/sigaction.2.html

</div>

</div>

---

# Process: <span class="gold">Signals</span>

<div class="columns">

<div class="margin-top-0-5">

## <strong class="special">SIGCHLD</strong>

A <strong class="special">SIGCHLD</strong> **event** is delivered to the
<strong class="success">process</strong> whenever one of its <strong
class="warning">child</strong> <strong class="success">processes</strong> has
terminated.


```c
// Register handler for SIGCHLD
struct sigaction sa = {
    .sa_handler = sigchld_handler
};
sigaction(SIGCHLD, &sa, NULL);

// Handle SIGCHLD event
void sigchld_handler(int signum) {
    puts("Waiting for terminated child");
    wait(NULL);
}
```

</div>

<div class="margin-top-0-5">

## <strong class="special">SIGARLM</strong>

A <strong class="special">SIGALRM</strong> **event** can be scheduled for the
future using [alarm] or [setitimer].

```c
// Schedule one time alarm in 5 seconds
alarm(5);

// Schedule periodic alarm every 5 seconds
struct itimerval interval = {
    // Periodic interval
    .it_interval = { .tv_sec = 5, .tv_usec = 0},
    // Time until next expiration
    .it_value    = { .tv_sec = 5, .tv_usec = 0},
};
setitimer(ITIMER_REAL, &interval, NULL);
```

</div>

</div>

[alarm]: https://man7.org/linux/man-pages/man2/alarm.2.html
[setitimer]: https://man7.org/linux/man-pages/man2/setitimer.2.html













