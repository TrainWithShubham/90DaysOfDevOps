# Shell Scripting Cheat Sheet

---

## Quick Reference Table

| Topic      | Key Syntax                         | Example |
|------------|------------------------------------|---------|
| Variable   | `VAR="value"`                      | `NAME="Shiv"` |
| Argument   | `$1`, `$2`, `$@`, `$#`             | `./script.sh arg1 arg2` |
| If         | `if [ condition ]; then ... fi`    | `if [ -f file ]; then echo "Exists"; fi` |
| For Loop   | `for i in list; do ... done`       | `for i in 1 2 3; do echo "$i"; done` |
| Function   | `name() { ... }`                   | `greet() { echo "Hi"; }` |
| Grep       | `grep pattern file`                | `grep -i "error" log.txt` |
| Awk        | `awk '{print $1}' file`            | `awk -F: '{print $1}' /etc/passwd` |
| Sed        | `sed 's/old/new/g' file`           | `sed -i 's/foo/bar/g' config.txt` |

---

## Task 1 – Basics

### 1. Shebang (`#!/bin/bash`)

Defines which shell should interpret the script.

```bash
#!/bin/bash
```

Without shebang, system may use default shell.

---

### 2. Running a Script

Give execute permission:

```bash
chmod +x script.sh
```

Run script:

```bash
./script.sh
bash script.sh
```

- `./script.sh` → runs using shebang  
- `bash script.sh` → forces execution using bash  

---

### 3. Comments

Single line comment:

```bash
# This is a single line comment
```

Inline comment:

```bash
echo "Hello"  # This is an inline comment
```

---

### 4. Variables

Declaring variable:

```bash
NAME="Shiv"
```

Using variable:

```bash
echo $NAME
echo "$NAME"
echo '$NAME'
```

- `$NAME` → expands (word splitting may occur)  
- `"$NAME"` → safe expansion  
- `'$NAME'` → does not expand  

---

### 5. Reading User Input

```bash
read -p "Enter your name: " NAME
echo "Hello $NAME"
```

Reads input at runtime and stores in a variable.

---

### 6. Command-Line Arguments

```bash
./script.sh arg1 arg2
```

Inside script:

```bash
$0   # script name  
$1   # first argument  
$#   # number of arguments  
$@   # all arguments  
$?   # exit code of last command  
```
---

## Task 2 – Operators and Conditionals

### 1. String Comparisons

```bash
[ "$a" = "$b" ]
[ "$a" != "$b" ]
[ -z "$a" ]   # true if empty
[ -n "$a" ]   # true if not empty
```

Used to compare string values safely.

---

### 2. Integer Comparisons

```bash
[ "$a" -eq "$b" ]   # equal
[ "$a" -ne "$b" ]   # not equal
[ "$a" -lt "$b" ]   # less than
[ "$a" -gt "$b" ]   # greater than
[ "$a" -le "$b" ]   # less or equal
[ "$a" -ge "$b" ]   # greater or equal
```

Used for numeric comparisons.

---

### 3. File Test Operators

```bash
[ -f file ]   # file exists
[ -d dir ]    # directory exists
[ -e path ]   # file or directory exists
[ -r file ]   # readable
[ -w file ]   # writable
[ -x file ]   # executable
[ -s file ]   # not empty
```

Used to check file and directory conditions.

---

### 4. If, Elif, Else

```bash
if [ -f file ]; then
    echo "File exists"
elif [ -d file ]; then
    echo "Directory exists"
else
    echo "Not found"
fi
```

Used to execute conditional logic.

---

### 5. Logical Operators

```bash
[ -f file ] && echo "File exists"
[ -f file ] || echo "File not found"
! [ -f file ]   # NOT condition
```

Used to combine conditions.

---

### 6. Case Statement

```bash
case "$var" in
    start)
        echo "Starting service"
        ;;
    stop)
        echo "Stopping service"
        ;;
    *)
        echo "Invalid option"
        ;;
esac
```

Used for multi-condition branching.
---

## Task 3 – Loops

### 1. For Loop (List Based)

```bash
for i in 1 2 3 4 5
do
    echo "$i"
done
```

Used to iterate over a list of values.

---

### 2. For Loop (C-Style)

```bash
for (( i=0; i<5; i++ ))
do
    echo "$i"
done
```

Used when numeric control is needed.

---

### 3. While Loop

```bash
count=1
while [ "$count" -le 5 ]
do
    echo "$count"
    count=$((count+1))
done
```

Runs while condition is true.

---

### 4. Until Loop

```bash
count=1
until [ "$count" -gt 5 ]
do
    echo "$count"
    count=$((count+1))
done
```

Runs until condition becomes true.

---

### 5. Loop Control

```bash
break     # exit loop
continue  # skip current iteration
```

Used to control loop flow.

---

### 6. Looping Over Files

```bash
for file in *.log
do
    echo "$file"
done
```

Iterates over matching files.

---

### 7. Looping Over Command Output

