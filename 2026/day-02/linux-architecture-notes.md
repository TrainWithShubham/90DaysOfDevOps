
## The core components of Linux (kernel, user space, init/systemd)

# Kernel
The kernel is the core(heart) of the operating system.
kernel is the bridge between software and hardware. 

It directly interacts with the hardware and manages:
- CPU scheduling
- Memory management
- Disk and file systems
- Device drivers
- Networking
- Security and permissions

# User Space
User space is where normal applications run.
Examples:
- Bash shell
- Nginx
- Docker
- Python programs
- Editors like Vim

Applications cannot directly access hardware.
They must request services from the kernel using system calls.

Flow : User command ==> Shell ==> System Call ==> Kernel ==> Hardware

# init System (systemd)
When Linux boots, the kernel starts the first process:
systemd:

- Starts services during boot
- Manages background daemons
- Handles logging
- Restarts failed services
- Tracks dependencies between services



## How processes are created and managed
A process is a running instance of a program.

# Process Creation
Linux commonly creates processes using:

fork() ==> creates a copy of the current process
exec() ==> replaces the copied process with a new program.

# Process IDs (PID)
Every process has a unique number:

You can inspect processes using:
ps aux
top
htop

# Process States
Running, Sleeping, Stopped, Zombie

# Signals
Linux controls processes using signals.
SIGTERM	, SIGKILL , SIGSTOP	, SIGCONT	


## What systemd does and why it matters
systemd is the service manager used by most modern Linux systems.

# Service Management
Start/stop/restart services.

systemctl start nginx
systemctl stop docker
systemctl restart ssh

# Boot Management

systemctl enable nginx

# Logging
systemd includes centralized logging.

journalctl -u nginx

# Automatic Recovery
systemd can restart failed services automatically.

Restart=always 


