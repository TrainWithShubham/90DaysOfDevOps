# Linux Operating System
## Operating System
- The operating system manages the communication between your software and your hardware. Without the operating system (OS), the software wouldn’t function.
- It is the manager and administrator of all the system resources and facilities. Without it, nothing works.
## What is Linux?
- Just like Windows, iOS, and Mac OS, Linux is an operating system.
- An operating system is software that manages all of the hardware resources associated with your desktop or laptop.
---
### Linux Operating System have several different pieces.
- Bootloader –  The software that manages the boot process of your computer. For most users, this will simply be a splash screen that pops up and eventually goes away to boot into the operating system.
- Kernel – The kernel is the core of the system and manages the CPU, memory, and peripheral devices.
   -The kernel is the lowest level of the OS.
- Init system – This is a sub-system that bootstraps the user space and is charged with controlling daemons.
   - One of the most widely used init systems is systemd. It is the init system that manages the boot process, once the initial booting is handed over from the bootloader (i.e., GRUB or GRand Unified Bootloader).
- Daemons – These are background services (printing, sound, scheduling, etc.).
   - It will start up during boot or after you log into the desktop.
- Graphical server – This is the sub-system that displays the graphics on your monitor.
- Desktop environment – This is the piece that the users actually interact with.
- Applications – Ubuntu Linux has the Ubuntu Software Center (a rebrand of GNOME Software) which allows you to quickly search among the thousands of apps and install them from one centralized location.
---
## Why Use Linux?
- Linux is less vulnerable to such attacks. As for server reboots, they’re only necessary if the kernel is updated.
-  It is not out of the ordinary for a Linux server to go years without being rebooted.
-  If you follow the regular recommended updates, stability and dependability are practically assured.
- You can install Linux on many computers as you like without paying a rupees for software or server licensing.
---

## Open Source
- You can freely run the program, for any purpose.
- You can freely study how the program works, and change it, make it according to what you want.
- You can freely redistribute copies so you can help others.
- You can freely distribute copies of your modified versions to others.
---

## What is a “distribution?”
Linux has a number of different versions to suit From new users to hard-core users, you’ll find a “flavor” of Linux.
These versions are called distributions (or, in the short form, “distros”).
- Popular Linux distributions include:
1. LINUX MINT
2. MANJARO
3. DEBIAN
4. UBUNTU
5. ANTERGOS
6. SOLUS
7. FEDORA
8. ELEMENTARY OS
9. OPENSUSE
---

## Which distribution is right for you?

- For Beginner with basic skills --- Linux Mint, Ubuntu, Elementary OS or Deepin.
- For Intermediate or above-average range skills, you could go with a distribution like --- Debian or Fedora.
- For Advanced level skills which know's computer and system administration, use a distribution like --- Gentoo.
- If you want a challenge, you can build your own Linux distribution, with the help of Linux From Scratch.
---

## Installing Linux in Windows
- Through WSL2.
- Through Virtual Machines. 
- Through DualBoot.
   
The Ubuntu Server does not install a GUI interface  
- You can install a GUI package on the Ubuntu Server with a single command like.
- `sudo apt-get install ubuntu-desktop`
---

## Process & Process States:

- A process is more than just a program. For example, if you are using a text editor, the file you are editing is not part of the program on disk, but is part of the process in memory. If someone else were to be using the same editor, both of you would be using the same program. However, each of you would have a different process in memory

- Many different users can be on the system at the same time, they have processes that are in memory all at the same time. The system needs to keep track of what user is running what process, which terminal the process is running on, and what other resources the process has (such as open files). All of this is part of the process.
With the exception of the init process (PID 1) every process is the child of another process. Therefore every process with the exception of the init process has a “parent” process.
---

### Process States
The states that a Process enters in working from start till end are known as Process states. These are listed below as:
- Created -Process is newly created by system call, is not ready to run
- User running -Process is running in user mode which means it is a user process.
- Kernel Running -Indicates process is a kernel process running in kernel mode.
- Zombie- Process does not exist/ is terminated.
- Preempted- When process runs from kernel to user mode, it is said to be preempted.
- Ready to run in memory- It indicated that process has reached a state where it is ready to run in memory and is waiting for kernel to schedule it.
- Ready to run, swapped - Process is ready to run but no empty main memory is present
- Sleep, swapped- Process has been swapped to secondary storage and is at a blocked state.
- Asleep in memory- Process is in memory(not swapped to secondary storage) but is in blocked state.
---

### After Process States status will be changing like this-
- User-running: Process is in user-running.
- Kernel-running: Process is allocated to kernel and hence, is in kernel mode.
- Ready to run in memory: Further, after processing in main memory process is rescheduled to the Kernel.i.e.The process is not executing but is ready to run as soon as the kernel schedules it.
- Asleep in memory: Process is sleeping but resides in main memory. It is waiting for the task to begin.
- Ready to run, swapped: Process is ready to run and be swapped by the processor into main memory, thereby allowing kernel to schedule it for execution.
- Sleep, Swapped: Process is in sleep state in secondary memory, making space for execution of other processes in main memory. It may resume once the task is fulfilled.
- Pre-empted: Kernel preempts an on-going process for allocation of another process, while the first process is moving from kernel to user mode.
- Created: Process is newly created but not running. This is the start state for all processes.
- Zombie: Process has been executed thoroughly and exit call has been enabled. The process, thereby, no longer exists. But, it stores a statistical record for the process. This is the final state of all processes.
---

## Commands in daily use
1. `pwd`
2. `ls`
3. `cd`
4. `mkdir`
5. `touch`

---





