# Day 12 - Breather & Revision (Days 01–11)

**Date:** February 10, 2026  
**Focus:** Consolidating and reinforcing Linux fundamentals from the past 11 days

---

## Mindset & Plan Review

### Day 01 Learning Plan Revisited

**Original Goals (Day 01):**
- ✅ Build strong Linux command-line fundamentals
- ✅ Understand process management and system services
- ✅ Master file permissions and ownership
- ✅ Learn user and group management
- ✅ Practice troubleshooting workflows

**Progress Assessment:**
- **Achieved:** Strong foundation in Linux basics, file operations, permissions, and ownership
- **Confident areas:** File creation/reading, basic permissions (chmod), user/group management
- **Needs practice:** Advanced troubleshooting scenarios, complex permission combinations, systemd deep dive

**Updated Goals for Next Phase:**
- Deepen understanding of networking commands
- Practice shell scripting for automation
- Learn package management and system updates
- Explore log analysis and monitoring tools
- Build real-world troubleshooting muscle memory

**Mindset Reflection:**
- The hands-on approach is working well - practice before theory
- Daily challenges build confidence incrementally
- Need to focus on combining concepts (permissions + ownership + groups)
- Ready to move from basics to practical DevOps scenarios

---

## Processes & Services Review

### Command Re-runs from Days 04–05

#### Command 1: Check Running Processes

```bash
ps aux --sort=-%cpu | head -10
```
<img width="1215" height="534" alt="image" src="https://github.com/user-attachments/assets/16fd628b-c5ff-43c7-aab0-9de5b2ab9a68" />


**What I observed today:**
- Firefox consuming most CPU (3.2%) - expected for active browser
- systemd running smoothly as PID 1
- nginx worker using minimal resources
- System is healthy with low overall resource usage

---

#### Command 2: Check Service Status
```bash
systemctl status ssh
```
<img width="1423" height="727" alt="Screenshot_2" src="https://github.com/user-attachments/assets/ff9f2808-dc6c-4f8f-94f1-2ae00309a819" />

**What I observed today:**
- SSH service active and running since boot
- Service is enabled (will start automatically)
- Low memory footprint (4.8M)
- No errors in status output

---

## File Skills Practice

### Quick Operations from Days 06–11

#### Operation 1: Create and Append to File
```bash
echo "Revision Day - Testing file operations" > revision-test.txt
echo "Command: echo with >> operator" >> revision-test.txt
echo "Date: $(date)" >> revision-test.txt
cat revision-test.txt
```
**Confidence level:** ✅ High - This is muscle memory now

---

#### Operation 2: Change Permissions
```bash
cat > quick-script.sh << 'EOF'
#!/bin/bash
echo "Testing permission changes"
EOF

chmod +x quick-script.sh
./quick-script.sh
```
**Confidence level:** ✅ High - chmod +x is automatic for scripts

---

#### Operation 3: Change Ownership
```bash
touch ownership-test.txt
sudo chown tokyo:developers ownership-test.txt
ls -l ownership-test.txt
```
**Confidence level:** ✅ Medium-High - Remember to use sudo and verify user/group exists

---

## Cheat Sheet Refresh

### Top 5 Commands for Incident Response

#### 1. `systemctl status <service>`
**Why:** Instantly shows if service is running, failed, or degraded  
**Use case:** "App is down" - First thing I check

#### 2. `journalctl -u <service> -n 50 -f`
**Why:** Shows recent logs AND follows in real-time  
**Use case:** Watch errors as they happen

#### 3. `top` or `htop`
**Why:** Real-time view of resource usage  
**Use case:** "Server is slow" - Identify resource hog

#### 4. `df -h`
**Why:** Check disk space - many issues caused by full disks  
**Use case:** "Can't write to disk" - Check if space is full

#### 5. `tail -f /var/log/syslog`
**Why:** System-wide logs in real-time  
**Use case:** General troubleshooting when unsure

**Honorable mentions:**
- `ls -l` - Verify file ownership/permissions
- `ps aux | grep <process>` - Find specific process
- `ss -tulpn` - Check listening ports
- `chmod` - Fix permission issues
- `chown` - Fix ownership issues

---

## User/Group Sanity Check

### Recreating Scenario from Day 09/11
```bash
# Create test user
sudo useradd -m -s /bin/bash testuser
sudo passwd testuser

# Create test group
sudo groupadd testgroup

# Add user to group
sudo usermod -aG testgroup testuser

# Verify with id
id testuser
```

**Output:** `uid=1010(testuser) gid=1010(testuser) groups=1010(testuser),1011(testgroup)`

**Verification successful!** ✅

---
```bash
# Create shared directory
sudo mkdir /opt/test-shared
sudo chown root:testgroup /opt/test-shared
sudo chmod 775 /opt/test-shared
sudo chmod g+s /opt/test-shared

# Verify
ls -ld /opt/test-shared
```

**Output:** `drwxrwsr-x 2 root testgroup 4096 Feb 10 17:45 /opt/test-shared`

**Observations:**
- ✅ setgid bit is set (s in group position)
- ✅ Group has write permission
- ✅ User 'testuser' can access because they're in 'testgroup'

