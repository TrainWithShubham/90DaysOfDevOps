**Process States in Linux**

Running (R)
The process is currently executing on the CPU or is ready to run and waiting for CPU time.

Sleeping (S / D)
The process is waiting for an event or resource, such as disk I/O, network I/O, or the completion of another process via wait().

Zombie (Z)
The process has completed execution, but its parent process has not yet collected its exit status. The process entry remains in the process table until it is reaped by the parent.

**Commonly Used Linux Commands**

ls -ltr – List files in long format, sorted by modification time

ps -ef – Display all running processes with full details

top – Monitor real-time CPU and memory usage

grep -i – Search text patterns case-insensitively

cd / mkdir / mv – Basic directory navigation and file management commands
