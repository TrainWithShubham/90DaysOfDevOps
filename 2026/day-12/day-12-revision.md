# Day 12 – Breather & Revision (Days 01–11)

**Date:** 2026-02-18  
**Author:** Rameez Ahmed  
**Goal:** Consolidate and reinforce fundamentals from Days 01–11

---

## 📋 Overview

Today is a **revision day** — no new concepts, just strengthening the foundation built over the last 11 days. This is about **retention**, not rushing ahead. A strong DevOps engineer revisits fundamentals regularly because these are the commands and concepts you'll reach for first in production incidents.

---

## 🔁 Review Summary (Days 01–11)

### Day-by-Day Recap

| Day        | Topic                        | Key Takeaway                                                         |
| ---------- | ---------------------------- | -------------------------------------------------------------------- |
| **Day 01** | DevOps Intro & Learning Plan | DevOps = Culture + Automation + CI/CD + Monitoring                   |
| **Day 02** | Linux Basics & OS Overview   | Linux is the backbone of most production systems                     |
| **Day 03** | Essential Linux Commands     | Navigation, file ops, and pipeline commands are daily tools          |
| **Day 04** | Process Management           | `ps`, `top`, `kill` — understanding what's running on the system     |
| **Day 05** | Services & Systemctl         | `systemctl` is the gateway to managing Linux services                |
| **Day 06** | File System & Navigation     | Understanding the Linux directory hierarchy (`/etc`, `/var`, `/opt`) |
| **Day 07** | Package Management           | `apt`/`yum` — installing, updating, and removing software            |
| **Day 08** | Nginx Deployment on AWS      | Real-world cloud deployment with EC2 and web server setup            |
| **Day 09** | User & Group Management      | `useradd`, `groupadd`, `usermod -aG` — controlling access            |
| **Day 10** | File Permissions             | `chmod`, the `rwx` model, octal notation (644, 755, etc.)            |
| **Day 11** | File Ownership               | `chown`, `chgrp`, recursive ownership with `-R`                      |

---

## 🎯 Mindset & Plan Revisit

### Original Goals (Day 01)
- ✅ Learn Linux fundamentals — **Completed (Days 02–11)**
- ✅ Understand cloud basics — **Started (Day 08 — AWS EC2 + Nginx)**
- 🔄 Build automation skills — **Coming up in the next phase**
- 🔄 Master CI/CD pipelines — **Planned for later days**

### Tweaks to the Plan
- **Spend more time on scripting** — Bash scripting will tie together all the commands learned so far
- **Practice troubleshooting scenarios** — Not just running commands, but diagnosing real problems
- **Focus on networking next** — Understanding ports, firewalls, and connectivity is essential for DevOps

---

## 🔧 Hands-On Re-runs

### 1. Processes & Services (Days 04–05)

```bash
# Check running processes
ps aux | head -15
```

**Observation:** The system is running essential services like `sshd`, `systemd`, and user processes. The `ps aux` output shows CPU/memory usage — useful for identifying resource-hungry processes.

```bash
# Check the status of a service
systemctl status sshd
```

**Observation:** The SSH daemon is active and running, showing its PID, memory usage, and recent log entries. This is the first command to run when checking if a service is healthy.

```bash
# View recent logs for a service
journalctl -u sshd --no-pager -n 10
```

**Observation:** `journalctl` provides timestamped log entries, which is crucial for debugging connection issues or authentication failures.

---

### 2. File Skills Practice (Days 06–11)

```bash
# Create a test file and append content
echo "Revision day practice" > revision-test.txt
echo "Adding more content" >> revision-test.txt
cat revision-test.txt
```

```bash
# Set specific permissions
chmod 640 revision-test.txt
ls -l revision-test.txt
```

**Output:**
```
-rw-r----- 1 rameez rameez 41 Feb 18 23:40 revision-test.txt
```

```bash
# Create a directory with specific permissions
mkdir -m 755 revision-project
ls -ld revision-project/
```

**Output:**
```
drwxr-xr-x 2 rameez rameez 4096 Feb 18 23:40 revision-project/
```

---

### 3. User/Group Sanity Check (Days 09 & 11)

```bash
# Recreate a small scenario: create user and verify
sudo useradd -m testuser-revision
id testuser-revision
```

**Expected Output:**
```
uid=1005(testuser-revision) gid=1005(testuser-revision) groups=1005(testuser-revision)
```

```bash
# Create a group and add the user
sudo groupadd revision-team
sudo usermod -aG revision-team testuser-revision

# Verify group membership
groups testuser-revision
```

**Expected Output:**
```
testuser-revision : testuser-revision revision-team
```

```bash
# Change file ownership and verify
touch ownership-test.txt
sudo chown testuser-revision:revision-team ownership-test.txt
ls -l ownership-test.txt
```

**Expected Output:**
```
-rw-r--r-- 1 testuser-revision revision-team 0 Feb 18 23:41 ownership-test.txt
```

```bash
# Cleanup
sudo userdel -r testuser-revision
sudo groupdel revision-team
rm ownership-test.txt
```

---

### 4. Cheat Sheet Refresh (Day 03)

#### 🔥 Top 5 Commands I'd Reach for First in an Incident

| # | Command | Why It's First |
|---|---------|----------------|
| 1 | `systemctl status <service>` | Instantly tells if a service is running, failed, or inactive |
| 2 | `journalctl -u <service> -n 50 --no-pager` | Shows recent logs to diagnose WHY something failed |
| 3 | `ps aux \| grep <process>` | Finds if a specific process is running and its resource usage |
| 4 | `df -h` | Checks disk space — full disks cause silent failures everywhere |
| 5 | `tail -f /var/log/syslog` | Live-stream system logs to see errors as they happen |

