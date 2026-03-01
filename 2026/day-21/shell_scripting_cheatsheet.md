# Shell Scripting Cheat Sheet

## Quick Reference Table

| Topic | Key Syntax | Example |
|-------|-----------|---------|
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop | `for i in list; do` | `for i in 1 2 3; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i "error" log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |
| Exit code | `$?` | `echo $?  # 0=success` |
| Trap | `trap 'fn' EXIT` | `trap 'rm -f /tmp/lock' EXIT` |

---

## 1. Basics

### Shebang
Tells the OS which interpreter to use. Must be the first line.
```bash
#!/bin/bash
```

### Running a Script
```bash
chmod +x script.sh   # make executable
./script.sh          # run directly
bash script.sh       # run with bash explicitly
```

### Comments
```bash
# This is a full-line comment
echo "Hello"  # inline comment
```

### Variables
```bash
NAME="DevOps"        # declare (no spaces around =)
echo $NAME           # use variable
echo "$NAME"         # quoted — safe, prevents word splitting
echo '$NAME'         # single quotes — literal, no expansion
```

### Reading User Input
```bash
read -p "Enter your name: " USERNAME
echo "Hello, $USERNAME"
```

### Command-Line Arguments
```bash
$0   # script name
$1   # first argument
$#   # number of arguments
$@   # all arguments (as separate words)
$?   # exit code of last command
```

---

## 2. Operators and Conditionals

### String Comparisons
```bash
[ "$a" = "$b" ]    # equal
[ "$a" != "$b" ]   # not equal
[ -z "$a" ]        # true if string is empty
[ -n "$a" ]        # true if string is non-empty
```

### Integer Comparisons
```bash
[ $a -eq $b ]   # equal
[ $a -ne $b ]   # not equal
[ $a -lt $b ]   # less than
[ $a -gt $b ]   # greater than
[ $a -le $b ]   # less than or equal
[ $a -ge $b ]   # greater than or equal
```

### File Test Operators
```bash
[ -f file ]   # is a regular file
[ -d dir ]    # is a directory
[ -e path ]   # exists
[ -r file ]   # readable
[ -w file ]   # writable
[ -x file ]   # executable
[ -s file ]   # exists and non-empty
```

### if / elif / else
```bash
if [ "$1" = "start" ]; then
  echo "Starting..."
elif [ "$1" = "stop" ]; then
  echo "Stopping..."
else
  echo "Unknown command"
fi
```

### Logical Operators
```bash
[ condition1 ] && [ condition2 ]   # AND
[ condition1 ] || [ condition2 ]   # OR
! [ condition ]                    # NOT
```

### Case Statement
```bash
case "$1" in
  start)  echo "Starting" ;;
  stop)   echo "Stopping" ;;
  *)      echo "Usage: $0 {start|stop}" ;;
esac
```

---

## 3. Loops

### for Loop
```bash
# List-based
for fruit in apple banana cherry; do
  echo "$fruit"
done

# C-style
for ((i=1; i<=5; i++)); do
  echo "$i"
done
```

### while Loop
```bash
count=1
while [ $count -le 5 ]; do
  echo "$count"
  ((count++))
done
```

### until Loop
```bash
count=1
until [ $count -gt 5 ]; do
  echo "$count"
  ((count++))
done
```

### Loop Control
```bash
break      # exit loop immediately
continue   # skip to next iteration
```

### Loop Over Files
```bash
for file in *.log; do
  echo "Processing $file"
done
```

### Loop Over Command Output
```bash
cat servers.txt | while read line; do
  echo "Pinging $line"
done
```

---

## 4. Functions

### Define and Call
```bash
greet() {
  echo "Hello, $1!"
}

greet "DevOps"   # call with argument
```

### Arguments Inside Functions
```bash
add() {
  echo $(( $1 + $2 ))
}
add 3 5   # outputs 8
```

### Return Values
```bash
# return sends an exit code (0-255)
is_even() {
  [ $(( $1 % 2 )) -eq 0 ] && return 0 || return 1
}

# echo is used to return actual data
get_date() {
  echo "$(date +%Y-%m-%d)"
}
TODAY=$(get_date)
```

