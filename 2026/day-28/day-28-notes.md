# 🚀 Day 28: Revision & Mastery Day

## 📌 Overview
Today marks a critical milestone in my **#90DaysOfDevOps** journey. After 27 days of intensive learning across Linux, Shell Scripting, and Git, I dedicated today to revisiting complex topics, filling knowledge gaps, and solidifying my foundation.

---

## 🛠 Self-Assessment Checklist

### ✅ Confident In:
* **Linux Fundamentals:** Navigation, file hierarchy, and system troubleshooting (`top`, `df`, `free`).
* **User Management:** Managing permissions with `chmod` and ownership with `chown`.
* **Shell Scripting:** Writing automation scripts using loops, functions, and `crontab`.
* **Git Workflows:** Branching strategies, `git stash`, and remote repository management.

### 🔍 Re-visited Today:
* **LVM (Logical Volume Management):** Practiced creating Physical Volumes and expanding Volume Groups.
* **Git Reset vs. Revert:** Clarified when to use `--hard` reset vs. creating a safe `revert` commit.
* **Error Handling:** Refined scripts using `set -euo pipefail` for better reliability.

---

## 🎓 Teach It Back: Linux File Permissions 🛡️

I’ve summarized file permissions into a simple "VIP Club" analogy for beginners:

Every file has three groups of people who want access:
1. **Owner (u):** The VIP who created it.
2. **Group (g):** The Staff/Team.
3. **Others (o):** The General Public.

### The Math of Permissions:
We use numbers to assign "keys" to these groups:
* **Read (4):** View the content.
* **Write (2):** Modify/Delete the content.
* **Execute (1):** Run the file as a program.

**Example: `chmod 755 script.sh`**
* **7 (4+2+1):** The Owner has full power.
* **5 (4+1):** The Group and Others can read and run it, but **cannot** change it.

---

## 🧠 Quick-Fire Revision (Memory Check)

| Question | Answer |
| :--- | :--- |
| **Check port 8080?** | `sudo ss -tulpn \| grep 8080` |
| **`git pull` vs `fetch`?** | `fetch` gets updates; `pull` gets updates AND merges them into your code. |
| **`set -e` in scripts?** | Tells the script to stop immediately if any command fails. |
| **LVM Benefit?** | Allows you to resize disk space dynamically without reformatting. |

---

## 📂 Progress Audit
- [✅] All folders from Day 1 to 27 pushed and organized.
- [✅] Shell Scripting Cheat Sheet updated.
- [✅] GitHub Profile README optimized for branding.

---
**Learning in Public:**


#DevOps #Linux #ShellScripting #Git #90DaysOfDevOps