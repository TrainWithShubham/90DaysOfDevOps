# Day 09 – Linux User & Group Management Challenge

**Date:** 2026-02-18  
**Author:** Rameez Ahmed  
**Challenge:** Practice user and group management on a Linux system

---

## 📋 Overview

Today's challenge focused on **Linux user and group management**, a fundamental skill for any DevOps engineer. Managing users, groups, and permissions is critical for maintaining secure systems, controlling access to resources, and following the **principle of least privilege** in production environments.

---

## 👥 Users & Groups Created

### Users
| Username    | Home Directory        | Purpose                     |
|-------------|----------------------|------------------------------|
| `tokyo`     | `/home/tokyo`        | Developer user               |
| `berlin`    | `/home/berlin`       | Developer + Admin user       |
| `professor` | `/home/professor`    | Admin user                   |
| `nairobi`   | `/home/nairobi`      | Project team member          |

### Groups
| Group Name     | Purpose                       |
|----------------|-------------------------------|
| `developers`   | Development team group        |
| `admins`       | Administrative team group     |
| `project-team` | Cross-functional project team |

---

## 🔧 Group Assignments

| User        | Primary Group | Additional Groups          |
|-------------|---------------|----------------------------|
| `tokyo`     | `tokyo`       | `developers`, `project-team` |
| `berlin`    | `berlin`      | `developers`, `admins`     |
| `professor` | `professor`   | `admins`                   |
| `nairobi`   | `nairobi`     | `project-team`             |

---

## 📁 Directories Created

| Directory              | Group Owner    | Permissions | Description             |
|------------------------|----------------|-------------|-------------------------|
| `/opt/dev-project`     | `developers`   | `775` (rwxrwxr-x) | Shared dev workspace     |
| `/opt/team-workspace`  | `project-team` | `775` (rwxrwxr-x) | Team collaboration space |

---

## 🛠️ Commands Used

### Task 1: Create Users (with home directories and passwords)

```bash
# Create users with home directories (-m flag)
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor

# Set passwords for each user
sudo passwd tokyo
sudo passwd berlin
sudo passwd professor
```

#### Verification:

```bash
# Check /etc/passwd for the newly created users
cat /etc/passwd | grep -E "tokyo|berlin|professor"
```

**Expected Output:**
```
tokyo:x:1001:1001::/home/tokyo:/bin/sh
berlin:x:1002:1002::/home/berlin:/bin/sh
professor:x:1003:1003::/home/professor:/bin/sh
```

```bash
# Verify home directories were created
ls -la /home/ | grep -E "tokyo|berlin|professor"
```

**Expected Output:**
```
drwxr-xr-x  2 tokyo     tokyo     4096 Feb 18 23:00 tokyo
drwxr-xr-x  2 berlin    berlin    4096 Feb 18 23:00 berlin
drwxr-xr-x  2 professor professor 4096 Feb 18 23:00 professor
```

---

### Task 2: Create Groups

```bash
# Create the developers and admins groups
sudo groupadd developers
sudo groupadd admins
```

#### Verification:

```bash
# Check /etc/group for the newly created groups
cat /etc/group | grep -E "developers|admins"
```

**Expected Output:**
```
developers:x:1004:
admins:x:1005:
```

---

### Task 3: Assign Users to Groups

```bash
# Add tokyo to developers group
sudo usermod -aG developers tokyo

# Add berlin to both developers AND admins groups
sudo usermod -aG developers berlin
sudo usermod -aG admins berlin

# Add professor to admins group
sudo usermod -aG admins professor
```

> **⚠️ Important:** The `-aG` flags are critical here:
> - `-a` = **append** (without this, the user would be removed from all other supplementary groups)
> - `-G` = supplementary **groups**

#### Verification:

```bash
# Check group memberships for each user
groups tokyo
groups berlin
groups professor
```

**Expected Output:**
```
tokyo : tokyo developers
berlin : berlin developers admins
professor : professor admins
```

```bash
# Alternative: Check from the group side
cat /etc/group | grep -E "developers|admins"
```

**Expected Output:**
```
developers:x:1004:tokyo,berlin
admins:x:1005:berlin,professor
```

---

### Task 4: Shared Directory (`/opt/dev-project`)

```bash
# Step 1: Create the shared directory
sudo mkdir -p /opt/dev-project

# Step 2: Set group owner to developers
sudo chgrp developers /opt/dev-project

# Step 3: Set permissions to 775 (rwxrwxr-x)
sudo chmod 775 /opt/dev-project
```

#### Verification:

```bash
# Check the directory permissions and ownership
ls -ld /opt/dev-project
```

**Expected Output:**
```
drwxrwxr-x 2 root developers 4096 Feb 18 23:05 /opt/dev-project
```

