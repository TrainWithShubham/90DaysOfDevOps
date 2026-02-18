## Core Components of Linux

## Kernel

Core of the operating system

Manages CPU, memory, disk, and devices

Handles system calls from applications

Responsible for process and memory management

## User Space

Where user applications run (bash, nginx, docker, etc.)

Cannot directly access hardware

Communicates with kernel using system calls

## init / systemd

First process started by kernel (PID 1)

Initializes system after boot

Starts and manages services

In modern Linux, systemd replaces traditional init

## How Processes Are Created & Managed

- Process Creation

Created using fork() system call

Parent process creates child process

Each process has a unique PID

Can view processes using ps or top

## Process States

Running (R) → Currently using CPU

Sleeping (S) → Waiting for event/input

Stopped (T) → Paused manually

Zombie (Z) → Finished execution but not cleaned by parent

Zombie processes occur when parent doesn’t read child’s exit status.

## What is systemd?

systemd is the service manager in modern Linux.

## Why It Matters

Starts services during boot

Restarts failed services automatically

Manages background services (daemons)

Maintains logs via journalctl

Enables parallel boot → Faster startup

## Important systemd Commands

systemctl start nginx

systemctl stop nginx

systemctl status nginx

systemctl enable nginx

journalctl -xe

## 5 Daily Linux Commands (DevOps Use)

ps aux → View running processes

top → Monitor CPU and memory

systemctl status <service> → Check service health

kill <PID> → Stop a process

free -h → Check memory  usage

## Why This Matters in DevOps

Helps debug crashed services

Identify high CPU/memory usage

Understand service failures

Analyze logs quickly

Troubleshoot production incidents faster
