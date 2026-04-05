# Day 11 – File Ownership Challenge (chown & chgrp)

**Date:** 2026-02-18  
**Author:** Rameez Ahmed  
**Challenge:** Master file and directory ownership in Linux using `chown` and `chgrp`

---

## 📋 Overview

Today's challenge focused on **file ownership** in Linux — understanding how every file and directory has both a **user owner** and a **group owner**, and how to change them using `chown` and `chgrp`. Proper ownership management is essential for DevOps engineers managing application deployments, shared team directories, container permissions, and CI/CD pipelines.

---

## 📁 Files & Directories Created

### Files

| File Name              | Location                           | Purpose                                 |
|------------------------|------------------------------------|-----------------------------------------|
| `devops-file.txt`      | Working directory                  | Practice basic `chown` operations       |
| `team-notes.txt`       | Working directory                  | Practice basic `chgrp` operations       |
| `project-config.yaml`  | Working directory                  | Combined owner & group change practice  |
| `gold.txt`             | `heist-project/vault/`             | Recursive ownership testing             |
| `strategy.conf`        | `heist-project/plans/`             | Recursive ownership testing             |
| `access-codes.txt`     | `bank-heist/`                      | Final challenge — individual ownership  |
| `blueprints.pdf`       | `bank-heist/`                      | Final challenge — individual ownership  |
| `escape-plan.txt`      | `bank-heist/`                      | Final challenge — individual ownership  |

### Directories

| Directory Name           | Purpose                                   |
|--------------------------|-------------------------------------------|
| `app-logs/`              | Directory ownership change practice       |
| `heist-project/`         | Recursive ownership change (root dir)     |
| `heist-project/vault/`   | Sub-directory for recursive testing       |
| `heist-project/plans/`   | Sub-directory for recursive testing       |
| `bank-heist/`            | Final challenge workspace                 |

---

## 🛠️ Commands Used

### Task 1: Understanding Ownership

Every file in Linux has **two ownership attributes**:
1. **User Owner** — The user who owns the file
2. **Group Owner** — The group associated with the file

```bash
# View ownership details of files in home directory
ls -l ~
```

**Output Format:**
```
-rw-r--r--  1  owner  group  size  date  filename
│               │      │
│               │      └── Group owner
│               └── User owner (file creator)
└── Permissions
```

#### Owner vs Group — What's the Difference?

| Attribute | Description | Example |
|-----------|-------------|---------|
| **Owner** | A single user who "owns" the file. Usually the creator. Has primary control over the file. | `rameez` |
| **Group** | A group of users who share access. Multiple users can belong to the same group. | `developers` |

> **💡 Key Insight:** The owner can change permissions on the file, while group membership determines which users share the group-level permissions. A user doesn't need to be the owner to have access — they just need to be in the right group.

---

### Task 2: Basic `chown` Operations

```bash
# Step 1: Create the file
touch devops-file.txt

# Step 2: Check current ownership
ls -l devops-file.txt
```

**Output (Before):**
```
-rw-r--r-- 1 rameez rameez 0 Feb 18 23:35 devops-file.txt
```

```bash
# Step 3: Change owner to tokyo
sudo chown tokyo devops-file.txt

# Verify the change
ls -l devops-file.txt
```

**Output (After chown to tokyo):**
```
-rw-r--r-- 1 tokyo rameez 0 Feb 18 23:35 devops-file.txt
```

```bash
# Step 4: Change owner to berlin
sudo chown berlin devops-file.txt

# Step 5: Verify the change
ls -l devops-file.txt
```

**Output (After chown to berlin):**
```
-rw-r--r-- 1 berlin rameez 0 Feb 18 23:35 devops-file.txt
```

> **📌 Note:** Only `root` (via `sudo`) can change file ownership. A regular user cannot give away their files to another user — this is a security feature to prevent abuse.

---

### Task 3: Basic `chgrp` Operations

```bash
# Step 1: Create the file
touch team-notes.txt

# Step 2: Check current group
ls -l team-notes.txt
```

