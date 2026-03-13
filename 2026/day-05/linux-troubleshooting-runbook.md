# Linux Troubleshooting Runbook: Process Health Check

---

## Target Service Overview

**Service Name:** process_api  
**Process ID:** 1  
**Command:** `/process_api --addr 0.0.0.0:2024 --max-ws-buffer-size 32768 --cpu-shares 1024 --oom-polling-period-ms 100 --memory-limit-bytes 4294967296 --block-local-connections`  
**Port:** 2024  
**Purpose:** Process management API service

---

## Environment Basics

### Command 1: System Information
```bash
uname -a
```
**Output:**
```
Linux runsc 4.4.0 #1 SMP Sun Jan 10 15:06:54 PST 2016 x86_64 x86_64 x86_64 GNU/Linux
```
**Observation:** Running on Linux kernel 4.4.0, x86_64 architecture. System appears to be containerized (runsc - gVisor runtime).

---

### Command 2: OS Version Check
```bash
cat /etc/os-release
```
**Output:**
```
PRETTY_NAME="Ubuntu 24.04.3 LTS"
VERSION_ID="24.04"
VERSION_CODENAME=noble
```
**Observation:** Ubuntu 24.04.3 LTS (Noble Numbat) - Long Term Support version, current and stable.

---

##  Filesystem Sanity Checks

### Command 3: Test Directory Creation & File Operations
```bash
mkdir -p /tmp/runbook-demo && \
echo "Runbook test file created at $(date)" > /tmp/runbook-demo/test.txt && \
cp /etc/hosts /tmp/runbook-demo/hosts-copy && \
ls -lh /tmp/runbook-demo/
```
**Output:**
```
total 1.0K
-rwxr-xr-x 1 root root 98 Jan 31 19:41 hosts-copy
-rw-r--r-- 1 root root 58 Jan 31 19:41 test.txt
```
**Observation:** Filesystem write operations working correctly. No permission issues. Files created successfully with proper timestamps.

---

### Command 4: Verify File Content
```bash
cat /tmp/runbook-demo/test.txt
```
**Output:**
```
Runbook test file created at Sat Jan 31 19:41:33 UTC 2026
```
**Observation:**  File content persisted correctly. No data corruption detected.

---

##  CPU & Memory Snapshot

### Command 5: Process-Specific Resource Usage
```bash
ps -o pid,pcpu,pmem,comm -p 1
```
**Output:**
```
  PID %CPU %MEM COMMAND
    1  2.5  0.1 process_api
```
**Observation:** Process is consuming 2.5% CPU and 0.1% memory - normal idle state. No CPU spikes observed.

---

### Command 6: System-Wide Memory Usage
```bash
free -h
```
**Output:**
```
               total        used        free      shared  buff/cache   available
Mem:           9.0Gi        13Mi       9.0Gi          0B       8.2Mi       9.0Gi
Swap:             0B          0B          0B
```
**Observation:**  Excellent memory health. Only 13MB used out of 9GB. No swap configured (containerized environment). 99% memory available.

---

### Command 7: Top Process Overview
```bash
top -b -n 1 | head -20
```
**Output:**
```
top - 19:41:52 up 0 min,  0 user,  load average: 0.00, 0.00, 0.00
Tasks:   4 total,   1 running,   3 sleeping,   0 stopped,   0 zombie
%Cpu(s):   0.0 us,   0.0 sy,   0.0 ni, 100.0 id,   0.0 wa,   0.0 hi,   0.0 si
MiB Mem :   9216.0 total,   9200.0 free,     16.0 used,      8.6 buff/cache

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    1 root      20   0  487844  22916      0 S  10.0   0.2   0:00.72 process_api
```
**Observation:** System just booted (0 min uptime). Load average 0.00 indicates no stress. CPU 100% idle. Only 4 total tasks running - minimal overhead.

---

### Command 8: System Load & Uptime
```bash
uptime
```
**Output:**
```
19:42:33 up 1 min,  0 user,  load average: 0.00, 0.00, 0.00
```
**Observation:**  System freshly started. Load averages all at 0.00 (1min, 5min, 15min) - no load stress.

---

##  Disk & I/O Snapshot

### Command 9: Disk Space Usage
```bash
df -h
```
**Output:**
```
Filesystem      Size  Used Avail Use% Mounted on
none            9.9G  2.2M  9.9G   1% /
none            315G     0  315G   0% /dev
none            1.0P     0  1.0P   0% /mnt/transcripts
```
**Observation:**  Excellent disk health. Root filesystem only 1% used (2.2MB of 9.9GB). All critical partitions have abundant space.

---

### Command 10: Log Directory Size
```bash
du -sh /var/log
```
**Output:**
```
967K    /var/log
```
**Observation:**  Log directory consuming less than 1MB. No log accumulation issues. System logs are healthy and not filling disk.

---

## Network Snapshot

### Command 11: TCP Connections
```bash
cat /proc/net/tcp | head -10
```
**Output:**
```
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode
   3: 00000000:07E8 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0        4
  87: 08000015:07E8 5E03040A:EB48 01 00000000:00000000 00:00000000 00000000     0        0       88
```
**Observation:** Port 0x07E8 (2024 decimal) is listening (state 0A = LISTEN). One established connection detected. No queue backlogs.

---

