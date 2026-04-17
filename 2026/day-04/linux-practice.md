# Linux Practice Log - Day 04
**Hands-On Linux Command Practice**

Date: February 08, 2026  
Environment: Ubuntu 24 Container

---

## 🔍 Process Checks

### 1. Display Running Processes (ps aux)

**Command:**
```bash
ps aux | head -15
```

**Output:**
```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  8.0  0.1 352336 17896 ?        Ssl  06:19   0:00 /process_api --addr 0.0.0.0:2024 --max-ws-buffer-size 32768...
root        11 33.3  0.0  10848  3580 ?        S    06:19   0:00 /bin/sh -c ps aux | head -15
root        12  100  0.0  15996  8280 ?        R    06:19   0:00 ps aux
root        13  0.0  0.0  10756  4184 ?        S    06:19   0:00 head -15
```

**What I Learned:**
- The first process (PID 1) is the main process running in this environment
- %CPU and %MEM columns show resource usage
- STAT column shows process state (S=sleeping, R=running, Ssl=session leader sleeping)
- VSZ = Virtual Memory, RSS = Resident Set Size (actual physical memory)

---

### 2. Find Process by Name (pgrep)

**Command:**
```bash
pgrep -a process
```

**Output:**
```
1 /process_api --addr 0.0.0.0:2024 --max-ws-buffer-size 32768 --cpu-shares 1024...
```

**What I Learned:**
- `pgrep -a` shows both PID and full command
- Useful for quickly finding specific processes without parsing ps output
- Alternative to `ps aux | grep process`

---

### 3. Process Hierarchy (ps -ef)

**Command:**
```bash
ps -ef | grep -E "PID|process" | head -5
```

**Output:**
```
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  2 06:19 ?        00:00:00 /process_api --addr 0.0.0.0:2024...
root        48     1 66 06:20 ?        00:00:00 /bin/sh -c ps -ef | grep...
```

