# Day 10 Challenge - File Permissions & File Operations

**Date:** February 03, 2026  
**Focus:** Mastering file creation, reading, and permission management in Linux

---
<img width="1014" height="724" alt="image" src="https://github.com/user-attachments/assets/470648a7-9ea2-497e-93c1-125b715abf67" />

## Challenge Overview

This challenge builds on fundamental Linux skills:
- Creating files using different methods
- Reading file contents with various tools
- Understanding the Linux permission model
- Modifying permissions for security and functionality
- Testing permission restrictions

---

## Task 1: Create Files

### Objective
Create files using different methods: `touch`, `cat`/`echo`, and `vim`

### Commands and Steps

#### File 1: Create empty file using touch
```bash
touch devops.txt
```

**Verification:**
```bash
ls -l devops.txt
```

**Output:**
```
-rw-r--r-- 1 devuser devuser 0 Feb  3 16:00 devops.txt
```

**What happened:**
- `touch` created an empty file (0 bytes)
- Default permissions: `-rw-r--r--` (644)
- Owner and group: current user (devuser)

---

#### File 2: Create file with content using echo and redirection

**Method 1: Using echo with redirection**
```bash
echo "This is my DevOps learning journey" > notes.txt
echo "Day 10: File Permissions Challenge" >> notes.txt
echo "Learning Linux fundamentals" >> notes.txt
echo "Mastering chmod and file operations" >> notes.txt
```

**Method 2: Using cat with heredoc**
```bash
cat > notes.txt << EOF
This is my DevOps learning journey
Day 10: File Permissions Challenge
Learning Linux fundamentals
Mastering chmod and file operations
EOF
```

**Verification:**
```bash
ls -l notes.txt
cat notes.txt
```

**Output:**
```
-rw-r--r-- 1 devuser devuser 128 Feb  3 16:02 notes.txt
```

**Content:**
```
This is my DevOps learning journey
Day 10: File Permissions Challenge
Learning Linux fundamentals
Mastering chmod and file operations
```

---

#### File 3: Create shell script using vim

**Step 1: Create file with vim**
```bash
vim script.sh
```

**Step 2: In vim, press `i` to enter insert mode, then type:**
```bash
#!/bin/bash
echo "Hello DevOps"
echo "Today is Day 10 of 90 Days Challenge"
echo "Current user: $USER"
echo "Current directory: $(pwd)"
```

**Step 3: Save and exit vim**
- Press `Esc` to exit insert mode
- Type `:wq` and press Enter (write and quit)

**Verification:**
```bash
ls -l script.sh
cat script.sh
```

**Output:**
```
-rw-r--r-- 1 devuser devuser 156 Feb  3 16:05 script.sh
```

**Content:**
```bash
#!/bin/bash
echo "Hello DevOps"
echo "Today is Day 10 of 90 Days Challenge"
echo "Current user: $USER"
echo "Current directory: $(pwd)"
```

---

### Summary of Files Created
```bash
ls -lh devops.txt notes.txt script.sh
```

**Output:**
```
-rw-r--r-- 1 devuser devuser   0 Feb  3 16:00 devops.txt
-rw-r--r-- 1 devuser devuser 128 Feb  3 16:02 notes.txt
-rw-r--r-- 1 devuser devuser 156 Feb  3 16:05 script.sh
```

**Observations:**
- All files created with default permissions `644` (`rw-r--r--`)
- Owner can read and write
- Group and others can only read
- `script.sh` is NOT executable yet (no `x` permission)

✅ **Task 1 Complete:** Three files created using different methods.

---

## Task 2: Read Files

### Objective
Read file contents using different Linux tools

### Commands and Outputs

#### Method 1: Read with cat (full content)
```bash
cat notes.txt
```

**Output:**
```
This is my DevOps learning journey
Day 10: File Permissions Challenge
Learning Linux fundamentals
Mastering chmod and file operations
```

**Use case:** Best for small files where you want to see everything.

---

#### Method 2: View file in vim (read-only mode)
```bash
vim -R script.sh
```
**Alternative:**
```bash
view script.sh
```

**What you see in vim:**
```bash
#!/bin/bash
echo "Hello DevOps"
echo "Today is Day 10 of 90 Days Challenge"
echo "Current user: $USER"
echo "Current directory: $(pwd)"
~
~
-- READONLY --
```