### Local Variables
```bash
my_func() {
  local x=10   # scoped to this function only
  echo "$x"
}
```

---

## 5. Text Processing Commands

### grep — Search Patterns
```bash
grep "error" file.log          # basic search
grep -i "error" file.log       # case-insensitive
grep -r "error" ./logs/        # recursive
grep -c "error" file.log       # count matching lines
grep -n "error" file.log       # show line numbers
grep -v "error" file.log       # invert (exclude matches)
grep -E "err|warn" file.log    # extended regex (OR)
```

### awk — Column Processing
```bash
awk '{print $1}' file              # print first column
awk -F: '{print $1}' /etc/passwd   # custom field separator
awk '$3 > 100 {print $1}' file     # filter by condition
awk 'BEGIN {print "Start"} {print} END {print "Done"}' file
```

### sed — Stream Editor
```bash
sed 's/old/new/' file           # replace first occurrence per line
sed 's/old/new/g' file          # replace all occurrences
sed -i 's/foo/bar/g' file       # in-place edit
sed '/^#/d' file                # delete comment lines
sed -n '5,10p' file             # print lines 5–10
```

### cut — Extract Columns
```bash
cut -d',' -f1 file.csv         # first field, comma-delimited
cut -d':' -f1,3 /etc/passwd    # fields 1 and 3
cut -c1-5 file                 # first 5 characters
```

### sort
```bash
sort file               # alphabetical
sort -n file            # numerical
sort -r file            # reverse
sort -u file            # unique (remove duplicates)
sort -k2 file           # sort by second column
```

### uniq
```bash
uniq file           # remove consecutive duplicates (sort first!)
uniq -c file        # count occurrences
uniq -d file        # show only duplicates
```

### tr — Translate / Delete Characters
```bash
echo "hello" | tr 'a-z' 'A-Z'    # uppercase
echo "he llo" | tr -d ' '        # delete spaces
echo "aabbcc" | tr -s 'a-z'      # squeeze repeated chars
```

### wc — Count
```bash
wc -l file    # line count
wc -w file    # word count
wc -c file    # byte count
```

### head / tail
```bash
head -n 20 file          # first 20 lines
tail -n 20 file          # last 20 lines
tail -f /var/log/syslog  # follow (live updates)
tail -f app.log | grep "ERROR"   # follow + filter
```

---

## 6. Useful One-Liners

```bash
# Find and delete files older than 30 days
find /var/logs -name "*.log" -mtime +30 -delete

# Count total lines across all .log files
wc -l *.log | tail -1

# Replace a string across multiple files
sed -i 's/localhost/prod-server/g' *.conf

# Check if a service is running
systemctl is-active --quiet nginx && echo "Running" || echo "Stopped"

# Alert if disk usage exceeds 80%
df -h | awk '$5+0 > 80 {print "ALERT: "$0}'

# Parse CSV — print second column
awk -F',' '{print $2}' data.csv

# Tail a log and filter for errors in real time
tail -f app.log | grep --line-buffered "ERROR"

# List top 10 most used commands from history
history | awk '{print $2}' | sort | uniq -c | sort -rn | head -10

# Kill all processes matching a name
pkill -f "python app.py"
```

---

## 7. Error Handling and Debugging

### Exit Codes
```bash
$?          # exit code of last command (0 = success)
exit 0      # explicit success
exit 1      # explicit failure
```

### Strict Mode Options
```bash
set -e            # exit immediately on error
set -u            # treat unset variables as errors
set -o pipefail   # catch errors inside pipes
set -x            # debug mode — print each command before executing

# Common pattern — use all together at top of script:
set -euo pipefail
```

### Trap — Cleanup on Exit
```bash
cleanup() {
  rm -f /tmp/mylock
  echo "Cleanup done"
}
trap cleanup EXIT         # runs on exit (normal or error)
trap 'echo "Interrupted"' INT   # runs on Ctrl+C
```

### Defensive Checks
```bash
# Check required argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <filename>" >&2
  exit 1
fi

# Check if command exists
command -v docker &>/dev/null || { echo "docker not found"; exit 1; }

# Default value if variable unset
LOG_DIR="${LOG_DIR:-/var/log/myapp}"
```

