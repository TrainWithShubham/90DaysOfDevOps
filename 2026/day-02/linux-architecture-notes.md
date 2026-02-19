# Core components of linux

i) Hardware layer
ii) Shell
iii) Kernel
iv) System libraries
v) System utilities(like,GNU)

# How processes are created in linux

*fork() System Call: A running "parent" process initiates the fork() system call to create a new, nearly identical "child" process. 
 The child process receives a copy of the parent's memory space, open file descriptors, and other resources
*exec() System Call: After the fork(), the child process typically uses an exec() system call (e.g., execve()) to replace its entire memory space with a new program's code and data.
*wait() System Call: The parent process often uses the wait() system call to pause its own execution until its child process finishes and exits,
 allowing the parent to collect the child's exit status and prevent it from becoming a zombie process. 

# Process states

A process transitions through several states during its lifecycle: 

1. Running (R): The process is either currently executing on the CPU or waiting in the run queue to be executed.
2. Sleeping/Waiting (S or D): The process is waiting for some event to occur (e.g., I/O completion, a signal).
3. Stopped (T): The process has been suspended by a job control signal (like Ctrl+Z).
5. Zombie (Z): The process has terminated, but its parent process has not yet collected its exit status, so its entry still exists in the process table.

# What systemd does

1. Initializes the System: It is the first user-space process to run during boot (PID 1)
2. Manages Services: It starts, stops, and restarts background services (daemons) efficiently using "unit files" which define how services should behave [2].
3. Provides System Logging: It includes journald, a centralized logging management system [1].
4. Manages Devices and Mount Points: It uses udev (as part of the suite) to manage device events and automatically handle device hot-plugging [1].
5. Enables Parallelism: It uses socket and D-Bus activation to start services in parallel, significantly speeding up boot times [2].

# Why does it matter

1. Standardization: It provides a consistent, standardized framework across many different Linux distributions, making system administration and development more uniform [2].
2. Faster Boot Times: Its design allows for aggressive parallelization during startup, which dramatically decreases the time it takes for a system to become usable [2].
3. Modern Features: It offers robust features essential for modern computing, such as cgroup management for resource control, on-demand service activation, and better security isolation for services [1, 2].