---
```bash
# Test access as testuser
sudo -u testuser touch /opt/test-shared/user-test-file.txt
sudo -u testuser ls -l /opt/test-shared/
```

**Success!** File inherits 'testgroup' due to setgid bit. ✅

**Confidence level:** ✅ High - Can now set up shared directories confidently

---

## Mini Self-Check

### 1. Which 3 commands save you the most time right now, and why?

**Command 1: `systemctl status <service>`**
- **Why:** One command shows everything - running status, enabled, recent logs, resource usage
- **Time saved:** Replaces 3-4 separate checks
- **Example:** `systemctl status docker` tells me if containers can run

**Command 2: `ls -l`**
- **Why:** Immediately shows permissions, ownership, size, modification time
- **Time saved:** No guessing about access issues - I can see the problem
- **Example:** `ls -l /var/log/app.log` shows who owns logs and who can write

**Command 3: `chmod +x <script>`**
- **Why:** Makes scripts executable instantly without numeric values
- **Time saved:** No mental math for permissions
- **Example:** `chmod +x deploy.sh` and ready to run

---

### 2. How do you check if a service is healthy? List the exact 2–3 commands you'd run first.

**Step 1: Check service status**
```bash
systemctl status <service>
```
**What it tells me:**
- ✅ Active (running) or failed?
- ✅ How long has it been running?
- ✅ Is it enabled (starts on boot)?
- ✅ Last few log entries
- ✅ Memory and CPU usage

**Step 2: Check recent logs**
```bash
journalctl -u <service> -n 50 --no-pager
```
**What it tells me:**
- ✅ Error messages
- ✅ Warning signs
- ✅ Recent restarts or crashes
- ✅ Patterns of issues

**Step 3 (if needed): Check resource usage**
```bash
ps aux | grep <service>
```
**What it tells me:**
- ✅ CPU percentage
- ✅ Memory usage
- ✅ Process ID
- ✅ If multiple instances running

---

### 3. How do you safely change ownership and permissions without breaking access? Give one example command.

**Safe approach:**
1. Check current state first - Never change blindly
2. Verify user/group exists - Avoid errors
3. Test with one file - Before applying to many
4. Use appropriate permissions - Match the use case
5. Verify after change - Confirm it worked

**Example command:**
```bash
# Step 1: Check current state
ls -ld /opt/project

# Step 2: Verify user and group exist
id projectlead
getent group developers

# Step 3: Change ownership and permissions
sudo chown -R projectlead:developers /opt/project
sudo chmod -R 775 /opt/project
sudo chmod g+s /opt/project

# Step 4: Verify changes
ls -ld /opt/project

# Step 5: Test access
sudo -u projectlead touch /opt/project/test.txt
```

**Why this is safe:**
- 775 permissions: Owner and group can read/write/execute
- setgid bit (g+s): New files inherit 'developers' group
- Recursive (-R): Applies to entire directory tree
- Testing: Verified with actual user access

---

### 4. What will you focus on improving in the next 3 days?

**Focus Area 1: Networking Commands (Days 13-14)**
- Master `ping`, `traceroute`, `netstat`/`ss`, `dig`, `curl`
- Understand ports and troubleshoot connectivity
- Practice diagnosing network issues
- Learn firewall basics (ufw/iptables)

**Why:** Many DevOps issues are network-related - critical gap to fill

---

**Focus Area 2: Shell Scripting Basics (Day 15)**
- Write simple bash scripts for automation
- Understand variables, loops, conditionals
- Practice error handling in scripts
- Combine commands learned so far

**Why:** Scripts turn manual commands into repeatable automation

---

**Focus Area 3: Integration Practice**
- Combine permissions + ownership + services in real scenarios
- Build mini-projects (e.g., web server with proper permissions)
- Practice troubleshooting workflows start to finish
- Document common patterns for reuse

**Why:** Individual commands are great, but DevOps is about combining them

---

## Key Takeaways from Days 01–11

### What I've Mastered ✅

**File Operations:**
- Creating files: `touch`, `echo >`, `cat >`, `vim`
- Reading files: `cat`, `head`, `tail`, `less`
- File I/O redirection: `>`, `>>`, `|`
- File organization: `cp`, `mv`, `mkdir -p`, `rm`

**Permissions:**
- Understanding rwx for owner/group/others
- Symbolic chmod: `chmod +x`, `chmod -w`
- Numeric chmod: `chmod 755`, `chmod 644`, `chmod 640`
- Permission troubleshooting

**Ownership:**
- Change owner: `chown user file`
- Change group: `chgrp group file`
- Combined: `chown user:group file`
- Recursive: `chown -R user:group dir/`

**User & Group Management:**
- Create users: `useradd -m -s /bin/bash username`
- Create groups: `groupadd groupname`
- Add to groups: `usermod -aG group user`
- Verify: `id`, `groups`, `getent group`

**Process & Service Management:**
- Check processes: `ps aux`, `top`, `htop`
- Check services: `systemctl status service`
- Service logs: `journalctl -u service`
- Service control: `systemctl start/stop/restart`

---

### Areas for Continued Practice 📝