**Output (Before):**
```
-rw-r--r-- 1 rameez rameez 0 Feb 18 23:36 team-notes.txt
```

```bash
# Step 3: Create the heist-team group
sudo groupadd heist-team

# Step 4: Change file group to heist-team
sudo chgrp heist-team team-notes.txt

# Step 5: Verify the change
ls -l team-notes.txt
```

**Output (After chgrp):**
```
-rw-r--r-- 1 rameez heist-team 0 Feb 18 23:36 team-notes.txt
```

> **📌 `chgrp` vs `chown :group`:** Both commands can change the group of a file:
> - `sudo chgrp heist-team file.txt` — dedicated group change command
> - `sudo chown :heist-team file.txt` — using chown with `:group` syntax (owner stays unchanged)
>
> They are functionally equivalent for group changes.

---

### Task 4: Combined Owner & Group Change

The `chown` command supports changing **both** owner and group in a **single command** using the `owner:group` syntax.

```bash
# Step 1: Create project-config.yaml
touch project-config.yaml

# Check current ownership
ls -l project-config.yaml
```

**Output (Before):**
```
-rw-r--r-- 1 rameez rameez 0 Feb 18 23:37 project-config.yaml
```

```bash
# Step 2: Change BOTH owner to professor AND group to heist-team (one command!)
sudo chown professor:heist-team project-config.yaml

# Verify the change
ls -l project-config.yaml
```

**Output (After):**
```
-rw-r--r-- 1 professor heist-team 0 Feb 18 23:37 project-config.yaml
```

```bash
# Step 3: Create app-logs directory
mkdir app-logs

# Step 4: Change directory owner to berlin and group to heist-team
sudo chown berlin:heist-team app-logs/

# Verify the directory change
ls -ld app-logs/
```

**Output (After):**
```
drwxr-xr-x 2 berlin heist-team 4096 Feb 18 23:38 app-logs/
```

#### `chown` Syntax Variations

| Syntax | Effect |
|--------|--------|
| `chown user file` | Change **owner only** |
| `chown :group file` | Change **group only** (note the colon) |
| `chown user:group file` | Change **both owner and group** |
| `chown user: file` | Change owner and set group to user's **login group** |

---

### Task 5: Recursive Ownership

The `-R` (recursive) flag applies ownership changes to a directory **and all of its contents** (files and subdirectories).

```bash
# Step 1: Create the directory structure
mkdir -p heist-project/vault
mkdir -p heist-project/plans
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf

# Verify the structure
ls -lR heist-project/
```

**Output (Before — all owned by rameez):**
```
heist-project/:
total 8
drwxr-xr-x 2 rameez rameez 4096 Feb 18 23:39 plans
drwxr-xr-x 2 rameez rameez 4096 Feb 18 23:39 vault

heist-project/plans:
total 0
-rw-r--r-- 1 rameez rameez 0 Feb 18 23:39 strategy.conf

heist-project/vault:
total 0
-rw-r--r-- 1 rameez rameez 0 Feb 18 23:39 gold.txt
```

```bash
# Step 2: Create the planners group
sudo groupadd planners

# Step 3: Change ownership RECURSIVELY
sudo chown -R professor:planners heist-project/

# Step 4: Verify ALL files and subdirectories changed
ls -lR heist-project/
```

**Output (After — ALL owned by professor:planners):**
```
heist-project/:
total 8
drwxr-xr-x 2 professor planners 4096 Feb 18 23:39 plans
drwxr-xr-x 2 professor planners 4096 Feb 18 23:39 vault

heist-project/plans:
total 0
-rw-r--r-- 1 professor planners 0 Feb 18 23:39 strategy.conf

heist-project/vault:
total 0
-rw-r--r-- 1 professor planners 0 Feb 18 23:39 gold.txt
```

> **✅ Key Point:** The `-R` flag changed ownership on:
> - The `heist-project/` directory itself
> - Both subdirectories (`vault/` and `plans/`)
> - Both files inside (`gold.txt` and `strategy.conf`)
>
> **All in a single command!**

