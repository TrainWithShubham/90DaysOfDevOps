# Day 28 – Revision Day: Everything from Day 1 to Day 27

## Task

You've covered a lot of ground in 27 days — DevOps fundamentals, Linux deep dives, Shell scripting, Python basics, Git & GitHub, and even your developer branding. Today, **stop and revise**. No new concepts. Just solidify what you've learned.

The goal is to identify gaps, revisit topics you struggled with, and make sure you can confidently explain and use everything covered so far.

---

## What You've Covered So Far

| Days | Topic | Key Concepts |
|------|-------|-------------|
| 1 | DevOps & Cloud Intro | What is DevOps, SDLC, Cloud basics |
| 2–7 | Linux Fundamentals | Architecture, commands, processes, systemd, file system hierarchy, troubleshooting, text files |
| 8 | Cloud Server Setup | Docker, Nginx, web deployment |
| 9–11 | Users, Permissions & Ownership | User/group management, file permissions, chown/chgrp |
| 12 | Revision Day 1 | Days 1–11 recap |
| 13 | Volume Management | LVM — physical volumes, volume groups, logical volumes |
| 14–15 | Networking | Fundamentals, DNS, IP, subnets, ports, hands-on checks |
| 16–18 | Shell Scripting | Basics, loops, arguments, error handling, functions |
| 19–20 | Shell Scripting Projects | Log rotation, backup, crontab, log analyzer |
| 21 | Shell Scripting Cheat Sheet | Personal reference guide |
| 22–25 | Git & GitHub | Init, branching, merge, rebase, stash, cherry pick, reset, revert, branching strategies |
| 26 | GitHub CLI | Managing GitHub from the terminal |
| 27 | GitHub Profile | Profile README, repo organization, developer branding |

---

## Challenge Tasks

### Task 1: Self-Assessment Checklist
Go through the checklist below. For each item, mark yourself honestly:
- **Can do confidently**
- **Need to revisit**
- **Haven't done yet**

#### Linux
- ✅ Navigate the file system, create/move/delete files and directories
- ✅ Manage processes — list, kill, background/foreground
- ✅ Work with systemd — start, stop, enable, check status of services
- ✅ Read and edit text files using vi/vim or nano
- ✅ Troubleshoot CPU, memory, and disk issues using top, free, df, du
- ✅ Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
- ✅ Create users and groups, manage passwords
- ✅ Set file permissions using chmod (numeric and symbolic)
- ✅ Change file ownership with chown and chgrp
- ✅ Create and manage LVM volumes
- ✅ Check network connectivity — ping, curl, netstat, ss, dig, nslookup
- ✅ Explain DNS resolution, IP addressing, subnets, and common ports

#### Shell Scripting
- ✅ Write a script with variables, arguments, and user input
- ✅ Use if/elif/else and case statements
- ✅ Write for, while, and until loops
- ✅ Define and call functions with arguments and return values
- ✅ Use grep, awk, sed, sort, uniq for text processing
- ✅ Handle errors with set -e, set -u, set -o pipefail, trap
- ✅ Schedule scripts with crontab

#### Git & GitHub
- ✅ Initialize a repo, stage, commit, and view history
- ✅ Create and switch branches
- ✅ Push to and pull from GitHub
- ✅ Explain clone vs fork
- ✅ Merge branches — understand fast-forward vs merge commit
- ✅ Rebase a branch and explain when to use it vs merge
- ✅ Use git stash and git stash pop
- ✅ Cherry-pick a commit from another branch
- ✅ Explain squash merge vs regular merge
- ✅ Use git reset (soft, mixed, hard) and git revert
- ✅ Explain GitFlow, GitHub Flow, and Trunk-Based Development
- ✅ Use GitHub CLI to create repos, PRs, and issues

---

### Task 2: Revisit Your Weak Spots
1. Pick **3 topics** from the checklist where you marked "Need to revisit"
 - CIDR & SUBNETING
 - GIT ERROR HANDLING
 - DNS RESOLUTION

---

### Task 3: Quick-Fire Questions
Answer these from memory (no Googling). Then verify your answers:

1. What does `chmod 755 script.sh` do?
 - Give the owner read write execute permission.
 - Give group and other read and execute permission.

2. What is the difference between a process and a service?
 - a process is the runnign instance program.
 - a service is the running in background process is the runnging continuosly in background.

3. How do you find which process is using port 8080?
  - sudo ss -tlnp sport = :80

4. What does `set -euo pipefail` do in a shell script?
   - this use if your script have any error the exact there this is stop and exit from this.
   - detect error in your pipeline
   - treat unset variable like a error

5. What is the difference between `git reset --hard` and `git revert`?
   - git reset --hard rewrite the commit history 
   - git revert create new commit and safely undo previous changes

 
7. What does `git stash` do and when would you use it?
 - when you doning wokr and come some emergency work but i dont need commit this then use git stash.
 - then after i finish emergency work then come and do this work again to use git pop.

8. How do you schedule a script to run every day at 3 AM?
  - 0 3 * * *

9. What is the difference between `git fetch` and `git pull`?
 - git fetch download the changes of remote in local without merging
 - git pull download the changes into the local with merging.

10. What is LVM and why would you use it instead of regular partitions?
 - Logical Volume Manager (LVM) provides flexible disk management by creating Logical Volumes from Volume Groups, allowing storage to be resized without repartitioning disks.



---


### Task 4: Organize Your Work
☑ Verified all Day 1–27 tasks are committed and pushed
☑ Reviewed markdown documentation
☑ Updated GitHub repositories
☑ Verified GitHub Profile README
☑ Organized screenshots and project files

---

### Task 5: Teach It Back
Pick **one topic** you've learned and write a short explanation (5-10 lines) as if you're teaching it to someone who has never heard of it. Add it to your `day-28-notes.md`.

1. cronttab
 - the crontab is best sorftware to if you want do 1 work daily at same time then use of crontab
   like suppose in you in a company your boss say you take a daily bakup of this file ata every 10 am then you can use crontab and backup will genrate automatic you dont do anything.

2. DNS Resolution
- get anything ex if google.com is the domain name when you serch in browser in the backgrond dns resolve this ip and go to this server where this website is live or this ip which instnce this running .

3. Linux file permission 
 - int the linux you have a permision to execute the fiel rwx that type of permission of you want execute any file then you can execute the filse permission set from chmod.


## Key Takeaways
- Strengthened Linux fundamentals through revision.
- Improved understanding of networking concepts.
- Reinforced shell scripting and automation basics.
- Gained better confidence with Git and GitHub workflows.
- Identified weak areas for continued practice.

## Outcome
- By the end of Day 28, I was able to:

- Revise concepts from Day 1–27.
- Validate my understanding with self-assessment.
- Answer fundamental DevOps interview questions.
- Organize my GitHub documentation.
- Build a stronger foundation before moving to advanced DevOps topics.


`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
