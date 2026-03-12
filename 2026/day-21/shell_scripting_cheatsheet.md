### Tasks

### Task 1: Basics
* **Shebang (`#!/bin/bash`)**: The first line that tells the kernel which shell to use to execute the script.
* **Execution**:
    * `chmod +x script.sh` - Grant execute permission.
    * `./script.sh` - Run the script.
    * `bash script.sh` - Run script through bash explicitly.
* **Comments**: Use `#` for single-line or inline notes.
* **Variables**:
    * `VAR="Value"` (No spaces around `=`).
    * `"$VAR"` (Double quotes: expands variables).
    * `'$VAR'` (Single quotes: literal string, no expansion).
* **User Input**: `read -p "Enter username: " USERNAME`
* **Arguments**:
    * `$0`: Script name | `$1-$9`: Arguments | `$#`: Number of args | `$@`: All args | `$?`: Exit status of last command.

---

### Task 2: Operators and Conditionals

### Comparison Operators
* **Strings**: `==` (equal), `!=` (not equal), `-z` (empty), `-n` (not empty).
* **Integers**: `-eq` (==), `-ne` (!=), `-lt` (<), `-gt` (>), `-le` (<=), `-ge` (>=).
* **Files**: `-f` (file exists), `-d` (directory exists), `-x` (executable), `-s` (not empty).

### Logic & Syntax
```bash
# If/Else Logic
if [[ "$STATUS" == "active" ]] && [[ "$USER" == "root" ]]; then
    echo "Access Granted"
elif [[ "$STATUS" == "pending" ]]; then
    echo "Wait..."
else
    echo "Denied"
fi

# Case Statements
case "$ACTION" in
    start) systemctl start nginx ;;
    stop)  systemctl stop nginx ;;
    *)     echo "Usage: start|stop" ;;
esac
```

### Task 3: Loops
```bash
# List-based For Loop
for item in upload backup logs; do
    mkdir -p "/mnt/$item"
done

# C-style For Loop
for ((i=1; i<=5; i++)); do
    echo "Iteration $i"
done

# While Loop (Reading a file line by line)
while read -r line; do
    echo "Processing: $line"
done < data.txt
```

### Task 4: Functions
```bash

check_status() {
    local service=$1  # Use 'local' to prevent global scope issues
    systemctl is-active --quiet "$service"
    if [ $? -eq 0 ]; then
        echo "$service is running"
    else
        return 1
    fi
}

# Call the function
check_status "docker"
```
### Task 5: Text Processing Commands
**grep**: grep -ri "error" /var/log (Search recursively, case-insensitive).

**awk**: awk -F':' '{print $1}' /etc/passwd (Print 1st column using : as delimiter).

**sed**: sed -i 's/search/replace/g' config.yml (In-place string replacement).

**cut**: cut -d',' -f2 file.csv (Extract 2nd field of a CSV).

**sort/uniq**: sort file.txt | uniq -c (Sort lines and count unique occurrences).

**tr**: cat file | tr 'a-z' 'A-Z' (Convert to uppercase).

**wc**: wc -l file.txt (Line count).

**tail -f**: tail -f /var/log/syslog (Live stream log updates).

### Task 6: Useful Patterns and One-Liners
Delete files older than 30 days: find /logs -mtime +30 -type f -delete

Check if a port is open: netstat -tuln | grep :8080

Count lines in all .log files: cat *.log | wc -l

Find the largest 5 files: du -ah . | sort -rh | head -n 5

Monitor disk usage alert: df -h | awk '$5+0 > 80 {print "Warning: " $1 " is at " $5}'

set -e          # Exit script immediately if a command fails
set -u          # Exit if an uninitialized variable is used
set -o pipefail # Catch errors in piped commands
set -x          # Print commands for debugging (Trace mode)

# Cleanup trap
trap "echo 'Cleaning up...'; rm -f /tmp/temp_*" EXIT