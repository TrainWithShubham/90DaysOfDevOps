# Day 07 - Linux File System Hierarchy & Scenario-Based Practice

**Date:** February 03, 2026  
**Focus:** Understanding Linux directory structure and real-world troubleshooting scenarios

---

## Part 1: Linux File System Hierarchy

### Core Directories (Must Know)

#### 1. `/` (Root Directory)
**What it contains:** The top-level directory of the entire Linux file system. Every file and directory starts from here.

**Verification:**
```bash
ls -l /
```
**Output:**
```
drwxr-xr-x   2 root root  4096 Jan 28 10:15 bin
drwxr-xr-x   4 root root  4096 Feb  1 08:22 boot
drwxr-xr-x 140 root root  3840 Feb  3 06:00 etc
drwxr-xr-x   3 root root  4096 Jan 15 12:30 home
drwxr-xr-x  14 root root  4096 Jan 28 10:15 lib
drwxr-xr-x   2 root root  4096 Jan 28 10:15 opt
drwxr-xr-x  12 root root  4096 Feb  3 13:45 var
```

**I would use this when:** Navigating to any system directory or understanding the complete directory structure of the system.

---

#### 2. `/home` - User Home Directories
**What it contains:** Personal directories for all regular (non-root) users. Each user has a subdirectory here (e.g., `/home/john`, `/home/jane`).

**Verification:**
```bash
ls -l /home
```
**Output:**
```
drwxr-x--- 15 devuser devuser 4096 Feb  3 12:00 devuser
drwxr-x--- 12 admin   admin   4096 Jan 30 09:15 admin
```

**I would use this when:** Accessing user-specific files, configurations, or project directories. Each user's documents, downloads, and personal scripts live here.

---

#### 3. `/root` - Root User's Home Directory
**What it contains:** Home directory for the root (superuser) account. Separate from `/home` for security reasons.

**Verification:**
```bash
sudo ls -l /root
```
**Output:**
```
drwx------  2 root root 4096 Jan 28 10:30 .ssh
-rw-------  1 root root 3426 Feb  1 14:22 .bash_history
-rw-r--r--  1 root root  570 Jan 28 10:15 .bashrc
```

**I would use this when:** Working as root user or storing system administration scripts that should only be accessible to the superuser.

---

#### 4. `/etc` - Configuration Files
**What it contains:** System-wide configuration files for applications, services, and the operating system itself.

**Verification:**
```bash
ls -l /etc | head -10
```
**Output:**
```
-rw-r--r--  1 root root   3028 Jan 28 10:15 adduser.conf
drwxr-xr-x  2 root root   4096 Feb  1 08:20 apache2
-rw-r--r--  1 root root     45 Jan 28 10:15 bash.bashrc
drwxr-xr-x  2 root root   4096 Jan 30 12:00 cron.d
-rw-r--r--  1 root root    604 Jan 28 10:15 fstab
-rw-r--r--  1 root root     13 Feb  3 06:00 hostname
drwxr-xr-x  3 root root   4096 Jan 28 10:15 nginx
-rw-r--r--  1 root root    411 Jan 28 10:15 hosts
drwxr-xr-x  2 root root   4096 Jan 28 10:15 ssh
```

**Example files:**
```bash
cat /etc/hostname
```
**Output:** `devops-server`

**I would use this when:** Configuring services (nginx, ssh, cron), editing network settings, or troubleshooting application configurations.

---

#### 5. `/var/log` - Log Files
**What it contains:** System and application log files. Critical for troubleshooting and monitoring.

**Verification:**
```bash
ls -lh /var/log
```
**Output:**
```
-rw-r--r--  1 root root  45M Feb  3 14:00 syslog
-rw-r-----  1 root adm   12M Feb  3 14:00 auth.log
-rw-r--r--  1 root root 128M Feb  3 13:55 docker.log
drwxr-xr-x  2 root root 4.0K Jan 28 10:15 nginx
-rw-r-----  1 root adm   8.5M Feb  3 14:00 kern.log
```

