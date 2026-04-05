# File I/O Practice - Day 06

**Date:** 2026-02-01  
**Goal:** Master basic Linux file read/write operations  
**Duration:** 30 minutes  
**Difficulty:** Beginner

---

## Overview

This practice session covers fundamental file operations that every DevOps engineer uses daily:
- Creating files
- Writing content (overwrite vs append)
- Reading entire files
- Reading specific parts of files
- Using tee for simultaneous write and display

---

##  Commands Practiced

### 1. Creating an Empty File

**Command:**
```bash
touch notes.txt
```

**What it does:**
- Creates an empty file named `notes.txt`
- If file exists, updates its timestamp
- Commonly used to initialize files or update modification times

**Output:**
```bash
ls -lh notes.txt
-rw-r--r-- 1 root root 0 Feb  1 14:21 notes.txt
```

**Use Case:** Creating placeholder files, updating timestamps for Makefiles

---

### 2. Writing to File (Overwrite)

**Command:**
```bash
echo "Line 1: This is the first line written with > redirection" > notes.txt
```

**What it does:**
- `>` redirects output to a file
- **OVERWRITES** the entire file content
- If file doesn't exist, creates it
- **Warning:** Be careful with `>` as it destroys existing content!

**Use Case:** Creating new config files, resetting log files

---

### 3. Appending to File

**Command:**
```bash
echo "Line 2: This line is appended with >> redirection" >> notes.txt
```

**What it does:**
- `>>` redirects output and **APPENDS** to file
- Preserves existing content
- Adds new content at the end
- Safe for adding to existing files

**Use Case:** Adding log entries, appending to configuration files

---

### 4. Using tee to Write and Display

**Command:**
```bash
echo "Line 3: Added using tee command (writes and displays)" | tee -a notes.txt
```

**What it does:**
- `tee` reads from stdin and writes to both stdout AND file(s)
- `-a` flag appends to file (without `-a`, it overwrites)
- Shows you what was written (good for confirmation)
- Can write to multiple files: `tee file1.txt file2.txt`

**Output:**
```
Line 3: Added using tee command (writes and displays)
```

**Use Case:** 
- Logging command output while viewing it
- Writing to multiple log files simultaneously
- Pipelines where you need both file output and terminal display

---

### 5. Adding More Lines

**Commands:**
```bash
echo "Line 4: DevOps engineers work with config files daily" >> notes.txt
echo "Line 5: Logs are critical for troubleshooting issues" >> notes.txt
echo "Line 6: Scripts automate repetitive tasks" >> notes.txt
echo "Line 7: Understanding file I/O is fundamental" >> notes.txt
echo "Line 8: Master these basics before advanced topics" >> notes.txt
```

**What it does:**
- Builds up our practice file with meaningful content
- Each line appended without destroying previous content

---

### 6. Reading the Entire File

**Command:**
```bash
cat notes.txt
```

**What it does:**
- `cat` (concatenate) displays entire file content
- Outputs all lines to stdout
- Can concatenate multiple files: `cat file1.txt file2.txt`

**Output:**
```
Line 1: This is the first line written with > redirection
Line 2: This line is appended with >> redirection
Line 3: Added using tee command (writes and displays)
Line 4: DevOps engineers work with config files daily
Line 5: Logs are critical for troubleshooting issues
Line 6: Scripts automate repetitive tasks
Line 7: Understanding file I/O is fundamental
Line 8: Master these basics before advanced topics
```

**Use Case:** Viewing small config files, quick content checks, file concatenation

---

### 7. Reading First N Lines (head)

**Command:**
```bash
head -n 3 notes.txt
```

**What it does:**
- Shows first 3 lines of file
- Default is 10 lines if `-n` not specified
- Useful for seeing file headers or recent entries (if file is time-ordered)

**Output:**
```
Line 1: This is the first line written with > redirection
Line 2: This line is appended with >> redirection
Line 3: Added using tee command (writes and displays)
```

**Alternative:**
```bash
head -n 2 notes.txt
Line 1: This is the first line written with > redirection
Line 2: This line is appended with >> redirection
```

**Use Case:** 
- Checking CSV headers
- Viewing file format before processing
- Quick preview of large files

---

### 8. Reading Last N Lines (tail)

**Command:**
```bash
tail -n 3 notes.txt
```

**What it does:**
- Shows last 3 lines of file
- Default is 10 lines if `-n` not specified
- **Critical for log files** (most recent entries at the end)

**Output:**
```
Line 6: Scripts automate repetitive tasks
Line 7: Understanding file I/O is fundamental
Line 8: Master these basics before advanced topics
```

**Alternative:**
```bash
tail -n 2 notes.txt
Line 7: Understanding file I/O is fundamental
Line 8: Master these basics before advanced topics
```

**Use Case:** 
- Checking most recent log entries
- Monitoring error logs
- Following file updates with `tail -f` (live monitoring)

---

### 9. Advanced: Following Files in Real-Time

**Command:**
```bash
tail -f /var/log/syslog
```

**What it does:**
- `-f` (follow) keeps tail running
- Displays new lines as they're added
- **Essential for live log monitoring**
- Exit with `Ctrl+C`

**Use Case:** Monitoring application logs during deployments, debugging in real-time

---

### 10. Bonus: Counting Lines

**Command:**
```bash
wc -l notes.txt
```

**What it does:**
- `wc` (word count) with `-l` counts lines
- Useful for validation and file size checks

**Output:**
```
8 notes.txt
```

**Use Case:** Validating data imports, checking log file size, script verification

---

## Complete Practice Session

### Final File Content (notes.txt)
```
Line 1: This is the first line written with > redirection
Line 2: This line is appended with >> redirection
Line 3: Added using tee command (writes and displays)
Line 4: DevOps engineers work with config files daily
Line 5: Logs are critical for troubleshooting issues
Line 6: Scripts automate repetitive tasks
Line 7: Understanding file I/O is fundamental
Line 8: Master these basics before advanced topics
```

**Total Lines:** 8  
**File Size:** ~420 bytes

---

## Why This Matters for DevOps

### Real-World Scenarios:

1. **Config Management:**
   ```bash
   echo "ServerName example.com" >> /etc/apache2/apache2.conf
   ```

2. **Log Monitoring:**
   ```bash
   tail -f /var/log/nginx/error.log
   ```

3. **Script Output Logging:**
   ```bash
   ./deploy.sh | tee -a deployment.log
   ```

4. **Checking Log Errors:**
   ```bash
   tail -n 100 /var/log/app.log | grep ERROR
   ```

5. **Creating Documentation:**
   ```bash
   echo "# Server Inventory" > inventory.md
   echo "- server1.example.com" >> inventory.md
   ```

---

##  Next Steps

### Practice These Variations:

1. **Create a script log:**
   ```bash
   date > script.log
   echo "Starting process..." >> script.log
   echo "Process complete" >> script.log
   cat script.log
   ```

2. **Monitor a growing file:**
   ```bash
   # Terminal 1:
   tail -f growing.txt
   
   # Terminal 2:
   echo "New entry" >> growing.txt
   ```

3. **Save command output:**
   ```bash
   ps aux > processes.txt
   df -h >> processes.txt
   cat processes.txt
   ```

4. **Use tee in a pipeline:**
   ```bash
   ls -la | tee directory_listing.txt | grep "\.txt$"
   ```

---

## Additional Resources

- `man cat` - Manual for cat command
- `man head` - Manual for head command
- `man tail` - Manual for tail command
- `man tee` - Manual for tee command
- `man touch` - Manual for touch command

---

