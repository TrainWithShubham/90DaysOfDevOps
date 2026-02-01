# Day 07 – Linux File System Hierarchy & Scenario-Based Practice

**Date:** 2026-02-01  
**Goal:** Understand Linux filesystem structure and practice real-world troubleshooting  
**Duration:** 70 minutes  
**Difficulty:** Intermediate

---

## Part 1: Linux File System Hierarchy (30 minutes)

### Overview
The Linux filesystem follows the **Filesystem Hierarchy Standard (FHS)**. Everything starts from the root (`/`) directory and branches out in a tree structure.

---

### Core Directories (Must Know)

#### 1. `/` - Root Directory
**What it contains:** The starting point of the entire filesystem hierarchy  
**Files/Folders observed:**
```bash
ls -l /
drwxr-xr-x  1 root root    4096 Nov 21 02:02 etc
drwxr-xr-x  1 root root    4096 Nov 21 01:53 home
drwxr-xr-x  1 root root    4096 Jan 31 19:00 mnt
drwx--S---  1 root root    4096 Jan 31 19:41 root
drwxrwxrwt  1 root root    4096 Jan 31 19:41 tmp
```

**I would use this when:** 
- Understanding the overall system structure
- Navigating to any location using absolute paths
- Performing system-wide operations

---

#### 2. `/home` - User Home Directories
**What it contains:** Personal directories for regular (non-root) users  
**Files/Folders observed:**
```bash
ls -la /home
drwxr-xr-x 1 root   root   4096 Nov 21 01:53 rameez
drwxr-x--- 2 ubuntu ubuntu  100 Oct 13 14:09 ahmed
```

**I would use this when:**
- Accessing user-specific files, configurations, and data
- Managing user documents, scripts, or personal configs
- Setting up development environments for specific users

**Real-world example:** `/home/rameez/.bashrc` for user-specific shell configuration

---

#### 3. `/root` - Root User's Home Directory
**What it contains:** Home directory for the root (administrator) user  
**Files/Folders observed:**
```bash
ls -la /root
drwx--S--- 1 root root 4096 Jan 31 19:41 .
-rw-r--r-- 1 root root 3106 Apr 22  2024 .bashrc
-rw-r--r-- 1 root root  161 Apr 22  2024 .profile
drwx--S--- 2 root root   40 Nov 21 01:55 .ssh
```

**I would use this when:**
- Running administrative tasks as root
- Storing root user's SSH keys, configs, and scripts
- Accessing root's command history and preferences

**Security note:** This directory has restricted permissions (700) for security

---

#### 4. `/etc` - Configuration Files
**What it contains:** System-wide configuration files for applications and services  
**Files/Folders observed:**
```bash
ls -la /etc | head -15
-rw-r--r-- 1 root root    3444 Jul  5  2023 adduser.conf
drwxr-xr-x 2 root root    1380 Nov 21 01:59 alternatives
drwxr-xr-x 8 root root     180 Oct 13 14:03 apt
-rw-r--r-- 1 root root    2319 Mar 31  2024 bash.bashrc
-rw-r--r-- 1 root root       0 Oct 13 14:03 hosts
-rw-r--r-- 1 root root       0 Oct 13 14:03 hostname
```

**Example config file:**
```bash
cat /etc/hosts
# BEGIN CONTAINER MANAGED HOSTS
127.0.0.1 localhost
127.0.0.1 runsc
# END CONTAINER MANAGED HOSTS
```

**I would use this when:**
- Configuring network settings (`/etc/hosts`, `/etc/resolv.conf`)
- Modifying service configurations (`/etc/nginx/nginx.conf`)
- Managing user/group information (`/etc/passwd`, `/etc/group`)
- Setting up system-wide environment variables

**DevOps critical:** This is where 90% of configuration changes happen!

---

#### 5. `/var/log` - Log Files
**What it contains:** System and application log files  
**Files/Folders observed:**
```bash
ls -lh /var/log
-rw-r--r-- 1 root root             20K Nov 21 01:59 alternatives.log
drwxr-xr-x 2 root root             100 Nov 21 01:59 apt
-rw-r--r-- 1 root root             60K Oct 13 14:03 bootstrap.log
-rw-r--r-- 1 root root            575K Nov 21 02:00 dpkg.log
drwxr-sr-x 2 root systemd-journal   40 Nov 21 01:55 journal
```

