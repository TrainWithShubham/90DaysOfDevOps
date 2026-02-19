# Day 10 – File Permissions & File Operations Challenge

**Date:** 2026-02-18  
**Author:** Rameez Ahmed  
**Challenge:** Master file permissions and basic file operations in Linux

---

## 📋 Overview

Today's challenge focused on **file permissions and file operations** — the backbone of Linux security. Every file and directory in Linux has an associated set of permissions that determine who can read, write, or execute it. Understanding this system is essential for DevOps engineers to secure servers, manage deployments, and troubleshoot access issues.

---

## 📁 Files Created

| File Name      | Method Used       | Purpose                        |
|----------------|-------------------|--------------------------------|
| `devops.txt`   | `touch`           | Empty file for permission practice |
| `notes.txt`    | `echo` / `cat >`  | File with content              |
| `script.sh`    | `vim`             | Shell script for execution test |
| `project/`     | `mkdir`           | Directory with custom permissions |

---

## 🛠️ Commands Used

### Task 1: Create Files

```bash
# 1. Create an empty file using touch
touch devops.txt

# 2. Create notes.txt with some content using echo
echo "This is my DevOps learning journal - Day 10" > notes.txt

# Alternative: Create notes.txt using cat with heredoc
cat > notes.txt << EOF
This is my DevOps learning journal - Day 10
Learning about file permissions and operations
Linux permissions are critical for system security
EOF

# 3. Create script.sh using vim with a simple script
vim script.sh
# Inside vim, type:
#   echo "Hello DevOps"
# Save and exit with :wq
```

> **💡 Quick Tip:** You can also create `script.sh` without opening vim:
> ```bash
> echo 'echo "Hello DevOps"' > script.sh
> ```

#### Verification:

```bash
ls -l devops.txt notes.txt script.sh
```

**Expected Output:**
```
-rw-r--r-- 1 rameez rameez   0 Feb 18 23:30 devops.txt
-rw-r--r-- 1 rameez rameez 112 Feb 18 23:30 notes.txt
-rw-r--r-- 1 rameez rameez  21 Feb 18 23:30 script.sh
```

> **📌 Note:** By default, new files are created with `644` (`rw-r--r--`) permissions. The `umask` value (usually `022`) determines the default permissions.

---

### Task 2: Read Files

```bash
# 1. Read notes.txt using cat
cat notes.txt
```

**Expected Output:**
```
This is my DevOps learning journal - Day 10
Learning about file permissions and operations
Linux permissions are critical for system security
```

```bash
# 2. View script.sh in vim read-only mode
vim -R script.sh
# Or use the shortcut:
view script.sh
```

> **📌 Note:** In read-only mode, vim will warn you if you try to modify the file. Press `:q` to exit.

```bash
# 3. Display first 5 lines of /etc/passwd using head
head -n 5 /etc/passwd
```

**Expected Output:**
```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
```

```bash
# 4. Display last 5 lines of /etc/passwd using tail
tail -n 5 /etc/passwd
```

**Expected Output:**
```
(last 5 users on the system will be displayed here)
```

---

### Task 3: Understand Permissions

#### The Linux Permission Model

Every file/directory in Linux has three types of permissions for three categories of users:

```
  -  rwx  rwx  rwx
  │   │    │    │
  │   │    │    └── Others (everyone else)
  │   │    └─────── Group (users in the file's group)
  │   └──────────── Owner (the file creator)
  └──────────────── File type (- = file, d = directory, l = symlink)
```

#### Permission Values (Octal)

| Symbol | Value | Meaning                       |
|--------|-------|-------------------------------|
| `r`    | 4     | **Read** – View file content / list directory |
| `w`    | 2     | **Write** – Modify file / add/remove files in directory |
| `x`    | 1     | **Execute** – Run file as program / enter directory |
| `-`    | 0     | **No permission**             |

#### Common Permission Combinations

| Octal | Symbolic    | Meaning                           |
|-------|-------------|-----------------------------------|
| `777` | `rwxrwxrwx` | Full access for everyone          |
| `755` | `rwxr-xr-x` | Owner: full, Others: read+execute |
| `644` | `rw-r--r--` | Owner: read+write, Others: read   |
| `640` | `rw-r-----` | Owner: read+write, Group: read    |
| `600` | `rw-------` | Owner only: read+write            |
| `444` | `r--r--r--` | Read-only for everyone            |
| `000` | `----------`| No access for anyone              |

#### Check Current Permissions:

```bash
ls -l devops.txt notes.txt script.sh
```

**Expected Output (Default):**
```
-rw-r--r-- 1 rameez rameez   0 Feb 18 23:30 devops.txt
-rw-r--r-- 1 rameez rameez 112 Feb 18 23:30 notes.txt
-rw-r--r-- 1 rameez rameez  21 Feb 18 23:30 script.sh
```

#### Analysis of Default Permissions (`644` / `rw-r--r--`):