5. Text Processing Commands
grep — Top 10 Production Commands
bash# 1. Find all ERROR/WARN lines in app logs (case-insensitive)
grep -iE "error|warn|critical" /var/log/app/app.log

# 2. Search recursively across all config files for a setting
grep -r "max_connections" /etc/nginx/

# 3. Show filename + line number — great for multi-file log triage
grep -rn "OutOfMemoryError" /var/log/tomcat/

# 4. Exclude noise (filter out debug/info, keep real issues)
grep -v -E "DEBUG|INFO" /var/log/app/app.log

# 5. Count how many times a pattern appears (quick error frequency check)
grep -c "Connection refused" /var/log/app/app.log

# 6. Live log monitoring — tail + grep for errors in real time
tail -f /var/log/nginx/access.log | grep --line-buffered " 50[0-9] "

# 7. Extract only matching part (e.g. IP addresses from access logs)
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /var/log/nginx/access.log | sort | uniq -c | sort -rn

# 8. Search inside .gz compressed logs without decompressing
zgrep "ERROR" /var/log/app/app.log.2.gz

# 9. Show N lines of context around a match (before/after the error)
grep -A 5 -B 2 "FATAL" /var/log/app/app.log

# 10. Find all files containing a pattern (just filenames, no content)
grep -rl "password=" /etc/ 2>/dev/null
awk — Top 10 Production Commands
bash# 1. Print specific columns from logs (e.g. timestamp + log level)
awk '{print $1, $2, $3}' /var/log/app/app.log

# 2. Calculate average response time from access logs
awk '{sum += $NF; count++} END {print "Avg:", sum/count, "ms"}' response_times.log

# 3. Filter lines where HTTP status is 5xx (column 9 in nginx logs)
awk '$9 >= 500 {print $0}' /var/log/nginx/access.log

# 4. Parse /etc/passwd to list all system users and their shells
awk -F: '$3 >= 1000 {print $1, $7}' /etc/passwd

# 5. Sum disk usage of a specific user from du output
du -sh /home/* | awk '{sum += $1} END {print "Total:", sum, "MB"}'

# 6. Find top 10 IPs hammering your server
awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -rn | head -10

# 7. Print lines between two patterns (e.g. extract a specific deploy block)
awk '/Deploy START/,/Deploy END/' /var/log/deploy.log

# 8. Alert if CPU column exceeds threshold in a monitoring output
ps aux | awk '$3 > 80 {print "HIGH CPU:", $1, $2, $3"%"}'

# 9. Reformat CSV — swap columns and change delimiter
awk -F',' '{print $2 "|" $1 "|" $3}' data.csv

# 10. Count occurrences of each HTTP status code
awk '{print $9}' /var/log/nginx/access.log | sort | uniq -c | sort -rn
sed — Top 10 Production Commands
bash# 1. Replace a config value in-place (e.g. update DB host during deploy)
sed -i 's/db_host=localhost/db_host=prod-db.internal/g' app.conf

# 2. Comment out a line matching a pattern (disable a config option)
sed -i 's/^PermitRootLogin yes/#PermitRootLogin yes/' /etc/ssh/sshd_config

# 3. Uncomment a line (enable a config option)
sed -i 's/^#\(MaxConnections\)/\1/' /etc/app/config.conf

# 4. Delete all blank lines from a file
sed -i '/^[[:space:]]*$/d' config.conf

# 5. Delete all comment lines (clean up config for review)
sed '/^#/d' /etc/app/config.conf

# 6. Insert a line after a match (e.g. add config option after a section header)
sed -i '/\[database\]/a db_timeout=30' app.ini

# 7. Print only lines 100–200 of a huge log file (faster than head/tail combo)
sed -n '100,200p' /var/log/app/app.log

# 8. Remove ANSI color codes from logs (clean up CI/CD output)
sed -i 's/\x1B\[[0-9;]*[mK]//g' build.log

# 9. Replace a port number across multiple files in a directory
find /etc/nginx/conf.d/ -name "*.conf" | xargs sed -i 's/:8080/:9090/g'

# 10. Bulk rename — strip a prefix from lines (useful in pipeline transformations)
sed 's/^prod-//' servers.txt