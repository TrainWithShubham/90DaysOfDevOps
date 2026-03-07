# 🗂 Linux File System Hierarchy – Practice Notes
## 🔹 Core Directories (Must Know)
- /(Root) -The root directory is the top-level directory in Linux. Everything starts from here. Command `la -l /` , I would use this when I need to understand the overall filesystem structure or navigate to system-level directories. Eg: bin, etc, home
- /Home - Contains personal directories for normal users. `ls -l /home`, I would use this when I need to access or manage user files and personal data. Eg: ubuntu
- /root - Home directory for the root (administrator) user. `ls -l /root`I would use this when I am logged in as root and need access to root-specific configuration or scripts. Eg: .bashrc , .profile
- /etc - Stores system-wide configuration files. `ls -l /etc` I would use this when I need to modify service configurations (e.g., SSH, networking, users). Eg: ssh/ ,passwd, hosts
- /var/log -Contains system and application log files. Very important for troubleshooting. `ls -l /var/log` I would use this when I am investigating system errors, service failures, or login issues. Eg: auth.log, syslog, journal/
- /tmp -Stores temporary files created by users and applications. `ls -l /tmp` I would use this when I need a safe place to test file operations without affecting production data. Eg: runbook-demo, systemd-private-*
## 🔹 Additional Directories (Good to Know)
- /bin -Contains essential system command binaries required for booting and basic operations. `ls -l /bin` I would use this when I want to verify where core Linux commands are located. Eg: ls, cp, mv
- /usr/bin - Contains most user-level command binaries and applications. `ls -l /usr/bin` I would use this when I need to check if a program is installed on the system. Eg: git, python3, vim
- /opt - Used for installing optional or third-party software. `ls -l /opt` I would use this when I install custom software like Jenkins, Docker packages, or vendor applications. Eg: May be empty or contain application folders
# Hands on task
`du -sh /var/log/* 2>/dev/null | sort -h | tail -5` - Show me the 5 largest log files in /var/log.
- du -sh /var/log/*
- du → Disk usage
- -s → Summary (don’t go inside subfolders deeply)
- -h → Human readable (MB, GB instead of bytes)
- /var/log/* → All files/folders inside /var/log
- 2>/dev/null - This hides permission errors
 - 2> = redirect error output
 - /dev/null = throw it away
- sort -h -sort in human-readable size order, Now logs are sorted from smallest → largest.
- tail -5 - show last 5 lines,Since sorted smallest → largest,the last 5 are the biggest
- OUTPUT
```
4.0K  /var/log/boot.log
12M   /var/log/syslog
85M   /var/log/journal
```
# Part 2: Scenario-Based Practice
- Question: How do you check if the 'nginx' service is running?
- Step by step solution
- Step 1 : Check service status `systemctl status nginx` - Why this command? It shows if  the service is active, failed, or stopped
- Step 2: If service is not found, list all services - `systemctl list-units --type=service` Why this command? To see what services exist on the system
- Step 3: Check if service is enabled on boot `systemctl is-enabled nginx` - Why this command? To know if it will start automatically after reboot
- What i learned - Always check status first, then investigate based on what you see.

# Scenario 1: Service Not Starting
```
A web application service called 'myapp' failed to start after a server reboot.
What commands would you run to diagnose the issue?
Write at least 4 commands in order.
```
- Step 1: `systemctl status myapp` - To check whether the service is running, failed, inactive, or stuck — and see the immediate error message.
- step 2: - `journalctl -u myapp -n 50` - To view the last 50 log entries for the service and identify the exact failure reason (config error, port conflict, permission issue, etc.).
- Step 3: `systemctl is-enabled myapp` -To check if the service is configured to automatically start on boot.
- `systemctl list-units --type=service | grep myapp` -To confirm the service is properly registered with systemd and recognized by the system.

# Scenario 2: High CPU Usage
```
Your manager reports that the application server is slow.
You SSH into the server. What commands would you run to identify
which process is using high CPU?
```
- Step 1: `top` -To view live CPU usage and quickly identify which process is consuming the most CPU in real time.
- step 2: `ps aux --sort=-%cpu | head -10` To list processes sorted by highest CPU usage and display the top 10 consumers.
- step 3: `ps -fp <PID>` To get detailed information about the specific process — including parent process and command path.
- step 4: `top -p <PID>` To monitor only that specific process and confirm whether CPU usage remains high.

# Scenario 3: Script Not Executing (Permission denied)
- `ls -l /home/user/.backup.sh` - check current permissions
- ``` -rw-r--r-- 1 user user  245 Feb 10 21:30 backup.sh ``` - no execulatable permission which is x - cannot run the script
- Add execute permission - `chmod =x /home/user/backup.sh` - Adds execute permission for owner, group, and others. Now the system allows the file to be executed as a program.
- Verify It Worked - `ls -l /home/user/backup.sh` - 
```-rwxr-xr-x 1 user user 245 Feb 10 21:30 backup.sh
```
- owner, group and others can read, write and excute 
- Run the script - `./backup.sh` -Now it should execute.
# 🎯 Core Concept
- To run a file directly with ./filename:
- It must have x permission
- It must be in your current directory (or use full path)
- It must have a valid interpreter if it’s a script

# Scenario 4: Finding Logs for docker Service
- Since docker is managed by systemd, its logs are stored in journald.
- Step 1: Check Service Status - `systemctl status docker` - To confirm whether the service is running, failed, or inactive and see recent log lines directly in the status output.
- Step 2: View Recent Logs - `journalctl -u docker -n 50` - To view the last 50 log entries for the docker service and identify errors, crashes, or startup issues.
- step 3: Follow Logs in Real-Time -`journalctl -u docker -f` -To monitor live logs while restarting Docker or reproducing the issue (similar to tail -f).
- step 4: Option but strong command to filter logs within a specific time window when the issue occurred `journalctl -u docker --since "10 minutes ago"`