**Largest log files found:**
```bash
du -sh /var/log/* 2>/dev/null | sort -h | tail -5
5.5K    /var/log/fontconfig.log
20K     /var/log/alternatives.log
60K     /var/log/bootstrap.log
305K    /var/log/apt
575K    /var/log/dpkg.log
```

**I would use this when:**
- Troubleshooting application failures
- Investigating security incidents
- Monitoring system events
- Debugging deployment issues
- Checking authentication attempts (`/var/log/auth.log`)

---

#### 6. `/tmp` - Temporary Files
**What it contains:** Temporary files that may be deleted on reboot  
**Files/Folders observed:**
```bash
ls -la /tmp | head -10
drwxrwxrwt 1 root root 4096 Jan 31 19:41 .
drwxr-xr-x 2 root root   40 Nov 21 02:00 hsperfdata_root
drwxr-xr-x 3 root root   60 Nov 21 01:57 node-compile-cache
drwxr-xr-x 2 root root 4096 Jan 31 19:41 runbook-demo
```

**I would use this when:**
- Storing temporary files during script execution
- Testing file operations without affecting production data
- Creating temporary working directories for deployments
- Storing session data that doesn't need to persist

**Note:** Files here may be deleted on system reboot. Don't store important data!

---

### Additional Directories (Good to Know)

#### 7. `/bin` - Essential Command Binaries
**What it contains:** Essential command binaries needed for system boot and single-user mode  
**Files/Folders observed:**
```bash
ls -l /bin
lrwxrwxrwx 1 root root 7 Apr 22  2024 /bin -> usr/bin
```

**I would use this when:**
- Locating basic commands like `ls`, `cat`, `cp`, `grep`
- Understanding where shell commands are stored
- Troubleshooting PATH issues

**Common binaries:** bash, cat, chmod, cp, date, echo, grep, ls, mkdir, rm, sh

---

#### 8. `/usr/bin` - User Command Binaries
**What it contains:** User command binaries and applications  
**Files/Folders observed:**
```bash
ls -l /usr/bin | head -10
-rwxr-xr-x 1 root root     2064864 Oct 23 17:29 Xvfb
-rwxr-xr-x 1 root root       55744 Jun 22  2025 [
-rwxr-xr-x 1 root root       14488 May 11  2024 acyclic
-rwxr-xr-x 1 root root       16422 Jul  2  2025 add-apt-repository
```

**I would use this when:**
- Running non-essential user programs
- Finding installed applications
- Checking which version of a tool is installed (`which python3`)

**Contains:** python, git, curl, wget, vim, nano, gcc, and most user applications

---

#### 9. `/opt` - Optional/Third-Party Applications
**What it contains:** Add-on application software packages  
**Files/Folders observed:**
```bash
ls -la /opt
drwxr-xr-x 3 root root   60 Nov 21 01:57 google
drwxr-xr-x 6 root root  120 Nov 21 01:59 pw-browsers
```

**I would use this when:**
- Installing third-party software that doesn't follow standard paths
- Deploying custom applications (like `/opt/myapp`)
- Managing commercial software installations
- Keeping manually installed software separate from package-managed software

**Examples:** `/opt/google/chrome`, `/opt/teamviewer`, custom enterprise apps

---

### Additional Important Directories (Quick Reference)

| Directory | Purpose                | Use Case                                   |
| --------- | ---------------------- | ------------------------------------------ |
| `/var`    | Variable data files    | Logs, databases, email, print queues       |
| `/usr`    | User programs and data | Installed applications, libraries          |
| `/dev`    | Device files           | Hardware devices (disks, terminals)        |
| `/proc`   | Process information    | Virtual filesystem for kernel/process info |
| `/sys`    | System information     | Kernel and hardware configuration          |
| `/boot`   | Boot loader files      | Kernel, initrd, bootloader config          |
| `/lib`    | Essential libraries    | Shared libraries for /bin and /sbin        |
| `/mnt`    | Mount points           | Temporary mount points for filesystems     |
| `/media`  | Removable media        | USB drives, CD-ROMs auto-mounted here      |
| `/srv`    | Service data           | Data for services (web, FTP)               |

---

## Part 2: Scenario-Based Practice (40 minutes)

### Understanding the Approach

**Key principle:** Follow a systematic troubleshooting flow:
1. **Observe** - What's the current state?
2. **Investigate** - Gather data and logs
3. **Diagnose** - Identify the root cause
4. **Fix** - Apply the solution
5. **Verify** - Confirm it's working

