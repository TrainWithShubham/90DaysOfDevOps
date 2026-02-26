# File I/O Practice: Read and Write Text Files

**Date:** February 03, 2026  
**Focus:** Basic Linux file operations for DevOps workflows

---

## Creating and Writing to Files

### Step 1: Create an Empty File
```bash
touch notes.txt
```
**What it does:** Creates an empty file named `notes.txt` in the current directory. If the file already exists, it updates the timestamp.

**Verification:**
```bash
ls -lh notes.txt
```
**Output:**
```
-rw-r--r-- 1 user user 0 Feb  3 13:00 notes.txt
```

---

### Step 2: Write First Line (Overwrite Mode)
```bash
echo "Day 06: Learning Linux file I/O operations" > notes.txt
```
**What it does:** The `>` operator **overwrites** the file with new content. Any existing content is replaced.

**Command breakdown:**
- `echo` - Prints text to standard output
- `>` - Redirects output to file (overwrite mode)

---

### Step 3: Append Second Line
```bash
echo "These commands are essential for DevOps engineers" >> notes.txt
```
**What it does:** The `>>` operator **appends** content to the file without deleting existing lines.

**Command breakdown:**
- `>>` - Redirects output to file (append mode)

---

### Step 4: Append Multiple Lines
```bash
echo "File operations help us manage logs and configs" >> notes.txt
echo "Practice makes perfect!" >> notes.txt
```
**What it does:** Adds two more lines to the file sequentially.

---

### Step 5: Use Tee to Write and Display
```bash
echo "This line uses tee command for simultaneous write and display" | tee -a notes.txt
```
**Output:**
```
This line uses tee command for simultaneous write and display
```
**What it does:** 
- `tee` writes to file AND displays on screen simultaneously
- `-a` flag means append mode (without it, tee overwrites)
- `|` pipe sends echo output to tee command

---

### Step 6: Add More Content
```bash
echo "=== Practice Session Complete ===" >> notes.txt
echo "Total commands practiced: 7" >> notes.txt
echo "Next: Learn grep and sed for text processing" >> notes.txt
```

---

## Reading Files

### Step 7: Read Full File Content
```bash
cat notes.txt
```
**Output:**
```
Day 06: Learning Linux file I/O operations
These commands are essential for DevOps engineers
File operations help us manage logs and configs
Practice makes perfect!
This line uses tee command for simultaneous write and display
=== Practice Session Complete ===
Total commands practiced: 7
Next: Learn grep and sed for text processing
```
**What it does:** Displays entire file content. Best for small files.

**Line count:**
```bash
wc -l notes.txt
```
**Output:** `8 notes.txt`

---

### Step 8: Read First Few Lines
```bash
head -n 3 notes.txt
```
**Output:**
```
Day 06: Learning Linux file I/O operations
These commands are essential for DevOps engineers
File operations help us manage logs and configs
```
**What it does:** Shows first 3 lines of the file. Useful for checking file headers or recent log entries.

**Alternative:**
```bash
head -n 5 notes.txt
```
Shows first 5 lines.

---

### Step 9: Read Last Few Lines
```bash
tail -n 3 notes.txt
```
**Output:**
```
=== Practice Session Complete ===
Total commands practiced: 7
Next: Learn grep and sed for text processing
```
**What it does:** Shows last 3 lines of the file. Essential for checking latest log entries.

---

### Step 10: Read Specific Line Range
```bash
head -n 5 notes.txt | tail -n 2
```
**Output:**
```
Practice makes perfect!
This line uses tee command for simultaneous write and display
```
**What it does:** Shows lines 4-5 by combining head and tail with pipe.

---

## Advanced Reading Techniques

### Step 11: Number Lines While Reading
```bash
cat -n notes.txt
```
**Output:**
```
     1  Day 06: Learning Linux file I/O operations
     2  These commands are essential for DevOps engineers
     3  File operations help us manage logs and configs
     4  Practice makes perfect!
     5  This line uses tee command for simultaneous write and display
     6  === Practice Session Complete ===
     7  Total commands practiced: 7
     8  Next: Learn grep and sed for text processing
```
**What it does:** Displays file with line numbers - helpful for referencing specific lines.

---

### Step 12: Display with Line Numbers (Alternative)
```bash
nl notes.txt
```
**Output:** Similar to `cat -n` but formats line numbers differently.

---

## Real-World DevOps Use Cases

### Use Case 1: Quick Log Check
```bash
# Check last 20 lines of application log
tail -n 20 /var/log/application.log

# Monitor log in real-time
tail -f /var/log/application.log
```

---

### Use Case 2: Configuration Backup
```bash
# Backup config before editing
cat /etc/nginx/nginx.conf > /tmp/nginx.conf.backup

# Append timestamp to backup
echo "Backup created: $(date)" >> /tmp/nginx.conf.backup
```

---

### Use Case 3: Quick Documentation
```bash
# Create deployment notes
echo "Deployment Date: $(date)" > deployment-notes.txt
echo "Server: production-01" >> deployment-notes.txt
echo "Version: v2.3.4" >> deployment-notes.txt

# Display and save command output
ps aux | grep nginx | tee nginx-processes.txt
```

---

## Commands Summary Table

| Command | Purpose | Mode | Common Use |
|---------|---------|------|------------|
| `touch file.txt` | Create empty file | - | Initialize new files |
| `echo "text" > file` | Write (overwrite) | Overwrite | Create new content |
| `echo "text" >> file` | Write (append) | Append | Add to existing file |
| `cat file` | Read entire file | Read | View small files |
| `head -n N file` | Read first N lines | Read | Check file beginning |
| `tail -n N file` | Read last N lines | Read | Check recent logs |
| `tail -f file` | Follow file updates | Read | Monitor live logs |
| `tee file` | Write and display | Write | Save command output |
| `tee -a file` | Append and display | Append | Log with visibility |
| `cat -n file` | Read with line numbers | Read | Reference specific lines |

---

## Key Learnings

### Redirection Operators
1. **`>` (Overwrite)**: Replaces entire file content
   - Use when: Starting fresh or resetting a file
   - Risk: Loses all existing data

2. **`>>` (Append)**: Adds to end of file
   - Use when: Adding to logs or accumulating data
   - Safe: Preserves existing content

3. **`|` (Pipe)**: Chains commands together
   - Use when: Passing output between commands
   - Power: Builds complex workflows

