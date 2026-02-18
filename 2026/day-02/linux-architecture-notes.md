# Day 02 -- Linux Architecture, Processes, and systemd

------------------------------------------------------------------------

## The Core Components of Linux

Linux is mainly divided into three core components:

1.  Kernel
2.  User Space
3.  Init System (systemd)

------------------------------------------------------------------------

### 1. Kernel

-   Heart of the Linux operating system
-   Runs in Kernel Space
-   Directly interacts with hardware

------------------------------------------------------------------------

### 2. User Space

-   Where users and applications run
-   Runs in User Space (restricted access)
-   Communicates with the kernel via system calls

Includes: - Shell (Bash, Zsh)
- Commands (ls, cp, ps)
- Applications (Nginx, MySQL, Docker)

------------------------------------------------------------------------

### 3. Init System (systemd)

-   First process started by the kernel
-   Runs as PID 1
-   Manages system services
-   Most modern Linux distributions use systemd

Responsibilities: - Start and stop services
- Restart failed services
- Logging
- Faster boot process

------------------------------------------------------------------------

## How Processes Are Created and Managed

### Process Creation

A process is a running instance of a program.
Each process has a PID (Process ID).

Processes are created using:

1.  fork() -- Creates a child process and assigns a new PID.
2.  exec() -- Replaces the child's memory and loads a new program.

Flow: Parent → fork() → Child → exec() → Program Runs

------------------------------------------------------------------------

### Process Management (Handled by Kernel)

The kernel is responsible for:

-   CPU scheduling
-   Memory allocation
-   Context switching
-   Security and permissions

The kernel decides: - Which process runs
- For how long
- When it should stop

------------------------------------------------------------------------

### Process States

-   New -- Process is being created
-   Ready -- Waiting for CPU
-   Running -- Currently executing
-   Waiting / Blocked -- Waiting for I/O
-   Terminated -- Finished execution
-   Zombie -- Finished but parent has not collected the status
-   Stopped -- Suspended

------------------------------------------------------------------------

## What systemd Does and Why It Matters

systemd is the init system used in modern Linux.

It is the first process started by the Linux kernel (PID 1) and is
responsible for managing the system boot process, starting and stopping
services, handling service dependencies, automatically restarting failed
services, and managing system logs through journald to ensure overall
system stability.

systemd matters because it enables faster boot through parallel service
startup, provides automatic service recovery, simplifies service
management using systemctl, offers centralized logging, and is widely
used in production and enterprise Linux environments.

------------------------------------------------------------------------

## 5 Commands Used Daily

-   mkdir -- Create a directory
-   ls -- List directory contents
-   pwd -- Show current directory
-   whoami -- Show current user
-   touch -- Create a file

------------------------------------------------------------------------

## What I Learned

-   Learned Linux architecture and its core components
-   Understood process creation and management
-   Learned process states\
-   Understood what systemd is and why it is important
