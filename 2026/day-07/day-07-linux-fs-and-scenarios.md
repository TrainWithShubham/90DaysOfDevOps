```
2026/day-07/day-07-linux-fs-and-scenarios.md
```

---

# Day 07 — Linux File System Hierarchy & Scenario Practice

## Part 1: Linux File System Hierarchy

### Core Directories (Must Know)

#### `/` (root)

* The top-level directory; everything in Linux starts from here.
* Contains all other directories and system files.

**Example contents (ls -l /):**

* `bin`, `etc`, `home`, `var`

**I would use this when:** Navigating the system or locating any directory from the absolute path.

---

#### `/home`

* Contains personal directories for regular users.
* Stores user files, downloads, configs, etc.

**Example contents (ls -l /home):**

* `user`, `ubuntu`

**I would use this when:** Accessing or managing user data.

---

#### `/root`

* Home directory of the root (administrator) user.
* Separate from `/home` for security.

**Example contents (ls -l /root):**

* `.bashrc`, `.ssh`

**I would use this when:** Performing administrative tasks as root.

---

#### `/etc`

* Stores system-wide configuration files.
* Critical for system behavior and service configs.

**Example contents (ls -l /etc):**

* `hostname`, `ssh/`, `passwd`

**I would use this when:** Modifying system or service configurations.

---

#### `/var/log`

* Contains system and application log files.
* Essential for troubleshooting and monitoring.

**Example contents (ls -l /var/log):**

* `syslog`, `auth.log`, `kern.log`

**I would use this when:** Diagnosing errors, failures, or unusual behavior.

---

#### `/tmp`

* Stores temporary files created by applications.
* Usually cleared on reboot.

**Example contents (ls -l /tmp):**

* Temporary folders and session files

**I would use this when:** Applications need short-term storage.

---

### Additional Directories (Good to Know)

#### `/bin`

* Contains essential command binaries required for boot and basic operation.

**Example contents (ls -l /bin):**

* `ls`, `cp`, `mv`, `cat`

**I would use this when:** Running core commands even in minimal environments.

---

#### `/usr/bin`

* Contains most user-level command binaries.
* Larger collection than `/bin`.

**Example contents (ls -l /usr/bin):**

* `git`, `python`, `vim`

**I would use this when:** Running installed applications and tools.

---

#### `/opt`

* Used for optional or third-party software installations.

**Example contents (ls -l /opt):**

* `google/`, `docker/`, custom apps

**I would use this when:** Managing manually installed software packages.

---

### Hands-on Tasks

**Find largest log files:**

```bash
du -sh /var/log/* 2>/dev/null | sort -h | tail -5
```

---

**View hostname config:**

```bash
cat /etc/hostname
```

---

**Check home directory contents:**

```bash
ls -la ~
```

---

## Part 2: Scenario-Based Practice

### Scenario 1: Service Not Starting

**Problem:** Service `myapp` failed after reboot.

**Step 1:** Check service status

```bash
systemctl status myapp
```

**Why:** Determines whether the service is active, failed, or inactive.

---

**Step 2:** Check recent logs

```bash
journalctl -u myapp -n 50
```

**Why:** Shows error messages explaining why it failed.

---

**Step 3:** Check if enabled on boot

```bash
systemctl is-enabled myapp
```

**Why:** Confirms whether it should start automatically.

---

**Step 4:** Try starting manually

```bash
systemctl start myapp
```

**Why:** Tests if the service can start now and produces fresh logs.

---

### Scenario 2: High CPU Usage

**Problem:** Server is slow.

**Step 1:** View live CPU usage

```bash
top
```

**Why:** Shows real-time CPU consumption by processes.

---

**Step 2:** Use enhanced viewer (if installed)

```bash
htop
```

**Why:** Easier to read and sort processes interactively.

---

**Step 3:** List top CPU-consuming processes

```bash
ps aux --sort=-%cpu | head -10
```

**Why:** Identifies the processes using the most CPU and their PIDs.

---

### Scenario 3: Finding Docker Service Logs

**Step 1:** Check service status

```bash
systemctl status docker
```

**Why:** Confirms service state and shows recent logs.

---

**Step 2:** View recent logs

```bash
journalctl -u docker -n 50
```

**Why:** Retrieves last 50 log entries from systemd journal.

---

**Step 3:** Follow logs in real time

```bash
journalctl -u docker -f
```

**Why:** Monitors live activity for troubleshooting ongoing issues.

---

### Scenario 4: File Permissions Issue

**Problem:** Script not executable (`Permission denied`)

**Step 1:** Check permissions

```bash
ls -l /home/user/backup.sh
```

Look for: `-rw-r--r--` (no execute permission)

---

**Step 2:** Add execute permission

```bash
chmod +x /home/user/backup.sh
```

---

**Step 3:** Verify change

```bash
ls -l /home/user/backup.sh
```

Look for: `-rwxr-xr-x`

---

**Step 4:** Run the script

```bash
./backup.sh
```

---

## Key Takeaways

* Linux file system hierarchy tells you where configs, logs, binaries, and user data live.
* Logs and service status checks are the first steps in most troubleshooting workflows.
* Understanding permissions is critical for executing scripts and securing systems.
* Scenario-based practice mirrors real DevOps incidents and interview questions.

