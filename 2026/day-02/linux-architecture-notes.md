# Day 02 – Linux Architecture, Processes, and systemd

## Linux Architecture
- It is divided into different layers:
  1. Hardware: Physical Components, the actual machine (CPU, RAM, Disk)
  2. Kernel: The core of linux, the heart of the machine that runs everything- memory, CPU scheduling, devices, file systems.
  3. Shell: Interface between the User and kernel. User sends command through shell to Kernel.
  4. Application: The apps used by users in the system- nginx, docker, podman etc.
 
## Processes
- Executing instance of any program is a process.
- Every process have a unique PID.
- systemd is the first process with PID = 1.
- Types of processes:
  1. Running: Process that is actively using CPU.
  2. Sleeping: Process that is waiting for some result, input or output.
  3. Zombie: Process that is terminated but waiting for parent process to exit (takes no resource just a empty process).
  4. Stopped: Process that is stopped by interruption (mostly by ctrl + Z).
  5. Dead: Process that is completely terminated by Kernel.

## systemd
- It is the service manager in linux
- Handles all the services running in background
- have PID = 1, first process that is always running under the hood.

## 5 most common commands used in Linux used on daily basis
1. systemctl: To check status or start/stop a service.
2. df -h: Check the disk usage.
3. top: live process monitor
4. ps aux: show running processes.
5. kill -9 PID: forcefully kill a process.
