# Nginx Troubleshooting Runbook

## Issue
Web application is unreachable or returning **502 / 504 / connection refused** errors through Nginx.

## Objective
Identify whether the issue is caused by Nginx configuration, service state, networking, or upstream application failure.

## Target Service / Process
**Service:** nginx  
**Role:** Reverse proxy / web server  
**Host:** Production Linux server

---

## Environment Basics

### Step 1: Kernel & Architecture

#### Command
```bash
uname -a
```
### Interpretation
- Confirms kernel version and architecture.
- Useful for OS-specific networking or file descriptor issues.

### Step 2: OS Distribution
#### Command
```bash
cat /etc/os-release
```
### Interpretation
Identifies Linux distribution and version.
Important for Nginx package paths and service behavior.
---
## Filesystem Sanity
### Step 3: Basic Filesystem Check
#### Command
```bash
mkdir /tmp/runbook-nginx
cp /etc/hosts /tmp/runbook-nginx/hosts-copy
ls -l /tmp/runbook-nginx
```
### Interpretation
- Confirms filesystem is writable.
- Rules out read-only mounts affecting logs or PID files.
---
## Snapshot: CPU & Memory
### Step 4: Nginx Process Resource Usage
### Command
```bash
ps -o pid,pcpu,pmem,comm -C nginx
```
### Interpretation
- Confirms Nginx worker processes are running.
- High CPU may indicate traffic spikes or stuck workers.

## Snapshot: CPU & Memory
### Step 4: Nginx Process Resource Usage
#### Command
```bash
ps -o pid,pcpu,pmem,comm -C nginx
```
### Interpretation
- Confirms Nginx worker processes are running.
- High CPU may indicate traffic spikes or stuck workers.

### Step 5: System Memory Status
#### Command
```bash
free -h
```
### Interpretation
- Confirms available memory.
- Low memory can cause worker crashes or request drops.

## Snapshot: Disk & IO
### Step 6: Disk Space Check
#### Command
```bash
df -h
```
### Interpretation
- Ensures disks are not full.
- Full disks can prevent Nginx from writing logs or temp files.

### Step 7: Nginx Log Size Check
#### Command
```bash
du -sh /var/log/nginx
```
### Interpretation
- Detects uncontrolled log growth.
- Prevents disk exhaustion caused by excessive logging.

## Snapshot: Network
### Step 8: Nginx Listening Ports
####Command
```bash
sudo ss -tulpn | grep nginx
```
### Interpretation
- Confirms Nginx is listening on expected ports (80/443).
- Missing listeners indicate service or config failure.

### Step 9: Local HTTP Check
#### Command
```bash
curl -I http://localhost
```
### Interpretation
- HTTP 200/301 confirms Nginx responds locally.
- Failure indicates Nginx is down or misconfigured.

## Upstream / Backend Check
### Step 10: Check Upstream Application Connectivity
#### Command
```bash
curl -I http://127.0.0.1:8080
```
### Interpretation
- Verifies backend application is reachable.
- If this fails but Nginx is up → upstream issue (common cause of 502).

## Logs Reviewed
### Step 11: Nginx Error Logs
#### Command
```bash
tail -n 20 /var/log/nginx/error.log
```
### Interpretation
- Shows configuration errors, upstream failures, or permission issues.
- Look for connect() failed, no live upstreams, or permission denied.

### Step 12: Nginx Access Logs
#### Command
```bash
tail -n 20 /var/log/nginx/access.log
```
### Interpretation
- Confirms incoming requests are reaching Nginx.
- 502/504 responses confirm backend issues.

## Configuration Validation
### Step 13: Nginx Config Test
#### Command
```bash
nginx -t
```
### Interpretation
- Validates Nginx configuration syntax.
- Prevents reload failures due to misconfiguration.

---
Quick Findings
- Nginx is running and listening on expected ports
- Backend connectivity determines 502/504 errors
- No disk or memory pressure detected
- Errors point to upstream application instability

---
## If This Worsens (Next Steps)

### 1. Restart strategy
        - Reload Nginx config: nginx -s reload
        - Restart service if workers are stuck
### 2. Increase visibility
        - Temporarily increase error log level to debug
        - Enable upstream timing logs

### 3. Deep diagnostics
        - Capture strace on Nginx worker
        - Investigate backend service health and latency
---
## Notes
- Never reload Nginx without nginx -t
- Treat 502/504 as upstream issues first
- Keep this runbook updated after incidents
