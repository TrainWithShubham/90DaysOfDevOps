# Day 28 – Revision Day: Everything from Day 1 to Day 27
---
### Task 1: Self-Assessment Checklist
Go through the checklist below. For each item, mark yourself honestly:
- **Can do confidently**
- **Need to revisit**
- **Haven't done yet**

#### Linux
- [Confident] Navigate the file system, create/move/delete files and directories
- [Confident] Manage processes — list, kill, background/foreground
- [Confident] Work with systemd — start, stop, enable, check status of services
- [Confident] Read and edit text files using vi/vim or nano
- [Confident] Troubleshoot CPU, memory, and disk issues using top, free, df, du
- [Confident] Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
- [Confident] Create users and groups, manage passwords
- [Confident] Set file permissions using chmod (numeric and symbolic)
- [Confident] Change file ownership with chown and chgrp
- [Confident] Create and manage LVM volumes
- [Confident] Check network connectivity — ping, curl, netstat, ss, dig, nslookup
- [Confident] Explain DNS resolution, IP addressing, subnets, and common ports

#### Shell Scripting
- [Confident] Write a script with variables, arguments, and user input
- [Confident] Use if/elif/else and case statements
- [Confident] Write for, while, and until loops
- [Confident] Define and call functions with arguments and return values
- [Confident] Use grep, awk, sed, sort, uniq for text processing
- [Confident] Handle errors with set -e, set -u, set -o pipefail, trap
- [Confident] Schedule scripts with crontab

#### Git & GitHub
- [Confident] Initialize a repo, stage, commit, and view history
- [Confident] Create and switch branches
- [Confident] Push to and pull from GitHub
- [Confident] Explain clone vs fork
- [Confident] Merge branches — understand fast-forward vs merge commit
- [Revisit] Rebase a branch and explain when to use it vs merge
- [Confident] Use git stash and git stash pop
- [Confident] Cherry-pick a commit from another branch
- [Confident] Explain squash merge vs regular merge
- [Confident] Use git reset (soft, mixed, hard) and git revert
- [Confident] Explain GitFlow, GitHub Flow, and Trunk-Based Development
- [Confident] Use GitHub CLI to create repos, PRs, and issues

---

### Task 2: Revisit Your Weak Spots
1. Pick **3 topics** from the checklist where you marked "Need to revisit"
- [Confident] Rebase a branch and explain when to use it vs merge
- [Confident] Use git stash and git stash pop
- [Confident] Use git reset (soft, mixed, hard) and git revert
2. Go back to that day's challenge and redo the hands-on tasks [Done]
- [Confident] Rebase a branch and explain when to use it vs merge[Done]
- [Confident] Use git stash and git stash pop[Done]
- [Confident] Use git reset (soft, mixed, hard) and git revert[Done]
---

# Task 3: Quick-Fire Answers (Correct Reference Answers)

### 1. What does `chmod 755 script.sh` do?

Sets permissions to:

* Owner: read, write, execute (7)
* Group: read, execute (5)
* Others: read, execute (5)

Equivalent to: `rwxr-xr-x`

---

### 2. What is the difference between a process and a service?

* **Process**: A running instance of a program.
* **Service**: A background process managed by the system (often via systemd) designed to provide ongoing functionality (e.g., nginx).

All services are processes. Not all processes are services.

---

### 3. How do you find which process is using port 8080?

```bash
ss -tulpn | grep 8080
```

or

```bash
lsof -i :8080
```

---

### 4. What does `set -euo pipefail` do in a shell script?

* `-e`: exit on error
* `-u`: error on undefined variables
* `-o pipefail`: fail pipeline if any command fails

It enforces strict error handling.

---

### 5. What is the difference between `git reset --hard` and `git revert`?

* `git reset --hard`
  Moves HEAD and rewrites history. Discards commits and working changes. Dangerous on shared branches.

* `git revert`
  Creates a new commit that reverses changes. Safe for shared branches.

---

### 6. What branching strategy would you recommend for a team of 5 developers shipping weekly?

**GitHub Flow** or lightweight **Trunk-Based Development**:

* `main` always deployable
* Short-lived feature branches
* PR review required
* Frequent merges
* CI required

Avoid full GitFlow unless complexity justifies it.

---

### 7. What does `git stash` do and when would you use it?

Temporarily saves uncommitted changes (tracked files) so you can switch branches cleanly.

Use when:

* Mid-work but need to change branches
* Pulling changes without committing incomplete work

Restore with:

```bash
git stash pop
```

---

### 8. How do you schedule a script to run every day at 3 AM?
```bash
crontab -e
```

Add:

```bash
0 3 * * * /path/to/script.sh
```

---

### 9. What is the difference between `git fetch` and `git pull`?

* `git fetch`: Downloads changes, does NOT merge.
* `git pull`: Fetch + merge (or rebase).

Pull = fetch + integrate.

---

### 10. What is LVM and why would you use it instead of regular partitions?

**Logical Volume Manager**

Abstraction layer over physical storage:

* Resize volumes dynamically
* Combine multiple disks into one logical pool
* Snapshot support
* Easier storage management

More flexible than traditional static partitions.

---

# Task 4: Organization Checklist

Verify:

* All day-1 → day-27 committed and pushed[Done]
* `git-commands.md` updated[Done]
* Shell scripting cheat sheet complete[Done]
* GitHub profile clean:[Done]


# Task 5: Teach It Back 
---

## 1 Explain Git Branching to a Non-Developer

Think of Git like a shared document history. A **branch** is like creating a copy of the document so you can experiment without breaking the original.

The main version (often called `main`) is the official copy. When someone wants to add a feature or fix something, they create a new branch to work safely.

If everything works well, that branch gets merged back into the main version.

Branches allow multiple people to work at the same time without interfering with each other.

---

## 2 Explain File Permissions to a New Linux User

In Linux, every file and folder has rules about **who can read it, change it, or run it**.

There are three groups:

* The owner (usually the creator)
* The group (a set of users)
* Everyone else

Each group can have:

* Read (r)
* Write (w)
* Execute (x)

For example, `755` means the owner can do everything, but others can only read and run the file.

Permissions protect the system from accidental or unauthorized changes.

---

## 3 Explain What a Crontab Is and Why Sysadmins Use It

A **crontab** is a built-in Linux scheduler. It lets the system run commands or scripts automatically at specific times.

For example:

* Run a backup every day at 3 AM
* Clear log files every Sunday
* Restart a service every night

Instead of manually running tasks, sysadmins define a schedule once, and the system handles it automatically.

Crontab is essential for automation, maintenance, and reliability in server environments.

---