**Find largest log files:**
```bash
du -sh /var/log/* 2>/dev/null | sort -h | tail -5
```
**Output:**
```
8.5M    /var/log/kern.log
12M     /var/log/auth.log
45M     /var/log/syslog
128M    /var/log/docker.log
256M    /var/log/nginx
```

**I would use this when:** Debugging service failures, investigating security incidents, monitoring application behavior, or tracking system events.

---

#### 6. `/tmp` - Temporary Files
**What it contains:** Temporary files created by applications and users. Usually cleared on reboot.

**Verification:**
```bash
ls -lh /tmp | head -10
```
**Output:**
```
drwx------  2 root    root    4.0K Feb  3 12:30 systemd-private-abc123
-rw-r--r--  1 devuser devuser  342 Feb  3 13:15 notes.txt
drwx------  2 devuser devuser 4.0K Feb  3 13:00 runbook-demo
-rw-------  1 root    root     128 Feb  3 11:45 tmp.xyz789
```

**I would use this when:** Storing temporary files during scripts, testing configurations, or creating scratch workspaces that don't need to persist.

---

### Additional Directories (Good to Know)

#### 7. `/bin` - Essential Command Binaries
**What it contains:** Essential system binaries (commands) needed for system boot and repair.

**Verification:**
```bash
ls -l /bin | head -10
```
**Output:**
```
-rwxr-xr-x 1 root root 1183448 Feb 25  2024 bash
-rwxr-xr-x 1 root root   52880 Jan 17  2024 cat
-rwxr-xr-x 1 root root   68656 Jan 17  2024 chmod
-rwxr-xr-x 1 root root   72816 Jan 17  2024 cp
-rwxr-xr-x 1 root root  153976 Jan 17  2024 ls
-rwxr-xr-x 1 root root   97536 Jan 17  2024 mkdir
```

**I would use this when:** Understanding where basic commands like `ls`, `cat`, `cp`, and `bash` are located, or when the PATH variable needs troubleshooting.

---

#### 8. `/usr/bin` - User Command Binaries
**What it contains:** Non-essential command binaries for all users. Most user programs live here.

**Verification:**
```bash
ls -l /usr/bin | grep -E "python|git|vim" | head -5
```
**Output:**
```
-rwxr-xr-x 1 root root  2918008 Jan 15  2024 git
lrwxrwxrwx 1 root root        9 Jan 20  2024 python -> python3.12
-rwxr-xr-x 1 root root  6689744 Jan 20  2024 python3.12
-rwxr-xr-x 1 root root  3645192 Dec 12  2023 vim
```

**I would use this when:** Locating installed applications, checking which version of a tool is installed, or understanding the difference between system and user binaries.

---

#### 9. `/opt` - Optional/Third-Party Applications
**What it contains:** Manually installed or third-party software packages that don't fit in standard directories.

**Verification:**
```bash
ls -l /opt
```
**Output:**
```
drwxr-xr-x 5 root root 4096 Jan 25 10:00 google
drwxr-xr-x 8 root root 4096 Jan 28 15:30 gitlab
drwxr-xr-x 3 root root 4096 Jan 20 09:45 nodejs
```

**I would use this when:** Installing custom software, managing third-party applications like GitLab or Jenkins, or organizing company-specific tools.

---

### Quick Reference: My Home Directory
```bash
ls -la ~
```
**Output:**
```
drwxr-x--- 15 devuser devuser 4096 Feb  3 14:00 .
drwxr-xr-x  4 root    root    4096 Jan 15 12:30 ..
-rw-------  1 devuser devuser 8542 Feb  3 13:45 .bash_history
-rw-r--r--  1 devuser devuser  220 Jan 15 12:30 .bash_logout
-rw-r--r--  1 devuser devuser 3771 Jan 15 12:30 .bashrc
drwx------  2 devuser devuser 4096 Jan 28 11:00 .ssh
drwxr-xr-x  5 devuser devuser 4096 Feb  1 09:30 projects
drwxr-xr-x  2 devuser devuser 4096 Feb  3 12:00 scripts
```

