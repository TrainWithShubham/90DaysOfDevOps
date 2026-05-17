### Task 1: Self-Assessment Checklist
- **Can do confidently**
- **Need to revisit**
- **Haven't done yet**

#### Linux
- [**Can do confidently**] Navigate the file system, create/move/delete files and directories
- [**Can do confidently** ] Manage processes — list, kill, background/foreground
- [ **Can do confidently**] Work with systemd — start, stop, enable, check status of services
- [**Can do confidently** ] Read and edit text files using vi/vim or nano
- [ **Can do confidently**] Troubleshoot CPU, memory, and disk issues using top, free, df, du
- [ **Can do confidently**] Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
- [**Can do confidently** ] Create users and groups, manage passwords
- [ **Can do confidently**] Set file permissions using chmod (numeric and symbolic)
- [ **Can do confidently**] Change file ownership with chown and chgrp
- [ **Can do confidently**] Create and manage LVM volumes
- [ **Can do confidently**] Check network connectivity — ping, curl, netstat, ss, dig, nslookup
- [**Can do confidently** ] Explain DNS resolution, IP addressing, subnets, and common ports

#### Shell Scripting
- [**Need to revisit** ] Write a script with variables, arguments, and user input
- [ **Need to revisit** ] Use if/elif/else and case statements
- [**Need to revisit** ] Write for, while, and until loops
- [**Need to revisit** ] Define and call functions with arguments and return values
- [**Need to revisit** ] Use grep, awk, sed, sort, uniq for text processing
- [**Need to revisit** ] Handle errors with set -e, set -u, set -o pipefail, trap
- [**Can do confidently**] Schedule scripts with crontab

#### Git & GitHub
- [**Can do confidently** ] Initialize a repo, stage, commit, and view history
- [ **Can do confidently**] Create and switch branches
- [ **Can do confidently**] Push to and pull from GitHub
- [ **Can do confidently**] Explain clone vs fork
- [**Can do confidently** ] Merge branches — understand fast-forward vs merge commit
- [ **Can do confidently**] Rebase a branch and explain when to use it vs merge
- [ **Can do confidently**] Use git stash and git stash pop
- [ **Can do confidently**] Cherry-pick a commit from another branch
- [ **Can do confidently**] Explain squash merge vs regular merge
- [**Can do confidently**] Use git reset (soft, mixed, hard) and git revert
- [ **Can do confidently**] Explain GitFlow, GitHub Flow, and Trunk-Based Development
- [ **Can do confidently**] Use GitHub CLI to create repos, PRs, and issues

---

### Task 2: Revisit Weak Spots

### Weak Spot: Shell Scripting

**What I Re-learned**:

1. Refreshed how to use variables and pass arguments correctly in scripts.

2. Practiced writing if/elif/else and case statements for decision-making.

3. Reworked for, while, and until loops to improve understanding.

4. Strengthened my basics in grep, awk, and sed for text processing.

5. I realized that I am still not fully confident in writing shell scripts. I need more hands-on practice to improve my syntax and problem-solving speed.

**Action Plan**:
- From now on,I will practice shell scripting daily to build confidence and make it a habit.
---

### Task 3: Quick-Fire Questions
Answer these from memory (no Googling). Then verify your answers:

1. What does `chmod 755 script.sh` do?
- owner can read/write/execute, groups & others can read/execute.
2. What is the difference between a process and a service?
- process is a running program instance, service is a long running background process.
3. How do you find which process is using port 8080?
- ss -tulnp | grep 8080
4. What does `set -euo pipefail` do in a shell script?
- makes a script exit immediately if any command fails,if an undefined variable is used,or if any command in a pipeline fails.
5. What is the difference between `git reset --hard` and `git revert`?
- `git reset --hard`: removes commit from history
- `git revert`: creates a new commit,keeps original commit in history
6. What branching strategy would you recommend for a team of 5 developers shipping weekly?
- Trunk-Based Development becasue it keeps things simple ,reduces merge conflicts and supports frequent releases. 
7. What does `git stash` do and when would you use it?
- temporarily saves uncommitted changes so you can switch branches without committing. 
8. How do you schedule a script to run every day at 3 AM?
- using crontab 0 3 * * * /path/to/script.sh
9. What is the difference between `git fetch` and `git pull`?
- `git fetch` downloads changes without merging,while `git pull` fetches and merges
10. What is LVM and why would you use it instead of regular partitions?
- LVM is a way to manage disk space more flexibly.so you can easily increase,decrease or combine disk space.
- Regular partitions are fixed in size and hard to change.while LVM lets you easily resize or combine disk space whenever you need.

---

### Task 4: Organize Your Work
1. [✅] Make sure all your daily submissions (day-1 through day-27) are committed and pushed 
2. [✅] Check that your `git-commands.md` is up to date
3. [✅] Check that your shell scripting cheat sheet is complete 
4. [✅] Verify your GitHub profile and repos are clean (from Day 27) 

---

### Task 5: Teach It Back

1. Explain file permissions to a new Linux user

**Home Door Analogy**
- 	Read (r): You can open the door and look inside.
- 	Write (w): You can move furniture.
- 	Execute (x): You can actually use the room — like turning on the lights and living in it.

In simple terms: Linux permissions are like house rules — they decide who can look,change or use a room.