| File         | Owner (rameez) | Group (rameez) | Others |
|--------------|----------------|----------------|--------|
| `devops.txt` | Read + Write   | Read only      | Read only |
| `notes.txt`  | Read + Write   | Read only      | Read only |
| `script.sh`  | Read + Write   | Read only      | Read only |

> **⚠️ Key Observation:** None of the files have **execute** (`x`) permission by default! This means `script.sh` **cannot** be run directly with `./script.sh` until we explicitly add execute permission.

---

### Task 4: Modify Permissions

#### 4.1 – Make `script.sh` Executable

```bash
# Before: Check current permissions
ls -l script.sh
```
```
-rw-r--r-- 1 rameez rameez 21 Feb 18 23:30 script.sh
```

```bash
# Add execute permission for the owner
chmod +x script.sh

# After: Verify the change
ls -l script.sh
```
```
-rwxr-xr-x 1 rameez rameez 21 Feb 18 23:30 script.sh
```

```bash
# Now run the script!
./script.sh
```
```
Hello DevOps
```

> **📌 Note:** `chmod +x` adds execute permission for **all** (owner, group, others). To add only for the owner, use `chmod u+x script.sh`.

---

#### 4.2 – Set `devops.txt` to Read-Only

```bash
# Before: Check current permissions
ls -l devops.txt
```
```
-rw-r--r-- 1 rameez rameez 0 Feb 18 23:30 devops.txt
```

```bash
# Remove write permission for ALL users (owner, group, others)
chmod a-w devops.txt

# Alternatively, use octal notation:
# chmod 444 devops.txt

# After: Verify the change
ls -l devops.txt
```
```
-r--r--r-- 1 rameez rameez 0 Feb 18 23:30 devops.txt
```

---

#### 4.3 – Set `notes.txt` to `640`

```bash
# Before: Check current permissions
ls -l notes.txt
```
```
-rw-r--r-- 1 rameez rameez 112 Feb 18 23:30 notes.txt
```

```bash
# Set permissions to 640 (owner: rw, group: r, others: none)
chmod 640 notes.txt

# After: Verify the change
ls -l notes.txt
```
```
-rw-r----- 1 rameez rameez 112 Feb 18 23:30 notes.txt
```

**Breakdown of `640`:**
- **6** (owner) = read (4) + write (2) = `rw-`
- **4** (group) = read (4) = `r--`
- **0** (others) = no permissions = `---`

---

#### 4.4 – Create Directory `project/` with Permissions `755`

```bash
# Create the directory
mkdir project

# Set permissions to 755
chmod 755 project

# Alternatively, create and set permissions in one logical step
mkdir -m 755 project

# Verify the directory permissions
ls -ld project/
```
```
drwxr-xr-x 2 rameez rameez 4096 Feb 18 23:35 project/
```

**Breakdown of `755`:**
- **7** (owner) = read (4) + write (2) + execute (1) = `rwx`
- **5** (group) = read (4) + execute (1) = `r-x`
- **5** (others) = read (4) + execute (1) = `r-x`

> **📌 For directories:** The `x` (execute) permission means the ability to **enter** (`cd`) into the directory. Without it, users cannot access the directory even if they have read permission.

---

### Task 5: Test Permissions

#### 5.1 – Writing to a Read-Only File

```bash
# Try to write to the read-only devops.txt
echo "test" >> devops.txt
```

**Error Message:**
```
bash: devops.txt: Permission denied
```

> **💡 Explanation:** The write permission was removed for all users (including the owner). The shell prevents any modification to the file.

```bash
# Even redirecting output fails
echo "test" > devops.txt
```

**Error Message:**
```
bash: devops.txt: Permission denied
```

> **⚠️ However:** The file owner can still restore write permission with `chmod u+w devops.txt` and then write to it. Root can also override this restriction.

---

#### 5.2 – Executing a File Without Execute Permission

```bash
# First, remove execute permission from script.sh
chmod -x script.sh

# Try to execute it
./script.sh
```

**Error Message:**
```
bash: ./script.sh: Permission denied
```

> **💡 Workaround:** Even without execute permission, the script can still be run using the interpreter directly:
> ```bash
> bash script.sh
> ```
> This works because `bash` reads the file (it has read permission) and interprets it — the execute bit isn't checked on the file itself in this case.

---

#### 5.3 – Accessing a File with No Permissions

```bash
# Remove ALL permissions from a test file
chmod 000 devops.txt

# Try to read it
cat devops.txt
```

**Error Message:**
```
cat: devops.txt: Permission denied
```

```bash
# Restore permissions
chmod 644 devops.txt
```

---

## 📊 Permission Changes Summary

| File/Directory | Before (Default) | After | Command Used |
|----------------|-------------------|-------|-------------|
| `script.sh`    | `-rw-r--r--` (644) | `-rwxr-xr-x` (755) | `chmod +x script.sh` |
| `devops.txt`   | `-rw-r--r--` (644) | `-r--r--r--` (444) | `chmod a-w devops.txt` |
| `notes.txt`    | `-rw-r--r--` (644) | `-rw-r-----` (640) | `chmod 640 notes.txt` |
| `project/`     | `drwxr-xr-x` (755) | `drwxr-xr-x` (755) | `mkdir -m 755 project` |

