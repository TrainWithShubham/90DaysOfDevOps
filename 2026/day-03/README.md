# Cheatsheet for Process management 

# Process management 

# ps
shows commands runs in terminal

# ps -e
 displays all running processes on the system. Use this option when you need a complete list of system processes, including background services and processes from other users.
# ps -ef
show all the processes with full format listing
# ps -x 
shows processes which do not have tty
# ps aux
The ps aux format displays a detailed view of all running processes including user processes, system services, and background tasks. It provides information such as CPU usage, memory usage, process owner, start time, command name.

# ps -u username 
shows process related to username
# ps -a 
-a option processes for all users that are associated with terrminal except session leaders

# ps -p pid
show process with pid 
# ps -ef --forest
option displays process in a hierarchical true format, showing parent child relationships between processes.
# ps -A
The -A option displays all running processes on the Linux system
# ps -d 
list all processes except session leaders
# ps -T
The -T option displays all processes associated with the current terminal session. This helps users identify commands running within their terminal.

# ps -G group_name 
every process belongs to a user group.

# curl i 

# wget

# ip addr

# ping

# ls -l

# ls -la

# ls -lah

# cd ..
 Moves up one directory level.
# mv source destination 

# cp source destination 

# cp -r source destinations 
copy all the files from source to destinations

# mv: Moves or renames files and directories.

# 1.mv old_name.txt new_name.txt (Renaming)

# 2.mv file.txt /path/to/destination/ (Moving)

# rm file.txt

# rm -r directory 
recursively delete directory and its contents

# rm -rf directorty 
Forces deletion without prompting; use with extreme caution

# cat
Concatenates and displays the entire contents of a file to the standard output.

# less
 Opens a file for interactive, page-by-page viewing (better for large files than cat). Use q to exit.

# head -n 20 file.txt
Displays the first 20 lines of a file.

# tail -n 20 file.txt
 Displays the last 20 lines of a file. Use tail -f file.txt to monitor file additions in real-time (ideal for log tracking).

# traceroute
Tracks the path that network packets take to reach their destination, listing every intermediate router hop and response time.

# nslookup
Queries Domain Name System (DNS) servers to look up domain name records (e.g., finding the IP address associated with google.com). dig provides more detailed debugging information.

# netstat -tuln

## Data Transfer and Remote Management
# curl -O <URL>
Downloads a file from the internet via terminal.

# curl -I <URL> 
fetches just the HTTP header data.

# wget <URL>
A robust tool to download files from the web. It handles background downloads and mirrors entire directories natively.

# ssh user@remote_host
 Securely connects to a remote Linux machine over the network via SSH protocol.

# scp file.txt user@remote_host:/path/to/dest/
 Securely copies files over an SSH connection between local and remote hosts.

 # kill pid 
 kill <PID>: Sends a termination signal to a specific process ID.

By default, it sends SIGTERM (15), which politely asks the program to save its data and close down.

# kill -9 pid
Sends SIGKILL (9), which instantly forces the process to terminate. Use this only if the standard kill command fails.

# pkill process name
: Kills a process by its name rather than its PID.

# killall processname
Similar to pkill, it terminates all instances of a process sharing the exact same name.

managing background and foreground jobs 
# &
appending this to the end of any command launched it directly into the background leaving your terminal free

<!-- adjusting process priority -->
# nice -n commands
starts brand new process with designated priority value.
nice -n 10 tar -czf backup.tar.gz /data : runs a heavy compression task at a low priority so uit doesn't slowdown the rest of you system
# renice <value> -p pid
alters the priority of process that is already running.
renice -n -5 -p 1234
# jobs
 Lists all active background tasks started from the current terminal session, alongside their job numbers.
# bg %<job_number>
 Resumes a paused background job, keeping it running in the background.
# fg %<job_number>
 Brings a background job back into the foreground (takes control of your active terminal screen).