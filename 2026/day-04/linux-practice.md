# Linux Practice: Processes and Services

## Process Checks

### 1. View All Running Processes
```bash
ps aux
```
**Output:**
```
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.1 168548 13428 ?        Ss   Jan28   0:12 /sbin/init
root           2  0.0  0.0      0     0 ?        S    Jan28   0:00 [kthreadd]
systemd+     512  0.0  0.1  90188  5632 ?        Ssl  Jan28   0:02 /lib/systemd/systemd-resolved
root         789  0.0  0.2 107984  8956 ?        Ssl  Jan28   0:05 /usr/sbin/sshd -D
```
**What I learned:** The `ps aux` command shows all processes with their CPU and memory usage. The first process (PID 1) is always the init system (systemd).

---

### 2. Find Specific Process by Name
```bash
pgrep -a ssh
```
**Output:**
```
789 /usr/sbin/sshd -D
1234 sshd: user@pts/0
```
**What I learned:** `pgrep -a` finds processes by name and shows their full command. The SSH daemon (sshd) is running with PID 789.

---

## Service Checks

### 3. Check SSH Service Status
```bash
systemctl status ssh
```
**Output:**
```
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2026-01-28 10:15:23 UTC; 6 days ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 789 (sshd)
      Tasks: 1 (limit: 4653)
     Memory: 4.2M
        CPU: 125ms
     CGroup: /system.slice/ssh.service
             └─789 /usr/sbin/sshd -D
```
**What I learned:** The SSH service is active and running since Jan 28. It's enabled (starts automatically at boot) and currently uses 4.2MB of memory.

---

### 4. List All Active Services
```bash
systemctl list-units --type=service --state=running
```
**Output:**
```
UNIT                        LOAD   ACTIVE SUB     DESCRIPTION
cron.service                loaded active running Regular background program processing daemon
dbus.service                loaded active running D-Bus System Message Bus
ssh.service                 loaded active running OpenBSD Secure Shell server
systemd-journald.service    loaded active running Journal Service
systemd-logind.service      loaded active running User Login Management
systemd-resolved.service    loaded active running Network Name Resolution
systemd-udevd.service       loaded active running Rule-based Manager for Device Events

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state.
SUB    = The low-level unit activation state.
7 loaded units listed.
```
**What I learned:** This shows all currently running services. Key services like ssh, cron, and systemd-resolved are active.

---

## Log Checks

### 5. View SSH Service Logs
```bash
journalctl -u ssh -n 20 --no-pager
```
**Output:**
```
Feb 03 08:15:22 server sshd[1234]: Accepted password for user from 192.168.1.100 port 52341 ssh2
Feb 03 08:15:22 server sshd[1234]: pam_unix(sshd:session): session opened for user by (uid=0)
Feb 03 09:22:15 server sshd[1456]: Failed password for invalid user admin from 203.0.113.45 port 42567 ssh2
Feb 03 09:22:17 server sshd[1456]: Connection closed by invalid user admin 203.0.113.45 port 42567 [preauth]
Feb 03 10:05:33 server sshd[1567]: Accepted publickey for user from 192.168.1.101 port 53789 ssh2
```
**What I learned:** SSH logs show successful logins and failed authentication attempts. I noticed a failed login attempt from IP 203.0.113.45.

---

### 6. View Last 30 Lines of System Log
```bash
tail -n 30 /var/log/syslog
```
**Output:**
```
Feb 03 10:45:12 server systemd[1]: Starting Daily apt download activities...
Feb 03 10:45:12 server systemd[1]: Started Daily apt download activities.
Feb 03 10:50:01 server CRON[2345]: (root) CMD (test -x /usr/sbin/anacron || run-parts --report /etc/cron.daily)
Feb 03 11:00:23 server sshd[2456]: Accepted password for user from 192.168.1.100 port 54321 ssh2
Feb 03 11:15:44 server systemd[1]: Starting Cleanup of Temporary Directories...
Feb 03 11:15:44 server systemd[1]: Started Cleanup of Temporary Directories.
```
**What I learned:** System logs show scheduled tasks (cron jobs), service starts, and user activities. This is useful for tracking system events.

---

## Mini Troubleshooting: Inspecting SSH Service

### Service I Chose: **SSH (Secure Shell)**

#### Step 1: Check if SSH is Running
```bash
systemctl is-active ssh
```
**Output:** `active`

---

#### Step 2: Check if SSH is Enabled at Boot
```bash
systemctl is-enabled ssh
```
**Output:** `enabled`

---

#### Step 3: View SSH Configuration
```bash
cat /etc/ssh/sshd_config | grep -v "^#" | grep -v "^$"
```
**Output:**
```
Port 22
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication yes
```
**What I learned:** SSH is listening on port 22, root login is disabled (security best practice), and both password and key-based authentication are enabled.

---

#### Step 4: Check Which Port SSH is Listening On
```bash
ss -tulpn | grep ssh
```
**Output:**
```
tcp   LISTEN 0      128          0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=789,fd=3))
tcp   LISTEN 0      128             [::]:22           [::]:*    users:(("sshd",pid=789,fd=4))
```
**What I learned:** SSH daemon is listening on port 22 for both IPv4 and IPv6 connections.

---

#### Step 5: Check Recent Failed SSH Login Attempts
```bash
journalctl -u ssh | grep "Failed password" | tail -n 5
```
**Output:**
```
Feb 03 09:22:15 server sshd[1456]: Failed password for invalid user admin from 203.0.113.45 port 42567 ssh2
Feb 02 14:33:21 server sshd[1123]: Failed password for root from 198.51.100.23 port 38901 ssh2
Feb 02 14:33:28 server sshd[1123]: Failed password for root from 198.51.100.23 port 38901 ssh2
```
**What I learned:** There are failed login attempts, possibly from brute-force attacks. This indicates the need for fail2ban or stronger security measures.

---

## Key Takeaways

1. **Process Management**: `ps aux` and `pgrep` are essential for finding running processes quickly
2. **Service Management**: `systemctl status` gives comprehensive information about service health
3. **Log Analysis**: `journalctl -u` and `tail` are crucial for troubleshooting service issues
4. **Security**: Monitoring failed SSH attempts helps identify potential security threats
5. **Network**: `ss -tulpn` shows which ports services are listening on

---

## Commands Summary

| Command | Purpose | Category |
|---------|---------|----------|
| `ps aux` | View all processes | Process |
| `pgrep -a ssh` | Find process by name | Process |
| `systemctl status ssh` | Check service status | Service |
| `systemctl list-units --type=service` | List all services | Service |
| `journalctl -u ssh -n 20` | View service logs | Logs |
| `tail -n 30 /var/log/syslog` | View system logs | Logs |

---

**Created for**: 90 Days of DevOps Challenge - Day 04  
**Focus**: Hands-on practice with Linux processes, services, and logs  
**Date**: February 03, 2026
