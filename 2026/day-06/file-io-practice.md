# Day 06 - File I/O Practice Log
**Linux File Read and Write Operations**

Date: February 08, 2026  
Practice File: `notes.txt`

---

## 🎯 Learning Objectives

Today I practiced:
- Creating files with `touch`
- Writing to files using redirection (`>` and `>>`)
- Reading files with `cat`, `head`, and `tail`
- Using `tee` to write and display simultaneously

---

## 📝 Step-by-Step Practice

### Step 1: Create Empty File

**Command:**
```bash
touch notes.txt
```

**Verification:**
```bash
ls -lh notes.txt
```

**Output:**
```
-rw-r--r-- 1 root root 0 Feb  8 07:33 notes.txt
```

**What I Learned:**
- `touch` creates an empty file if it doesn't exist
- File size is 0 bytes (empty)
- Default permissions are `-rw-r--r--` (readable by all, writable by owner only)

---

### Step 2: Write First Line (Overwrite)

**Command:**
```bash
echo "Day 06: Learning Linux file operations" > notes.txt
```

**Read the file:**
```bash
cat notes.txt
```

**Output:**
```
Day 06: Learning Linux file operations
```

**What I Learned:**
- `>` redirects output to a file
- `>` **OVERWRITES** the file (deletes previous content)
- `echo` prints text to standard output
- Be careful with `>` - it destroys existing content!

---

### Step 3: Append Second Line

**Command:**
```bash
echo "This is my second line of text" >> notes.txt
```

**Read the file:**
```bash
cat notes.txt
```

**Output:**
```
Day 06: Learning Linux file operations
This is my second line of text
```

**What I Learned:**
- `>>` **APPENDS** to a file (adds to the end)
- `>>` does NOT overwrite existing content
- Much safer than `>` when adding to existing files

---

### Step 4: Append Third Line

**Command:**
```bash
echo "Third line added using append operator" >> notes.txt
```

**Read the file:**
```bash
cat notes.txt
```

**Output:**
```
Day 06: Learning Linux file operations
This is my second line of text
Third line added using append operator
```

**What I Learned:**
- Can use `>>` multiple times safely
- Each line is added on a new line automatically
- File grows with each append operation

---

### Step 5: Using tee Command

**Command:**
```bash
echo "Fourth line using tee command" | tee -a notes.txt
```

**Output (displayed on screen):**
```
Fourth line using tee command
```

**Read the file:**
```bash
cat notes.txt
```

**File content:**
```
Day 06: Learning Linux file operations
This is my second line of text
Third line added using append operator
Fourth line using tee command
```

**What I Learned:**
- `tee` writes to file AND displays on screen simultaneously
- `|` (pipe) sends output from `echo` to `tee`
- `-a` flag means append (like `>>`)
- Without `-a`, tee would overwrite (like `>`)
- Very useful for logging while seeing output

---

### Step 6: Add More Content

**Commands:**
```bash
echo "Commands practiced: touch, cat, echo, tee" >> notes.txt
echo "head, tail, and redirection operators" >> notes.txt
```

**Read full file:**
```bash
cat notes.txt
```

**Output:**
```
Day 06: Learning Linux file operations
This is my second line of text
Third line added using append operator
Fourth line using tee command
Commands practiced: touch, cat, echo, tee
head, tail, and redirection operators
```

---

### Step 7: Read First 3 Lines (head)

**Command:**
```bash
head -n 3 notes.txt
```

**Output:**
```
Day 06: Learning Linux file operations
This is my second line of text
Third line added using append operator
```

**What I Learned:**
- `head` shows the beginning of a file
- `-n 3` means "show first 3 lines"
- Default is 10 lines if you don't specify
- Useful for checking file headers or previewing files

---

### Step 8: Read Last 2 Lines (tail)

**Command:**
```bash
tail -n 2 notes.txt
```

**Output:**
```
Commands practiced: touch, cat, echo, tee
head, tail, and redirection operators
```

**What I Learned:**
- `tail` shows the end of a file
- `-n 2` means "show last 2 lines"
- Default is 10 lines if you don't specify
- Very useful for checking recent log entries
- Can use `tail -f` to follow file changes in real-time

---

### Step 9: Count Lines in File

**Command:**
```bash
wc -l notes.txt
```

**Output:**
```
6 notes.txt
```

