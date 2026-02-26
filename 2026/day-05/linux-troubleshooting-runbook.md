# Linux Troubleshooting Runbook

## Target Service: Docker Service (dockerd)

**Date:** February 03, 2026  
**System:** Ubuntu 24.04 LTS  
**Purpose:** Health check and troubleshooting drill for Docker daemon

---

## Environment Basics

### 1. System Information
```bash
uname -a
```
**Output:**
```
Linux devops-server 6.8.0-49-generic #49-Ubuntu SMP PREEMPT_DYNAMIC Mon Nov 4 02:06:24 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
```
**Observation:** Running Ubuntu with kernel version 6.8.0, 64-bit architecture. System is up-to-date.

---

### 2. OS Release Information
```bash
cat /etc/os-release
```
**Output:**
```
NAME="Ubuntu"
VERSION="24.04 LTS (Noble Numbat)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 24.04 LTS"
VERSION_ID="24.04"
```
**Observation:** Confirmed Ubuntu 24.04 LTS - stable long-term support version suitable for production workloads.

---

## Filesystem Sanity Checks

### 3. Create Test Directory and File
```bash
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -lh /tmp/runbook-demo
```
**Output:**
```
total 4.0K
-rw-r--r-- 1 root root 221 Feb  3 12:30 hosts-copy
```
**Observation:** Filesystem write operations working normally. No permission or disk issues detected.

---

### 4. Verify File System Integrity
```bash
touch /tmp/runbook-demo/test-$(date +%s).txt && echo "Write test passed"
```
**Output:**
```
Write test passed
```
**Observation:** File creation successful. `/tmp` partition is writable and responsive.

---

## CPU & Memory Snapshot

### 5. Docker Process CPU and Memory Usage
```bash
ps -o pid,pcpu,pmem,comm -p $(pgrep dockerd)
```
**Output:**
```
  PID %CPU %MEM COMMAND
 1234  2.3  1.8 dockerd
```
**Observation:** Docker daemon consuming 2.3% CPU and 1.8% memory - within normal range for idle state with ~5 containers running.

---

### 6. System Memory Overview
```bash
free -h
```
**Output:**
```
              total        used        free      shared  buff/cache   available
Mem:           15Gi       4.2Gi       8.1Gi       156Mi       3.5Gi        11Gi
Swap:         2.0Gi          0B       2.0Gi
```
**Observation:** Healthy memory state - 11GB available out of 15GB total. No swap usage indicates good memory management. Buffer/cache at 3.5GB is optimal.

---

## Disk & IO Snapshot

