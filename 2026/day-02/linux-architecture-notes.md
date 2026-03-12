
## Task

Day 02 – Linux Architecture, Processes, and systemd
Task

Today’s goal is to understand how Linux works under the hood.

You will create a short note that explains:

    The core components of Linux (kernel, user space, init/systemd)
    How processes are created and managed
    What systemd does and why it matters

This is the foundation for all troubleshooting you will do as a DevOps engineer.

---

# Core Components of Linux

**Kernel**
The kernel is the core of Linux. It manages hardware resources such as CPU, memory, disk, and network, and acts as a bridge between hardware and applications.

**User Space**
User space is where users and applications run. It includes the shell, system commands, and application software. User space cannot access hardware directly and communicates with it through the kernel.

**Init / systemd**
Init or systemd is the first process that starts when the system boots. It manages system services, starts them at boot time, and keeps the system running smoothly.

# How processes are created and managed

A process is created when we run a command or start a program.
Linux creates a process, gives it a PID, and starts running it.

Linux manages processes by:

Deciding which process runs first

Giving CPU time to each process

Controlling process states like running or sleeping