> **💡 Incident Response Order:** Check service → Read logs → Check processes → Check resources → Check network

---

## ✅ Mini Self-Check

### 1) Which 3 commands save you the most time right now, and why?

| Command | Why It Saves Time |
|---------|-------------------|
| **`systemctl status <service>`** | One command gives you running state, PID, memory, and recent logs — replaces 3-4 separate checks |
| **`chmod 755 <file>`** | Octal notation sets exact permissions in one shot instead of multiple `u+x`, `g+r`, `o+r` calls |
| **`chown -R user:group dir/`** | Recursively fixes ownership on entire directory trees in a single command — would take dozens of individual commands otherwise |

---

### 2) How do you check if a service is healthy? List the exact 2–3 commands you'd run first.

```bash
# Command 1: Check if the service is active and running
systemctl status nginx

# Command 2: Check recent service logs for errors
journalctl -u nginx -n 20 --no-pager

# Command 3: Verify the process is actually listening on the expected port
ss -tlnp | grep nginx
```

**What to look for:**
- `systemctl status` → Should show `active (running)` in green
- `journalctl` → Should have no `ERROR` or `FATAL` entries
- `ss -tlnp` → Should show the service listening on the expected port (e.g., `0.0.0.0:80`)

---

### 3) How do you safely change ownership and permissions without breaking access? Give one example command.

**Safe approach — always verify before and after:**

```bash
# Step 1: Check CURRENT permissions (before making changes)
ls -la /opt/app-directory/

# Step 2: Change ownership (use -R carefully, double-check the path!)
sudo chown -R www-data:www-data /opt/app-directory/

# Step 3: Set permissions — files get 644, directories get 755
sudo find /opt/app-directory/ -type f -exec chmod 644 {} \;
sudo find /opt/app-directory/ -type d -exec chmod 755 {} \;

# Step 4: VERIFY the changes look correct
ls -la /opt/app-directory/
```

> **🔑 Key Safety Rule:** Never blindly run `chown -R` or `chmod -R` without first confirming the path. A typo like `chown -R user:group /` (root!) vs `chown -R user:group ./` (current dir) can destroy the system.

---

### 4) What will you focus on improving in the next 3 days?

| Focus Area | Why | Plan |
|------------|-----|------|
| **Shell Scripting** | Automate repetitive tasks instead of manual commands | Write scripts that combine user management + permissions |
| **Networking Fundamentals** | Understanding ports, DNS, and firewalls is critical for deployments | Learn `ss`, `netstat`, `iptables`, `curl` diagnostics |
| **Real Troubleshooting** | Move from "knowing commands" to "diagnosing problems" | Practice scenarios: "service down", "disk full", "permission denied" |

---

## 🧠 Key Takeaways from Days 01–11

### The Big Picture

```
                ┌──────────────────────────────────┐
                │       DevOps Foundation          │
                │       (Days 01-11)               │
                └──────────────┬───────────────────┘
                               │
          ┌────────────────────┼────────────────────┐
          │                    │                    │
    ┌─────┴─────┐      ┌──────┴──────┐      ┌─────┴─────┐
    │  System    │      │   Access    │      │   Cloud   │
    │  Admin     │      │   Control   │      │  Deploy   │
    │            │      │             │      │           │
    │ • Commands │      │ • Users     │      │ • AWS EC2 │
    │ • Processes│      │ • Groups    │      │ • Nginx   │
    │ • Services │      │ • Perms     │      │ • Security│
    │ • Packages │      │ • Ownership │      │   Groups  │
    └───────────┘      └─────────────┘      └───────────┘
     Days 02-07          Days 09-11           Day 08
```

### Top 5 Concepts That Connect Everything

1. **Everything in Linux is a file** — Processes (`/proc`), devices (`/dev`), configs (`/etc`) — understanding files = understanding Linux
2. **Permissions + Ownership = Security** — `chmod` controls WHAT can be done, `chown` controls WHO the rules apply to
3. **`systemctl` is the control center** — Starting, stopping, and monitoring services is the #1 daily DevOps task
4. **Always verify** — `ls -l`, `id`, `groups`, `systemctl status` — never assume, always check
5. **`sudo` responsibly** — With great power comes great responsibility — understand what each command does before running it as root

---

## 📊 Skills Progress Tracker

| Skill | Day Learned | Confidence Level | Notes |
|-------|-------------|-------------------|-------|
| Navigation & basic commands | Day 02-03 | ⭐⭐⭐⭐⭐ | Comfortable — use daily |
| Process management | Day 04 | ⭐⭐⭐⭐ | Good — need more practice with `kill` signals |
| Service management | Day 05 | ⭐⭐⭐⭐ | Solid — `systemctl` is second nature |
| File system navigation | Day 06 | ⭐⭐⭐⭐⭐ | Know the key directories well |
| Package management | Day 07 | ⭐⭐⭐⭐ | Good with `apt`, need to practice `yum` |
| Cloud deployment | Day 08 | ⭐⭐⭐ | Did it once — need more hands-on practice |
| User & group management | Day 09 | ⭐⭐⭐⭐ | Confident with `useradd`, `usermod -aG` |
| File permissions | Day 10 | ⭐⭐⭐⭐ | Octal notation is clear — practice symbolic more |
| File ownership | Day 11 | ⭐⭐⭐⭐ | `chown` and `chgrp` are straightforward |

---