```bash
# Test file creation as tokyo (member of developers)
sudo -u tokyo touch /opt/dev-project/tokyo-file.txt

# Test file creation as berlin (member of developers)
sudo -u berlin touch /opt/dev-project/berlin-file.txt

# Verify the files were created
ls -la /opt/dev-project/
```

**Expected Output:**
```
total 8
drwxrwxr-x 2 root   developers 4096 Feb 18 23:06 .
drwxr-xr-x 4 root   root       4096 Feb 18 23:05 ..
-rw-r--r-- 1 berlin berlin        0 Feb 18 23:06 berlin-file.txt
-rw-r--r-- 1 tokyo  tokyo         0 Feb 18 23:06 tokyo-file.txt
```

---

### Task 5: Team Workspace

```bash
# Step 1: Create user nairobi with home directory
sudo useradd -m nairobi
sudo passwd nairobi

# Step 2: Create group project-team
sudo groupadd project-team

# Step 3: Add nairobi and tokyo to project-team
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo

# Step 4: Create team workspace directory
sudo mkdir -p /opt/team-workspace

# Step 5: Set group to project-team and permissions to 775
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace
```

#### Verification:

```bash
# Check directory permissions
ls -ld /opt/team-workspace
```

**Expected Output:**
```
drwxrwxr-x 2 root project-team 4096 Feb 18 23:08 /opt/team-workspace
```

```bash
# Verify group memberships
groups nairobi
groups tokyo
```

**Expected Output:**
```
nairobi : nairobi project-team
tokyo : tokyo developers project-team
```

```bash
# Test file creation as nairobi
sudo -u nairobi touch /opt/team-workspace/nairobi-file.txt

# Verify the file was created
ls -la /opt/team-workspace/
```

**Expected Output:**
```
total 8
drwxrwxr-x 2 root    project-team 4096 Feb 18 23:09 .
drwxr-xr-x 5 root    root         4096 Feb 18 23:08 ..
-rw-r--r-- 1 nairobi nairobi         0 Feb 18 23:09 nairobi-file.txt
```

---

## 📝 Summary of All Commands

| # | Command | Purpose |
|---|---------|---------|
| 1 | `sudo useradd -m <username>` | Create a new user with a home directory |
| 2 | `sudo passwd <username>` | Set or update a user's password |
| 3 | `sudo groupadd <groupname>` | Create a new group |
| 4 | `sudo usermod -aG <group> <user>` | Add a user to a supplementary group |
| 5 | `sudo mkdir -p <path>` | Create a directory (and any parent directories) |
| 6 | `sudo chgrp <group> <directory>` | Change the group owner of a directory |
| 7 | `sudo chmod 775 <directory>` | Set permissions to rwxrwxr-x |
| 8 | `groups <username>` | Check which groups a user belongs to |
| 9 | `sudo -u <username> <command>` | Run a command as a different user |
| 10| `ls -ld <directory>` | Check directory permissions and ownership |
| 11| `cat /etc/passwd` | View user account information |
| 12| `cat /etc/group` | View group information |

---

## 💡 What I Learned

### 1. The Critical Importance of the `-a` Flag with `usermod -G`
Without the `-a` (append) flag, `usermod -G` **replaces** all existing supplementary groups. This is a common and dangerous mistake that can lock users out of critical groups. Always use `-aG` together when adding users to additional groups.

### 2. Group-Based Access Control is Foundational to DevOps
In production environments, directories like `/opt/dev-project` mirror real-world scenarios such as:
- **Shared deployment directories** where multiple team members need write access
- **Log directories** accessible to monitoring tools but restricted from general users
- **CI/CD pipelines** where build agents need specific group permissions to deploy artifacts

### 3. Permission Model: The Numeric (Octal) System
The `775` permission breaks down as:
- **7** (owner) = read (4) + write (2) + execute (1) = `rwx`
- **7** (group) = read (4) + write (2) + execute (1) = `rwx`
- **5** (others) = read (4) + execute (1) = `r-x`

This ensures that the **owner** and **group members** have full access, while **others** can only read and traverse the directory — a balanced approach for team collaboration.

---

## 🏗️ Real-World DevOps Use Cases

| Concept | Real-World Application |
|---------|----------------------|
| User management | Creating service accounts for applications (e.g., `nginx`, `postgres`) |
| Group permissions | Controlling access to deployment directories, secrets, and configs |
| Shared directories | CI/CD artifact storage, shared logs, team project workspaces |
| Principle of least privilege | Ensuring users/services only have access to what they need |

---

## 🔍 Troubleshooting Tips

| Issue | Solution |
|-------|----------|
| Permission denied | Use `sudo` before the command |
| User can't access directory | Check group membership with `groups username` |
| Permission looks correct but access denied | User may need to **log out and back in** for group changes to take effect |
| Need to check directory permissions | Use `ls -ld /path/to/directory` |
| User accidentally removed from groups | Use `usermod -aG` (with `-a` flag!) to re-add |

---

