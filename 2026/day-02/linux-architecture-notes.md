# Linux Architecture – Beginner Notes

A beginner-friendly overview of how Linux works internally, written in simple language with examples. Ideal for **students, revision, and interviews**.

##  Table of Contents

* [Overview](#overview)
* [Core Components](#core-components)
* [Kernel](#kernel)
* [User Space](#user-space)
* [init / systemd](#init--systemd)
* [Processes](#processes)
* [Process States](#process-states)
* [Common Linux Commands](#common-linux-commands)
* [Summary](#summary)

## Overview

Linux works using a clear separation between **hardware control** and **user programs**. This design makes Linux **secure, stable, and efficient**.

## Core Components

Linux is mainly divided into three core components:

1. **Kernel** – the core of the operating system
2. **User Space** – where applications run
3. **init / systemd** – manages booting and services

---

## Kernel

* The **kernel is the heart of Linux**
* Written mainly in **C language**
* Communicates directly with **hardware**
* Manages critical system resources:

  * CPU
  * Memory
  * Processes
  * Devices (disk, keyboard, network, etc.)

> Users and applications never talk to the kernel directly.
> Commands and programs request actions, and the kernel performs them safely.

## User Space

* **User space** is where normal programs run
* Programs here **do not have direct access to hardware**

### Examples

* Web browsers: Chrome, Firefox
* Shells: bash, zsh
* Text editors: vim, nano
* Servers: nginx, mysql

### Why User Space Matters

*  **Security** – limits damage from faulty apps
*  **Stability** – one crash doesn’t crash the OS
*  **Isolation** – programs don’t affect each other

> Without user space, a single bad program could crash the entire system.

## init / systemd

* `systemd` is the **init system** in modern Linux
* Responsible for:

  * Starting the system during boot
  * Managing background services (ssh, network, nginx, etc.)
* Runs continuously in the background
* It is the **first process started by the kernel**

  * PID = **1**


## Processes

* A **process** is a running program
* A new process is created when a program starts another program
* Each process has:

  * Its own memory
  * Its own Process ID (PID)

### Example

```bash
ls
```

What happens:

1. The shell starts a new process for `ls`
2. The OS decides when it uses the CPU
3. `ls` finishes execution
4. Memory is freed
5. The shell keeps running

## Process States

### Running

* Process is using the CPU or ready to use it

---

### Sleeping

* Process is waiting for something (input, disk, network)
* This is normal behavior

---

### Zombie

* Process has finished execution
* Parent process has not cleaned it up yet

```bash
ps aux | grep Z
```

> Zombie processes do not use CPU or memory, but too many are harmful.

## Common Linux Commands

### Navigation

```bash
ls
```

Lists files and directories

### File Creation

```bash
touch file.txt
```

Creates a file

### View File Content

```bash
cat file.txt
```

Displays file content

### View Logs

```bash
tail -f /var/log/syslog
```

Shows live system logs

### Networking

```bash
ping trainwithshubham.com
```

Checks network connectivity

## Summary

* Linux separates kernel and user space
* The kernel controls hardware and resources
* User space runs applications safely
* `systemd` manages system startup and services
* Processes are created, scheduled, and cleaned up by the OS

