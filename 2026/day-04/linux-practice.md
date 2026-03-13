# Day 04 – Linux Practice: Processes and Services

##  Today's Mission
Practice Linux fundamentals by running actual commands and understanding what they show you. This is **hands-on learning** - no theory, just doing!

---

##  Part 1: Process Checks

### Command 1: `ps aux` - List All Running Processes

**What I ran:**
```bash
ps aux | head -20
```

**What it does:**
- `ps aux` = Show all processes from all users
- `a` = Show processes for all users
- `u` = Display user-oriented format
- `x` = Include processes without a terminal

**Real Output:**
```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1 13.7  0.1 352336 17552 ?        Ssl  18:39   0:00 /process_api
root        11 25.0  0.0  10848  2988 ?        S    18:39   0:00 /bin/sh
root        12 66.6  0.0  15996  8132 ?        R    18:39   0:00 ps aux
```

**What I learned:**
- **PID** = Process ID (unique identifier)
- **%CPU** = CPU usage percentage
- **%MEM** = Memory usage percentage
- **STAT** = Process state (R=Running, S=Sleeping, Z=Zombie)
- **TIME** = Total CPU time used
- PID 1 is always the init process (systemd on most systems)

---

### Command 2: `ps -ef` - Show Parent-Child Relationships

**What I ran:**
```bash
ps -ef | head -15
```

**What it does:**
- Shows every process with PPID (Parent Process ID)
- Helps understand which process started which

**Real Output:**
```
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  1 18:39 ?        00:00:00 /process_api
root        27     1 33 18:40 ?        00:00:00 /bin/sh -c ps -ef
root        28    27 50 18:40 ?        00:00:00 ps -ef
```

