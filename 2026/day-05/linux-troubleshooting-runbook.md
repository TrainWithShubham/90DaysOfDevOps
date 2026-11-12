# 🛠️ Linux Incident Troubleshooting & Triage Runbook

**Author:** Rashid Khan  
**Batch:** #90DaysOfDevOps (2026)  
**Task:** Day 05 - Production System Diagnostics & Incident Mitigation  

---

## 📌 Incident Resolution Workflow

Whenever a server issues an alert, I follow this 4-step triage methodology:
1. **Resource Check:** Inspect RAM, CPU, and Disk space.
2. **Process Check:** Identify high-resource or hung process IDs (PIDs).
3. **Network Check:** Verify open ports and listening sockets.
4. **Log Inspection:** Check systemd logs and restart failed services.

---

## 1. System Resource Diagnostics

### A. Check RAM Usage
```bash
free -h -t
```

### B. Check Disk Space
```bash
df -h
```

### C. Check System Load
```bash
uptime
```

## 2. Process Identification & Management

### A. Find Top CPU Consuming Processes
```bash
ps aux --sort=-%cpu | head -n 10
```
### B. Find Top RAM Consuming Processes
```bash
ps aux --sort=-%mem | head -n 10
```
### C. Kill Unresponsive Processes
```bash
pgrep -fl nginx
kill 15 <PID>
kill -9 <PID>
```
## 3. Network & Port Diagnostics

### A. Check Open Listening Ports
```bash
sudo ss -tulpn | grep LISTEN
```

## 4. Service Lifecycle & Log Inspection

### A. Check Service Status
```bash
sudo systemctl status nginx
```
### B. View Live Logs for Troubleshooting
```bash
sudo journalctl -u nginx -n 50 --no-pager
```