> **⚠️ Warning:** Be extremely careful with `chown -R` on system directories (like `/`, `/etc`, `/var`). A misapplied recursive ownership change can **break your entire system**.

---

### Task 6: Practice Challenge

```bash
# Step 1: Create users (if not already created from Day 09)
sudo useradd -m tokyo 2>/dev/null
sudo useradd -m berlin 2>/dev/null
sudo useradd -m nairobi 2>/dev/null

# Step 2: Create groups
sudo groupadd vault-team
sudo groupadd tech-team

# Step 3: Create the bank-heist directory
mkdir bank-heist

# Step 4: Create files inside bank-heist
touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt
```

**Verify (Before):**
```bash
ls -l bank-heist/
```
```
total 0
-rw-r--r-- 1 rameez rameez 0 Feb 18 23:40 access-codes.txt
-rw-r--r-- 1 rameez rameez 0 Feb 18 23:40 blueprints.pdf
-rw-r--r-- 1 rameez rameez 0 Feb 18 23:40 escape-plan.txt
```

```bash
# Step 5: Set different ownership for each file
sudo chown tokyo:vault-team bank-heist/access-codes.txt
sudo chown berlin:tech-team bank-heist/blueprints.pdf
sudo chown nairobi:vault-team bank-heist/escape-plan.txt
```

**Verify (After):**
```bash
ls -l bank-heist/
```
```
total 0
-rw-r--r-- 1 tokyo   vault-team 0 Feb 18 23:40 access-codes.txt
-rw-r--r-- 1 berlin  tech-team  0 Feb 18 23:40 blueprints.pdf
-rw-r--r-- 1 nairobi vault-team 0 Feb 18 23:40 escape-plan.txt
```

> **✅ Each file now has a different owner and group, demonstrating granular ownership control!**

---

## 🔄 Ownership Changes Summary

| File/Directory | Before (owner:group) | After (owner:group) | Command |
|----------------|---------------------|---------------------|---------|
| `devops-file.txt` | `rameez:rameez` | `berlin:rameez` | `sudo chown berlin devops-file.txt` |
| `team-notes.txt` | `rameez:rameez` | `rameez:heist-team` | `sudo chgrp heist-team team-notes.txt` |
| `project-config.yaml` | `rameez:rameez` | `professor:heist-team` | `sudo chown professor:heist-team project-config.yaml` |
| `app-logs/` | `rameez:rameez` | `berlin:heist-team` | `sudo chown berlin:heist-team app-logs/` |
| `heist-project/` (recursive) | `rameez:rameez` | `professor:planners` | `sudo chown -R professor:planners heist-project/` |
| `access-codes.txt` | `rameez:rameez` | `tokyo:vault-team` | `sudo chown tokyo:vault-team bank-heist/access-codes.txt` |
| `blueprints.pdf` | `rameez:rameez` | `berlin:tech-team` | `sudo chown berlin:tech-team bank-heist/blueprints.pdf` |
| `escape-plan.txt` | `rameez:rameez` | `nairobi:vault-team` | `sudo chown nairobi:vault-team bank-heist/escape-plan.txt` |

---

## 📝 Summary of All Commands

| # | Command | Purpose |
|---|---------|---------|
| 1 | `ls -l <file>` | View file ownership (owner and group) |
| 2 | `ls -ld <dir>` | View directory ownership |
| 3 | `ls -lR <dir>` | View ownership recursively for all contents |
| 4 | `sudo chown <user> <file>` | Change file owner only |
| 5 | `sudo chown :<group> <file>` | Change file group only (using chown) |
| 6 | `sudo chown <user>:<group> <file>` | Change both owner and group at once |
| 7 | `sudo chown <user>: <file>` | Change owner and set group to user's login group |
| 8 | `sudo chgrp <group> <file>` | Change file group (dedicated command) |
| 9 | `sudo chown -R <user>:<group> <dir>` | Recursively change ownership of dir and all contents |
| 10 | `sudo chgrp -R <group> <dir>` | Recursively change group of dir and all contents |
| 11 | `sudo useradd -m <user>` | Create a new user (prerequisite for chown) |
| 12 | `sudo groupadd <group>` | Create a new group (prerequisite for chgrp) |