**What I learned:**
- **PPID** = Parent Process ID
- Process 1 has PPID 0 (it's the root of the process tree)
- Process 28 (ps) was started by process 27 (shell)
- Everything traces back to PID 1

---

### Command 3: `pgrep` - Find Process by Name

**What I ran:**
```bash
pgrep -l ssh
pgrep -l cron
pgrep -l process
```

**What it does:**
- Searches for processes by name
- `-l` flag shows both PID and name

**Real Output:**
```
1 process_api
```

**What I learned:**
- Much easier than using `ps aux | grep`
- Returns just the PID (useful for scripting)
- With `-l` flag, also shows the process name

**Useful variations:**
```bash
pgrep -u root        # Find processes owned by root
pgrep -c nginx       # Count how many nginx processes
pkill -9 nginx       # Kill all nginx processes (dangerous!)
```

---

### Command 4: `top` - Real-Time Process Monitor

**What I ran:**
```bash
top -b -n 1 | head -20
```

**What it does:**
- Shows processes in real-time (like Task Manager on Windows)
- `-b` = Batch mode (for capturing output)
- `-n 1` = Run only 1 iteration

**Real Output:**
```
top - 18:40:12 up 0 min,  0 user,  load average: 0.00, 0.00, 0.00
Tasks:   4 total,   1 running,   3 sleeping,   0 stopped,   0 zombie
%Cpu(s):   0.0 us,   0.0 sy,   0.0 ni, 100.0 id,   0.0 wa,   0.0 hi
MiB Mem :   9216.0 total,   9186.8 free,     29.2 used
MiB Swap:      0.0 total,      0.0 free,      0.0 used

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    1 root      20   0  352868  18460      0 S  30.0   0.2   0:00.41 process_a
```

**What I learned:**
- **Load average**: System load over last 1, 5, 15 minutes
- **Tasks**: Total processes and their states
- **%Cpu(s)**: us=user, sy=system, id=idle, wa=waiting for I/O
- **Memory**: Total, free, used RAM
- Press `q` to quit top in interactive mode
- Press `h` for help in interactive mode

**Pro Tips:**
```bash
top                  # Interactive mode
htop                 # Better visual interface (needs install)
top -u username      # Show processes for specific user
```

---

##  Part 2: Service Checks (systemd)

### Command 5: `systemctl status` - Check Service Status

**What I ran:**
```bash
systemctl status ssh
systemctl status docker
systemctl status nginx
```

**Example Output (SSH service):**
```
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2026-01-28 10:15:23 UTC; 2h 15min ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 1234 (sshd)
      Tasks: 1 (limit: 4915)
     Memory: 2.5M
        CPU: 45ms
     CGroup: /system.slice/ssh.service
             └─1234 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

Jan 28 10:15:23 server systemd[1]: Starting OpenBSD Secure Shell server...
Jan 28 10:15:23 server sshd[1234]: Server listening on 0.0.0.0 port 22.
Jan 28 10:15:23 server systemd[1]: Started OpenBSD Secure Shell server.
```

**What I learned:**
- **Loaded**: Where the service file is located and if it's enabled
- **Active**: Current state (running, stopped, failed)
- **Main PID**: The main process ID for this service
- **Tasks**: Number of tasks/threads
- **Memory/CPU**: Resource usage
- **CGroup**: Process hierarchy
- Recent log entries shown at bottom

---

### Command 6: `systemctl list-units` - List All Services

**What I ran:**
```bash
systemctl list-units --type=service --state=running
systemctl list-units --type=service --state=failed
systemctl list-units --type=service
```

**Example Output (Running Services):**
```
UNIT                               LOAD   ACTIVE SUB     DESCRIPTION
accounts-daemon.service            loaded active running Accounts Service
cron.service                       loaded active running Regular background program
dbus.service                       loaded active running D-Bus System Message Bus
docker.service                     loaded active running Docker Application Container
networkd-dispatcher.service        loaded active running Dispatcher daemon for systemd
ssh.service                        loaded active running OpenBSD Secure Shell server
systemd-journald.service           loaded active running Journal Service
systemd-logind.service             loaded active running Login Service
```

**What I learned:**
- `LOAD` = Whether systemd loaded the unit file
- `ACTIVE` = Current state
- `SUB` = More detailed state
- Easy way to see what's running on your system
- Can filter by state (running, failed, dead)

**Useful commands:**
```bash
systemctl list-units --type=service --state=failed    # Find broken services
systemctl list-units --all                            # Show everything
systemctl list-unit-files --type=service              # All service files
```

---

### Command 7: Service Management Commands

**What I ran (for practice):**
```bash
# Check if a service is enabled (starts on boot)
systemctl is-enabled ssh

# Check if a service is active
systemctl is-active ssh

# Enable a service (start on boot)
sudo systemctl enable docker

# Disable a service
sudo systemctl disable nginx

# Start a service
sudo systemctl start nginx

# Stop a service
sudo systemctl stop nginx

# Restart a service
sudo systemctl restart nginx

# Reload configuration without restarting
sudo systemctl reload nginx
```

**What I learned:**
- `enable/disable` = Controls boot behavior (doesn't start/stop now)
- `start/stop` = Controls current state (doesn't affect boot)
- `restart` = Stop then start (brief downtime)
- `reload` = Reload config without downtime (if supported)
- Need `sudo` for most service management commands

---

##  Part 3: Log Checks

### Command 8: `journalctl` - View System Logs

**What I ran:**
```bash
# View logs for SSH service
journalctl -u ssh

# View last 50 lines
journalctl -u ssh -n 50

# Follow logs in real-time (like tail -f)
journalctl -u ssh -f

# View logs since today
journalctl -u ssh --since today

# View logs from specific time
journalctl -u ssh --since "2026-01-28 10:00:00"

# View logs between times
journalctl -u ssh --since "10:00" --until "11:00"
```

**Example Output:**
```
Jan 28 10:15:23 server systemd[1]: Starting OpenBSD Secure Shell server...
Jan 28 10:15:23 server sshd[1234]: Server listening on 0.0.0.0 port 22.
Jan 28 10:15:23 server sshd[1234]: Server listening on :: port 22.
Jan 28 10:15:23 server systemd[1]: Started OpenBSD Secure Shell server.
Jan 28 12:30:45 server sshd[5678]: Accepted publickey for admin from 192.168.1.100
Jan 28 12:30:45 server sshd[5678]: pam_unix(sshd:session): session opened for user admin
```

**What I learned:**
- `journalctl` is systemd's log viewer
- `-u` flag specifies which service
- `-n` shows last N lines
- `-f` follows logs in real-time (Ctrl+C to stop)
- `--since` and `--until` for time filtering
- Logs are stored in binary format (not plain text files)

**Useful options:**
```bash
journalctl -p err                    # Only errors
journalctl -p warning                # Warnings and above
journalctl -b                        # Logs since last boot
journalctl -b -1                     # Logs from previous boot
journalctl --disk-usage              # How much space logs use
journalctl --vacuum-time=2weeks      # Clean old logs
```

---

### Command 9: `tail` - View Traditional Log Files

**What I ran:**
```bash
# View last 50 lines of auth log
sudo tail -n 50 /var/log/auth.log

# Follow log file in real-time
sudo tail -f /var/log/syslog

# View last 100 lines of nginx access log
sudo tail -n 100 /var/log/nginx/access.log

# View last 50 lines of nginx error log
sudo tail -n 50 /var/log/nginx/error.log
```

**Example Output (auth.log):**
```
Jan 28 12:30:45 server sshd[5678]: Accepted publickey for admin from 192.168.1.100
Jan 28 12:30:45 server sshd[5678]: pam_unix(sshd:session): session opened for user admin
Jan 28 12:45:12 server sudo: admin : TTY=pts/0 ; PWD=/home/admin ; USER=root ; COMMAND=/bin/systemctl status nginx
Jan 28 12:45:12 server sudo: pam_unix(sudo:session): session opened for user root
```

**What I learned:**
- Traditional log files are in `/var/log/`
- `tail -f` is invaluable for watching logs live
- Different services have different log files
- Need `sudo` to read most log files
- Press Ctrl+C to stop following

**Common log locations:**
```
/var/log/syslog         # General system log
/var/log/auth.log       # Authentication logs
/var/log/kern.log       # Kernel logs
/var/log/dmesg          # Boot messages
/var/log/nginx/         # Nginx logs
/var/log/apache2/       # Apache logs
/var/log/mysql/         # MySQL logs
```

---

##  Part 4: Mini Troubleshooting Example

### Scenario: Docker Service Won't Start

**Step 1: Check if Docker is running**
```bash
systemctl status docker
```

**Output shows:**
```
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled)
     Active: failed (Result: exit-code) since Wed 2026-01-28 14:30:12 UTC
     Process: 3456 ExecStart=/usr/bin/dockerd (code=exited, status=1/FAILURE)
```

**Problem identified:** Service is `failed`

---

**Step 2: Check the logs**
```bash
journalctl -u docker -n 50
```

**Output shows:**
```
Jan 28 14:30:12 server dockerd[3456]: failed to start daemon: error initializing graphdriver: 
Jan 28 14:30:12 server dockerd[3456]: driver not supported
Jan 28 14:30:12 server systemd[1]: docker.service: Main process exited, code=exited, status=1/FAILURE
Jan 28 14:30:12 server systemd[1]: docker.service: Failed with result 'exit-code'.
```

**Problem identified:** Issue with storage driver

---

**Step 3: Check Docker process**
```bash
pgrep -l docker
```

**Output:**
```
(no output - process not running)
```

---

**Step 4: Check configuration file**
```bash
sudo cat /etc/docker/daemon.json
```

**Found the issue:** Misconfigured storage driver

---

**Step 5: Fix the configuration**
```bash
sudo nano /etc/docker/daemon.json
# Fix the config
```

---

**Step 6: Reload and restart**
```bash
sudo systemctl daemon-reload
sudo systemctl start docker
```

---

**Step 7: Verify it's working**
```bash
systemctl status docker
```

**Output:**
```
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled)
     Active: active (running) since Wed 2026-01-28 14:35:45 UTC
```

**Success!** 

---

##  What I Learned Today

### Process Management
1. `ps aux` shows all processes with resource usage
2. `ps -ef` shows parent-child relationships (PPID)
3. `pgrep` is the easiest way to find processes by name
4. `top` gives real-time view of system resources

### Service Management
5. `systemctl status` shows detailed service information
6. `systemctl list-units` shows all running services
7. Always use `sudo` for starting/stopping services
8. `enable` ≠ `start` (boot vs now)

### Log Investigation
9. `journalctl -u <service>` for systemd service logs
10. `tail -f` for real-time log monitoring
11. Logs are your best friend when troubleshooting

### Troubleshooting Workflow
1. Check status first (`systemctl status`)
2. Read the logs (`journalctl -u`)
3. Look for error messages
4. Check configuration files
5. Make changes
6. Reload and restart
7. Verify it worked

---

##  My Personal Cheat Sheet

### Quick Process Checks
```bash
ps aux | grep <name>              # Find specific process
pgrep -l <name>                   # Simpler way to find process
top                               # Interactive process viewer
kill <PID>                        # Stop a process
kill -9 <PID>                     # Force kill (last resort)
```

### Quick Service Checks
```bash
systemctl status <service>        # Check service status
systemctl start <service>         # Start service
systemctl stop <service>          # Stop service
systemctl restart <service>       # Restart service
systemctl enable <service>        # Start on boot
systemctl disable <service>       # Don't start on boot
```

### Quick Log Checks
```bash
journalctl -u <service>           # View service logs
journalctl -u <service> -f        # Follow logs live
journalctl -u <service> -n 50     # Last 50 lines
tail -f /var/log/syslog           # Follow system log
tail -n 100 /var/log/auth.log     # Last 100 auth events
```

---


## Additional Commands I Want to Remember

```bash
# See all failed services
systemctl --failed

# See service dependencies
systemctl list-dependencies <service>

# Show service configuration
systemctl show <service>

# Check system boot time
systemd-analyze

# Find which services slow down boot
systemd-analyze blame

# Watch logs for multiple services
journalctl -u service1 -u service2 -f

# Get help on any command
man ps
man systemctl
man journalctl
```

---

**Date Practices:** January 28, 2026  
**Time Spent:** 2 hours  
**Feeling:** More confident with Linux fundamentals.

