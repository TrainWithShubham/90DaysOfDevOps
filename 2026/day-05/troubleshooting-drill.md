# Command 1: uname -a

Observation: Confirmed kernel version and system architecture. Useful for checking module compatibility (like Brotli or OpenSSL).
Linux abhishek 6.8.0-87-generic #88-Ubuntu SMP PREEMPT_DYNAMIC Sat Oct 11 09:28:41 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

# Command 2: cat /etc/os-release

Observation: Identified the specific Linux distro to know whether to use apt or dnf if Nginx needs a package update.
PRETTY_NAME="Ubuntu 24.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.3 LTS (Noble Numbat)"
# Command 3: sudo nginx -t

Observation: This is the "Filesystem/Config Sanity" check for Nginx. It verifies that all included config files are readable and have the correct syntax.

# ps -o pid,pcpu,pmem,comm -C nginx

ps — display information about running processes.
-C nginx — select processes whose command name is nginx.
-o pid,pcpu,pmem,comm — customize the output columns:
pid — process ID.
pcpu — CPU usage percentage.
pmem — memory usage percentage.
comm — command name.

Example output:

  PID %CPU %MEM COMMAND
 1023  0.0  0.1 nginx
 1024  0.1  0.2 nginx
 1025  0.1  0.2 nginx

 The fundamental difference between free -h and df -h comes down to Memory vs. Storage:

# free -h 
measures your system's RAM (Random Access Memory). This is temporary, volatile workspace memory that your CPU uses to run active processes (like Nginx). When you turn off the machine, this data is wiped clean.

# df -h 
stands for "disk free" and measures your system's Disk Storage (Hard Drive / SSD). This is permanent, non-volatile space where your files, code, logs, and OS system files live. It survives system reboots

ss -tulpn displays listening network sockets and the processes associated with them.

Breakdown of the options:

-t — show TCP sockets.
-u — show UDP sockets.
-l — show only listening sockets.
-p — show the process (PID/program name) using the socket.
-n — show numeric addresses and port numbers (don't resolve names).

Example:

# ss -tulpn

-t — show TCP sockets.
-u — show UDP sockets.
-l — show only listening sockets.
-p — show the process (PID/program name) using the socket.
-n — show numeric addresses and port numbers (don't resolve names).
Sample output:

Netid State  Recv-Q Send-Q Local Address:Port  Peer Address:Port Process
tcp   LISTEN 0      511    0.0.0.0:80        0.0.0.0:*     users:(("nginx",pid=1023,fd=6))
tcp   LISTEN 0      128    0.0.0.0:22        0.0.0.0:*     users:(("sshd",pid=845,fd=3))
udp   UNCONN 0      0      0.0.0.0:68        0.0.0.0:*     users:(("dhclient",
pid=702,


# du -sh filename (disk usage)
sudo du -sh /var/log
This command estimates the space used by specific individual files or directories. It works by literally walking through a directory tree and adding up the size of every file it finds, which can take time on large folders.

# df -h (disk free )

This command reports the total space, used space, and available space on all mounted filesystems. It queries the filesystem structure itself, making it incredibly fast.

# head -n 10 os-release
read 10 lines from os-release 