**What I learned:** Hidden files (starting with `.`) contain user-specific configurations. The `.ssh` directory holds SSH keys for authentication.

---

## Part 2: Scenario-Based Practice

### SOLVED EXAMPLE: Check if a Service is Running

**Scenario:** How do you check if the 'nginx' service is running?

**My Solution:**

**Step 1:** Check service status
```bash
systemctl status nginx
```
**Output:**
```
● nginx.service - A high performance web server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2026-02-03 06:00:15 UTC; 8h ago
   Main PID: 1523 (nginx)
      Tasks: 5 (limit: 4653)
     Memory: 12.3M
```
**Why this command?** It shows if the service is active, failed, or stopped, along with recent log entries and resource usage.

**Step 2:** If service is not found, list all services
```bash
systemctl list-units --type=service
```
**Why this command?** To see what services exist on the system and their current states.

**Step 3:** Check if service is enabled on boot
```bash
systemctl is-enabled nginx
```
**Output:** `enabled`
**Why this command?** To know if it will start automatically after reboot.

**What I learned:** Always check status first, then investigate based on what you see. The status command provides 80% of the information needed for initial diagnosis.

---

### Scenario 1: Service Not Starting

**Problem:** A web application service called 'myapp' failed to start after a server reboot. What commands would you run to diagnose the issue?

**My Solution:**

**Step 1:** Check if the service is running or failed
```bash
systemctl status myapp
```
**Expected Output:**
```
● myapp.service - My Application Service
     Loaded: loaded (/etc/systemd/system/myapp.service; enabled; vendor preset: enabled)
     Active: failed (Result: exit-code) since Tue 2026-02-03 06:01:23 UTC; 8h ago
    Process: 1234 ExecStart=/usr/bin/myapp (code=exited, status=1/FAILURE)
   Main PID: 1234 (code=exited, status=1/FAILURE)
```
**Why:** Shows current state and indicates the service failed with exit code 1.

---

**Step 2:** Check detailed logs for the service
```bash
journalctl -u myapp -n 50 --no-pager
```
**Expected Output:**
```
Feb 03 06:01:22 server myapp[1234]: Error: Cannot bind to port 8080: Address already in use
Feb 03 06:01:23 server systemd[1]: myapp.service: Main process exited, code=exited, status=1/FAILURE
Feb 03 06:01:23 server systemd[1]: myapp.service: Failed with result 'exit-code'.
```
**Why:** Reveals the root cause - port 8080 is already in use by another process.

---

**Step 3:** Identify what's using the port
```bash
sudo ss -tulpn | grep :8080
```
**Expected Output:**
```
tcp   LISTEN 0      128        0.0.0.0:8080       0.0.0.0:*    users:(("old-app",pid=987,fd=3))
```
**Why:** Discovers that 'old-app' (PID 987) is occupying port 8080.

---

**Step 4:** Check if service is enabled to start on boot
```bash
systemctl is-enabled myapp
```
**Expected Output:** `enabled`
**Why:** Confirms the service should start on boot, so the port conflict is preventing it.

---

**Step 5:** Check service dependencies
```bash
systemctl list-dependencies myapp
```
**Why:** Verify if any required services failed to start first.

---

**Resolution Steps:**
```bash
# Option 1: Stop the conflicting service
sudo systemctl stop old-app

# Option 2: Change myapp's port in configuration
sudo vim /etc/myapp/config.yml
# Change port: 8080 → port: 8081

# Then restart myapp
sudo systemctl start myapp
sudo systemctl status myapp
```

**What I learned:** Service failures often have clear error messages in logs. Always check journalctl first before attempting fixes.

---

### Scenario 2: High CPU Usage

**Problem:** Your manager reports that the application server is slow. You SSH into the server. What commands would you run to identify which process is using high CPU?

**My Solution:**

