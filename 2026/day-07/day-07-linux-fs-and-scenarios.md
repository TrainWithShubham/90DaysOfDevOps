# Day 07 Task - Linux File System Hierarchy & Scenario-Based Practice

**Author:** Rashid Khan 
**Batch:** #90DaysOfDevOps (2026) 

---

## Part 1: Linux File System Hierarchy

Understanding where system assets reside is critical for rapid incident diagnosis and system configuration.

| Directory | Purpose & Contents | Command Example | Use Case |
| :--- | :--- | :--- | :--- |
| **`/` (root)** | Top-level starting point of the entire directory tree | `ls -l /` | Navigating overall file system structure. |
| **`/home`** | Personal directories for regular users | `ls -la ~` | Storing user scripts, configs, and SSH keys. |
| **`/root`** | Home directory for the administrative superuser | `sudo ls -l /root` | Administrative maintenance and root-specific operations. |
| **`/etc`** | System-wide configuration files and startup scripts | `cat /etc/hostname` | Modifying network, system, or application settings. |
| **`/var/log`** | Variable data files, specifically application & system logs | `du -sh /var/log/* 2>/dev/null \| sort -h \| tail -5` | Debugging service failures and auditing logs. |
| **`/tmp`** | Temporary files created by system and programs | `ls -l /tmp` | Inspecting transient runtime data (cleared on reboot). |
| **`/bin`** | Essential user command binaries | `ls /bin` | Running single-user mode recovery utilities (`ls`, `cat`). |
| **`/usr/bin`** | Primary directory for user executable commands | `ls /usr/bin` | Standard CLI application execution. |
| **`/opt`** | Subdirectory for add-on/third-party application software packages | `ls /opt` | Installing standalone enterprise software (e.g., custom agents). |

---

## Part 2: Scenario-Based Troubleshooting Practice

### Scenario 1: Service Not Starting (`myapp`)
**Problem:** A web application service called `myapp` failed to start after a server reboot.

 **Step 1:** Check current service status.
  ```bash
  systemctl status myapp
  ```
  Why: Identifies whether the service is inactive, active, or in a failed state.

**Step 2:** Inspect failure logs in systemd journal.
  ```bash
  journalctl -u myapp -n 50
  ```
  Why: Extracts the last 50 log lines to pinpoint stdout/stderr runtime errors.

**Step 3:** Verify if the service is configured to auto-start on boot.
  ```bash
   systemctl is-enabled myapp
  ```
  Why: Determines if the unit file is missing boot-time enablement.

**Step 4:** List all active services if myapp is missing.
  ```bash
   systemctl list-units --type=service
  ```
  Why: Confirms exact service naming syntax installed on the host.

### Scenario 2: High CPU Usage Investigation
**Problem:** Server response latency is high due to CPU saturation.

 **Step 1:** Inspect top CPU-consuming processes interactively.
   ```bash
    top
   ```
  Why: Displays real-time live resource usage breakdown sorted by %CPU.

 **Step 2:** Get a top-10 snapshot sorted by CPU usage.
   ```bash
    ps aux --sort=-%cpu | head -10
   ```
  Why: Instantly lists process owner, PID, CPU percentage, and exact executing command line.

### Scenario 3: Finding & Tailing Service Logs (`docker`)
**Problem:** Developer requests real-time log monitoring for the docker service.
 
 **Step 1:** Verify active Docker service status.
   ```bash
    systemctl status docker
   ```
  Why: Ensures the docker daemon is active before inspecting logs.

 **Step 2:** Inspect recent Docker logs.
   ```bash
    journalctl -u docker -n 50
   ```
  Why: Reviews recent startup and operational logs.

 **Step 3:** Stream live Docker logs continuously.
   ```bash
    journalctl -u docker -f
   ```
  Why: Follows real-time log streams for active debugging.

### Scenario 4: Fixing Script Execution Permission (`backup.sh`)
**Problem:** Executing /home/user/backup.sh throws Permission denied.
 **Step 1:** Check current file permissions.
  ```bash
   ls -l /home/user/backup.sh
  ```
  Output: -rw-r--r-- (Missing execute x permissions).

 **Step 2:** Add execute permission for the file owner/group.
  ```bash
   chmod +x /home/user/backup.sh
  ```
  Why: Grants binary execution privileges.

 **Step 3:** Verify permission change.
  ```bash
   ls -l /home/user/backup.sh
  ```
  Output: -rwxr-xr-x (Execute permission granted).

 **Step 4:** Execute the backup script.
  ```bash
   ./backup.sh
  ```