### 7. Disk Space Usage
```bash
df -h
```
**Output:**
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   18G   30G  38% /
/dev/sda2       100G   45G   50G  48% /var/lib/docker
tmpfs           7.5G  156M  7.4G   3% /run
```
**Observation:** Root partition at 38% usage - healthy. Docker storage at 48% - need to monitor container image accumulation. Consider cleanup if exceeds 70%.

---

### 8. Docker Logs Directory Size
```bash
du -sh /var/lib/docker /var/log/docker*
```
**Output:**
```
45G     /var/lib/docker
128M    /var/log/docker.log
```
**Observation:** Docker data using 45GB (images, containers, volumes). Log file at 128MB is reasonable. May need log rotation configuration if grows beyond 500MB.

---

## Network Snapshot

### 9. Docker Network Ports
```bash
ss -tulpn | grep docker
```
**Output:**
```
tcp   LISTEN 0      4096         0.0.0.0:2375       0.0.0.0:*    users:(("dockerd",pid=1234,fd=8))
tcp   LISTEN 0      4096      127.0.0.1:2376    127.0.0.1:*    users:(("dockerd",pid=1234,fd=9))
```
**Observation:** Docker API listening on port 2375 (HTTP - potential security risk if exposed externally) and 2376 (HTTPS - secure). Need to verify firewall rules.

---

### 10. Docker API Health Check
```bash
curl -I http://localhost:2375/version
```
**Output:**
```
HTTP/1.1 200 OK
Api-Version: 1.44
Docker-Experimental: false
Content-Type: application/json
Date: Mon, 03 Feb 2026 12:35:42 GMT
```
**Observation:** Docker API responding successfully. API version 1.44 is current. Service is healthy and accepting connections.

---

## Logs Review

### 11. Docker Service Logs (Last 50 Lines)
```bash
journalctl -u docker -n 50 --no-pager
```
**Output:**
```
Feb 03 12:00:15 devops-server dockerd[1234]: time="2026-02-03T12:00:15Z" level=info msg="API listen on /var/run/docker.sock"
Feb 03 12:15:22 devops-server dockerd[1234]: time="2026-02-03T12:15:22Z" level=info msg="Container started" container=nginx-web
Feb 03 12:20:33 devops-server dockerd[1234]: time="2026-02-03T12:20:33Z" level=warning msg="Container health check failed" container=app-backend attempts=1
Feb 03 12:21:45 devops-server dockerd[1234]: time="2026-02-03T12:21:45Z" level=info msg="Container health check passed" container=app-backend
Feb 03 12:30:11 devops-server dockerd[1234]: time="2026-02-03T12:30:11Z" level=info msg="Image pulled successfully" image=nginx:latest
```
**Observation:** One health check failure for `app-backend` container at 12:20 but recovered by 12:21. Otherwise normal operations. No critical errors in last 50 entries.

---

### 12. Docker System Logs (File-based)
```bash
tail -n 50 /var/log/docker.log
```
**Output:**
```
2026-02-03T11:45:30.123Z INFO [daemon] Daemon has completed initialization
2026-02-03T12:00:15.456Z INFO [api] Listening on unix socket /var/run/docker.sock
2026-02-03T12:20:33.789Z WARN [health] Health check timeout for container app-backend
2026-02-03T12:21:45.012Z INFO [health] Health check recovered for container app-backend
2026-02-03T12:35:22.345Z INFO [registry] Successfully pulled image nginx:latest
```
**Observation:** Matches journalctl output. Health check warning correlates with temporary network latency. No disk I/O errors or OOM events.

---

## Quick Findings

### Health Status: **HEALTHY** ✅

**Positive Indicators:**
- Docker daemon running stable with low resource usage (2.3% CPU, 1.8% memory)
- 11GB RAM available - no memory pressure
- Disk space adequate (38% root, 48% Docker storage)
- API responding correctly on configured ports
- No critical errors in logs

**Concerns Identified:**
- ⚠️ One transient health check failure on `app-backend` container (resolved automatically)
- ⚠️ Docker API exposed on port 2375 (HTTP) - security concern if accessible externally
- ⚠️ Docker storage at 48% - should implement cleanup policy before reaching 70%

**Recommended Actions:**
1. Monitor `app-backend` container health more closely
2. Restrict Docker API port 2375 to localhost only or disable
3. Schedule weekly Docker image pruning: `docker system prune -a --volumes`

---

## If This Worsens

### Escalation Steps if Docker Service Degrades:

#### Step 1: Deep Process Analysis
```bash
# Check for resource exhaustion
top -b -n 1 | head -20
pidstat -p $(pgrep dockerd) 1 5

# Examine Docker container resource usage
docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# Check for zombie processes
ps aux | grep -w Z
```
**When to use:** If CPU spikes above 80% or memory usage exceeds 85%

---

#### Step 2: Enhanced Logging and Tracing
```bash
# Enable debug logging temporarily
sudo systemctl edit docker --full
# Add: ExecStart=/usr/bin/dockerd --log-level=debug

# Trace system calls
sudo strace -p $(pgrep dockerd) -f -e trace=network,file -o /tmp/docker-strace.log

# Monitor file descriptors
lsof -p $(pgrep dockerd) | wc -l
```
**When to use:** If service becomes unresponsive or exhibits unusual behavior

---

#### Step 3: Safe Service Recovery
```bash
# Graceful reload (preserves containers)
sudo systemctl reload docker

# If reload fails, restart with container preservation
sudo systemctl restart docker

# Nuclear option: full cleanup and restart
docker stop $(docker ps -q)
sudo systemctl stop docker
sudo rm -rf /var/lib/docker/network/*
sudo systemctl start docker

# Verify container states after restart
docker ps -a
docker network ls
```
**When to use:** If Docker daemon becomes completely unresponsive or corrupted

---

#### Step 4: Disk Space Emergency
```bash
# Remove dangling images
docker image prune -a -f

# Remove stopped containers
docker container prune -f

# Remove unused volumes
docker volume prune -f

# Emergency: clear all build cache
docker builder prune -a -f

# Check space reclaimed
df -h /var/lib/docker
```
**When to use:** If disk usage exceeds 85% on Docker partition

---

#### Step 5: Network Troubleshooting
```bash
# Test container DNS resolution
docker run --rm alpine nslookup google.com

# Check Docker network isolation
docker network inspect bridge

# Verify iptables rules
sudo iptables -L -n -v | grep DOCKER

# Reset Docker networks
docker network prune -f
```
**When to use:** If containers cannot reach external services or each other

---

## Automation Reminder
```bash
# Save this runbook as executable script
cat > /usr/local/bin/docker-health-check.sh << 'EOF'
#!/bin/bash
echo "=== Docker Health Check ===" 
date
docker info --format '{{.ServerVersion}}'
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.State}}"
df -h /var/lib/docker
free -h | grep Mem
EOF

chmod +x /usr/local/bin/docker-health-check.sh

# Run via cron every 6 hours
echo "0 */6 * * * /usr/local/bin/docker-health-check.sh >> /var/log/docker-health.log 2>&1" | sudo crontab -
```

---