**Step 1:** Check real-time CPU usage with top
```bash
top
```
**Expected Output:**
```
top - 14:25:32 up 8:25, 2 users, load average: 3.45, 2.89, 2.34
Tasks: 215 total,   2 running, 213 sleeping,   0 stopped,   0 zombie
%Cpu(s): 78.2 us,  4.5 sy,  0.0 ni, 15.3 id,  0.0 wa,  0.0 hi,  2.0 si,  0.0 st
MiB Mem :  15872.5 total,   2341.2 free,  11234.8 used,   2296.5 buff/cache
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.   3876.5 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 2345 www-data  20   0  892456 245632  12456 R  85.3  1.5  125:34.12 php-fpm
 1523 root      20   0  456789 123456   8765 S   8.2  0.8   15:23.45 nginx
  987 mysql     20   0 2345678 654321  23456 S   5.1  4.0   45:12.34 mysqld
```
**Why:** Shows live CPU usage sorted by %CPU. The php-fpm process (PID 2345) is consuming 85.3% CPU.

**Tip:** Press 'P' to sort by CPU, 'M' to sort by memory, 'q' to quit.

---

**Step 2:** Get detailed process list sorted by CPU
```bash
ps aux --sort=-%cpu | head -10
```
**Expected Output:**
```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
www-data  2345 85.3  1.5 892456 245632 ?      R    06:15 125:34 php-fpm: pool www
root      1523  8.2  0.8 456789 123456 ?      Ss   06:00  15:23 nginx: master process
mysql      987  5.1  4.0 2345678 654321 ?     Ssl  06:00  45:12 /usr/sbin/mysqld
```
**Why:** Provides snapshot view of top CPU consumers with additional details like user, VSZ (virtual memory), and RSS (resident memory).

---

**Step 3:** Check what this process is doing
```bash
sudo ls -l /proc/2345/exe
```
**Expected Output:**
```
lrwxrwxrwx 1 www-data www-data 0 Feb  3 14:25 /proc/2345/exe -> /usr/sbin/php-fpm8.1
```
**Why:** Identifies the actual binary being executed.

---

**Step 4:** Check process command line and arguments
```bash
cat /proc/2345/cmdline | tr '\0' ' '
```
**Expected Output:**
```
php-fpm: pool www
```
**Why:** Shows how the process was started and with what arguments.

---

**Step 5:** Monitor the specific process over time
```bash
pidstat -p 2345 1 5
```
**Expected Output:**
```
Linux 6.8.0-49-generic (server)   02/03/2026   _x86_64_   (4 CPU)

02:25:33 PM   UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
02:25:34 PM    33      2345   82.00    3.00    0.00    0.00   85.00     2  php-fpm
02:25:35 PM    33      2345   84.00    2.00    0.00    0.00   86.00     2  php-fpm
02:25:36 PM    33      2345   83.00    3.00    0.00    0.00   86.00     2  php-fpm
```
**Why:** Shows CPU usage trend over 5 seconds, confirming sustained high usage.

---

**Step 6:** Check what files the process has open
```bash
sudo lsof -p 2345 | head -20
```
**Why:** Can reveal if process is stuck reading/writing large files or has connection issues.

---

**Resolution Investigation:**
```bash
# Check PHP-FPM logs
sudo tail -n 100 /var/log/php8.1-fpm.log

# Check PHP error logs
sudo tail -n 100 /var/log/php_errors.log

# Check nginx access logs for traffic spike
sudo tail -n 100 /var/log/nginx/access.log

# Check if specific script is causing issue
sudo grep "script" /var/log/nginx/access.log | tail -20
```

**What I learned:** High CPU can be caused by runaway scripts, infinite loops, or traffic spikes. Always identify the process first, then investigate its logs and behavior patterns.

---

### Scenario 3: Finding Service Logs

**Problem:** A developer asks: "Where are the logs for the 'docker' service?" The service is managed by systemd. What commands would you use?

**My Solution:**

