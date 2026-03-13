
# ✅ Day 10 — File Permissions & File Operations Challenge

## 🔹 Task 1 — Create Files

### 1) Create empty file

```bash
touch devops.txt
```

---

### 2) Create file with content (using echo)

```bash
echo "These are my DevOps notes." > notes.txt
```

(Alternative)

```bash
cat > notes.txt
# Type content → press Ctrl+D to save
```

---

### 3) Create script using vim

```bash
vim script.sh
```

Press `i` → insert mode → add:

```bash
echo "Hello DevOps"
```

Save:

```
Esc → :wq → Enter
```

---

### ✔ Verify

```bash
ls -l
```

Typical output:

```
-rw-r--r--  devops.txt
-rw-r--r--  notes.txt
-rw-r--r--  script.sh
```

---

## 🔹 Task 2 — Read Files

### 1) Read notes.txt

```bash
cat notes.txt
```

---

### 2) View script in vim read-only mode

```bash
vim -R script.sh
```

Quit:

```
:q
```

---

### 3) First 5 lines of /etc/passwd

```bash
head -n 5 /etc/passwd
```

---

### 4) Last 5 lines

```bash
tail -n 5 /etc/passwd
```

---

## 🔹 Task 3 — Understand Permissions

Check:

```bash
ls -l devops.txt notes.txt script.sh
```

Example:

```
-rw-r--r-- 1 user user 0   devops.txt
-rw-r--r-- 1 user user 24  notes.txt
-rw-r--r-- 1 user user 20  script.sh
```

### 🔎 Interpretation

Permission format:

```
Owner | Group | Others
rw-     r--      r--
```

Meaning:

| File       | Owner        | Group | Others |
| ---------- | ------------ | ----- | ------ |
| devops.txt | Read + Write | Read  | Read   |
| notes.txt  | Read + Write | Read  | Read   |
| script.sh  | Read + Write | Read  | Read   |

➡️ No execute permission yet.

---

## 🔹 Task 4 — Modify Permissions

### 1) Make script executable

```bash
chmod +x script.sh
```

Verify:

```bash
ls -l script.sh
```

Run:

```bash
./script.sh
```

Output:

```
Hello DevOps
```

---

### 2) Make devops.txt read-only

Remove write permission for all:

```bash
chmod a-w devops.txt
```

Verify:

```
-r--r--r-- devops.txt
```

---

### 3) Set notes.txt to 640

```bash
chmod 640 notes.txt
```

Meaning:

* Owner → read + write
* Group → read only
* Others → none

Verify:

```
-rw-r----- notes.txt
```

---

### 4) Create directory with 755

```bash
mkdir project
chmod 755 project
```

Verify:

```bash
ls -ld project
```

Expected:

```
drwxr-xr-x project
```

---

## 🔹 Task 5 — Test Permissions

### 1) Write to read-only file

```bash
echo "New text" >> devops.txt
```

Result:

```
Permission denied
```

---

### 2) Execute file without execute permission

Remove execute:

```bash
chmod -x script.sh
```

Run:

```bash
./script.sh
```

Result:

```
Permission denied
```

---

# 📄 Ready-to-Submit Markdown File

Create:

```
day-10-file-permissions.md
```

Paste:

```markdown
# Day 10 Challenge

## Files Created

- devops.txt
- notes.txt
- script.sh
- project/ directory

---

## Permission Changes

script.sh:
- Before: rw-r--r--
- After: rwxr-xr-x (executable)

devops.txt:
- Before: rw-r--r--
- After: r--r--r-- (read-only)

notes.txt:
- Set to 640 → rw-r-----

project/:
- Set to 755 → rwxr-xr-x

---

## Commands Used

touch devops.txt  
echo "text" > notes.txt  
vim script.sh  
cat notes.txt  
vim -R script.sh  
head -n 5 /etc/passwd  
tail -n 5 /etc/passwd  
chmod +x script.sh  
chmod a-w devops.txt  
chmod 640 notes.txt  
mkdir project  
chmod 755 project  

---

## What I Learned

- Linux permission model for owner, group, others
- How execute permission affects script execution
- Numeric vs symbolic chmod usage
```

---

# 🎯 Real DevOps Concepts You Practiced

These are foundational production skills:

### 🔹 Secure Script Deployment

Executable flags control what can run on servers.

### 🔹 Least Privilege Principle

Restrict write/execute access to reduce risk.

### 🔹 File System Security

Critical for logs, configs, secrets, binaries.

### 🔹 Debugging Permission Issues

Common cause of production failures.

