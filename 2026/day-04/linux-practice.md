Task 1 – Check Running Processes
ps -a
Shows active processes attached to terminals (except session leaders).

PID → Process ID

TTY → Terminal associated
TIME → CPU time consumed
CMD → Command executed

Output:
    root@TWS-BATCH-10-SERVER:~# ps -a
    PID TTY          TIME CMD
    2143 pts/0    00:00:00 ps


top
Real‑time monitoring tool for processes and system performance.

Displays:
    CPU usage
    Memory usage
    Load average (1, 5, 15 minutes)
    Process list with PID, USER, priority, memory, CPU %, etc.

    root@TWS-BATCH-10-SERVER:~# top
top - 14:59:30 up 1 min,  1 user,  load average: 0.56, 0.24, 0.09
Tasks: 192 total,   1 running, 191 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.2 us,  0.3 sy,  0.0 ni, 99.5 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   3915.9 total,   2604.1 free,    969.4 used,    564.5 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.   2946.5 avail Mem


Task 2 – Inspect One Systemd Service
Command: systemctl list-units --type=service
Output: Shows all loaded services and their states (running, exited, failed).

jenkins.service   loaded active running Jenkins Continuous Integration Server
docker.service    loaded active running Docker Application Container Engine

systemctl status jenkins.service
Output:
● jenkins.service - Jenkins Continuous Integration Server
     Loaded: loaded (/usr/lib/systemd/system/jenkins.service; enabled)
     Active: active (running) since Tue 2026-01-27 14:58:38 UTC; 8min ago
   Main PID: 756 (java)
      Tasks: 44
     Memory: 644.7M
        CPU: 30.905s
     CGroup: /system.slice/jenkins.service
             └─756 /usr/bin/java -jar /usr/share/java/jenkins.war

Task 3 – Capture a Small Troubleshooting Flow
command: systemctl status jenkins.service
output: Confirms if Jenkins is active or failed.


journalctl -u jenkins.service -n 50

Shows last 50 log entries for Jenkins.
Useful for spotting errors (e.g., port conflicts, permission issues).

ls -ld /var/lib/jenkins
drwxr-xr-x 16 jenkins jenkins 4096 Jan 27 14:58 /var/lib/jenkins















