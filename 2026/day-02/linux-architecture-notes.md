# Day 02 – Linux Architecture, Processes, and systemd

## Core Components of Linux
* **Kernel:** It’s an intermediary between the hardware and the software which manages the hardware resources for the software.
* **User Space:** It’s a layer where all the applications and the users exist. The users cannot directly access the hardware from here.
* **Init / systemd:** (Stands for "system daemon"). When the Linux system boots up, it first loads the kernel. The kernel then starts this very first process to manage everything else. It is always assigned **PID 1**.

## Processes
A **process** is any program that is currently in execution. Every running process is assigned a unique identifier called a **PID** (Process ID).

### Types of Process States:
* **Running:** The process is active and executing.
* **Sleeping:** The process is currently waiting for something to happen.
* **Stopped:** The process is stopped or suspended.
* **Zombie:** The process has finished executing and is dead, but it still has a record in the system.

## 5 Daily Commands (Processes & systemd)
* `top`: Shows a live dashboard of running processes.
* `ps`: Takes a snapshot of active processes.
* `kill`: Stops a process using its PID.
* `systemctl`: Manages systemd background services.
* `journalctl`: Views system logs for debugging.