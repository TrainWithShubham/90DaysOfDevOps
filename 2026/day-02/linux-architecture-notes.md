# Linux Architecture, Processes, and systemd

## 1. Core Components of Linux

### Kernel (known as "Linux Kernel")
- The **core of the OS**(Heart)
- Manages:
  - CPU scheduling
  - Memory management
  - Hardware access (drivers)
  - Process lifecycle
- Runs in **kernel space** (full privileges)

### User Space
- Where **applications and users** operate
- Includes:
  - Shells (bash, zsh)
  - Utilities (`ls`, `ps`, `top`)
  - Services (nginx, docker)
- Cannot access hardware directly → requests go via kernel

### Init System (systemd)
- First process started by the kernel (**PID 1**)
- Responsible for:
  - Starting services
  - Restarting failed services
  - Managing logs and dependencies

---

## 2. How Processes Work in Linux

### Process Creation
- A new process is created using:
  - `fork()` → creates a copy
  - `exec()` → loads a new program
- Every process has:
  - **PID** (Process ID)
  - **PPID** (Parent PID)
  - Owner (user)

### Process States
- **R (Running)** – Executing on CPU
- **S (Sleeping)** – Waiting for I/O or event
- **D (Uninterruptible Sleep)** – Waiting for disk/network (cannot be killed)
- **T (Stopped)** – Paused (e.g., Ctrl+Z)
- **Z (Zombie)** – Finished execution but parent hasn’t cleaned it up

> Zombies don’t use CPU/memory, but many zombies indicate a bug.

---

## 3. What systemd Does (and Why It Matters)

- Controls system services using **units**
- Common unit types:
  - `service` – background services
  - `timer` – cron replacement
  - `target` – system states (multi-user, graphical)

### Why systemd is Important
- Automatically restarts crashed services
- Handles service dependencies
- Centralized logging with `journalctl`
- Faster boot and better observability

---

## 4. Daily Linux Commands (DevOps Essentials)

1. `ps aux` – View running processes
2. `top` / `htop` – Monitor CPU & memory usage
3. `systemctl status <service>` – Check service health
4. `journalctl -u <service>` – View service logs
5. `kill -9 <PID>` – Force stop a stuck process

---

## 5. DevOps Takeaway

- Kernel = control
- Processes = workload
- systemd = reliability

If you understand these three:
- You can debug crashes
- Fix performance issues
- Confidently manage production servers
