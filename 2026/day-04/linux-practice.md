# Practiced on Process commands, Service Commands, Log Commands.
----

# # Process Management Commands.
| Commands | Description | Example |
| -------- | ----------- | ------- |
| `ps` | It show running process in the current shell | `ps`  |

this command is without option. It will show you this:-
PID :- is the unique processID of process.
TTY:- is the type of terminal user is logged in to. pts means pseudo terminal.
TIME gives you how long the process has been running.
CMD is the command that you run to launch the process.
| Commands | Description | Example |
| -------- | ----------- | ------- |
| `ps -U` | It show information about all processes run by user. | `ps -U username` |

| Commands | Description | Example |
| -------- | ----------- | ------- |
| `top` | It track the running process. | `top` |

top command show you the running process in real-time with memory and cpu usage.
* PID: Unique Process ID given to each process. *
* User: Username of the process owner. *
* PR: Priority given to a process while scheduling. *
* NI: ‘nice’ value of a process. *
* VIRT: Amount of virtual memory used by a process. *
* RES: Amount of physical memory used by a process. *
* SHR: Amount of memory shared with other processes. *
* S: state of the process
‘D’ = uninterruptible sleep
‘R’ = running
‘S’ = sleeping
‘T’ = traced or stopped
‘Z’ = zombie *
* %CPU: Percentage of CPU used by the process. *
* %MEM; Percentage of RAM used by the process. *
* TIME+: Total CPU time consumed by the process. *
* Command: Command used to activate the process. *

| Commands | Description | Example |
| `kill` | It use for stop process in your OS. | `kill` |
| -------- | ----------- | ------- |
| -------- | ----------- | ------- |
| -------- | ----------- | ------- |