```bash
cat file.txt | while read line
do
    echo "$line"
done
```

Processes command output line by line.

---

## Task 4 – Functions

### 1. Defining a Function

```bash
greet() {
    echo "Hello"
}
```

Functions help organize reusable code.

---

### 2. Calling a Function

```bash
greet
```

Calls the function by its name.

---

### 3. Passing Arguments to Functions

```bash
greet() {
    echo "Hello $1"
}

greet "Shiv"
```

Arguments inside functions are accessed using `$1`, `$2`, etc.

---

### 4. Return Values

Using `return` (used for exit status):

```bash
my_func() {
    return 1
}
```

Using `echo` (used to return actual value):

```bash
get_name() {
    echo "Shiv"
}

NAME=$(get_name)
```

`return` → exits function  
`echo` → outputs value

---

### 5. Local Variables

```bash
my_func() {
    local value=10
    echo "$value"
}
```

`local` restricts variable scope to the function.

---

## Task 5 – Text Processing Commands

### 1. Grep

Search for patterns in files.

```bash
grep "error" file.txt
grep -i "error" file.txt      # case insensitive
grep -r "error" /logs        # recursive
grep -c "error" file.txt     # count matches
grep -n "error" file.txt     # show line numbers
grep -v "error" file.txt     # invert match
grep -E "error|fail" file.txt  # multiple patterns
```

---

### 2. Awk

Used for column-based processing.

```bash
awk '{print $1}' file.txt
awk -F: '{print $1}' /etc/passwd
awk 'NR==1' file.txt        # print first line
awk '/error/' file.txt      # pattern matching
```

`-F` → field separator  
`NR` → current line number  

---

### 3. Sed

Stream editor for modifying text.

```bash
sed 's/old/new/' file.txt
sed 's/old/new/g' file.txt      # global replace
sed -i 's/foo/bar/g' file.txt   # in-place edit
sed '/error/d' file.txt         # delete lines
```

---

### 4. Cut

Extract specific columns.

```bash
cut -d: -f1 /etc/passwd
cut -c1-5 file.txt
```

`-d` → delimiter  
`-f` → field  

---

### 5. Sort

Sort lines.

```bash
sort file.txt
sort -n file.txt    # numeric sort
sort -r file.txt    # reverse
sort -u file.txt    # unique
```

---

### 6. Uniq

Remove duplicate lines (must sort first).

```bash
sort file.txt | uniq
sort file.txt | uniq -c   # count occurrences
```

---

### 7. Tr

Translate or delete characters.

```bash
tr 'a-z' 'A-Z' < file.txt
tr -d '\r' < file.txt
```

---

### 8. Wc

Count lines, words, characters.

```bash
wc -l file.txt   # line count
wc -w file.txt   # word count
wc -c file.txt   # character count
```

---

### 9. Head / Tail

```bash
head -n 5 file.txt
tail -n 5 file.txt
tail -f file.txt   # follow log in real time
```
---

## Task 6 – Useful Patterns and One-Liners

### 1. Find and Delete Files Older Than N Days

```bash
find /path -type f -mtime +7 -exec rm -f {} \;
```

Deletes files older than 7 days.

---

### 2. Count Lines in All .log Files

```bash
wc -l *.log
```

Counts lines in all log files in directory.

---

### 3. Replace a String Across Multiple Files

```bash
sed -i 's/old/new/g' *.txt
```

Replaces text in all matching files.

---

### 4. Check if a Service is Running

```bash
ps -ef | grep nginx | grep -v grep
```

Checks if process is running.

---

### 5. Monitor Disk Usage

```bash
df -h
```

Shows disk usage in human-readable format.

---

### 6. Tail Log and Filter Errors in Real Time

```bash
tail -f app.log | grep --line-buffered "ERROR"
```

Monitors logs and shows errors live.

---

### 7. Get Top 5 CPU Consuming Processes

```bash
ps -eo pid,cmd,%cpu --sort=-%cpu | head -n 6
```

Shows highest CPU usage processes.

---

## Task 7 – Error Handling and Debugging

### 1. Exit Codes

```bash
echo $?
exit 0   # success
exit 1   # failure
```

`$?` returns exit code of last executed command.

---

### 2. set -e

```bash
set -e
```

Script exits immediately if any command fails.

---

### 3. set -u

```bash
set -u
```

Treats unset variables as an error.

---

### 4. set -o pipefail

```bash
set -o pipefail
```

Script fails if any command in a pipeline fails.

---

### 5. set -x (Debug Mode)

```bash
set -x
```

Prints each command before execution (useful for debugging).

---

### 6. Trap

```bash
cleanup() {
    rm -f temp.txt
}

trap 'cleanup' EXIT
```

Runs cleanup function when script exits.

---

## Notes

- Always quote variables when working with file paths.
- Prefer `wc -l < file` instead of `cat file | wc -l`.
- Use `set -euo pipefail` for safer scripts.
- Test scripts with small inputs before production use.