---

## 🧠 `chown` vs `chgrp` — When to Use Which?

| Feature                    | `chown`               | `chgrp`   |
| -------------------------- | --------------------- | --------- |
| Change owner               | ✅ Yes                 | ❌ No      |
| Change group               | ✅ Yes (with `:group`) | ✅ Yes     |
| Change both simultaneously | ✅ Yes (`user:group`)  | ❌ No      |
| Recursive (`-R`)           | ✅ Yes                 | ✅ Yes     |
| Requires `sudo`            | ✅ Usually             | ✅ Usually |

> **💡 Recommendation:** Use `chown` for most scenarios since it can do everything `chgrp` can plus more. Use `chgrp` when you explicitly want to **only** change the group and want your command to be self-documenting.

---

## 💡 What I Learned

### 1. Ownership is Separate from Permissions
Ownership (who owns the file) and permissions (what actions are allowed) are **two distinct systems** that work together:
- **Ownership** determines which permission set applies to a user (owner, group, or others)
- **Permissions** determine what actions are allowed for each category

For example, a file owned by `tokyo:developers` with permissions `640`:
- `tokyo` (owner) → gets `rw-` (read + write)
- Users in `developers` group → get `r--` (read only)
- Everyone else → gets `---` (no access)

### 2. The `-R` Flag is Powerful but Dangerous
Recursive ownership changes (`chown -R`) affect **every single file and directory** within the target. This is incredibly useful for:
- Setting up new application deployments
- Fixing broken permissions after a migration
- Provisioning shared project directories

But it can also be **destructive** if applied to wrong directories. Always double-check the path before running `chown -R`, especially with `sudo`.

### 3. Why `sudo` is Required for `chown`
Linux prevents regular users from changing file ownership as a **security measure**:
- **Prevents quota abuse** — A user could create large files and "give" them to another user, consuming their disk quota
- **Prevents privilege escalation** — A user could create a setuid program and assign it to root
- **Maintains accountability** — File ownership provides an audit trail of who created what

Only `root` (via `sudo`) can change ownership — this is by design, not a limitation!

---

## 🏗️ Real-World DevOps Use Cases

| Scenario | Command Example | Why It Matters |
|----------|----------------|----------------|
| **Application deployment** | `sudo chown -R www-data:www-data /var/www/app/` | Web server needs ownership of app files |
| **Shared team directory** | `sudo chown :dev-team /opt/project/` | Team members need group access to project files |
| **Container file mounts** | `sudo chown -R 1000:1000 /data/volume/` | Containers often run as specific UIDs |
| **CI/CD artifact directory** | `sudo chown jenkins:jenkins /var/lib/jenkins/` | Build agent needs ownership of its workspace |
| **Log file management** | `sudo chown syslog:adm /var/log/app.log` | Log collector needs appropriate ownership |
| **Database data directory** | `sudo chown -R postgres:postgres /var/lib/postgresql/` | Database must own its data files |
| **SSH key setup** | `sudo chown user:user ~/.ssh/authorized_keys` | SSH daemon enforces strict ownership checks |

---

## 🔍 Troubleshooting Tips

| Issue | Cause | Solution |
|-------|-------|----------|
| `chown: invalid user` | User doesn't exist | Create user first: `sudo useradd <username>` |
| `chgrp: invalid group` | Group doesn't exist | Create group first: `sudo groupadd <groupname>` |
| `Operation not permitted` | Not using `sudo` | Prefix with `sudo`: `sudo chown ...` |
| Ownership didn't change on subdirectories | Forgot `-R` flag | Use recursive: `sudo chown -R user:group dir/` |
| App can't read files after chown | Wrong user/group | Verify the app runs as the correct user with `ps aux` |
| Container permission issues | UID mismatch | Match container UID with `chown <UID>:<GID> dir/` |

---