**Step 1:** Check service status (includes recent log entries)
```bash
systemctl status docker
```
**Expected Output:**
```
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2026-02-03 06:00:15 UTC; 8h ago
       Docs: https://docs.docker.com
   Main PID: 1234 (dockerd)
      Tasks: 45
     Memory: 245.3M
        CPU: 2min 34s
     CGroup: /system.slice/docker.service
             └─1234 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

Feb 03 14:15:22 server dockerd[1234]: time="2026-02-03T14:15:22Z" level=info msg="Container started"
Feb 03 14:20:33 server dockerd[1234]: time="2026-02-03T14:20:33Z" level=warning msg="Health check failed"
```
**Why:** Quick overview with last few log lines visible immediately.

---

**Step 2:** View last 50 lines of Docker service logs
```bash
journalctl -u docker -n 50 --no-pager
```
**Expected Output:**
```
Feb 03 14:00:15 server dockerd[1234]: time="2026-02-03T14:00:15Z" level=info msg="API listen on /var/run/docker.sock"
Feb 03 14:15:22 server dockerd[1234]: time="2026-02-03T14:15:22Z" level=info msg="Container nginx-web started"
Feb 03 14:20:33 server dockerd[1234]: time="2026-02-03T14:20:33Z" level=warning msg="Container app-backend health check failed"
Feb 03 14:21:45 server dockerd[1234]: time="2026-02-03T14:21:45Z" level=info msg="Container app-backend health check passed"
```
**Why:** Shows recent systemd journal entries for the Docker service.

---

**Step 3:** Follow Docker logs in real-time
```bash
journalctl -u docker -f
```
**Expected Output:**
```
-- Journal begins at Tue 2026-02-03 06:00:00 UTC. --
Feb 03 14:30:11 server dockerd[1234]: time="2026-02-03T14:30:11Z" level=info msg="Image pulled successfully" image=nginx:latest
Feb 03 14:31:23 server dockerd[1234]: time="2026-02-03T14:31:23Z" level=info msg="Container created" id=abc123def456
[waiting for new entries...]
```
**Why:** Like `tail -f`, this monitors logs as they're written - essential for debugging in real-time.

---

**Step 4:** Search for specific errors in Docker logs
```bash
journalctl -u docker | grep -i "error" | tail -20
```
**Expected Output:**
```
Feb 03 12:15:33 server dockerd[1234]: level=error msg="Failed to pull image" image=badimage:latest error="manifest unknown"
Feb 03 13:22:45 server dockerd[1234]: level=error msg="Container failed to start" container=broken-app
```
**Why:** Quickly identifies error messages without reading all logs.

---

**Step 5:** Check Docker file-based logs (alternative location)
```bash
sudo ls -lh /var/log/docker.log
```
**Expected Output:**
```
-rw-r--r-- 1 root root 128M Feb  3 14:30 /var/log/docker.log
```
```bash
sudo tail -n 50 /var/log/docker.log
```
**Why:** Some systems also write to file-based logs. Good to check both locations.

---

**Step 6:** View logs with timestamps and priority
```bash
journalctl -u docker -n 30 -o verbose
```
**Why:** Shows full metadata including exact timestamps, useful for correlating with other system events.

---

**Additional Techniques:**

**Check logs for specific time range:**
```bash
journalctl -u docker --since "2026-02-03 14:00:00" --until "2026-02-03 14:30:00"
```

**Check logs from last boot:**
```bash
journalctl -u docker -b
```

**Export logs to file for analysis:**
```bash
journalctl -u docker -n 1000 > /tmp/docker-logs-export.txt
```

**What I learned:** Systemd-managed services store logs in journald, accessed via `journalctl`. The `-u` flag targets specific services, `-f` follows live, and `-n` limits output lines.

---

### Scenario 4: File Permissions Issue

**Problem:** A script at `/home/user/backup.sh` is not executing. When you run `./backup.sh`, you get "Permission denied". What commands would you use to fix this?

**My Solution:**

**Step 1:** Check current permissions
```bash
ls -l /home/user/backup.sh
```
**Expected Output:**
```
-rw-r--r-- 1 user user 1245 Feb  3 13:00 /home/user/backup.sh
```
**Analysis:**
- `-rw-r--r--` breaks down as:
  - `-` = regular file (not directory)
  - `rw-` = owner (user) can read and write
  - `r--` = group can only read
  - `r--` = others can only read
  - **NO 'x' anywhere = NOT EXECUTABLE**

