# Linux Architecture, Processes and systemd

---

## Core Concepts of Linux

Linux works on the **ASKH principle**:

- **A** – Application  
- **S** – Shell  
- **K** – Kernel  
- **H** – Hardware  

### How ASKH Works

- The **Shell** acts as a user interface.
- Applications and services communicate with the **Kernel** using system calls.
- The Kernel directly interacts with the **Hardware**.

---

## Linux Boot Process (High Level)

When you power ON the system:

1. BIOS/UEFI loads the GNU GRUB bootloader.
2. GNU GRUB initializes the Kernel.
3. The Kernel mounts the root filesystem.
4. The Kernel starts systemd (PID 1).
5. systemd initializes:
   - System libraries
   - Shell
   - System utilities
   - Applications

---

## Important Linux Philosophy

### 1️⃣ Everything is a File

In Linux:

- Devices are treated as files.
- Applications are files/directories.
- Copying a file is considered a process.
- Running an application is also a process.

Even if you install an application, Linux considers it as a file or directory.

---

### 2️⃣ Everything Running is a Process

- Every running program is managed as a **process**.
- `init/systemd` is the **first process** in Linux (PID 1).

---

# Process Creation and Management

## Fork-Exec Model

When you run a command:

1. Linux creates a copy of an existing process.
2. The copied process is modified to run your command.
3. The Kernel:
   - Allocates CPU time
   - Assigns memory
   - Executes the command
   - Terminates the process after completion

This is called the **Fork-Exec Process Model**.

### Fork

- Duplicates the existing process.

### Exec

- Replaces the duplicated process with the new program.

---

## Example: Running `ls` Command

1. The shell is running.
2. Linux creates a copy of the shell process.
3. The copied process is replaced with the `ls` command.
4. Kernel:
   - Assigns CPU time
   - Allocates memory
   - Executes `ls`
   - Terminates the process after completion

---

# What is systemd and Why It Matters?

`systemd` is the first process (PID 1) when Linux starts.

Its main job is to start, stop, and manage all other programs and services on the system.

## Responsibilities of systemd

- Starts services during boot  
  Example: network, SSH, web server
- Stops services during shutdown
- Automatically restarts crashed services
- Starts services in a specific order  
  Example: network services start before applications
- Manages system states:
  - Boot
  - Shutdown
  - Reboot
  - Rescue mode

## Why systemd is Important

- Faster boot time
- Automatic service recovery
- Easy service management

---

# Linux Process States

| State | Meaning | Description |
|-------|----------|--------------|
| **R (Running)** | Using CPU or ready to run | Example: Script currently executing |
| **S (Sleeping)** | Waiting for event | Most processes stay here |
| **D (Uninterruptible Sleep)** | Waiting for I/O | Cannot be killed easily |
| **Z (Zombie)** | Finished but not cleaned by parent | Uses no CPU but still listed |
| **T (Stopped)** | Manually paused | Example: Suspended process |

---

# Daily Used Linux Commands

## `cd` – Change Directory

Used to navigate between directories.

---

## `cp` – Copy

Used to copy files and directories from source to destination.

---

## `mv` – Move / Rename

Used to:
- Move files/directories
- Rename files or directories

---

## `cat` – View File Contents

Used to display the contents of a file.

---

## `touch` – Create File

Used to create an empty file without data.

---