---

### SOLVED EXAMPLE: Check if a Service is Running

**Scenario:** How do you check if the 'nginx' service is running?

#### My Solution (Step by step):

**Step 1: Check service status**
```bash
systemctl status nginx
```
**Why this command?** Shows if service is active, failed, or stopped with recent log entries

**Expected output patterns:**
- `Active: active (running)` → Service is working
- `Active: failed` → Service crashed, check logs
- `Active: inactive (dead)` → Service is stopped

---

**Step 2: If service is not found, list all services**
```bash
systemctl list-units --type=service | grep nginx
```
**Why this command?** Confirms if service exists on the system

---

**Step 3: Check if service is enabled on boot**
```bash
systemctl is-enabled nginx
```
**Why this command?** Determines if it will start automatically after reboot

**Output meanings:**
- `enabled` → Starts on boot
- `disabled` → Won't start on boot
- `static` → Controlled by another service

---

**What I learned:** 
Always check status first, then investigate based on what you see. Status command gives 80% of the info you need.

---

### Scenario 1: Service Not Starting

**Problem:** A web application service called 'myapp' failed to start after a server reboot. What commands would you run to diagnose the issue?

#### Solution:

**Step 1: Check if service is running or failed**
```bash
systemctl status ssh
```
**Why:** Shows current state (active/failed/inactive) and recent log entries  
**Look for:** Exit codes, error messages in the status output

---

**Step 2: Check if service is enabled on boot**
```bash
systemctl is-enabled ssh
```
**Why:** Determines if service will auto-start after reboot  
**If disabled:** Service won't start automatically - this might be the issue!

---

**Step 3: View recent logs for error messages**
```bash
journalctl -u ssh -n 50
```
**Why:** Shows last 50 log entries to identify error messages  
**Look for:** Stack traces, "failed to start", permission errors, port conflicts

---

**Step 4: View logs with explanatory text**
```bash
journalctl -u ssh -xe
```
**Why:** `-x` adds explanatory help text, `-e` jumps to end of logs  
**Helps:** Understand systemd-specific errors

---

**Step 5: If service is disabled, enable and start it**
```bash
systemctl enable --now ssh
```
**Why:** Enables service for boot AND starts it immediately  
**Verify with:** `systemctl status myapp`

---

**Additional troubleshooting commands:**
```bash
# Check service file for misconfiguration
systemctl cat ssh

# Reload systemd if you edited the service file
systemctl daemon-reload

# View all failed services
systemctl --failed
```

---

### Scenario 2: High CPU Usage

**Problem:** Your manager reports that the application server is slow. You SSH into the server. What commands would you run to identify which process is using high CPU?

#### Solution:

**Step 1: Check real-time CPU usage with top**
```bash
top
```
**Why:** Shows live CPU usage sorted by CPU% (press 'q' to quit)  
**Look for:** Process with highest %CPU in the top rows  
**Key columns:**
- `PID` - Process ID
- `%CPU` - CPU usage percentage
- `%MEM` - Memory usage percentage
- `COMMAND` - Process name

**Pro tip:** Press `1` to see individual CPU cores, `P` to sort by CPU

---

**Step 2: Get sorted list of top CPU consumers**
```bash
ps aux --sort=-%cpu | head -10
```
**Why:** Shows top 10 processes by CPU usage with full details  
**Advantage:** Non-interactive, can be saved to a file or sent in reports

---

**Step 3: Note the PID and get more details**
```bash
ps -o pid,pcpu,pmem,cmd -p <PID>
```
**Why:** Shows detailed info about specific process including full command  
**Example:** `ps -o pid,pcpu,pmem,cmd -p 1234`

---

**Step 4: Check if process is stuck or working normally**
```bash
top -p <PID>
```
**Why:** Monitor specific process CPU usage over time  
**Helps:** Determine if CPU spike is temporary or constant

---

**Step 5: Investigate what the process is doing**
```bash
lsof -p <PID>
```
**Why:** Lists open files and connections to understand process activity  
**Shows:** Files being read/written, network connections, shared libraries

---

**Additional investigation commands:**
```bash
# Check process threads
ps -eLf | grep <PID>

# See system load average
uptime

# Check CPU-intensive processes over time
sar -u 1 10  # if sysstat is installed
```

---

