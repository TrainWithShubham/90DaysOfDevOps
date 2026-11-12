# Day 28: Milestone Revision & Honest Self-Audit (Days 1–27)

**Author:** Rashid Khan  
**Track:** #90DaysOfDevOps (2026)  
**Milestone:** Systems Engineering, Automation & Version Control Consolidation  

---

## Task 1: Self-Assessment Checklist

### A. Linux Systems Administration
* [x] **Can do confidently** | Navigate the file system, create/move/delete files and directories (`mkdir -p`, `mv`, `rm -rf`, `cp -r`)
* [x] **Can do confidently** | Manage processes — list, inspect, and kill (`ps aux`, `top`, `pgrep`, `kill -15`, `kill -9`)
* [x] **Can do confidently** | Work with systemd — start, stop, enable, restart, and inspect status (`systemctl status`, `journalctl -u -f`)
* [x] **Can do confidently** | Read and edit text files using vi/vim or nano
* [x] **Can do confidently** | Troubleshoot CPU, memory, and disk issues using `top`, `free -h -t`, `df -h`, `du -sh`
* [x] **Can do confidently** | Explain the Linux file system hierarchy (`/`, `/etc`, `/var/log`, `/home`, `/tmp`, `/opt`, `/bin`)
* [x] **Can do confidently** | Create users and groups, manage passwords (`useradd`, `passwd`, `usermod -aG`)
* [x] **Can do confidently** | Set file permissions using chmod (numeric: `755`, `644`; symbolic: `chmod +x`, `u+rw`)
* [x] **Can do confidently** | Change file ownership with `chown` and `chgrp`
* [ ] **Need to revisit** | Create and manage LVM volumes (PV, VG, LV physical-to-logical lifecycle)
* [x] **Can do confidently** | Check network connectivity — `ping`, `curl -Iv`, `dig +short`, `ip addr`, `ss -tulpn`
* [x] **Can do confidently** | Explain DNS resolution, IP addressing, subnets, CIDR blocks, and standard ports (22, 80, 443)

### B. Shell Scripting & Automation
* [x] **Can do confidently** | Write a script with shebang (`#!/bin/bash`), variables, positional arguments (`$1`, `$2`), and user input (`read -p`)
* [x] **Can do confidently** | Use `if/elif/else` and `case` statements for conditional routing
* [x] **Can do confidently** | Write `for`, `while`, and `until` loops for batch operations
* [x] **Can do confidently** | Define and call modular functions with arguments and return exit codes
* [ ] **Need to revisit** | Advanced text processing with `awk`, `sed`, `sort`, `uniq` for structured log extraction
* [x] **Can do confidently** | Handle script failures defensively with `set -e`, `set -u`, `set -o pipefail`, and `trap`
* [x] **Can do confidently** | Schedule automation scripts with `crontab -e`

### C. Git & GitHub Architecture
* [x] **Can do confidently** | Initialize a repo, stage (`git add`), commit, and inspect logs (`git log --oneline --graph`)
* [x] **Can do confidently** | Create, switch, and delete branches (`git checkout -b`, `git branch -d`)
* [x] **Can do confidently** | Push to and pull from remote tracking repositories (`origin`, `tws`)
* [x] **Can do confidently** | Explain clone (local copy of remote) vs fork (server-side copy under your namespace)
* [x] **Can do confidently** | Merge branches — understand fast-forward merges vs three-way merge commits
* [ ] **Need to revisit** | Rebase a branch (`git rebase main`) vs merge, and interactive squash workflows
* [x] **Can do confidently** | Use `git stash` and `git stash pop` to preserve work-in-progress state
* [x] **Can do confidently** | Cherry-pick specific commits across branches (`git cherry-pick <commit-hash>`)
* [x] **Can do confidently** | Explain squash merge (combining multiple feature commits into one) vs regular merge
* [x] **Can do confidently** | Use `git reset` (`--soft`, `--mixed`, `--hard`) and `git revert` safely
* [x] **Can do confidently** | Explain GitFlow, GitHub Flow, and Trunk-Based Development
* [x] **Can do confidently** | Use GitHub CLI (`gh`) to manage repos, clones, deletions, and pull requests headless

---

## Task 2: Revisit Weak Spots (My Hands-On Remediation)

