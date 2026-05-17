# Linux Architecture Notes

## Core Components of Linux
- 3 main layers: Application, Shell, Kernel
- Application: where we run our programs
- Shell: CLI like bash, sh, zsh that talks to Kernel using commands
- Kernel: talks directly to Hardware
- Example: when I use ls command, shell tells kernel to list the folder

## How Processes are Created
- Everything in Linux is a process
- Every command or app we open is a process
- Processes are tracked by PID number
- Use ps to see only working processes
- Use top to see all processes

## Process States
- Running: process is currently working
- Sleeping: process is currently not working
- Zombie: process finished its task but parent has not cleaned it up yet

## What systemd Does
- When we power on, Hardware loads firmware
- Firmware uses BIOS to load Bootloader
- Bootloader loads Kernel code
- Kernel starts first process PID 1 = systemd
- systemd runs in background and starts all other processes
- Without systemd no process can start

## 5 Daily Commands
- ls: list files in directory
- pwd: know current directory
- cd: change folder
- mkdir: make a new folder
- top: see all running processes