**How to navigate in vim:**
- Arrow keys or `j`/`k` to move up/down
- `:q` to quit
- Cannot edit in read-only mode

**Use case:** Safely view files without risk of accidental edits.

---

#### Method 3: Display first 5 lines using head
```bash
head -n 5 /etc/passwd
```

**Output:**
```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
```

**Explanation:**
- Shows first 5 user accounts from system password file
- Format: `username:x:UID:GID:comment:home:shell`

**Custom example with our file:**
```bash
head -n 2 notes.txt
```

**Output:**
```
This is my DevOps learning journey
Day 10: File Permissions Challenge
```

**Use case:** Preview file contents without loading entire file.

---

#### Method 4: Display last 5 lines using tail
```bash
tail -n 5 /etc/passwd
```

**Output:**
```
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
devuser:x:1000:1000:DevOps User:/home/devuser:/bin/bash
tokyo:x:1001:1001::/home/tokyo:/bin/bash
berlin:x:1002:1002::/home/berlin:/bin/bash
professor:x:1003:1003::/home/professor:/bin/bash
```

**Custom example with our file:**
```bash
tail -n 2 notes.txt
```

**Output:**
```
Learning Linux fundamentals
Mastering chmod and file operations
```

**Use case:** Check latest entries in log files or end of documents.

---

#### Method 5: Advanced reading - line numbers
```bash
cat -n notes.txt
```

**Output:**
```
     1	This is my DevOps learning journey
     2	Day 10: File Permissions Challenge
     3	Learning Linux fundamentals
     4	Mastering chmod and file operations
```

**Use case:** Reference specific lines when debugging or discussing files.

---

#### Method 6: Read with less (paginated view)
```bash
less notes.txt
```

**Navigation:**
- Space = next page
- `b` = previous page
- `/pattern` = search
- `q` = quit

**Use case:** Large files that don't fit on one screen.

---

### Reading Commands Summary

| Command | Purpose | Best For |
|---------|---------|----------|
| `cat file` | Display full content | Small files |
| `vim -R file` or `view file` | Read-only editing | Safe viewing |
| `head -n N file` | First N lines | File headers, previews |
| `tail -n N file` | Last N lines | Recent log entries |
| `less file` | Paginated view | Large files |
| `cat -n file` | With line numbers | Code review, debugging |

✅ **Task 2 Complete:** Practiced multiple file reading methods.

---

## Task 3: Understand Permissions

### Permission Format Breakdown
```
-rw-r--r--
│││││││││└── Other: read
││││││││└─── Other: write (not set)
│││││││└──── Other: execute (not set)
││││││└───── Group: read
│││││└────── Group: write (not set)
││││└─────── Group: execute (not set)
│││└──────── Owner: read
││└───────── Owner: write
│└────────── Owner: execute (not set)
└─────────── File type (- = regular file, d = directory, l = link)
```

### Numeric Representation

| Symbol | Binary | Decimal | Meaning |
|--------|--------|---------|---------|
| `---` | 000 | 0 | No permissions |
| `--x` | 001 | 1 | Execute only |
| `-w-` | 010 | 2 | Write only |
| `-wx` | 011 | 3 | Write + Execute |
| `r--` | 100 | 4 | Read only |
| `r-x` | 101 | 5 | Read + Execute |
| `rw-` | 110 | 6 | Read + Write |
| `rwx` | 111 | 7 | Read + Write + Execute |

---

### Check Current Permissions
```bash
ls -l devops.txt notes.txt script.sh
```

**Output:**
```
-rw-r--r-- 1 devuser devuser   0 Feb  3 16:00 devops.txt
-rw-r--r-- 1 devuser devuser 128 Feb  3 16:02 notes.txt
-rw-r--r-- 1 devuser devuser 156 Feb  3 16:05 script.sh
```

---

### Permission Analysis

#### devops.txt: `-rw-r--r--` (644)

**Breakdown:**
- Owner (devuser): `rw-` = read + write (6)
- Group (devuser): `r--` = read only (4)
- Others: `r--` = read only (4)