### Weak Spot 1: Logical Volume Management (LVM)
* **What tripped me up initially:** The three-tier abstraction (`PV -> VG -> LV`) felt abstract compared to mounting a regular drive. I had trouble visualizing why we need a Volume Group in between.
* **How I practiced and fixed it:**
  I walked through the entire creation and live-resizing workflow step-by-step:
  ```bash
  # 1. Initialize physical disk
  sudo pvcreate /dev/sdb
  # 2. Pool physical disks into a Volume Group
  sudo vgcreate app_vg /dev/sdb
  # 3. Carve out a 5GB slice for application data
  sudo lvcreate -L 5G -n app_data app_vg
  # 4. Format and verify
  sudo mkfs.ext4 /dev/app_vg/app_data
  # 5. Live volume extension without unmounting active services
  sudo lvextend -L +2G /dev/app_vg/app_data
  sudo resize2fs /dev/app_vg/app_data
  ```
* **My takeaway:** Standard disk partitions are rigid walls—expanding them requires taking servers offline. LVM acts like liquid storage; you can pour more disk space into a Volume Group and expand the Logical Volume on a running system without breaking services.

### Weak Spot 2: Advanced Text Parsing (`awk` & `sed`)
* **What tripped me up initially:** While `grep` is intuitive for matching single error lines, using `awk` column syntax (`$1`, `$9`) and `sed` stream substitution felt unnatural without referencing documentation.
* **How I practiced and fixed it:**
  I practiced isolating specific telemetry fields on web server access logs:
  ```bash
  # Extract unique client IPs and rank them by frequency
  awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -nr | head -n 5

  # In-place search and replace across config files without opening nano
  sed -i 's/127.0.0.1:5432/db.internal:5432/g' config.env
  ```
* **My takeaway:** `grep` is a filter, but `awk` is a data processor. During production log triage, combining `awk '{print $col}' | sort | uniq -c` isolates spikes and bad actors much faster than reading logs line-by-line.

### Weak Spot 3: Git Rebase vs. Merge in Real Workflows
* **What tripped me up initially:** Handling merge conflicts during a `git merge` is straightforward because Git creates a merge commit. During `git rebase`, conflicts occur commit-by-commit, which caused confusion when resolving and continuing.
* **How I practiced and fixed it:**
  I practiced resolving step-by-step rebase conflicts on test branches:
  ```bash
  git checkout feature/script
  git fetch origin
  git rebase origin/main
  # When conflict paused execution:
  # 1. Manually resolve conflict markers in the file
  # 2. Stage the resolution: git add <file>
  # 3. Continue the replay: git rebase --continue
  ```
* **My takeaway:** Merge preserves actual history as it happened, but leaves non-linear branch knots. Rebase unplugs your commits, updates the base to the latest commit, and replays your work on top. Rule of thumb: Rebase personal feature branches before PR submission; never rebase shared branches like `main`.

---

## Task 3: Quick-Fire Questions (Practical Experience & Mental Models)

### 1. What does `chmod 755 script.sh` do?
It assigns octal permission bits across Owner, Group, and Others:
* **7 (4+2+1) for Owner:** Full Read, Write, and Execute (`rwx`). The author can modify and run the script.
* **5 (4+0+1) for Group:** Read and Execute (`r-x`). Team members can view and run it, but cannot overwrite it.
* **5 (4+0+1) for Others:** Read and Execute (`r-x`). Any user on the OS can execute it without altering code.

### 2. What is the difference between a process and a service?
* **Process:** Any single execution instance of a program currently running in RAM with an assigned PID (e.g., executing `./script.sh` or running `top`). If the terminal session ends, the process terminates unless daemonized.
* **Service:** A managed daemon running persistently in the background, supervised by `systemd` (PID 1). It includes automatic restart rules, dependency ordering, boot enablement, and centralized logging.

### 3. How do you find which process is using port 8080?
Run socket statistics filtering for active listeners:
```bash
sudo ss -tulpn | grep :8080
# Alternative:
sudo lsof -i :8080
```
This shows the exact Process Name and PID holding the socket, allowing you to gracefully terminate it (`kill -15 <PID>`) if it blocks another deployment.

