# Day 02 – Linux Architecture, Processes, and systemd
## Linux Core Components
* Kernel
  * Heart of Linux OS
  * Manages CPU, memory, disk, and hardware
* User Space
  * Where users and applications run
   * Includes shell, commands, and programs
* Init / systemd
  * First process started by the kernel
  * Manages services, startups, and logs
## Process Basics
* Every running program is a process
* Each process has a unique PID (Process ID)
## Process States
* Running – Process is using CPU
* Sleeping – Waiting for input or resources
* Stopped – Paused manually or by signal
* Zombie – Process finished but not cleaned up
## Systemd Overview
* systemd is the init system used by most modern Linux systems
* Responsible for:
   * Starting services at boot
  * Restarting failed services
  * Managing logs and dependencies
## Daily Useful Linux Commands
* ps – View running processes
* top – Monitor CPU and memory usage
* systemctl – Manage services
* journalctl – View system logs
* kill – Stop a process
## Why This Matters
* Helps debug crashed services
* Helps identify CPU or memory issues
* Builds confidence in Linux troubleshooting