---

## 🔄 Symbolic vs Numeric (Octal) chmod

There are two ways to use `chmod`:

### Symbolic Mode

```bash
chmod u+x file     # Add execute for owner
chmod g-w file     # Remove write for group
chmod o=r file     # Set others to read-only
chmod a+x file     # Add execute for all (a = all)
chmod u=rwx,g=rx,o=r file  # Set specific permissions
```

| Symbol | Meaning |
|--------|---------|
| `u`    | User (owner) |
| `g`    | Group |
| `o`    | Others |
| `a`    | All (user + group + others) |
| `+`    | Add permission |
| `-`    | Remove permission |
| `=`    | Set exact permission |

### Numeric (Octal) Mode

```bash
chmod 755 file     # rwxr-xr-x
chmod 644 file     # rw-r--r--
chmod 600 file     # rw-------
```

> **💡 Pro Tip:** Symbolic mode is better for **relative changes** (adding/removing specific permissions), while octal mode is better for **setting exact permissions** in one command.

---

## 📝 Summary of All Commands

| # | Command | Purpose |
|---|---------|---------|
| 1 | `touch <filename>` | Create an empty file |
| 2 | `echo "text" > file` | Create a file with content (overwrites) |
| 3 | `echo "text" >> file` | Append text to a file |
| 4 | `cat > file` | Create file with interactive input (Ctrl+D to save) |
| 5 | `cat file` | Display file contents |
| 6 | `vim file` | Open file in vim editor |
| 7 | `vim -R file` / `view file` | Open file in read-only mode |
| 8 | `head -n N file` | Display first N lines of a file |
| 9 | `tail -n N file` | Display last N lines of a file |
| 10 | `ls -l` | List files with detailed permissions |
| 11 | `ls -ld <dir>` | Check directory permissions specifically |
| 12 | `chmod +x file` | Add execute permission |
| 13 | `chmod -w file` | Remove write permission |
| 14 | `chmod 755 file` | Set exact permissions using octal notation |
| 15 | `mkdir -m 755 dir` | Create directory with specific permissions |

---

## 💡 What I Learned

### 1. Default Permissions and `umask`
New files are created with `666` (rw-rw-rw-) and directories with `777` (rwxrwxrwx) as the base. The system's `umask` value (typically `022`) is then **subtracted** to give the actual permissions:
- Files: `666 - 022 = 644` (rw-r--r--)
- Directories: `777 - 022 = 755` (rwxr-xr-x)

This is why new files are never created with execute permission by default — it's a security measure!

### 2. The Execute Bit Means Different Things for Files and Directories
- **For files:** `x` means the file can be run as a program or script
- **For directories:** `x` means you can **enter** the directory with `cd` and access its contents

Without `x` on a directory, even listing (`ls`) its contents is not possible for that user, even if `r` is set. This is a subtle but critical distinction!

### 3. Permission Denied ≠ Impossible
As a file owner, you can always change permissions back (using `chmod`). And `root` can override virtually all permission restrictions. In a real DevOps environment, this means:
- **Never rely solely on file permissions** for critical security — use additional layers (SELinux, AppArmor, ACLs)
- **Service accounts** should run with minimal permissions
- **Sensitive files** (SSH keys, credentials) should be `600` (owner read/write only)

---

## 🏗️ Real-World DevOps Use Cases

| Scenario | Recommended Permission | Why |
|----------|----------------------|-----|
| SSH private key (`~/.ssh/id_rsa`) | `600` | Only the owner should read the key |
| SSH public key (`~/.ssh/id_rsa.pub`) | `644` | Everyone can read, only owner writes |
| Web server files (`/var/www/html/`) | `644` (files), `755` (dirs) | Web server reads, owner manages |
| Shell scripts in CI/CD | `755` | Must be executable by automation |
| Application config with secrets | `600` or `640` | Restrict access to sensitive data |
| Log directories | `755` | Readable for monitoring tools |
| `.env` files | `600` | Secrets must be owner-only |

---

## 🔍 Troubleshooting Tips

| Issue | Diagnosis | Solution |
|-------|-----------|----------|
| `Permission denied` when running script | Missing `x` permission | `chmod +x script.sh` |
| `Permission denied` when writing to file | Missing `w` permission | `chmod u+w file` |
| Can't `cd` into a directory | Missing `x` on directory | `chmod +x directory/` |
| SSH key rejected | Permissions too open | `chmod 600 ~/.ssh/id_rsa` |
| Web page returns 403 Forbidden | Wrong permissions on web root | `chmod 644` files, `755` dirs |
| `umask` giving unexpected defaults | Check current umask | Run `umask` to see current value |

---
