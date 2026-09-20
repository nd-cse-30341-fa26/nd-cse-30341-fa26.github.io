---
title: "Slides 08: Thread-based Concurrency"
description: "Thread-based Concurrency"
author: Peter Bui
keywords: lecture,osp,threads,concurrency
url: https://pnutz.h4x0r.space/courses/cse.30341.fa26/slides08.html
theme: domer-slides
---

<!-- _class: lead -->

# CSE 30341

## Thread-based Concurrency

---

# Questions

<div class="font-large">

1. What are the <strong class="success">pros</strong> and <strong
   class="danger">cons</strong> of:

    - <strong class="caution">Event-based concurrency</strong> with <strong
      class="warning">select/poll</strong>

    - <strong class="primary">Threads</strong>

2. What functions do we use to

    - <strong class="warning">Create</strong> a <strong
      class="primary">thread</strong>

    - <strong class="warning">Wait</strong> for a <strong
      class="primary">thread</strong> to complete

    - <strong class="warning">Lock</strong> for a <strong
      class="danger">critical section</strong>

    - <strong class="warning">Notify</strong> another <strong
      class="primary">thread</strong>

</div>

---

<!-- _class: lead -->

# POSIX Threads

---

# PThreads: <span class="gold">Overview</span>

On Unix (or *Unix-like*) systems, we can use the [POSIX] [Thread API], which
defines functions for:

<div class="columns">

<div>

<br>
<br>

- <strong class="warning">Creating</strong> new <strong
  class="primary">threads</strong>

- <strong class="warning">Waiting</strong> on <strong
  class="primary">threads</strong>

- <strong class="warning">Locking</strong> shared resources

- <strong class="warning">Notifying</strong> other <strong
  class="primary">thread</strong>

</div>

<div class="centered">

<img src="static/img/slides08-pthreads-overview.svg">

</div>

</div>

[POSIX]: http://pubs.opengroup.org/onlinepubs/9699919799/
[Thread API]: http://man7.org/linux/man-pages/man7/pthreads.7.html

---

# PThreads: <span class="gold">Implementations</span>

<div class="slide-centered">

<img src="static/img/slides08-pthreads-implementations.svg" height="600px">

</div>

---

# PThreads: <span class="gold">Compiling</span>

To <strong class="warning">compile</strong> a program that uses [POSIX
Threads], we need to include the <strong class="primary">pthreads</strong>
header in our source code:

```c
#include <pthread.h>
```

And pass the <strong class="primary">-pthread</strong> flag to the compiler:

```bash
$ gcc -pthread -o program program.c
```

[POSIX Threads]: http://man7.org/linux/man-pages/man7/pthreads.7.html

---

# PThreads: <span class="gold">Analogs</span>

<br>

<table class="bordered">
<thead>
    <th class="caution-bg">Action</th>
    <th class="success-bg">Process</th>
    <th class="info-bg">Thread</th>
</thead>
<tbody>
<tr>
    <td class="caution-bg centered"><b>Create new task</b></td>
    <td class="success-bg">fork + exec</td>
    <td class="info-bg">pthread_create</td>
</tr>
<tr>
    <td class="caution-bg centered"><b>Wait for task</b></td>
    <td class="success-bg">wait / waitpid</td>
    <td class="info-bg">pthread_join</td>
</tr>
<tr>
    <td class="caution-bg centered"><b>Lock critical section</b></td>
    <td class="success-bg">sigprocmask<br>SIG_BLOCK/SIG_UNBLOCK</td>
    <td class="info-bg">pthread_mutex_lock<br>pthread_mutex_unlock</td>
</tr>
<tr>
    <td class="caution-bg centered"><b>Notify another task</b></td>
    <td class="success-bg">sigaction / signal<br>kill</td>
    <td class="info-bg">pthread_cond_wait<br>pthread_cond_signal</td>
</tr>
</tbody>
</table>

---

# PThreads: <span class="gold">Creating</span>

When our <strong class="success">process</strong> starts, we have one <strong
class="info">main thread</strong>.  To <strong class="warning">create</strong>
another one, we can use the <strong class="primary">pthread_create</strong>
function:

<div class="columns">

<div>

```c
// Thread function
void *thread_function(void *arg) {
    // Convert thread function argument to int
    int tid = (int)arg;
    printf("thread %d\n", tid);
    return NULL;
}
```

