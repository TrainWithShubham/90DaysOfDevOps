# Core components of Linux

**Kernel**
Kernel acts a bridge between software applications and hardware of the computer.

**User space**
It is a non-privileged memory area where application software, daemons and most system libraries execute. Commands run here, shell script gets executed, service are managed here.

**init/systemd**
It is the first user-space started by Linux after kernel boots. It has PID 1 and is responsible for starting and managing all other services.

# How a process is created?

A process is a running program. Steps involved in process creation:
- fork(): A process copies itself and creates child process where new pid is assigned
- exec(): Child replaces itself with new program
- exit(): Process finishes and exits

# How are processes managed?

Kernel manages process. Scheduling, memory allocation and states are decided by Kernel

# What is systemd and why does it matter?

systemd is a system and service manager for modern Linux operating systems. It helps in managing multiple services and logs as well.

# Process states

- Running: When a process is running
- Uninterruptible sleeping: When a process is waiting for a resource to be available so that it can be executed
- Interruptible sleeping: When a process waits for some response from something or an input from user
- Stopped: The process has been paused and can brought back to runnning state
- Zombie: The process has completed execution but its entry still exists in table

# 5 commands to use daily

**top**
To check CPU load and memory consumption

**ps**
List all running processes

**systemctl**
To start, stop and check status of a service

**man**
To check the manual for a command

**kill**
To kill a process id