### 4. What does `set -euo pipefail` do in a shell script?
This is defensive bash scripting to prevent silent automation failures in production:
* `-e`: Immediately terminates the script if any command exits with a non-zero status.
* `-u`: Crashes execution if an uninitialized variable is referenced (prevents accidental disasters like `rm -rf /$UNSET_VAR`).
* `-o pipefail`: Prevents masked pipeline errors. In `cmd1 | cmd2`, bash normally only checks the exit code of `cmd2`. With `pipefail`, if `cmd1` fails, the pipeline fails.

### 5. What is the difference between `git reset --hard` and `git revert`?
* `git reset --hard <commit>`: Moves the branch pointer back in time, discarding all staged and unstaged work from that commit forward. It rewrites Git history destructively.
* `git revert <commit>`: Leaves existing commit history intact and generates a brand-new commit that applies the exact inverse diff of the target commit. It is safe for shared public branches.

### 6. What branching strategy would you recommend for a team of 5 developers shipping weekly?
**GitHub Flow:**
A team of 5 developers shipping weekly does not need the complexity of long-lived `release`, `develop`, and `hotfix` branches found in GitFlow. Maintain a single deployable `main` branch. Developers cut short-lived feature branches (`feature/auth`), open PRs with automated checks, get peer reviews, and merge directly into `main`.

### 7. What does `git stash` do and when would you use it?
`git stash` stores modified, uncommitted work (both staged and unstaged) in temporary storage and cleans the working tree back to `HEAD`.
* **When I use it:** While midway through editing a script, an urgent production bug requires an immediate branch switch. Running `git stash` shelves uncommitted work, allowing a clean checkout to fix the bug, followed by `git stash pop` upon returning.

### 8. How do you schedule a script to run every day at 3 AM?
Open the cron configuration with `crontab -e` and append:
```cron
0 3 * * * /bin/bash /home/ubuntu/scripts/backup.sh >> /var/log/backup.log 2>&1
```
*(Syntax: 0th minute, 3rd hour, any day of month, any month, any day of week)*

### 9. What is the difference between `git fetch` and `git pull`?
* `git fetch`: Queries the remote repository and downloads new commits and branch refs to your local tracking references (`origin/main`), without modifying your local working files.
* `git pull`: Executes `git fetch` and immediately follows it with a `git merge`, pulling changes directly into your active branch.

### 10. What is LVM and why would you use it instead of regular partitions?
LVM (Logical Volume Manager) adds an abstraction layer over raw storage, grouping physical disks into a shared Volume Group.
* **Why use it:** Standard disk partitions are hard boundaries. If a partition fills up, expanding it requires shutting down the server and repartitioning. LVM allows expanding a logical volume and its filesystem live with zero server downtime.

---

## Task 4: Work Organization & Showcase Verification

* [x] **Chronological Commits:** Days 01 through 27 organized and committed inside `2026/` in chronological order.
* [x] **Git Reference Guide:** Centralized `git-commands.md` reference maintained.
* [x] **Shell Automation Portfolio:** Bash scripts migrated into the dedicated `shell-scripts` showcase repository.
* [x] **Profile Hygiene:** Redundant practice repos removed via `gh repo delete`, and GitHub profile pinned repositories curated.

---

## Task 5: Teach It Back

### Topic: File Permissions Explained to a New Linux User
Think of your Linux computer like an office building where every file is a confidential folder inside a room. Linux assigns three basic permission keys to that folder:
1. **Read (r):** You can open the folder and read what is written on the paper.
2. **Write (w):** You can grab a pen and add, edit, or scribble over the pages.
3. **Execute (x):** If the paper contains step-by-step instructions (a script), you have the badge required to step up and run it.

Linux asks: **Who are you?**
* **The Owner (User):** The person who created the document.
* **The Department (Group):** The immediate colleagues sitting in the same office team.
* **The Public (Others):** A visitor walking in from the street.

When you see `chmod 755 backup.sh`, it means:
* The Owner has full keys (`7` = read + write + execute).
* The Team and the Public have restricted keys (`5` = read + execute, but **cannot edit** the text).

---

## Milestone Verdict
Foundational systems engineering, shell scripting, Git hygiene, and terminal troubleshooting consolidation complete. Ready for Docker containerization modules.