**Why this command?** Shows exact permissions and identifies the problem - missing execute permission.

---

**Step 2:** Add execute permission for the owner
```bash
chmod +x /home/user/backup.sh
```
**Alternative (more specific):**
```bash
chmod u+x /home/user/backup.sh  # Execute for user only
```
**Why:** Adds execute (`x`) permission, allowing the script to run.

---

**Step 3:** Verify permissions were changed
```bash
ls -l /home/user/backup.sh
```
**Expected Output:**
```
-rwxr-xr-x 1 user user 1245 Feb  3 13:00 /home/user/backup.sh
```
**Analysis:**
- `-rwxr-xr-x` now shows:
  - `rwx` = owner can read, write, execute ✅
  - `r-x` = group can read and execute
  - `r-x` = others can read and execute

**Why:** Confirms the change was successful.

---

**Step 4:** Try running the script
```bash
./backup.sh
```
**Expected Output:**
```
Starting backup process...
Backing up /home/user/documents to /backup/2026-02-03/
Backup completed successfully!
```
**Why:** Verifies the script now executes properly.

---

**Additional Troubleshooting (if still fails):**

**Step 5:** Check script interpreter (shebang)
```bash
head -n 1 /home/user/backup.sh
```
**Expected Output:**
```
#!/bin/bash
```
**Why:** Ensures script has proper shebang line telling system which interpreter to use.

---

**Step 6:** Check if script has correct ownership
```bash
ls -l /home/user/backup.sh
```
**If ownership is wrong:**
```bash
sudo chown user:user /home/user/backup.sh
```
**Why:** Script might be owned by different user, preventing execution.

---

**Step 7:** Verify bash is available
```bash
which bash
```
**Expected Output:**
```
/bin/bash
```
**Why:** Confirms the interpreter specified in shebang exists.

---

**Permission Modes Explained:**

| Symbol | Numeric | Meaning |
|--------|---------|---------|
| `---` | 0 | No permissions |
| `r--` | 4 | Read only |
| `rw-` | 6 | Read and write |
| `rwx` | 7 | Read, write, execute |
| `r-x` | 5 | Read and execute |

**Common chmod examples:**
```bash
chmod 755 script.sh   # rwxr-xr-x (owner: all, others: read+execute)
chmod 644 file.txt    # rw-r--r-- (owner: rw, others: read-only)
chmod 700 private.sh  # rwx------ (owner only, full access)
chmod u+x script.sh   # Add execute for user
chmod go-w file.txt   # Remove write for group and others
```

**What I learned:** 
- Files need execute (`x`) permission to run as scripts
- `ls -l` shows permissions in format: `type|owner|group|others`
- `chmod +x` is quickest way to make a file executable
- Always verify changes with `ls -l` after using `chmod`
- Permissions are fundamental to Linux security

---

## Summary: Key Takeaways

### File System Knowledge
✅ Know where to find configurations (`/etc`)  
✅ Know where to find logs (`/var/log`)  
✅ Know where user data lives (`/home`)  
✅ Understand the difference between `/bin`, `/usr/bin`, and `/opt`

### Troubleshooting Workflow
1. **Check status first** - `systemctl status <service>`
2. **Read the logs** - `journalctl -u <service> -n 50`
3. **Identify the problem** - Look for errors, warnings, resource issues
4. **Verify the fix** - Check status again after changes

### Essential Command Patterns
```bash
# Service troubleshooting
systemctl status <service>
journalctl -u <service> -n 50
systemctl is-enabled <service>

# Process troubleshooting
top
ps aux --sort=-%cpu
pidstat -p <PID>

# Permission troubleshooting
ls -l <file>
chmod +x <file>
chown user:group <file>

# Log analysis
journalctl -u <service> -f
tail -f /var/log/<logfile>
grep -i "error" /var/log/<logfile>