### Scenario 3: Finding Service Logs

**Problem:** A developer asks: "Where are the logs for the 'docker' service?" The service is managed by systemd. What commands would you use?

#### Solution:

**Step 1: First check if service exists and its status**
```bash
systemctl status docker
```
**Why:** Confirms service exists and shows brief status with recent log entries  
**Output includes:** Last few log lines directly in the status

---

**Step 2: View last 50 lines of service logs**
```bash
journalctl -u docker -n 50
```
**Why:** Shows recent log entries for the docker service  
**Alternative:** `-n 100` for more lines, `-n 20` for fewer

---

**Step 3: Follow logs in real-time (like tail -f)**
```bash
journalctl -u docker -f
```
**Why:** Continuously displays new log entries as they occur  
**Use case:** Monitoring during deployment or troubleshooting  
**Exit:** Press `Ctrl+C`

---

**Step 4: View logs with timestamp filter**
```bash
journalctl -u docker --since '1 hour ago'
```
**Why:** Shows only logs from the last hour (useful for recent issues)  
**Other examples:**
- `--since '2026-02-01 10:00:00'`
- `--since today`
- `--since yesterday`

---

**Step 5: Search logs for specific errors**
```bash
journalctl -u docker | grep -i error
```
**Why:** Filters logs to show only error messages  
**Case-insensitive:** `-i` flag catches ERROR, error, Error

---

**Advanced log commands:**
```bash
# Show logs between specific times
journalctl -u docker --since "2026-02-01 09:00" --until "2026-02-01 10:00"

# Show logs with priority level
journalctl -u docker -p err  # Only errors and above

# Export logs to file
journalctl -u docker > docker-logs.txt

# Show kernel logs
journalctl -k
```

---

### Scenario 4: File Permissions Issue

**Problem:** A script at `/home/ahmed/backup.sh` is not executing. When you run `./backup.sh`, you get "Permission denied". What commands would you use to fix this?

#### Solution (PRACTICAL DEMONSTRATION):

**Step 1: Check current permissions**
```bash
ls -l /home/ahmed/backup.sh
```
**Output:**
```
-rw-r--r-- 1 root root 68 Feb  1 14:48 backup.sh
```
**Observation:** Notice `-rw-r--r--` (no 'x' = not executable)

**Understanding the permissions:**
- `-` = regular file
- `rw-` = owner can read and write
- `r--` = group can only read
- `r--` = others can only read
- **Missing:** Execute permission (`x`)

---

**Step 2: Try to execute the script (will fail)**
```bash
./backup.sh
```
**Output:**
```
/bin/sh: 16: ./backup.sh: Permission denied
```
**Why it fails:** File doesn't have execute (`x`) permission

---

**Step 3: Add execute permission**
```bash
chmod +x backup.sh
```
**Why:** Adds execute permission for owner, group, and others  
**Alternative options:**
- `chmod u+x backup.sh` - Execute for owner only
- `chmod 755 backup.sh` - rwxr-xr-x (numeric method)
- `chmod +x *.sh` - Add execute to all shell scripts

---

**Step 4: Verify permissions changed**
```bash
ls -l backup.sh
```
**Output:**
```
-rwxr-xr-x 1 root root 68 Feb  1 14:48 backup.sh
```
**Observation:** Now shows `-rwxr-xr-x` (has 'x' = executable)

---

**Step 5: Try running it again (should work now)**
```bash
./backup.sh
```
**Output:**
```
Running backup script...
Backup complete!
```
**Success!** Script now executes properly

---

**Permission troubleshooting tips:**
```bash
# Check who owns the file
ls -l backup.sh

# Change ownership if needed
chown user:group backup.sh

# Give read, write, execute to owner only
chmod 700 backup.sh

# Common script permissions
chmod 755 backup.sh  # Owner: rwx, Others: r-x
chmod 644 config.txt  # Owner: rw-, Others: r--
```

---

### Common Command Patterns:

| Task | Primary Command | Alternative |
|------|----------------|-------------|
| Service status | `systemctl status <service>` | `service <service> status` |
| View logs | `journalctl -u <service>` | `tail -f /var/log/<service>.log` |
| CPU usage | `top` | `htop`, `ps aux --sort=-%cpu` |
| Permissions | `ls -l <file>` | `stat <file>` |
| Fix permissions | `chmod +x <file>` | `chmod 755 <file>` |

---
