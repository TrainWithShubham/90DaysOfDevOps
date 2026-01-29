# Day 02 – Linux Architecture, Processes, and systemd
# Core Components of Linux

## Kernel

- Core of the OS; talks directly to hardware
- Manages CPU, memory, disk, devices
- Handles process scheduling and system calls

## User Space

- Where users and applications run
- Includes shell (bash), utilities, libraries
- Programs request resources from the kernel

## Init / systemd (PID 1)

- First process started by the kernel
- Initializes the system after boot
- Starts and manages background services

# How Processes Are Created & Managed
## Process Creation

- fork() → Creates a copy of the parent process
- exec() → Replaces process memory with a new program
- Each process gets a unique PID

## Process States (Important for Troubleshooting)

- Running (R) → Actively using CPU
- Sleeping (S) → Waiting for event/input (most common state)
- Stopped (T) → Paused (e.g., via kill -STOP)
- Zombie (Z) → Finished execution but parent hasn’t collected status
- Idle → Kernel process doing nothing
- Uninterruptible Sleep (D) → Waiting on I/O (disk/network), cannot be interrupted

The kernel scheduler manages CPU time and priorities to ensure multitasking works efficiently.

## What systemd does and why it matters
# what it does:
- Starts services at boot(SSh, netwroking, docker, etc)
- Manages and monitor services
- Restart failed services automatically
- Handles logging(journald)
- Control targets(run levels like multi-user, graphical)
# Why it matters
- Faster boot with parallel startup
- Centralized service management
- Better reliability and monitoring
- Essential for Devops & server administration
## 5 Linux commands I'd use daily
- ps-aux -View running processes
- top/htop - Monitor CPU & Memory usage
- systemctl - Manages Services like start, stop, restart, status, enable, disable etc
- journalctl - check logs
- kill - stop or signal a process