**What I Learned:**
- `wc` means "word count"
- `-l` flag counts lines
- File has 6 lines total
- Can also use `-w` for words, `-c` for characters

---

### Step 10: Display with Line Numbers

**Command:**
```bash
cat -n notes.txt
```

**Output:**
```
     1	Day 06: Learning Linux file operations
     2	This is my second line of text
     3	Third line added using append operator
     4	Fourth line using tee command
     5	Commands practiced: touch, cat, echo, tee
     6	head, tail, and redirection operators
```

**What I Learned:**
- `cat -n` adds line numbers
- Very helpful for debugging scripts
- Makes it easy to reference specific lines
- Numbers are aligned for readability

---

### Step 11: More tee Practice

**Commands:**
```bash
echo "=== Additional Practice ===" | tee -a notes.txt
echo "File created on: $(date)" | tee -a notes.txt
```

**Output (displayed on screen):**
```
=== Additional Practice ===
File created on: Sun Feb  8 07:33:41 UTC 2026
```

**What I Learned:**
- Can use `$(date)` to embed current date/time
- `tee` shows output immediately (good for logging)
- `tee` can write to multiple files at once: `tee file1.txt file2.txt`

---

### Step 12: Final File Content

**Command:**
```bash
cat notes.txt
```

**Complete Output:**
```
Day 06: Learning Linux file operations
This is my second line of text
Third line added using append operator
Fourth line using tee command
Commands practiced: touch, cat, echo, tee
head, tail, and redirection operators
=== Additional Practice ===
File created on: Sun Feb  8 07:33:41 UTC 2026
```

**Total Lines:** 8  
**File Successfully Created!** ✓

---

## 📊 Commands Summary Table

| Command | Purpose | Example |
|---------|---------|---------|
| `touch file.txt` | Create empty file | `touch notes.txt` |
| `echo "text" > file` | Write (overwrite) | `echo "Hello" > notes.txt` |
| `echo "text" >> file` | Append | `echo "World" >> notes.txt` |
| `cat file` | Read entire file | `cat notes.txt` |
| `cat -n file` | Read with line numbers | `cat -n notes.txt` |
| `head -n N file` | Read first N lines | `head -n 3 notes.txt` |
| `tail -n N file` | Read last N lines | `tail -n 2 notes.txt` |
| `echo "text" \| tee file` | Write and display | `echo "Hi" \| tee notes.txt` |
| `echo "text" \| tee -a file` | Append and display | `echo "Hi" \| tee -a notes.txt` |
| `wc -l file` | Count lines | `wc -l notes.txt` |

---

## 🔑 Key Concepts Learned

### Redirection Operators

**Single `>` (Output Redirection - OVERWRITE)**
```bash
echo "New content" > file.txt
# DANGER: This DELETES everything in file.txt first!
```

**Double `>>` (Output Redirection - APPEND)**
```bash
echo "Additional content" >> file.txt
# SAFE: This ADDS to the end of file.txt
```

**Remember:**
- `>` = Replace everything (dangerous!)
- `>>` = Add to end (safe)

---

### Pipe Operator `|`

**What it does:** Sends output from one command to another

```bash
echo "Hello" | tee file.txt
#     ↑         ↑      ↑
#   command1  pipe  command2
```

**Command1 output becomes Command2 input**

---

### Reading Commands

| Command | Use Case |
|---------|----------|
| `cat` | Read entire file (small files) |
| `head` | Preview beginning (check headers) |
| `tail` | Check end (recent logs) |
| `tail -f` | Follow live updates (real-time logs) |

---

## 💡 Pro Tips Discovered

### 1. Always Use `>>` for Logs
```bash
# Good - adds to log
echo "[$(date)] Process started" >> app.log

# Bad - destroys previous logs!
echo "[$(date)] Process started" > app.log
```

---

### 2. Preview Before Processing
```bash
# Check first few lines before processing entire file
head -n 5 large-file.txt

# Check if file format is correct
head -n 1 data.csv
```

---

### 3. tee for Logging
```bash
# Save to log AND see output
./my-script.sh | tee -a script.log
```

---

### 4. Combine Commands
```bash
# Count how many error lines in a log
grep "ERROR" app.log | wc -l

# Show last 20 errors
grep "ERROR" app.log | tail -n 20
```

---