**What this means:**
- ✅ Owner can read and modify the file
- ✅ Group members can read the file
- ✅ Anyone else can read the file
- ❌ Nobody can execute (it's not a script)
- ❌ Group and others cannot modify

---

#### notes.txt: `-rw-r--r--` (644)

**Breakdown:**
- Owner (devuser): `rw-` = read + write (6)
- Group (devuser): `r--` = read only (4)
- Others: `r--` = read only (4)

**What this means:**
- ✅ Owner can read and edit notes
- ✅ Others can read but not modify
- 🔒 Good for shared documentation

---

#### script.sh: `-rw-r--r--` (644)

**Breakdown:**
- Owner (devuser): `rw-` = read + write (6)
- Group (devuser): `r--` = read only (4)
- Others: `r--` = read only (4)

**Problem:**
- ❌ Script is NOT executable (no `x` permission)
- ❌ Cannot run with `./script.sh`

**Why?** Linux requires explicit execute permission for scripts and programs.

---

### Test Current Permissions

**Try to execute script.sh:**
```bash
./script.sh
```

**Output:**
```
bash: ./script.sh: Permission denied
```

**Expected:** Script needs execute permission to run. We'll fix this in Task 4.

✅ **Task 3 Complete:** Understanding permission structure and numeric notation.

---

## Task 4: Modify Permissions

### Objective
Modify file permissions using `chmod` with both symbolic and numeric methods

---

### Change 1: Make script.sh Executable

**Current permissions:**
```bash
ls -l script.sh
```
**Output:** `-rw-r--r--` (644)

**Method 1: Add execute permission (symbolic)**
```bash
chmod +x script.sh
```

**Verification:**
```bash
ls -l script.sh
```
**Output:**
```
-rwxr-xr-x 1 devuser devuser 156 Feb  3 16:05 script.sh
```

**What changed:**
- Before: `-rw-r--r--` (644)
- After: `-rwxr-xr-x` (755)
- `+x` added execute for owner, group, and others

**Method 2: Specific permissions (numeric)**
```bash
chmod 755 script.sh
```
- `7` (owner) = `rwx`
- `5` (group) = `r-x`
- `5` (others) = `r-x`

---

**Test execution:**
```bash
./script.sh
```

**Output:**
```
Hello DevOps
Today is Day 10 of 90 Days Challenge
Current user: devuser
Current directory: /home/devuser
```

✅ **Success!** Script now executes properly.

---

### Change 2: Make devops.txt Read-Only (Remove Write Permission)

**Current permissions:**
```bash
ls -l devops.txt
```
**Output:** `-rw-r--r--` (644)

**Remove write permission for all:**
```bash
chmod -w devops.txt
```

**Verification:**
```bash
ls -l devops.txt
```
**Output:**
```
-r--r--r-- 1 devuser devuser 0 Feb  3 16:00 devops.txt
```

**What changed:**
- Before: `-rw-r--r--` (644)
- After: `-r--r--r--` (444)
- Write permission removed from owner, group, and others

**Alternative (numeric method):**
```bash
chmod 444 devops.txt
```

---

**Test write protection:**
```bash
echo "Testing write" > devops.txt
```

**Output:**
```
bash: devops.txt: Permission denied
```

✅ **Success!** File is now read-only, even for the owner.

---

### Change 3: Set notes.txt to 640 Permissions

**Current permissions:**
```bash
ls -l notes.txt
```
**Output:** `-rw-r--r--` (644)

**Set to 640:**
```bash
chmod 640 notes.txt
```

**Verification:**
```bash
ls -l notes.txt
```
**Output:**
```
-rw-r----- 1 devuser devuser 128 Feb  3 16:02 notes.txt
```

**Permission breakdown:**
- `6` (owner) = `rw-` = read + write
- `4` (group) = `r--` = read only
- `0` (others) = `---` = no access

**What this means:**
- ✅ Owner can read and edit
- ✅ Group can read
- ❌ Others have no access (more secure)

**Use case:** Sensitive files that should only be accessible to owner and team.

---

### Change 4: Create Directory with 755 Permissions

**Create directory:**
```bash
mkdir project
```

**Check default permissions:**
```bash
ls -ld project
```
**Output:**
```
drwxr-xr-x 2 devuser devuser 4096 Feb  3 16:20 project
```

**Observation:** Default directory permissions are already 755!

**If we need to explicitly set 755:**
```bash
chmod 755 project
```

**Permission breakdown for directories:**
- `7` (owner) = `rwx` = read, write, execute (can list, create/delete files, enter directory)
- `5` (group) = `r-x` = read, execute (can list and enter, cannot create files)
- `5` (others) = `r-x` = read, execute (can list and enter, cannot create files)

**Note:** For directories:
- `r` = can list contents (`ls`)
- `w` = can create/delete files inside
- `x` = can enter directory (`cd`)

---

**Test directory access:**
```bash
cd project
touch test-file.txt
ls -l
cd ..
```

**Output:**
```
-rw-r--r-- 1 devuser devuser 0 Feb  3 16:22 test-file.txt
```

✅ **Success!** Directory is accessible and writable.

---

### Summary of Permission Changes

**Before:**
```
-rw-r--r-- devops.txt   (644)
-rw-r--r-- notes.txt    (644)
-rw-r--r-- script.sh    (644)
drwxr-xr-x project/     (755)
```

**After:**
```
-r--r--r-- devops.txt   (444) - Read-only
-rw-r----- notes.txt    (640) - Owner: rw, Group: r, Others: none
-rwxr-xr-x script.sh    (755) - Executable
drwxr-xr-x project/     (755) - Standard directory
```

✅ **Task 4 Complete:** Successfully modified permissions using multiple methods.

---

## Task 5: Test Permissions

### Objective
Understand permission restrictions by testing denied operations and documenting error messages

---

### Test 1: Try Writing to Read-Only File

**Setup: devops.txt is read-only (444)**
```bash
ls -l devops.txt
```
**Output:** `-r--r--r--`

**Attempt 1: Write using echo redirection**
```bash
echo "This should fail" > devops.txt
```

**Error Message:**
```
bash: devops.txt: Permission denied
```

**What happened:** 
- Shell tried to open file in write mode
- File permissions don't allow write (`-w` is missing)
- Operation blocked by kernel

---

**Attempt 2: Write using cat**
```bash
cat >> devops.txt << EOF
More content
EOF
```

**Error Message:**
```
bash: devops.txt: Permission denied
```

**Same result:** Cannot append to read-only file.

---

**Attempt 3: Write using text editor**
```bash
vim devops.txt
```

**In vim:**
- Can view content
- Try to insert text with `i`
- Try to save with `:w`

**Error Message:**
```
"devops.txt" E505: "devops.txt" is read-only (add ! to override)
```

**Force write with :w!:**
```
"devops.txt" E166: Can't open linked file for writing
```

**What happened:**
- Vim detected read-only file
- Even force-write fails due to permission restrictions
- Would need to change permissions first or use `sudo`

---

### Test 2: Try Executing File Without Execute Permission

**Setup: Create a test script without execute permission**
```bash
cat > no-exec.sh << 'EOF'
#!/bin/bash
echo "This script has no execute permission"
EOF
```

**Check permissions:**
```bash
ls -l no-exec.sh
```
**Output:** `-rw-r--r--` (644) - No execute permission

---

**Attempt 1: Direct execution**
```bash
./no-exec.sh
```

**Error Message:**
```
bash: ./no-exec.sh: Permission denied
```

**What happened:**
- Shell tried to execute the file
- File lacks execute (`x`) permission
- Kernel denied the operation

---

**Attempt 2: Execution with bash explicitly**
```bash
bash no-exec.sh
```

**Output:**
```
This script has no execute permission
```

**What happened:**
- ✅ Script executed successfully!
- **Why?** We're not executing the file itself - we're passing it as an argument to `bash`
- Bash reads the file (we have read permission) and interprets it
- This is a workaround, but not how scripts should normally be run

---

**Proper fix:**
```bash
chmod +x no-exec.sh
./no-exec.sh
```

**Output:**
```
This script has no execute permission
```

✅ Now it works as intended.

---

### Test 3: Try Accessing File with No Permissions (000)

**Setup: Create a completely restricted file**
```bash
touch secret.txt
echo "Top secret data" > secret.txt
chmod 000 secret.txt
```

**Check permissions:**
```bash
ls -l secret.txt
```
**Output:** `---------- secret.txt` (000)

---

**Attempt 1: Read the file**
```bash
cat secret.txt
```

**Error Message:**
```
cat: secret.txt: Permission denied
```

---

**Attempt 2: Write to the file**
```bash
echo "Hack attempt" > secret.txt
```

**Error Message:**
```
bash: secret.txt: Permission denied
```

---

**Attempt 3: View in vim**
```bash
vim secret.txt
```

**Error Message:**
```
"secret.txt" [Permission Denied]
```

---

**How to access as owner:**
```bash
# Option 1: Restore read permission
chmod u+r secret.txt
cat secret.txt

# Option 2: Use sudo (if you have admin rights)
sudo cat secret.txt
```

---

### Test 4: Try Creating File in Directory Without Write Permission

**Setup: Create read-only directory**
```bash
mkdir readonly-dir
chmod 555 readonly-dir  # r-x for all
```

**Check permissions:**
```bash
ls -ld readonly-dir
```
**Output:** `dr-xr-xr-x` (555)

---

**Attempt: Create file in read-only directory**
```bash
touch readonly-dir/test.txt
```

**Error Message:**
```
touch: cannot touch 'readonly-dir/test.txt': Permission denied
```

**What happened:**
- Directory has read and execute permissions
- Can list contents (`ls`) and enter directory (`cd`)
- Cannot create files - missing write permission
- Write permission on directory is needed to create/delete files

---

**Test navigation:**
```bash
cd readonly-dir  # This works (x permission)
ls               # This works (r permission)
touch file.txt   # This fails (no w permission)
```

---

### Test 5: Try Deleting File with Write Permission

**Setup:**
```bash
touch deleteme.txt
echo "Can you delete me?" > deleteme.txt
chmod 444 deleteme.txt  # Read-only file
```

**Attempt: Delete read-only file**
```bash
rm deleteme.txt
```

**Interactive Prompt:**
```
rm: remove write-protected regular file 'deleteme.txt'? y
```

**Output:**
```
File deleted successfully
```

**What happened:**
- ✅ File was deleted even though it was read-only!
- **Why?** Delete permission depends on the **directory**, not the file
- The parent directory has write permission
- `rm` warned us but still allowed deletion

**To truly protect files from deletion:**
```bash
# Make the directory read-only
chmod 555 /path/to/directory

# Or use sticky bit for shared directories
chmod +t /path/to/directory
```

---

### Permission Error Messages Summary

| Scenario | Command | Error Message | Reason |
|----------|---------|---------------|--------|
| Write to read-only | `echo > file` | Permission denied | No write permission (`w`) |
| Execute non-executable | `./script` | Permission denied | No execute permission (`x`) |
| Read no-permission file | `cat file` | Permission denied | No read permission (`r`) |
| Create in read-only dir | `touch dir/file` | Permission denied | Directory lacks write permission |
| Delete file | `rm file` | write-protected warning | Directory has write, file doesn't |

---

### Key Insights from Testing

1. **File vs Directory Permissions:**
   - File permissions: control what you can do WITH the file
   - Directory permissions: control what you can do IN the directory
   - To delete a file, you need write permission on the directory, NOT the file

2. **Workarounds Exist:**
   - Can't execute file? Use `bash script.sh`
   - Can't read file as user? Use `sudo cat file`
   - These bypass intended restrictions

3. **Error Messages Are Clear:**
   - "Permission denied" = lacking required permission
   - "write-protected" = warning but may proceed
   - Check with `ls -l` to diagnose

4. **Security Best Practices:**
   - Use 640 for sensitive files (owner: rw, group: r, others: none)
   - Use 644 for public readable files
   - Use 600 for private files (owner only)
   - Use 755 for executables and directories
   - Use 700 for private executables

✅ **Task 5 Complete:** Thoroughly tested permission restrictions and documented behaviors.

---

## Commands Used Summary

### File Creation Commands
```bash
# Create empty file
touch filename

# Create with content (echo)
echo "content" > filename
echo "more content" >> filename

# Create with content (cat heredoc)
cat > filename << EOF
content
EOF

# Create with vim
vim filename
# (then i for insert, type content, Esc, :wq to save)
```

---

### File Reading Commands
```bash
# Read full file
cat filename

# Read with line numbers
cat -n filename

# Read first N lines
head -n N filename

# Read last N lines
tail -n N filename

# Read in pager
less filename

# Read-only in vim
vim -R filename
view filename
```

---

### Permission Viewing Commands
```bash
# List file permissions
ls -l filename

# List directory permissions
ls -ld directory

# Detailed file info
stat filename
```

---

### Permission Modification Commands
```bash
# Symbolic method
chmod +x filename       # Add execute for all
chmod -w filename       # Remove write for all
chmod u+x filename      # Add execute for owner
chmod g-w filename      # Remove write for group
chmod o-r filename      # Remove read for others

# Numeric method
chmod 755 filename      # rwxr-xr-x
chmod 644 filename      # rw-r--r--
chmod 600 filename      # rw-------
chmod 444 filename      # r--r--r--

# Directory permissions
chmod 755 directory     # rwxr-xr-x
chmod 775 directory     # rwxrwxr-x
chmod 700 directory     # rwx------
```

---

### Common Permission Patterns

| Permission | Numeric | Use Case |
|------------|---------|----------|
| `rwxr-xr-x` | 755 | Executable scripts, directories |
| `rw-r--r--` | 644 | Regular files, readable by all |
| `rw-r-----` | 640 | Sensitive files, group readable |
| `rw-------` | 600 | Private files, owner only |
| `r--r--r--` | 444 | Read-only for all |
| `rwxrwxr-x` | 775 | Shared directories |
| `rwx------` | 700 | Private executable or directory |

---

## What I Learned

### 1. File Permissions Control Access at Three Levels

**Key Understanding:**
- **Owner:** The user who created/owns the file
- **Group:** Users in the file's group
- **Others:** Everyone else on the system

**Each level has three permissions:**
- **Read (r, 4):** View contents
- **Write (w, 2):** Modify contents
- **Execute (x, 1):** Run as program

**Real-world application:**
In DevOps, proper permissions prevent:
- Unauthorized access to sensitive configs (`chmod 600 /etc/app/secret.conf`)
- Accidental deletion of critical scripts (`chmod 555 /opt/scripts/`)
- Security breaches from world-readable credentials

**Example scenario:**
```bash
# Application config with database credentials
chmod 640 /etc/app/config.yml
chown app-user:app-group /etc/app/config.yml

# Only app user can write, app group can read, others blocked
```

---

### 2. Symbolic vs Numeric chmod: Different Tools for Different Jobs

**Symbolic (+/-) Method:**
- Best for: Making incremental changes
- Examples:
```bash
  chmod +x deploy.sh          # Add execute
  chmod go-w sensitive.conf   # Remove write for group and others
  chmod u+rw,go+r readme.md   # Multiple changes
```
- **Advantage:** Don't need to know current permissions
- **Use when:** Adding/removing specific permissions

**Numeric (777) Method:**
- Best for: Setting exact permissions
- Examples:
```bash
  chmod 755 script.sh    # Exactly rwxr-xr-x
  chmod 600 private.key  # Exactly rw-------
```
- **Advantage:** Precise and repeatable
- **Use when:** Setting up files from scratch or in scripts

**Real-world application:**
```bash
# In deployment scripts, use numeric for consistency
chmod 644 /var/www/html/*.html
chmod 755 /var/www/html/cgi-bin/*

# For manual fixes, symbolic is faster
chmod +x forgotten-script.sh
```

---

### 3. Directory Permissions Work Differently Than File Permissions

**Critical Difference:**

For **files:**
- `r` = read contents
- `w` = modify contents
- `x` = execute as program

For **directories:**
- `r` = list contents (`ls`)
- `w` = create/delete files inside
- `x` = enter directory (`cd`)

**Important:** You need `x` to do ANYTHING in a directory!

**Example scenarios:**

**Scenario 1: Can list but can't enter (r-- permissions)**
```bash
chmod 400 mydir
ls mydir      # Works - can list
cd mydir      # Fails - can't enter
```

**Scenario 2: Can enter but can't list (--x permissions)**
```bash
chmod 100 mydir
ls mydir      # Fails - can't list
cd mydir      # Works - can enter if you know the path
```

**Scenario 3: Proper directory permissions (r-x permissions)**
```bash
chmod 755 mydir
ls mydir      # Works
cd mydir      # Works
```

**Real-world application:**
```bash
# Web server document root
chmod 755 /var/www/html
# Apache can enter and list, users can read files inside

# Shared project directory
chmod 775 /opt/team-project
chmod g+s /opt/team-project  # setgid bit
# Team can collaborate, files inherit group

# Private backup directory
chmod 700 /backup/sensitive
# Only owner can enter, list, and modify
```

**Pro tip:** Always set directories to 755 or 775, never 644!

---

## Additional Insights

### Special Permissions: Beyond rwx

**Setuid (s in owner position):**
```bash
chmod 4755 file  # -rwsr-xr-x
```
- File executes with owner's privileges
- Example: `/usr/bin/passwd` runs as root to modify password file

**Setgid (s in group position):**
```bash
chmod 2775 directory  # drwxrwsr-x
```
- New files inherit directory's group
- Essential for shared directories

**Sticky bit (t in others position):**
```bash
chmod 1777 /tmp  # drwxrwxrwt
```
- Only file owner can delete files
- Used in `/tmp` for shared temporary storage

---

### Quick Reference: Common Scenarios

**Web server files:**
```bash
# HTML/CSS/JS files
chmod 644 *.html *.css *.js

# CGI/PHP scripts
chmod 755 *.cgi *.php

# Directories
chmod 755 */
```

**SSH keys:**
```bash
# Private key (never share)
chmod 600 ~/.ssh/id_rsa

# Public key
chmod 644 ~/.ssh/id_rsa.pub

# .ssh directory
chmod 700 ~/.ssh
```

**Log files:**
```bash
# Application logs
chmod 640 /var/log/app.log
chown app:syslog /var/log/app.log

# System logs
chmod 644 /var/log/syslog
```

---

## Troubleshooting Guide

### Problem: "Permission denied" when executing script

**Diagnosis:**
```bash
ls -l script.sh
# Check if 'x' permission exists
```

**Solutions:**
```bash
# Option 1: Add execute permission
chmod +x script.sh

# Option 2: Run with interpreter
bash script.sh
python script.py
```

---

### Problem: Can't modify file I created

**Diagnosis:**
```bash
ls -l file.txt
# Check if 'w' permission exists for owner
```

**Solutions:**
```bash
# Restore write permission
chmod u+w file.txt

# Or set to standard permissions
chmod 644 file.txt
```

---

### Problem: Can't delete file in directory I own

**Diagnosis:**
```bash
ls -ld /path/to/directory
# Check if directory has 'w' permission
```

**Solutions:**
```bash
# Add write permission to directory
chmod u+w /path/to/directory

# Then delete file
rm /path/to/directory/file.txt
```

---

## Verification Checklist

### Files Created ✅
- [x] devops.txt (empty file via touch)
- [x] notes.txt (content via echo/cat)
- [x] script.sh (content via vim)
- [x] project/ (directory with 755)

### Files Read ✅
- [x] Full content with cat
- [x] Partial content with head/tail
- [x] Read-only mode in vim

### Permissions Modified ✅
- [x] script.sh → executable (755)
- [x] devops.txt → read-only (444)
- [x] notes.txt → 640 permissions
- [x] project/ → 755 permissions

### Permissions Tested ✅
- [x] Write to read-only file (denied)
- [x] Execute non-executable (denied)
- [x] Documented error messages
- [x] Verified permission changes

---

**Created for:** 90 Days of DevOps Challenge - Day 10  
**Focus:** File creation, reading, and comprehensive permission management  
**Skills Mastered:** touch, cat, vim, head, tail, chmod (symbolic & numeric), permission testing  
**Date:** February 03, 2026

---

## LinkedIn Post (Ready to Share)

🚀 **Day 10 of #90DaysOfDevOps Complete!**

Today I mastered Linux file permissions - the foundation of system security!

**Key breakthroughs:**
✅ Learned the difference between symbolic (`chmod +x`) and numeric (`chmod 755`) permission modes  
✅ Discovered directory permissions work differently - you need `x` to even `cd` into a directory!  
✅ Tested permission restrictions hands-on and documented every error message  

**Most important insight:** 
File deletion depends on **directory** write permissions, not the file itself. This is why you can delete a read-only file if you own the directory! 🤯

**Real-world application:**
```bash
chmod 600 ~/.ssh/id_rsa    # Private SSH key
chmod 755 ~/scripts/*.sh   # Executable scripts
chmod 640 /etc/app/*.conf  # Sensitive configs
```

These fundamentals prevent security breaches and protect critical infrastructure.

#DevOpsKaJosh #TrainWithShubham #LinuxSecurity #FilePermissions
