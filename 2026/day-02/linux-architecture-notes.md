# Day 02 – Linux Architecture, Processes, and systemd

## What We'll Learn Today
Understanding how Linux works is like learning how a car engine works before you start driving. It helps you fix problems faster and make better decisions as a DevOps engineer!

---

## Linux Architecture: The Big Picture

Think of Linux as a well-organized building with different floors:

```
┌─────────────────────────────────────┐
│     Applications & User Programs     │  (What you interact with)
│   (Firefox, Docker, VS Code, etc.)   │
├─────────────────────────────────────┤
│         User Space                   │  (Where programs run)
│    (Libraries, System Tools)         │
├─────────────────────────────────────┤
│      System Calls (Interface)        │  (Communication bridge)
├─────────────────────────────────────┤
│         Linux Kernel                 │  (The brain of the system)
│  (Process, Memory, Device Manager)   │
├─────────────────────────────────────┤
│         Hardware                     │  (Physical components)
│    (CPU, RAM, Disk, Network)         │
└─────────────────────────────────────┘
```

---

## Core Components of Linux

### 1️The Linux Kernel (The Brain)

**What is it?**  
The kernel is the core of the operating system. It's like the manager of a restaurant who coordinates everything.

**What does it do?**
- **Process Management**: Decides which program gets to use the CPU and when
- **Memory Management**: Allocates RAM to programs and makes sure they don't interfere with each other
- **Device Management**: Talks to your hardware (keyboard, mouse, disk, network card)
- **File System Management**: Organizes how files are stored and retrieved
- **Security**: Controls who can access what

**Simple Analogy:**  
Think of the kernel as a traffic controller at a busy intersection, making sure all cars (programs) move smoothly without crashing into each other.

---

### 2️User Space (Where We Live)

**What is it?**  
User space is where all your applications and programs run. This is separated from the kernel for safety.

**Why the separation?**  
If a program crashes in user space, it won't bring down the entire system. The kernel stays protected!

**What lives here?**
- Applications (browsers, text editors, Docker)
- System utilities (ls, cat, grep)
- Libraries (code that programs share)
- Your shell (bash, zsh)

**Simple Analogy:**  
User space is like the dining area of a restaurant. Customers (programs) can eat here, but they can't go into the kitchen (kernel) and mess with the stove!

---

### 3️Init System / systemd (The Startup Manager)

**What is Init?**  
Init is the **first process** that starts when Linux boots up. It's like the opening manager of a store who turns on all the lights and gets everything ready.

**What is systemd?**  
systemd is the modern init system used by most Linux distributions today. It replaced the older "SysV init" system.

**Why does it matter?**
- Starts and stops services (like web servers, databases)
- Manages dependencies (starts things in the right order)
- Monitors services and restarts them if they crash
- Handles system logging
- Much faster boot times than old init systems

**Simple Analogy:**  
systemd is like a stage manager at a theater. It makes sure all actors (services) come on stage at the right time, in the right order, and if someone misses their cue, it gets them back on stage!

---

## How Processes Work in Linux

### What is a Process?

A process is simply a **program that's running**. When you double-click an app, you create a process.

**Key Points:**
- Every process has a unique ID called **PID** (Process ID)
- The first process (systemd) has PID 1
- Every process (except PID 1) has a parent process (PPID)

### Process Lifecycle

```
1. Creation (Fork)
   ↓
2. Execution (Exec)
   ↓
3. Running
   ↓
4. Waiting/Sleeping (if needed)
   ↓
5. Termination
```

### How Are Processes Created?

Linux creates new processes using two system calls:

**1. fork()** – Makes a copy of the current process
- The parent process creates a child process
- The child is almost identical to the parent

**2. exec()** – Replaces the child process with a new program
- After forking, the child calls exec() to run a different program

**Simple Example:**
```
When you type "ls" in your terminal:
1. Your shell (bash) forks itself
2. The child process calls exec(ls)
3. Now the child is running "ls" command
4. When done, the child exits
5. The parent (bash) continues
```

---

## Process States

A process can be in different states:

| State | Symbol | What It Means |
|-------|--------|---------------|
| **Running** | R | Currently using the CPU |
| **Sleeping** | S | Waiting for something (like user input) |
| **Stopped** | T | Paused (you can resume it) |
| **Zombie** | Z | Finished but parent hasn't collected it yet |
| **Dead** | X | Completely terminated |

**Check process states:**
```bash
ps aux
```

---

## systemd Deep Dive

### Why systemd Matters for DevOps

As a DevOps engineer, you'll use systemd **every single day** to:
- Start/stop services (nginx, docker, databases)
- Check service status
- View logs
- Set services to start on boot
- Troubleshoot why services failed

### Key systemd Concepts

**1. Units**  
Everything in systemd is a "unit". Types include:
- `.service` – Services (nginx, docker)
- `.socket` – Network sockets
- `.timer` – Scheduled tasks (like cron)
- `.mount` – File systems
- `.target` – Groups of units

**2. Unit Files**  
Configuration files that describe how to manage a service.

**Location:**
```
/etc/systemd/system/      (custom services)
/lib/systemd/system/      (system services)
```

### Essential systemd Commands

```bash
# Start a service
sudo systemctl start nginx

# Stop a service
sudo systemctl stop nginx

# Restart a service
sudo systemctl restart nginx

# Check status
sudo systemctl status nginx

# Enable (start on boot)
sudo systemctl enable nginx

# Disable (don't start on boot)
sudo systemctl disable nginx

# View logs for a service
sudo journalctl -u nginx

# View real-time logs
sudo journalctl -u nginx -f

# List all running services
systemctl list-units --type=service --state=running

# Check if a service failed
systemctl is-failed nginx
```

---

##  Practical Examples for DevOps

### Example 1: Check if Docker is Running

```bash
systemctl status docker
```

If it's not running:
```bash
sudo systemctl start docker
sudo systemctl enable docker  # Start on boot
```
---

### Example 2: View Service Logs

```bash
# Last 100 lines
journalctl -u docker -n 100

# Real-time logs (like tail -f)
journalctl -u docker -f

# Logs from today
journalctl -u docker --since today
```

## Key Takeaways for DevOps Engineers

1. **Linux has layers**: Hardware → Kernel → User Space → Applications
2. **The kernel manages everything**: processes, memory, devices, files
3. **Processes are created using fork() and exec()**
4. **systemd is your service manager**: Start, stop, monitor, and troubleshoot services
5. **Learn systemctl and journalctl**: These are your daily tools for managing services


---

##  Quick Reference Cheat Sheet

### Process Commands
```bash
ps aux                    # List all processes
ps -ef                    # Another format
top                       # Real-time process viewer
htop                      # Better top (needs installation)
kill <PID>                # Stop a process
kill -9 <PID>             # Force kill
pgrep <name>              # Find PID by name
pkill <name>              # Kill by name
```

### systemd Commands
```bash
systemctl start <service>
systemctl stop <service>
systemctl restart <service>
systemctl status <service>
systemctl enable <service>
systemctl disable <service>
systemctl list-units --type=service
journalctl -u <service>
journalctl -u <service> -f
systemctl daemon-reload
```

---

*The best way to learn is by doing it.*