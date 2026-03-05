# Day 21 – Shell Scripting Cheat Sheet:

---

# 1 Script Basics

| Topic           | Syntax             | Why We Use It         | What It Does                | How It Works                              |
| --------------- | ------------------ | --------------------- | --------------------------- | ----------------------------------------- |
| Shebang         | `#!/bin/bash`      | Ensure correct shell  | Runs script with Bash       | OS reads first line to choose interpreter |
| Make Executable | `chmod +x file.sh` | Allow execution       | Adds execute permission     | Changes file mode bits                    |
| Run Script      | `./file.sh`        | Execute script        | Runs commands inside file   | Shell loads and executes line by line     |
| Comment         | `# comment`        | Explain code          | Ignored by shell            | Shell skips lines starting with `#`       |
| Variable        | `VAR="value"`      | Store data            | Saves value in memory       | Bash assigns string to name               |
| Use Variable    | `"$VAR"`           | Avoid errors          | Expands value safely        | Quotes prevent word splitting             |
| Read Input      | `read name`        | Get user input        | Stores typed value          | Reads from stdin                          |
| Arguments       | `$1`, `$@`, `$#`   | Accept external input | Access passed parameters    | Bash stores args in positional variables  |
| Exit Code       | `$?`               | Check success         | Returns last command status | 0 = success, non-zero = error             |

---

# 2️ Conditionals & Tests

| Feature          | Syntax              | Why We Use It    | What It Checks         | How It Works                        |  
| ---------------- | ------------------- | ---------------- | ---------------------- | ----------------------------------- | 
| String Compare   | `[ "$a" = "$b" ]`   | Compare text     | If values match        | `[` is a test command               | 
| Empty Check      | `[ -z "$a" ]`       | Validate input   | If variable empty      | `-z` checks string length           |    
| Number Compare   | `[ "$a" -gt 5 ]`    | Compare numbers  | Greater than           | Numeric test operator               |  
| File Exists      | `[ -f file ]`       | Validate file    | If regular file exists | Checks file metadata                | 
| Directory Exists | `[ -d dir ]`        | Validate folder  | If directory exists    | Checks file type                    |     
| AND              | `cmd && echo ok`    | Run if success   | Executes next if true  | Second runs only if first returns 0 |                        
| OR               | `cmd\|\| echo fail` | Handle failure   | Runs if error          | Executes if first fails             |
| If Statement     | `if [ cond ]; then` | Decision making  | Runs block if true     | Evaluates condition exit status     |                      
| Case             | `case $1 in`        | Multiple options | Matches patterns       | Compares value against patterns     |                           

---

# 3️ Loops

| Loop Type    | Syntax                | Why We Use It          | What It Does        | How It Works                |
| ------------ | --------------------- | ---------------------- | ------------------- | --------------------------- |
| For Loop     | `for i in list; do`   | Repeat over list       | Iterates items      | Expands list then loops     |
| C-Style Loop | `for ((i=0;i<5;i++))` | Counter loops          | Runs fixed times    | Uses arithmetic evaluation  |
| While Loop   | `while read line`     | Read data line-by-line | Processes input     | Runs while condition true   |
| Until Loop   | `until cmd`           | Wait for success       | Runs until true     | Opposite of while           |
| Break        | `break`               | Stop loop early        | Exits loop          | Terminates loop immediately |
| Continue     | `continue`            | Skip iteration         | Moves to next cycle | Skips remaining commands    |

---

# 4️ Functions

| Feature      | Syntax        | Why We Use It   | What It Does            | How It Works                |
| ------------ | ------------- | --------------- | ----------------------- | --------------------------- |
| Define       | `name() {}`   | Reuse code      | Creates reusable block  | Stored in shell memory      |
| Call         | `name`        | Execute logic   | Runs function code      | Executes block when called  |
| Arguments    | `$1 $2`       | Pass data       | Access parameters       | Positional inside function  |
| Return Code  | `return 1`    | Signal status   | Sends numeric exit code | 0–255 allowed               |
| Return Value | `echo result` | Output data     | Prints result           | Capture using `$(function)` |
| Local Var    | `local var=1` | Avoid conflicts | Limits scope            | Exists only inside function |

