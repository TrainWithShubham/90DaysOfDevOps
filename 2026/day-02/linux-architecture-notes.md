# Linux Architecture, Processes, and systemd

## Core Components
- **Kernel**: The core of Linux. Manages hardware, memory, CPU scheduling, and system calls.  
- **User Space**: Where applications, shells, and user processes run. Communicates with the kernel via system calls.  
- **Init/systemd**: The very first process started by the kernel. Initializes the system, starts services, and manages dependencies.

---

## Process Management
- Processes are created using `fork()` (to duplicate) and `exec()` (to replace with new program).  
- Each process has a **PID (Process ID)**.  
- Parent and child processes are linked.  
- The kernel schedules processes based on priority and resources.

### Process States
- **Running** → Actively using CPU.  
- **Sleeping** → Waiting for an event or resource.  
- **Zombie** → Finished execution but not cleaned up by parent.  
- **Stopped** → Suspended, waiting to be resumed.  

---

## systemd
- Default init system in most modern Linux distributions.  
- Manages services, sockets, devices, and timers.  
- Provides **parallel startup** → faster boot times.  
- Unified commands (`systemctl`) for starting, stopping, enabling, and checking services.  
- Centralized logging via `journalctl`.  
- Critical for troubleshooting and service management in production.

---

## Daily Commands
1. `ps aux` → List all processes with details.  
2. `top` → Monitor CPU/memory usage in real time.  
3. `systemctl status <service>` → Check service health.  
4. `systemctl restart <service>` → Restart a service.  
5. `journalctl -xe` → View detailed logs for debugging.  