**What I Learned:**
- PPID column shows parent process ID
- Process 1 has PPID 0 (it's the init process)
- Shows parent-child relationships clearly

---

## 📊 System Resource Monitoring

### 4. Real-Time System Overview (top)

**Command:**
```bash
top -b -n 1 | head -20
```

**Output:**
```
top - 06:19:56 up 0 min,  0 user,  load average: 0.00, 0.00, 0.00
Tasks:   4 total,   1 running,   3 sleeping,   0 stopped,   0 zombie
%Cpu(s):   0.0 us,   0.0 sy,   0.0 ni, 100.0 id,   0.0 wa,   0.0 hi,   0.0 si 
MiB Mem :   9216.0 total,   9200.5 free,     15.5 used,      8.6 buff/cache     
MiB Swap:      0.0 total,      0.0 free,      0.0 used.   9200.5 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    1 root      20   0  352644  18452      0 S   0.0   0.2   0:00.37 process_api
```

**What I Learned:**
- Load average shows 1, 5, and 15-minute averages
- Memory breakdown: total, free, used, buff/cache
- No swap configured in this environment
- CPU is 100% idle (id) - system not under load
- `-b` flag runs top in batch mode (non-interactive)

---

### 5. System Uptime

**Command:**
```bash
uptime
```

**Output:**
```
 06:20:13 up 0 min,  0 user,  load average: 0.00, 0.00, 0.00
```

**What I Learned:**
- Shows how long system has been running
- Load average indicates system load (0.00 means idle)
- User count shows active sessions

---

## 💾 Disk and Memory Analysis

### 6. Disk Space Usage (df -h)

**Command:**
```bash
df -h
```

**Output:**
```
Filesystem      Size  Used Avail Use% Mounted on
none            9.9G  2.1M  9.9G   1% /
none            315G     0  315G   0% /dev
none            315G     0  315G   0% /dev/shm
none            315G     0  315G   0% /sys/fs/cgroup
none            1.0P     0  1.0P   0% /mnt/transcripts
none            1.0P     0  1.0P   0% /mnt/skills/public
none            9.9G  2.1M  9.9G   1% /container_info.json
```

**What I Learned:**
- `-h` flag shows human-readable sizes (GB, MB, etc.)
- Root filesystem is 9.9GB with only 1% used
- Multiple mount points available
- Can quickly identify disk space issues

---

### 7. Memory Usage (free -h)

**Command:**
```bash
free -h
```

**Output:**
```
               total        used        free      shared  buff/cache   available
Mem:           9.0Gi        13Mi       9.0Gi          0B       8.2Mi       9.0Gi
Swap:             0B          0B          0B
```

**What I Learned:**
- 9GB total memory, only 13MB used
- No swap space configured
- Buff/cache is minimal at 8.2MB
- `available` column shows memory available for new processes

---

## 📝 Log Analysis

### 8. System Boot Messages (dmesg)

**Command:**
```bash
dmesg | tail -20
```

**Output:**
```
[    0.000000] Starting gVisor...
[    0.205956] Politicking the oom killer...
[    0.420567] Segmenting fault lines...
[    0.688076] Accelerating teletypewriter to 9600 baud...
[    1.153015] Forking spaghetti code...
[    1.533230] Creating bureaucratic processes...
[    1.906427] Searching for needles in stacks...
[    2.244173] Searching for socket adapter...
[    2.366414] Feeding the init monster...
[    2.776975] Creating process schedule...
[    2.928509] Checking naughty and nice process list...
[    3.353270] Ready!
```

**What I Learned:**
- `dmesg` shows kernel ring buffer messages
- Timestamps shown in seconds since boot
- Useful for hardware detection and kernel issues
- This system uses gVisor (lightweight container runtime)

---

### 9. Checking Available Logs

**Command:**
```bash
ls -lah /var/log/ | head -15
```

**Output:**
```
total 663K
drwxr-xr-x  5 root root             280 Nov 21 01:56 .
drwxr-xr-x 11 root root             260 Oct 13 14:09 ..
-rw-r--r--  1 root root             20K Nov 21 01:59 alternatives.log
drwxr-xr-x  2 root root             100 Nov 21 01:59 apt
-rw-r--r--  1 root root             60K Oct 13 14:03 bootstrap.log
-rw-rw----  1 root utmp               0 Oct 13 14:02 btmp
-rw-r--r--  1 root root            575K Nov 21 02:00 dpkg.log
-rw-r--r--  1 root root               0 Oct 13 14:03 faillog
-rw-r--r--  1 root root            5.1K Nov 21 01:59 fontconfig.log
drwxr-sr-x  2 root systemd-journal   40 Nov 21 01:55 journal
-rw-rw-r--  1 root utmp               0 Oct 13 14:02 lastlog
```

**What I Learned:**
- Common log locations in /var/log/
- `dpkg.log` tracks package installations
- `btmp` logs failed login attempts
- Different files have different permissions (security)

---

### 10. Package Management Logs

**Command:**
```bash
tail -20 /var/log/dpkg.log
```

**Output:**
```
2025-11-21 01:59:15 configure gstreamer1.0-plugins-bad:amd64 1.24.2-1ubuntu4 <none>
2025-11-21 01:59:15 status unpacked gstreamer1.0-plugins-bad:amd64 1.24.2-1ubuntu4
2025-11-21 01:59:15 status half-configured gstreamer1.0-plugins-bad:amd64 1.24.2-1ubuntu4
2025-11-21 01:59:15 status installed gstreamer1.0-plugins-bad:amd64 1.24.2-1ubuntu4
2025-11-21 02:00:08 trigproc ca-certificates-java:all 20240118 <none>
2025-11-21 02:00:08 status half-configured ca-certificates-java:all 20240118
2025-11-21 02:00:08 status installed ca-certificates-java:all 20240118
```

**What I Learned:**
- Shows package installation history
- Tracks configuration states (unpacked, half-configured, installed)
- Timestamps help correlate issues with package changes
- Useful for troubleshooting "what changed?"

---

## 🔧 Mini Troubleshooting Exercise

### Scenario: Check System Health

**Step 1: Check if system is under load**
```bash
uptime
# Result: load average: 0.00, 0.00, 0.00 - System idle ✓
```

**Step 2: Check memory availability**
```bash
free -h
# Result: 9.0Gi available - Plenty of memory ✓
```

**Step 3: Check disk space**
```bash
df -h
# Result: / is 1% used - No disk space issues ✓
```

**Step 4: Check for zombie processes**
```bash
ps aux | grep -i zombie
# Result: No zombie processes found ✓
```

**Step 5: Review recent system messages**
```bash
dmesg | tail -10
# Result: System boot completed successfully ✓
```

**Conclusion:** System is healthy with no resource constraints or process issues.

---

## 🎯 Key Takeaways

### Process Commands Mastered:
1. `ps aux` - Detailed process snapshot
2. `pgrep -a` - Find processes by name
3. `top -b -n 1` - Resource monitoring snapshot
4. `ps -ef` - Process hierarchy view

### System Monitoring:
1. `df -h` - Disk usage
2. `free -h` - Memory usage
3. `uptime` - Load and uptime

### Log Analysis:
1. `dmesg` - Kernel messages
2. `tail -n 20 <logfile>` - Recent log entries
3. `ls -lah /var/log/` - Available logs

---

## 💡 Pro Tips Learned

1. **Always use `-h` flag** for human-readable output (df -h, free -h)
2. **Pipe to head/tail** to limit output: `ps aux | head -20`
3. **Use pgrep instead of ps | grep** - faster and cleaner
4. **Check logs in /var/log/** when troubleshooting
5. **Load average** should be below number of CPU cores
6. **Container environments** may not have systemd (use alternative commands)

---

## 📚 Commands Summary

| Category | Command | Purpose |
|----------|---------|---------|
| Process | `ps aux` | List all processes |
| Process | `pgrep -a <name>` | Find process by name |
| Process | `ps -ef` | Process hierarchy |
| Monitor | `top -b -n 1` | System snapshot |
| Monitor | `uptime` | Load average |
| Disk | `df -h` | Disk usage |
| Memory | `free -h` | Memory usage |
| Logs | `dmesg` | Kernel messages |
| Logs | `tail -n 20 <file>` | Recent log entries |
| Logs | `ls -lah /var/log/` | List log files |

---

## 🔄 Next Steps

1. Practice these commands on a full Linux system with systemd
2. Explore `journalctl` for systemd service logs
3. Learn to use `htop` (interactive process viewer)
4. Study log file locations for different services
5. Practice troubleshooting workflows

---

**Practice Environment:** Container-based Ubuntu 24  
**Note:** Some commands (systemctl) not available in container - alternative approaches used  
**Created for:** #90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham

# Beginner's Guide to Linux Services & Logs
**Simple, Hands-On Guide for Managing Services**

---

## 🎯 What You'll Learn

By the end of this guide, you'll know how to:
1. Check if a service is running
2. Start, stop, and restart services
3. Read service logs
4. Troubleshoot basic service issues

**No prior experience needed!** Just follow along step-by-step.

---

## 📚 Part 1: Understanding Services

### What is a Service?

A **service** is a program that runs in the background on your Linux system.

**Common examples:**
- `ssh` - Allows remote login to your server
- `nginx` - Web server that serves websites
- `mysql` - Database server
- `cron` - Runs scheduled tasks
- `docker` - Container platform

Think of services like apps on your phone that run in the background.

---

## 🔧 Part 2: Basic Service Commands (systemctl)

### Command 1: Check Service Status

**The most important command you'll use daily:**

```bash
systemctl status <service-name>
```

**Example: Check SSH service**

```bash
systemctl status ssh
```

**What you'll see:**

```
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2026-02-08 10:00:00 UTC; 2h ago
   Main PID: 1234 (sshd)
      Tasks: 1 (limit: 4915)
     Memory: 2.5M
```

**How to read this:**

| Line | What it means |
|------|---------------|
| `Loaded: loaded` | Service configuration found ✓ |
| `Active: active (running)` | Service is running ✓ |
| `enabled` | Will start automatically on boot ✓ |
| `Main PID: 1234` | Process ID of the service |
| `Tasks: 1` | Number of running tasks |

**Quick status check:**
- 🟢 Green dot `●` + `active (running)` = Service is running fine
- 🔴 Red dot `●` + `failed` = Service has a problem
- ⚪ White dot `●` + `inactive (dead)` = Service is stopped

---

### Command 2: List All Services

**See all services on your system:**

```bash
systemctl list-units --type=service
```

**Too many results? Filter for running services only:**

```bash
systemctl list-units --type=service --state=running
```

**Example output:**

```
UNIT                    LOAD   ACTIVE SUB     DESCRIPTION
ssh.service            loaded active running OpenBSD Secure Shell server
cron.service           loaded active running Regular background program
nginx.service          loaded active running A high performance web server
```

**What each column means:**
- `UNIT` - Service name
- `LOAD` - Configuration loaded?
- `ACTIVE` - Is it running?
- `SUB` - Detailed state
- `DESCRIPTION` - What the service does

---

### Command 3: Start a Service

**Start a stopped service:**

```bash
sudo systemctl start <service-name>
```

**Example:**

```bash
sudo systemctl start nginx
```

**Note:** You need `sudo` (admin rights) to manage services.

---

### Command 4: Stop a Service

**Stop a running service:**

```bash
sudo systemctl stop <service-name>
```

**Example:**

```bash
sudo systemctl stop nginx
```

---

### Command 5: Restart a Service

**Restart a service (stop + start):**

```bash
sudo systemctl restart <service-name>
```

**When to use:**
- After changing configuration files
- When service is misbehaving
- After updates

**Example:**

```bash
sudo systemctl restart nginx
```

---

### Command 6: Reload Configuration

**Reload config without stopping service:**

```bash
sudo systemctl reload <service-name>
```

**Difference between reload and restart:**
- `reload` - Service keeps running, just re-reads config (no downtime)
- `restart` - Service stops and starts (brief downtime)

---

### Command 7: Enable Service at Boot

**Make service start automatically when system boots:**

```bash
sudo systemctl enable <service-name>
```

**Example:**

```bash
sudo systemctl enable nginx
```

---

### Command 8: Disable Service at Boot

**Prevent service from starting automatically:**

```bash
sudo systemctl disable <service-name>
```

---

### Command 9: Check Failed Services

**Find services that have problems:**

```bash
systemctl --failed
```

**Example output:**

```
UNIT           LOAD   ACTIVE SUB    DESCRIPTION
myapp.service  loaded failed failed My Application Service
```

---

## 📝 Part 3: Reading Service Logs

### Why Check Logs?

Logs tell you:
- What the service is doing
- If there are errors
- Why a service failed

---

### Command 10: View Service Logs (journalctl)

**Basic syntax:**

```bash
journalctl -u <service-name>
```

**Example: View SSH logs**

```bash
journalctl -u ssh
```

**Output example:**

```
Feb 08 10:15:23 server sshd[1234]: Accepted password for user from 192.168.1.100
Feb 08 10:20:45 server sshd[1234]: pam_unix(sshd:session): session opened
Feb 08 10:25:30 server sshd[5678]: Failed password for invalid user admin
```

**Tip:** Use arrow keys to scroll, press `q` to quit.

---

### Command 11: View Last N Lines of Logs

**See only recent logs:**

```bash
journalctl -u <service-name> -n 50
```

**Example: Last 20 SSH log entries**

```bash
journalctl -u ssh -n 20
```

**Why use this?**
- Faster than viewing all logs
- Good for quick checks

---

### Command 12: Follow Logs in Real-Time

**Watch logs as they happen (like tail -f):**

```bash
journalctl -u <service-name> -f
```

**Example: Watch nginx logs live**

```bash
journalctl -u nginx -f
```

**You'll see new entries appear in real-time:**

```
Feb 08 10:30:45 server nginx[5678]: 192.168.1.100 - "GET / HTTP/1.1" 200
Feb 08 10:30:50 server nginx[5678]: 192.168.1.101 - "GET /about HTTP/1.1" 200
```

**Press Ctrl+C to stop following.**

---

### Command 13: View Logs from Last Hour

**Filter by time:**

```bash
journalctl -u <service-name> --since "1 hour ago"
```

**More time examples:**

```bash
# Last 30 minutes
journalctl -u nginx --since "30 minutes ago"

# Since today
journalctl -u ssh --since today

# Since specific time
journalctl -u nginx --since "2026-02-08 10:00:00"
```

---

### Command 14: View Only Errors

**Filter by priority (errors only):**

```bash
journalctl -u <service-name> -p err
```

**Example:**

```bash
journalctl -u nginx -p err
```

**Priority levels (from worst to least severe):**
- `emerg` - Emergency (0)
- `alert` - Alert (1)
- `crit` - Critical (2)
- `err` - Error (3)
- `warning` - Warning (4)
- `notice` - Notice (5)
- `info` - Info (6)
- `debug` - Debug (7)

**Common usage:**

```bash
# Show errors and warnings
journalctl -u myapp -p warning
```

---

### Command 15: Traditional Log Files (tail)

**Some logs still in text files at /var/log/**

```bash
tail -n 50 /var/log/syslog
```

**Follow a log file:**

```bash
tail -f /var/log/nginx/error.log
```

**View specific log file:**

```bash
# System log
tail -n 50 /var/log/syslog

# Nginx access log
tail -n 100 /var/log/nginx/access.log

# Nginx error log
tail -n 50 /var/log/nginx/error.log

# Apache logs
tail -n 50 /var/log/apache2/error.log
```

---

## 🎓 Part 4: Hands-On Example - Inspecting SSH Service

Let's inspect the **SSH service** step-by-step.

### Step 1: Check if SSH is Running

```bash
systemctl status ssh
```

**Look for:**
- Green dot and "active (running)" = Good! ✓
- Red dot and "failed" = Problem! ✗

---

### Step 2: View Recent SSH Logs

```bash
journalctl -u ssh -n 50
```

**What to look for:**
- `Accepted password` - Successful login
- `Failed password` - Failed login attempt
- `Connection closed` - User disconnected

---

### Step 3: Check for Failed Login Attempts

```bash
journalctl -u ssh | grep "Failed"
```

**Example output:**

```
Feb 08 09:15:23 server sshd[1234]: Failed password for invalid user admin from 192.168.1.200
Feb 08 09:20:45 server sshd[5678]: Failed password for root from 192.168.1.201
```

**This shows someone tried to login and failed!**

---

### Step 4: Watch Live SSH Activity

```bash
journalctl -u ssh -f
```

**Now try to SSH to your server from another terminal.**  
**You'll see the login attempt appear in real-time!**

---

### Step 5: Check SSH Errors Only

```bash
journalctl -u ssh -p err --since today
```

**If empty = No errors today! ✓**

---

### Step 6: Restart SSH (if needed)

```bash
sudo systemctl restart ssh
```

**Then check status again:**

```bash
systemctl status ssh
```

---

## 🔥 Part 5: Common Troubleshooting Workflows

### Problem: Service Won't Start

**Follow these steps:**

```bash
# Step 1: Try to start it
sudo systemctl start nginx

# Step 2: Check status
systemctl status nginx

# Step 3: Check logs for errors
journalctl -u nginx -n 50

# Step 4: Look for specific error messages
journalctl -u nginx -p err

# Step 5: Fix the issue (config file, permissions, etc.)

# Step 6: Restart
sudo systemctl restart nginx
```

---

### Problem: Service Keeps Failing

```bash
# Step 1: Check what's wrong
systemctl status myapp

# Step 2: View detailed logs
journalctl -u myapp -n 100

# Step 3: Check recent errors
journalctl -u myapp -p err --since "10 minutes ago"

# Step 4: Watch while restarting
journalctl -u myapp -f
# (in another terminal: sudo systemctl restart myapp)
```

---

### Problem: Web Server Not Responding

```bash
# Step 1: Is it running?
systemctl status nginx

# Step 2: Check error logs
journalctl -u nginx -p err

# Or traditional log file:
tail -n 50 /var/log/nginx/error.log

# Step 3: Check access logs
tail -n 50 /var/log/nginx/access.log

# Step 4: Restart if needed
sudo systemctl restart nginx
```

---

## 📋 Quick Reference Card

### Service Management

| Task | Command |
|------|---------|
| Check status | `systemctl status <service>` |
| Start service | `sudo systemctl start <service>` |
| Stop service | `sudo systemctl stop <service>` |
| Restart service | `sudo systemctl restart <service>` |
| Enable at boot | `sudo systemctl enable <service>` |
| Disable at boot | `sudo systemctl disable <service>` |
| List running | `systemctl list-units --type=service --state=running` |
| Find failed | `systemctl --failed` |

### Log Viewing

| Task | Command |
|------|---------|
| View logs | `journalctl -u <service>` |
| Last 50 lines | `journalctl -u <service> -n 50` |
| Follow live | `journalctl -u <service> -f` |
| Since 1 hour | `journalctl -u <service> --since "1 hour ago"` |
| Errors only | `journalctl -u <service> -p err` |
| Today's logs | `journalctl -u <service> --since today` |
| Text log file | `tail -n 50 /var/log/<logfile>` |
| Follow text log | `tail -f /var/log/<logfile>` |

---

## 💡 Pro Tips for Beginners

### 1. Always Check Status First

Before doing anything, check if service is running:

```bash
systemctl status <service>
```

---

### 2. Use -n to Limit Output

Don't overwhelm yourself with millions of log lines:

```bash
journalctl -u nginx -n 20  # Just last 20 lines
```

---

### 3. Grep is Your Friend

Search for specific words:

```bash
journalctl -u ssh | grep "Failed"
journalctl -u nginx | grep "error"
```

---

### 4. Restart is Safe

When in doubt, restart:

```bash
sudo systemctl restart <service>
```

It's like "turn it off and on again" - often fixes issues!

---

### 5. Check Logs After Restart

Always verify restart worked:

```bash
sudo systemctl restart nginx
systemctl status nginx
journalctl -u nginx -n 20
```

---

## 🎯 Practice Exercise

**Try this with SSH service:**

1. Check SSH status
2. View last 20 SSH logs
3. Follow SSH logs in real-time (open new terminal and SSH to server)
4. Check for any failed login attempts today
5. Restart SSH service
6. Verify it restarted successfully

**Commands:**

```bash
# 1. Status
systemctl status ssh

# 2. Last 20 logs
journalctl -u ssh -n 20

# 3. Follow logs
journalctl -u ssh -f

# 4. Failed logins
journalctl -u ssh --since today | grep "Failed"

# 5. Restart
sudo systemctl restart ssh

# 6. Verify
systemctl status ssh
```

---

## 🚀 Next Steps

Once comfortable with these basics:

1. Learn about **log rotation** (keeping logs from filling disk)
2. Explore **systemd timers** (like cron jobs)
3. Study **service dependencies** (services that need other services)
4. Practice **creating custom services**

---

## ❓ Common Questions

### Q: What if journalctl says "No entries"?

**A:** Either:
- Service hasn't logged anything yet
- You misspelled the service name
- Service isn't installed

**Check:** `systemctl list-units --type=service | grep <name>`

---

### Q: Do I always need sudo?

**A:** 
- ✅ Viewing logs/status: **No sudo needed**
- ⛔ Starting/stopping services: **Sudo required**

```bash
# No sudo needed
systemctl status nginx
journalctl -u nginx

# Sudo needed
sudo systemctl restart nginx
sudo systemctl enable nginx
```

---

### Q: How do I know what services are important?

**A:** Start with these:

- `ssh` - Remote access (important!)
- `nginx` or `apache2` - Web server
- `mysql` or `postgresql` - Database
- `docker` - If using containers
- `cron` - Scheduled tasks

---

### Q: What's the difference between systemctl and service?

**A:** 
- `systemctl` - **Modern** (systemd)
- `service` - **Old** (legacy)

**Use systemctl** on modern Linux systems (Ubuntu 16.04+, CentOS 7+, etc.)

---

## 📝 Summary

**You now know how to:**

✅ Check if a service is running (`systemctl status`)  
✅ Start, stop, restart services (`systemctl start/stop/restart`)  
✅ View service logs (`journalctl -u <service>`)  
✅ Follow logs in real-time (`journalctl -u <service> -f`)  
✅ Find errors in logs (`journalctl -p err`)  
✅ Troubleshoot basic service issues  

**Practice makes perfect!** Try these commands on your own system.

---

**Created for:** #90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham  
**Remember:** When in doubt, check the status and logs! 🚀