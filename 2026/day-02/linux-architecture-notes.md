Linux Architecture, Processes and systemd

The core concepts of Linux- 

Linux works on ASKH principle.

A stands for Application
S stands for Shell
K stands for Kernel
H stands for Hardware

The shell is a user interface that allows users to interact with the system, while applications and services communicate with the kernel using system calls.

When you power ON the system BIOS/UEFI loads the GNU GRUB which initializes the kernel, the kernel mounts the root filesystem and starts the systemd (PID 1), which initiazies user space services like system libraries, shell, system utilities and applications. Key concepts of linux include treating all devices as files and managing processes.

In Linux we say Everything is a file or a file like device and and running programs are managed as processes.. For eg even if you install an application on the linux it will be considered a file or a directory and if you copy the file or start an application both are process to linux.

Note that init/systemd is the first process in the linux

How Processes are created and managed - 

When you run a command or start an application, linux creates a copy of existing process and then changes the copied process with the command you have run and then kernel will decide when the process gets CPU time, it gives memory to execute the process and later waits for command to be executed and then terminates process of the run command and this process is call fork-exec process

Fork is duplicating the existing process and exec is replacing the duplicated process with a process that user is running.

For eg you are running a ls command, as this is a shell command first linux will create a copy of shell process, the copy of shell process is replaced with ls command process, then kernel manages this ls process by giving it CPU time, provides memory and lets it finish and then removes that process

Manages 

What systemd does and why it matters?

Systemd is the boss of the system. When linux starts systemd is the first program to start, it main job is to start, stop and manage all other programs and services on the system.

Starts services when the system boots
   Eg - network, SSH, web server
Stops services when system shuts down
Keeps services running, i.e. if any service crashes it helps in restarting the service automatically
Starts the services in a particular order for eg it starts network services before apps
Manages system states such as Boot, shutdown, reboot and rescue mode.

Systemd is important because it provides faster boot time, automatic recovery of service, easy service management.

Linux Process States - 
Running (R)
Process is using CPU or ready to run
Example: a script currently executing

Sleeping (S)
Waiting for something (input, network, disk)
Most processes stay in this state

Uninterruptible Sleep (D)
Waiting for I/O (disk, network)
Cannot be killed easily

Zombie (Z)
Process finished execution
Parent didn’t clean it up
Uses no CPU, but still listed

Stopped (T)
Process paused manually
Example: pressed Ctrl + C

Linux Command used daily - 
cd - Change directory 
This command is used to navigate into directories

cp - copy command
This command is used to copy files and directories from source to destination

mv - Move / rename command
This command is used move the files and directory to a different location or rename the existing filename or directory name.

cat - Open and view the contents in a file
This command is used to view whats written in the file

touch - Creata file command
This command creates an empty file without data.



	






