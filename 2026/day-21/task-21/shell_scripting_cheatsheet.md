
# Day 21 – Shell Scripting Cheat Sheet: Build Your Own Reference Guide
## Task 1: Basics
### Shebang
Tells system which interpreter to use.

### Execution
- chmod +x script.sh (make executable)
- ./script.sh (run directly)
- bash script.sh (run via bash)

### Comments: 
Use # for single-line or inline notes.

### Variables
```
NAME="Fahad"

echo $NAME
echo "$NAME"
echo '$NAME'
```
Difference:
- $NAME → value
- "$NAME" → preserves spaces
- '$NAME' → literal text


### Reading User Input
`read -p "Enter name: " NAME`
`echo "Hello $NAME"`


### Command Line Arguments
```
echo "Script name: $0"
echo "First arg: $1"
echo "Total args: $#"
echo "All args: $@"
echo "Exit status: $?"
```

`./script.sh file1 file2`

---

## Task 2. Operators and Conditionals
### String Comparison
- Strings: = (equal), != (not equal), -z (string is empty), -n (not empty).
- Integers: -eq (equal), -ne (not equal), -lt (less than), -gt (greater than), -le / -ge.

### File Tests

`-f`: Is a regular file | `-d`: Is a directory | `-e`: Path exists.

`-r/-w/-x`: Is readable/writable/executable.

### IF/ELSE
```
if [ -f file.txt ]; then
echo "Exists"
elif [ -d folder ]; then
echo "Directory exists"
else
echo "Not found"
fi
```

### Logical Operators
```
[ -f file ] && echo "Exists"

[ -f file ] || echo "Not exists"

[ ! -f file ]
```

### Case Statement
```
case $VAR in
start)
echo "Starting"
;;
stop)
echo "Stopping"
;;
*)
echo "Unknown"
;;
esac
```

---

## 3. Loops
```
# List-based For
for item in apple orange banana; do echo $item; done

# C-style For
for ((i=0; i<5; i++)); do echo $i; done

# While Loop (Runs while true)
while [ $COUNT -gt 0 ]; do ((COUNT--)); done

# Looping over Files
for file in *.log; do mv "$file" "${file}.bak"; done

# Reading Command Output/File line-by-line
ls | while read line; do echo "Processing $line"; done
```

---

## Task 4: Functions
```
# Definition
deploy_app() {
  local version=$1  # local scope variable
  echo "Deploying version $version"
  return 0          # Return status (0-255)
}

# Calling
deploy_app "v1.2.0"

# Result capture
status=$(deploy_app "v2") # Captures echo output, not return value
```

---

## Task 5: Text Processing Commands
### GREP
```
grep "error" file.log
grep -i "error" file.log
grep -r "error" /var/log
grep -c "error" file.log
grep -n "error" file.log
grep -v "info" file.log
grep -E "error|fail" file.log
```

### AWK
```
awk '{print $1}' file.txt

awk -F: '{print $1}' /etc/passwd

awk 'BEGIN {print "Start"} {print $1} END {print "End"}' file.txt
```

### SED
```
sed 's/old/new/g' file.txt

sed -i 's/error/warning/g' file.txt

sed '2d' file.txt
```

### CUT
```
cut -d: -f1 /etc/passwd
cut -c1-5 file.txt
```

### SORT
```
sort file.txt
sort -n file.txt
sort -r file.txt
sort -u file.txt
```

### Uniq
```
uniq file.txt
uniq -c file.txt
```

### Tr
```
tr 'a-z' 'A-Z' < file.txt

tr -d ' ' < file.txt
```

### wc
```
wc -l file.txt
wc -w file.txt
wc -c file.txt
```

### Head and Tail
```
head -n 10 file.txt

tail -n 10 file.txt

tail -f file.log
```

---

### Task 6: Useful Patterns and One-Liners

- Delete files older than 30 days: find /path -type f -mtime +30 -delete

- Count lines in all logs: wc -l *.log

- Check if service is active: systemctl is-active --quiet nginx || echo "Nginx Down"

- Replace string in multiple files: grep -rl 'old' . | xargs sed -i 's/old/new/g'

- Monitor disk usage alert: df -h | awk '$5 > 90 {print $0}' (Prints partitions > 90% full).

--- 

### Task 7: Error Handling and Debugging

- set -e: Script exits immediately if a command returns a non-zero status.

- set -u: Exit if an undefined variable is used.

- set -o pipefail: Catch errors hidden inside pipes (e.g., grep | sed).

- set -x: Print every command before executing (Trace mode).

- Trap: trap 'rm -f /tmp/lock' EXIT (Execute cleanup code when script finishes/fails).
