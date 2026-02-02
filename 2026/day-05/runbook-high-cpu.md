# Runbook: High CPU Usage on Linux Server

## Incident
CPU usage is consistently above 90%, causing slow response times or service disruption.

## Objective
Identify the root cause of high CPU usage and safely mitigate the issue.

## Audience
DevOps, SRE, On-call Engineers

---

## Step 1: Confirm System Load

### Command
```bash
uptime
top
```
Interpretation
- Load average higher than CPU core count means the system is overloaded.
- top shows which processes are actively consuming CPU.
- Confirms the issue is real and ongoing.
---
## Step 2: Identify Top CPU-Consuming Processes
### Command
```
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -10
```
Interpretation
- Displays the top CPU-consuming processes.
- Helps identify runaway jobs or misbehaving applications.
- Processes near 100% CPU are usually the primary cause.

---
## Step 3: Check Per-Core CPU Utilization
### Command
```bash
mpstat -P ALL 1 5
```
Interpretation
- One core maxed → single-threaded bottleneck.
- All cores high → system-wide load or traffic spike.
- Useful for scaling and tuning decisions.

---
## Step 4: Check Disk IO Wait (CPU Waiting on Disk)
### Command
```bash
iostat -xz 1 5
```
Interpretation
- High %iowait means CPU is idle waiting on disk.
- %util close to 100% indicates disk saturation.
- High CPU alerts may actually be disk-related.

---
## Step 5: Check Memory and Swap Usage
### Command
```bash
free -h
vmstat 1 5
```
Interpretation
- High swap usage indicates memory pressure.
- High si / so values mean active swapping.
- Swapping increases CPU usage and slows applications.

---
## Step 6: Check Application or Service Health
### Command
```bash
systemctl status myapp
journalctl -u myapp --since "10 minutes ago"
```
Interpretation
- Detects crash loops or unhealthy services.
Logs often reveal errors such as:
    - Database connection failures
    - Timeouts
    - Unhandled exceptions

---

## Step 7: Immediate Mitigation (If Approved)
### Restart the Service
```bash
systemctl restart myapp
```
Interpretation
- Clears stuck threads and memory leaks.
- Often restores service quickly.

---

## Gracefully Stop a Process
### Command
```
kill -TERM <pid>
```
Interpretation
- Allows clean shutdown of the process.
- Preferred over force kill.
- Use kill -9 only as a last resort.

---
## Step 8: Validate Recovery
### Command
```
top
uptime
```
Interpretation
- CPU usage should return to normal levels.
- Load average should stabilize below CPU core count.
- Confirms the fix worked.

---
## Step 9: Escalation (If Issue Persists)
### Action
Escalate to:
- Application Team
- Database Team
- Infrastructure / SRE Team

### Provide
### Command outputs (top, ps, vmstat)
- Relevant logs
- Incident start time
- Actions already taken

---
Post-Incident Notes
- Root Cause:
- Resolution:
- Preventive Actions (alerts, scaling, code fixes):