---

# 5️ Text Processing Tools

## Grep

| Command             | Why         | What It Does         | How It Works                |
| ------------------- | ----------- | -------------------- | --------------------------- |
| `grep "error" file` | Search logs | Finds matching lines | Uses regex pattern matching |
| `-i`                | Ignore case | Case insensitive     | Converts internally         |
| `-r`                | Recursive   | Search folders       | Traverses directories       |
| `-n`                | Show line   | Debugging            | Prints line number          |
| `-c`                | Count       | Quick metrics        | Counts matches              |

---

## Sed

| Command         | Why          | What It Does      | How It Works                         |
| --------------- | ------------ | ----------------- | ------------------------------------ |
| `sed 's/a/b/g'` | Replace text | Substitutes words | Stream editor processes line-by-line |
| `-i`            | Modify file  | In-place edit     | Writes changes to file               |
| `/pattern/d`    | Remove lines | Delete matches    | Skips matched lines                  |

---

## Awk

| Command            | Why              | What It Does     | How It Works                  |
| ------------------ | ---------------- | ---------------- | ----------------------------- |
| `awk '{print $1}'` | Extract columns  | Prints field 1   | Splits line into fields       |
| `-F:`              | Custom delimiter | Change separator | Uses provided field separator |
| `/ERROR/ {print}`  | Filter rows      | Pattern match    | Executes action if matched    |

---

## Other Useful Commands

| Command   | Why              | What It Does               |
| --------- | ---------------- | -------------------------- |
| `cut`     | Extract fields   | Select column by delimiter |
| `sort -n` | Order numbers    | Numeric sorting            |
| `uniq -c` | Count duplicates | Groups identical lines     |
| `wc -l`   | Count lines      | File metrics               |
| `tail -f` | Monitor logs     | Real-time updates          |

---

# 6️ Useful One-Liners (Real DevOps)

| Task                | Command                       | Why It’s Useful  | 
| ------------------- | ----------------------------- | ---------------- |
| Delete old files    | `find . -mtime +7 -delete`    | Clean disk space | 
| Count logs          | `wc -l *.log`                 | Quick monitoring |  
| Replace config text | `sed -i 's/old/new/g' *.conf` | Bulk changes     |    
| Check service       | `systemctl is-active nginx`   | Service health   |   
| Disk usage alert    | `df -h \| awk '$5+0 > 80'`    | Prevent outages   |
| Live error monitor  | `tail -f app.log\| grep ERROR`| Real-time debugging |

---

# 7️ Error Handling & Debugging

| Command             | Why                | What It Does            | How It Works                 |
| ------------------- | ------------------ | ----------------------- | ---------------------------- |
| `exit 0/1`          | Control status     | Signals success/failure | Sends exit code to OS        |
| `$?`                | Check result       | Gets last status        | Stores previous command code |
| `set -e`            | Safer scripts      | Exit on error           | Stops script on failure      |
| `set -u`            | Catch typos        | Error on unset var      | Prevents silent bugs         |
| `set -o pipefail`   | Detect pipe errors | Fails if any pipe fails | Tracks full pipeline         |
| `set -x`            | Debug mode         | Show commands running   | Prints execution trace       |
| `trap cleanup EXIT` | Cleanup            | Run before exit         | Hooks into exit signal       |

Recommended header for production:

```bash
set -euo pipefail
```

---

# Core Principles (Remember These)

* Always use quote variables → `"$VAR"`
* Use `if` to validate inputs early.
* Use exit codes for automation reliability.
* Combine small tools using pipes.
* Test scripts before scheduling with cron.

---