**Medium confidence (need more reps):**
- Complex permission scenarios (combining with ownership)
- Advanced journalctl filtering (date ranges, priority levels)
- Process priority and nice values
- Service dependencies and targets

**Needs improvement:**
- Networking commands and troubleshooting
- Shell scripting and automation
- Package management (apt, yum, dnf)
- System monitoring and log analysis
- Backup and recovery procedures

---

## Practice Log - Today's Hands-On

### Commands Executed Successfully ✅
```bash
# Process checks
ps aux --sort=-%cpu | head -10
systemctl status ssh
journalctl -u docker -n 20

# File operations
echo "test" > file.txt
echo "append" >> file.txt
cat file.txt

# Permission changes
chmod +x script.sh
chmod 640 config.yml
ls -l

# Ownership changes
sudo chown tokyo:developers file.txt
sudo chown -R user:group directory/

# User/group management
sudo useradd -m testuser
sudo groupadd testgroup
sudo usermod -aG testgroup testuser
id testuser

# Directory with setgid
sudo mkdir /opt/shared
sudo chown root:developers /opt/shared
sudo chmod 775 /opt/shared
sudo chmod g+s /opt/shared
ls -ld /opt/shared
```

**Total commands practiced:** 20+  
**Time taken:** ~30 minutes  
**Errors encountered:** 0  
**Confidence boost:** Significant ✅

---

## Personal Notes

### Aha Moments This Week 💡

1. **setgid bit (g+s) is crucial for shared directories**
   - Without it, files inherit creator's primary group
   - With it, files inherit directory's group
   - This is the secret to team collaboration

2. **journalctl is more powerful than I realized**
   - Can filter by service, time, priority
   - Follows logs in real-time with -f
   - Integrates with systemd seamlessly

3. **Directory permissions work differently than files**
   - 'x' on directory means "can enter"
   - Without 'x', can't even list contents
   - This was causing mystery access issues

4. **chown can change both owner AND group**
   - `chown user:group file` is more efficient
   - Saves typing two separate commands
   - Atomic operation - no intermediate state

---

### What Surprised Me 🎯

- How fast troubleshooting becomes with 3-4 key commands
- How much systemctl status reveals in one output
- How setgid bit solves team permission headaches
- How permissions and ownership are separate but work together
- How much confidence builds from just 11 days of practice

---

## Confidence Tracker

### Command Confidence Levels

| Command | Confidence | Notes |
|---------|-----------|-------|
| `ls -l` | ⭐⭐⭐⭐⭐ | Automatic |
| `chmod` | ⭐⭐⭐⭐⭐ | Both symbolic and numeric |
| `chown` | ⭐⭐⭐⭐ | Need more complex scenarios |
| `systemctl status` | ⭐⭐⭐⭐⭐ | First thing I check |
| `journalctl` | ⭐⭐⭐⭐ | Know basics, need advanced filters |
| `ps aux` | ⭐⭐⭐⭐ | Sorting and filtering solid |
| `useradd/usermod` | ⭐⭐⭐⭐ | Confident with common flags |
| `groupadd` | ⭐⭐⭐⭐⭐ | Simple and memorized |
| `cat/echo` | ⭐⭐⭐⭐⭐ | Second nature |
| `mkdir/cp/mv` | ⭐⭐⭐⭐⭐ | Daily use |

**Overall Linux Fundamentals Confidence:** ⭐⭐⭐⭐ (4/5)

---

## Summary

**Days Reviewed:** 01-11  
**Time Invested:** 45 minutes  
**Commands Re-executed:** 20+  
**Confidence Gained:** Significant  
**Ready for Next Phase:** ✅ Yes

**Biggest Win:** Can now confidently troubleshoot services, manage permissions, and set up user access without documentation.

**Key Insight:** The fundamentals are stronger than I thought. Time to build on this foundation with networking and automation.

**Motivation Level:** High - excited to tackle networking and scripting! 🚀

---

**Created for:** 90 Days of DevOps Challenge - Day 12  
**Date:** February 10, 2026  
**Purpose:** Consolidation and confidence building  
**Next:** Day 13 - Networking fundamentals

---

## LinkedIn Post

🎯 **Day 12 of #90DaysOfDevOps - Revision & Consolidation!**

Today I took a breather to solidify everything from Days 01-11. 

**What I reinforced:**
✅ Service health checks: `systemctl status` + `journalctl -u` 
✅ Permission management: chmod/chown combinations
✅ User/group administration with proper testing
✅ My "first 5 commands" for any incident

**Biggest confidence boost:**
I can now troubleshoot a service from "it's down" to "found the issue" in under 2 minutes using just 3-4 commands. That's the power of practice! 💪

**Commands I now remember confidently:**
```
systemctl status service  # Health check
journalctl -u service -n 50  # Logs
chmod g+s /shared/dir  # Team collaboration
```

**Key insight:** The setgid bit (chmod g+s) solves 90% of team permission headaches. Files automatically inherit the directory's group!

Ready to tackle networking fundamentals next! 🔥

#DevOpsKaJosh #TrainWithShubham #LinuxMastery #ContinuousLearning