## 🎯 Real-World DevOps Use Cases

### Use Case 1: Creating Config Files
```bash
# Create new config file
touch /etc/myapp/config.txt

# Add configuration
echo "port=8080" >> /etc/myapp/config.txt
echo "host=localhost" >> /etc/myapp/config.txt
echo "debug=true" >> /etc/myapp/config.txt
```

---

### Use Case 2: Checking Log Files
```bash
# Check recent errors (last 50 lines)
tail -n 50 /var/log/nginx/error.log

# Follow live logs
tail -f /var/log/application.log

# Check log file beginning (configuration info often at top)
head -n 20 /var/log/app.log
```

---

### Use Case 3: Deployment Logging
```bash
# Log deployment with timestamp and visibility
echo "[$(date)] Starting deployment v2.1.0" | tee -a deploy.log
./deploy.sh | tee -a deploy.log
echo "[$(date)] Deployment completed" | tee -a deploy.log
```

---

### Use Case 4: Quick File Creation
```bash
# Create script file
cat > backup.sh << 'EOF'
#!/bin/bash
echo "Starting backup..."
tar -czf backup.tar.gz /data
echo "Backup complete"
EOF

# Make it executable
chmod +x backup.sh
```

---

## ⚠️ Common Mistakes to Avoid

### Mistake 1: Using `>` Instead of `>>`
```bash
# WRONG - destroys log file every time!
echo "Log entry" > app.log

# RIGHT - adds to log file
echo "Log entry" >> app.log
```

---

### Mistake 2: Forgetting `-a` with tee
```bash
# WRONG - overwrites file
echo "New entry" | tee logfile.txt

# RIGHT - appends to file
echo "New entry" | tee -a logfile.txt
```

---

### Mistake 3: Not Checking File First
```bash
# WRONG - might overwrite important data
echo "test" > data.txt

# RIGHT - check if file exists
ls -l data.txt
cat data.txt  # See what's there
echo "test" >> data.txt  # Then append if safe
```

---

## 🔄 Practice Exercise

**Challenge:** Create a system info file

```bash
# Create file with system info
echo "=== System Information ===" > sysinfo.txt
echo "Date: $(date)" >> sysinfo.txt
echo "Hostname: $(hostname)" >> sysinfo.txt
echo "Current User: $(whoami)" >> sysinfo.txt
echo "Current Directory: $(pwd)" >> sysinfo.txt
echo "" >> sysinfo.txt
echo "Disk Usage:" >> sysinfo.txt
df -h >> sysinfo.txt

# View the result
cat sysinfo.txt
```

---

## 📚 What's Next?

Now that I understand basic file I/O, next steps:
1. Learn file permissions (`chmod`, `chown`)
2. Practice with larger files
3. Learn text processing (`grep`, `sed`, `awk`)
4. Explore file compression (`tar`, `gzip`)
5. Master log rotation concepts

---

## 🎓 Summary

### ✅ Skills Acquired Today:

1. **File Creation** - `touch` command
2. **Writing** - `>` for overwrite, `>>` for append
3. **Reading** - `cat`, `head`, `tail`
4. **Dual Output** - `tee` command
5. **Piping** - `|` operator
6. **Line Counting** - `wc -l`
7. **Numbered Output** - `cat -n`

### 🔥 Most Useful Commands:

- `tail -f` - Follow log files in real-time
- `>>` - Safe append to files
- `tee -a` - Log and display simultaneously
- `head/tail -n` - Quick file preview

### 💪 Key Takeaway:

**File operations are the foundation of DevOps work.** Almost everything in Linux is a file - configs, logs, scripts. Mastering these basic commands makes debugging and automation much faster!

---

**Practice File:** `notes.txt` (8 lines created successfully)  
**Commands Practiced:** 12 different file operations  
**Created for:** #90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham

---

## 📝 Personal Notes

**What I found most useful:**
- `tee -a` for deployment logging
- `tail -f` will be essential for monitoring
- `>>` is much safer than `>` for production

**What surprised me:**
- How powerful simple redirection operators are
- `cat -n` is great for debugging scripts
- `tee` can write to multiple files at once

**What I'll practice more:**
- Combining commands with pipes
- Real-time log monitoring with `tail -f`
- Using these commands in automation scripts

---

**Tomorrow:** Moving on to text processing and searching! 🚀