### Command 12: Service Endpoint Test
```bash
curl -I http://127.0.0.1:2024 --max-time 5
```
**Output:**
```
curl: (56) Recv failure: Connection reset by peer
```
**Observation:**  HTTP connection to process_api port 2024 is being reset. Service may be using WebSocket protocol instead of HTTP, or authentication is required. This is expected behavior based on the --block-local-connections flag.

---

##  Logs Reviewed

### Command 13: System Package Logs
```bash
tail -n 50 /var/log/dpkg.log | head -30
```
**Output:**
```
2025-11-21 01:59:15 status installed glib-networking:amd64 2.80.0-1build1
2025-11-21 01:59:15 status installed libsoup-3.0-0:amd64 3.4.4-5ubuntu0.5
[... additional package installation logs ...]
```
**Observation:** Last package operations were successful installations on 2025-11-21. No package failures or dpkg errors. System packages are stable.

---

### Command 14: Kernel Messages
```bash
dmesg | tail -50
```
**Output:**
```
[    0.000000] Starting gVisor...
[    0.570863] Checking naughty and nice process list...
[    3.070288] Ready!
```
**Observation:**  Clean boot sequence. gVisor container runtime initialized successfully. No kernel panics, OOM kills, or hardware errors. System is "Ready!"

---

##  Findings Summary

###  Healthy Indicators:
1. **CPU Usage:** 2.5% - well within normal range
2. **Memory Usage:** 0.1% (13MB/9GB) - excellent
3. **Disk Space:** 1% utilization on root - no space concerns
4. **Load Average:** 0.00 across all intervals - no system stress
5. **Logs:** Clean, no errors 
6. **Filesystem:** Read/write operations functioning correctly

###  Health Status: **HEALTHY** 

**Overall Assessment:** The process_api service is running normally with excellent resource utilization. All critical subsystems (CPU, memory, disk, logs) show healthy metrics. The network connection reset is likely intentional based on service configuration.

---

##  Escalation Steps

### Step 1: Increase Monitoring Granularity
**If CPU spikes above 80% or memory above 50%:**
```bash
# Monitor process in real-time
watch -n 1 'ps -o pid,pcpu,pmem,rss,vsz,cmd -p 1'

# Check for memory leaks
cat /proc/1/status | grep -i mem

# Monitor file descriptors (potential leak indicator)
ls -la /proc/1/fd | wc -l

# Check thread count
ps -o nlwp -p 1
```

---

### Step 2: Enable Detailed Process Tracing
**If service becomes unresponsive or behavior is abnormal:**
```bash
# Capture system calls (if strace available)
strace -p 1 -f -e trace=network,file -o /tmp/process_api.strace

# Check for blocked I/O
cat /proc/1/stack

# Monitor process state changes
while true; do ps -o pid,state,wchan -p 1; sleep 1; done
```

---

### Step 3: Log Analysis & Service Restart Strategy
**If errors appear in logs or service is degraded:**
```bash
# Create full diagnostic snapshot before restart
mkdir -p /tmp/incident-$(date +%Y%m%d-%H%M%S)
cp /var/log/* /tmp/incident-$(date +%Y%m%d-%H%M%S)/ 2>/dev/null
ps aux > /tmp/incident-$(date +%Y%m%d-%H%M%S)/processes.txt
free -h > /tmp/incident-$(date +%Y%m%d-%H%M%S)/memory.txt
df -h > /tmp/incident-$(date +%Y%m%d-%H%M%S)/disk.txt

# Capture last-known-good state
cat /proc/1/cmdline > /tmp/incident-$(date +%Y%m%d-%H%M%S)/cmdline.txt
cat /proc/1/environ > /tmp/incident-$(date +%Y%m%d-%H%M%S)/environ.txt

# If using systemd (not available here but included for reference):
# systemctl restart process-api
# journalctl -u process-api -n 100 --no-pager

# Alternative: Send SIGTERM for graceful shutdown (if restart needed)
kill -15 1  # Graceful termination
# Note: In this container, PID 1 restart would restart the container
```

---

### Step 4: Advanced Diagnostics
**If issue persists after restart:**
```bash
# Check for network port conflicts
cat /proc/net/tcp | grep 07E8  # 2024 in hex

# Verify service can bind to port
# (This would require restarting the service to test)

# Check resource limits
cat /proc/1/limits

# Monitor I/O operations
cat /proc/1/io

# Check memory maps for shared library issues
cat /proc/1/maps | grep -E '(so|lib)'
```

---

### Step 5: Incident Documentation & Escalation
**If all troubleshooting fails:**

1. **Document the incident:**
   - Time of initial detection
   - All commands run and outputs captured
   - Snapshot directory location: `/tmp/incident-YYYYMMDD-HHMMSS/`

2. **Escalate to:**
   - Platform team (if infrastructure issue)
   - Application team (if service-specific issue)
   - Security team (if signs of compromise)

3. **Provide artifacts:**
   - Complete `/tmp/incident-*` directory
   - Timeline of events
   - Impact assessment (users affected, data loss, etc.)

---

---

##  Runbook Maintenance

**Last Updated:** 2026-01-31  
**Next Review:** 2026-02-07 (weekly review recommended)  
**Owner:** Rameez Ahmed

**Change Log:**
- 2026-01-31: Initial runbook creation based on process_api health check drill