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

# mv source destination 

# cp source destination 