<br>

<div class="alert warning-bg centered">

**Note**: Both the `void *arg` and `void *` return value are effectively
`64`-bit integers (ie. `size_t` or `int64_t`).

</div>

</div>

<div>

```c
// Main thread
int main(int argc, char *argv[]) {
    // Thread structure
    pthread_t thread;

    // Create new thread
    pthread_create(
        &thread,         // Pointer to structure
        NULL,            // Pointer to attributes
        thread_function, // Pointer to function
        1                // Argument to function
    );
    return 0;
}
```

</div>

</div>

---

# PThreads: <span class="gold">Waiting</span>

To <strong class="warning">wait</strong> for a <strong
class="info">thread</strong> to complete, we can use the <strong
class="primary">pthread_wait</strong> function:

<div class="columns">

<div>

```c
// Thread function
void *is_odd(void *arg) {
    int64_t n = (int64_t)arg;

    if (n % 2) {
        // Terminate thread and return 1
        pthread_exit((void *)true);
    }

    // Terminate thread and return 0
    return (void *)false;
}
```

<br>

</div>

<div>

```c
// Main thread
int main(int argc, char *argv[]) {
    // Create new thread
    pthread_t thread;
    pthread_create(
        &thread, NULL, is_odd,
        (void *)strtol(argv[1], NULL, 10)
    );

    // Wait for thread
    int64_t result;
    pthread_join(thread, (void **)&result);
    return !result;
}
```

</div>

</div>

---

# PThreads: <span class="gold">Locking</span>

To guard a <strong class="danger">critical section</strong>, we utilize <strong
class="warning">locks</strong> or <strong class="warning">mutual
exclusion</strong> via <strong class="primary">pthread_mutex_lock</strong> and
<strong class="primary">pthread_mutex_unlock</strong>:

```c
pthread_mutex_t Lock;               // Declare lock
pthread_mutex_init(&Lock, NULL);    // Initialize lock

pthread_mutex_lock(&Lock);          // Acquire lock
access_shared_resource();           // Perform critical section
pthread_mutex_unlock(&Lock);        // Release lock
```

<br>

<div class="alert centered warning-bg">

**Note**: we should perform **error checking**.

</div>

---

# PThreads: <span class="gold">Notifying</span>

To <strong class="warning">notify</strong> or <strong
class="warning">signal</strong> another <strong class="info">thread</strong>,
we use <strong class="caution">condition variables</strong>.

```c
pthread_mutex_t Lock  = PTHREAD_MUTEX_INITIALIZER;  // Global Lock
pthread_cond_t  Cond  = PTHREAD_COND_INITIALIZER;   // Global Condition variable
bool            Ready = false;                      // Global Ready flag
```

<div class="columns">

<div>

```c
// Receiver Thread
pthread_mutex_lock(&Lock);   // Acquire lock

// Wait until ready and notified
while (!Ready) {
    pthread_cond_wait(&Cond, &Lock);
}

pthread_mutex_unlock(&Lock); // Release lock
```

</div>

<div>

```c
// Sender Thread
pthread_mutex_lock(&Lock);    // Acquire lock

// Update variable and notify another thread
do_something();
Ready = true;
pthread_cond_signal(&Cond);

pthread_mutex_unlock(&Lock);  // Release lock
```

</div>

</div>

---

# Example: [counter.c]

We want to create an application, `counter`, that does the following:

- Periodically **increments a `counter`**.

- Provides a **shell prompt** that allows the user to enter in a **`command`**:

<table class="bordered">
<thead>
    <th class="info-bg">Command</th>
    <th class="success-bg">Description</th>
</thead>
<tbody>
<tr>
    <td class="info-bg centered"><b>count</b></td>
    <td class="success-bg">Returns the current value of <code>counter</code></td>
</tr>
<tr>
    <td class="info-bg centered"><b>reset</b></td>
    <td class="success-bg">Resets counter to <code>0</code></td>
</tr>
<tr>
    <td class="info-bg centered"><b>exit</b></td>
    <td class="success-bg">Quit program</td>
</tr>
</tbody>
</table>

[counter.c]: https://github.com/nd-cse-30341-fa26/examples/blob/master/lecture08/counter.c
