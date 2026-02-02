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
- uname -> unixname
Output:
```text
Linux ip-172-31-22-213 6.14.0-1018-aws #18~24.04.1-Ubuntu SMP Mon Nov 24 19:46:27 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
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
- Identifies Linux distribution and version.
- Important for Nginx package paths and service behavior.
---
## Filesystem Sanity
### Step 3: Basic Filesystem Check
#### Command
```bash
mkdir /tmp/runbook-nginx
cp /etc/hosts /tmp/runbook-nginx/hosts-copy
ls -l /tmp/runbook-nginx
```
Output:
```text
drwxrwxr-x 2 ubuntu ubuntu 4096 Jan 30 16:31 runbook-demo

127.0.0.1 localhost

total 4
-rw-r--r-- 1 ubuntu ubuntu 221 Jan 30 16:33 hosts-copy
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
Output:
```text
PID %CPU %MEM COMMAND
    623  0.0  0.1 nginx
    624  0.0  0.5 nginx
    625  0.0  0.5 nginx
```
### Interpretation
- Confirms Nginx worker processes are running.
- High CPU may indicate traffic spikes or stuck workers.

### Step 5: System Memory Status
#### Command
```bash
free -h
```
Output:
```text
Filesystem       Size  Used Avail Use% Mounted on
/dev/root        6.8G  1.8G  5.0G  27% /
tmpfs            458M     0  458M   0% /dev/shm
tmpfs            183M  888K  182M   1% /run
tmpfs            5.0M     0  5.0M   0% /run/lock
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
Output:
```text
Filesystem       Size  Used Avail Use% Mounted on
/dev/root        6.8G  2.3G  4.5G  34% /
tmpfs            458M     0  458M   0% /dev/shm
tmpfs            183M  876K  182M   1% /run
tmpfs            5.0M     0  5.0M   0% /run/lock
efivarfs         128K  3.8K  120K   4% /sys/firmware/efi/efivars
/dev/nvme0n1p16  881M   89M  730M  11% /boot
/dev/nvme0n1p15  105M  6.2M   99M   6% /boot/efi
tmpfs             92M   12K   92M   1% /run/user/1000
```
### Interpretation
- Ensures disks are not full.
- Full disks can prevent Nginx from writing logs or temp files.

### Step 7: Nginx Log Size Check
#### Command
```bash
du -sh /var/log/nginx
```
Output:
```text
20K     /var/log/nginx
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
```text
tcp   LISTEN 0      511               0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=625,fd=5),("nginx",pid=624,fd=5),("nginx",pid=623,fd=5))
tcp   LISTEN 0      511                  [::]:80           [::]:*    users:(("nginx",pid=625,fd=6),("nginx",pid=624,fd=6),("nginx",pid=623,fd=6))
```
### Interpretation
- Confirms Nginx is listening on expected ports (80/443).
- Missing listeners indicate service or config failure.

### Step 9: Local HTTP Check
#### Command
```bash
curl -I http://localhost
```
```text
HTTP/1.1 200 OK
Server: nginx/1.24.0 (Ubuntu)
Date: Mon, 02 Feb 2026 04:44:35 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Sun, 01 Feb 2026 18:02:11 GMT
Connection: keep-alive
ETag: "697f9523-267"
Accept-Ranges: bytes
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
Output:
```text
curl: (7) Failed to connect to 127.0.0.1 port 8080 after 0 ms: Couldn't connect to server
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
