1) Core Components of Linux

Kernel

The main part of Linux.

Talks directly to hardware (CPU, memory, disk, devices).

Manages processes, memory, files, and networking.

User Space

Where users and applications work.

Includes commands, tools, shells, and programs.

Example: bash, ls, cp, apps, scripts.

init / systemd

First process that starts when system boots.

Starts and manages all system services.

systemd is the modern init system used in most Linux systems.

2) How Processes Are Created & Managed

A process is created when we run a command or program.

Linux uses fork() to create a new process and exec() to run a program.

Kernel manages:

CPU time

Memory

Scheduling

Process priority

Process States

Running (R) – Process is using CPU.

Sleeping (S) – Waiting for input or event.

Stopped (T) – Paused manually.

Zombie (Z) – Process finished but not cleaned by parent.

3) What systemd Does & Why It Matters

Manages system services like:

Network

SSH

Docker

Web servers

Starts services in correct order.

Automatically restarts failed services.

Makes boot faster and system stable.

4) 5 Linux Commands I Use Daily

ls – list files and folders

cd – change directory

pwd – show current location

ps – check running processes

top / htop – monitor system usage