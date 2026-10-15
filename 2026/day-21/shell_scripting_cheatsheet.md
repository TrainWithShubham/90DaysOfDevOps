# Shell Scripting Cheat Sheet

## Quick Reference Table (Bonus)
| Topic | Key Syntax | Example |
|---|---|---|
| Variable | VAR="value" | NAME="DevOps" |
| Argument | $1, $2 | ./script.sh arg1 |
| If | if [ condition ]; then | if [ -f file ]; then |
| For loop | for i in list; do | for i in 1 2 3; do |
| Function | name() { ... } | greet() { echo "Hi"; } |
| Grep | grep pattern file | grep -i "error" log.txt |
| Awk | awk '{print $1}' file | awk -F: '{print $1}' /etc/passwd |
| Sed | sed 's/old/new/g' file | sed -i 's/foo/bar/g' config.txt |

---

## 1. Basics

**Shebang (#!/bin/bash)**
Tells the operating system which interpreter to use to execute the script. Must be the first line.
```bash
#!/bin/bash
```

**Running a Script**
Make the script executable first, then run it using a relative path or pass it directly to bash.
```bash
chmod +x script.sh
./script.sh
bash script.sh
```

**Comments**
Use the hash symbol for comments. The interpreter ignores anything after it on that line.
```bash
# This is a full-line comment
echo "Hello" # This is an inline comment
```

**Variables**
Declare without spaces around the equal sign. Double quotes allow variable expansion; single quotes treat everything literally.
```bash
VAR="DevOps"
echo $VAR      # Outputs: DevOps
echo "$VAR"    # Outputs: DevOps (Recommended to prevent word splitting)
echo '$VAR'    # Outputs: $VAR (Literal string)
```

**Reading User Input**
Pauses the script to take input from the user and stores it in a variable.
```bash
echo "Enter your name:"
read USER_NAME
```

**Command-line Arguments**
Special variables automatically populated by bash based on how the script was called.
```bash
$0 # Name of the script itself
$1 # First argument passed to the script
$# # Total number of arguments passed
$@ # All arguments as a list
$? # Exit status of the last executed command (0 is success)
```

---

## 2. Operators and Conditionals

**String Comparisons**
Used to check if strings are identical, different, empty, or not empty.
```bash
[ "$A" = "$B" ]  # True if strings are equal
[ "$A" != "$B" ] # True if strings are not equal
[ -z "$A" ]      # True if string is empty (zero length)
[ -n "$A" ]      # True if string is NOT empty
```

**Integer Comparisons**
Strictly for numerical values.
```bash
[ $A -eq $B ] # Equal to
[ $A -ne $B ] # Not equal to
[ $A -lt $B ] # Less than
[ $A -gt $B ] # Greater than
[ $A -le $B ] # Less than or equal to
[ $A -ge $B ] # Greater than or equal to
```

**File Test Operators**
Used to check file attributes before performing operations on them.
```bash
[ -f file.txt ] # True if it is a regular file
[ -d my_dir ]   # True if it is a directory
[ -e item ]     # True if the file or directory exists
[ -r file.txt ] # True if file is readable
[ -w file.txt ] # True if file is writable
[ -x script.sh ]# True if file is executable
[ -s file.txt ] # True if file size is greater than zero
```

**If, Elif, Else Syntax**
Basic conditional branching. Always end the block with fi.
```bash
if [ $AGE -ge 18 ]; then
    echo "Adult"
elif [ $AGE -ge 13 ]; then
    echo "Teenager"
else
    echo "Child"
fi
```

**Logical Operators**
Combine multiple conditions.
```bash
[ $A -eq 1 ] && [ $B -eq 2 ] # AND: True if both are true
[ $A -eq 1 ] || [ $B -eq 2 ] # OR: True if either is true
! [ $A -eq 1 ]               # NOT: Reverses the condition
```

**Case Statements**
Cleaner alternative to multiple if-elif statements when checking exact matches.
```bash
case $ACTION in
    start) echo "Starting..." ;;
    stop)  echo "Stopping..." ;;
    *)     echo "Invalid action" ;;
esac
```

---

## 3. Loops

**For Loop (List-based and C-style)**
Iterates over a predefined list of items or uses traditional numerical conditions.
```bash
# List-based
for COLOR in red green blue; do
    echo $COLOR
done

# C-style
for (( i=1; i<=5; i++ )); do
    echo $i
done
```

**While Loop**
Runs continuously as long as the condition evaluates to true.
```bash
COUNT=1
while [ $COUNT -le 5 ]; do
    echo $COUNT
    COUNT=$((COUNT + 1))
done
```

**Until Loop**
Runs continuously as long as the condition evaluates to false.
```bash
COUNT=1
until [ $COUNT -gt 5 ]; do
    echo $COUNT
    COUNT=$((COUNT + 1))
done
```

**Loop Control**
Used to prematurely exit a loop or skip the current iteration.
```bash
break    # Exits the loop completely
continue # Skips to the next iteration of the loop
```

**Looping Over Files**
Handy for bulk renaming or processing files in a directory.
```bash
for file in *.log; do
    echo "Processing $file"
done
```

**Looping Over Command Output**
Safest way to read files or command output line-by-line.
```bash
cat errors.log | while read line; do
    echo "Found: $line"
done
```

---

## 4. Functions

**Defining and Calling a Function**
Group reusable code blocks. Define it first, then call it by its name without parentheses.
```bash
my_function() {
    echo "Executing function tasks"
}
my_function # Calling the function
```

**Passing Arguments**
Functions use their own $1, $2, etc., separate from the script's global arguments.
```bash
greet() {
    echo "Hello, $1"
}
greet "DevOps Engineer"
```

**Return Values vs Echo**
Bash functions do not return strings; they return exit statuses (0-255). Use echo to return data.
```bash
check_status() {
    return 0 # Used for success/fail checks
}
get_name() {
    echo "Rashid" # Used to pass string data back
}
```

**Local Variables**
Using local prevents variables inside functions from overwriting global variables.
```bash
calculate() {
    local RESULT=100
    echo $RESULT
}
```

---

## 5. Text Processing Commands

**grep**
Searches for patterns inside text.
```bash
grep "ERROR" file.log    # Basic search
grep -i "error" file.log # Case-insensitive
grep -r "auth" /var/log/ # Search recursively in a directory
grep -c "Failed" auth.log# Count number of matches
grep -n "Deny" auth.log  # Print matches with line numbers
grep -v "INFO" file.log  # Print lines that DO NOT match
grep -E "ERROR|Failed"   # Use extended regex (multiple words)
```

**awk**
Powerful column and pattern processing tool.
```bash
awk '{print $1, $3}' file.txt    # Print column 1 and 3 (default space delimiter)
awk -F: '{print $1}' /etc/passwd # Change delimiter to colon
awk 'BEGIN {print "Start"} {print $1} END {print "Done"}' # Execute before and after processing
```

**sed**
Stream editor for finding and replacing text dynamically.
```bash
sed 's/old/new/' file.txt      # Replace first occurrence on each line
sed 's/old/new/g' file.txt     # Replace globally across the line
sed '/DEBUG/d' file.log        # Delete all lines containing DEBUG
sed -i 's/foo/bar/g' file.txt  # Edit the file in-place (saves changes)
```

**cut**
Extracts specific sections from each line based on a delimiter.
```bash
cut -d':' -f1 /etc/passwd # Cuts by colon and returns the first field
```

**sort**
Sorts lines of text files.
```bash
sort names.txt       # Alphabetical sorting
sort -n numbers.txt  # Numerical sorting
sort -r list.txt     # Reverse sorting
sort -u list.txt     # Sort and keep only unique values
```

**uniq**
Filters out adjacent duplicate lines. Almost always used after sort.
```bash
uniq file.txt        # Remove consecutive duplicates
uniq -c file.txt     # Prefix each line with its occurrence count
```

**tr**
Translates or deletes characters. Operates on standard input only.
```bash
cat text.txt | tr 'a-z' 'A-Z' # Convert lowercase to uppercase
cat text.txt | tr -d ' '      # Delete all spaces
```

**wc**
Counts newlines, words, and bytes.
```bash
wc -l file.txt # Count lines
wc -w file.txt # Count words
wc -c file.txt # Count characters
```

**head / tail**
Outputs the first or last parts of files.
```bash
head -n 5 file.txt # Print first 5 lines
tail -n 10 log.txt # Print last 10 lines
tail -f app.log    # Follow mode: continuously stream new lines
```

---

## 6. Useful Patterns and One-Liners

**Find and delete files older than 7 days**
```bash
find /var/log -type f -name "*.log" -mtime +7 -exec rm {} \;
```

**Count lines in all .log files in a directory**
```bash
find . -name "*.log" | xargs wc -l
```

**Replace a string across multiple files**
```bash
find . -type f -name "*.conf" -exec sed -i 's/old_host/new_host/g' {} +
```

**Check if a service (e.g., Docker) is running**
```bash
systemctl is-active --quiet docker && echo "Running" || echo "Stopped"
```

**Monitor disk usage and alert if above 80%**
```bash
df -h / | awk 'NR==2 {print $5}' | sed 's/%//' | while read usep; do [ $usep -ge 80 ] && echo "Disk full!"; done
```

**Parse a specific key from a JSON payload (using grep/awk)**
```bash
cat data.json | grep '"status"' | awk -F'"' '{print $4}'
```

**Tail a log and filter for specific errors in real-time**
```bash
tail -f /var/log/syslog | grep --line-buffered -E "CRITICAL|Failed"
```

---

## 7. Error Handling and Debugging

**Exit Codes**
Every command returns a status. Use exit commands to pass success or failure to the OS.
```bash
$?      # Contains the exit code of the last command
exit 0  # Represents a successful execution
exit 1  # Represents an error or failure
```

**Strict Execution Modes**
Place these at the top of your scripts to build fail-safe pipelines.
```bash
set -e          # Immediately exit if any command returns a non-zero status
set -u          # Treat unset/uninitialized variables as an error and exit
set -o pipefail # If any command in a pipeline fails, the whole pipeline fails
```

**Debug Mode**
Prints each command to the terminal before executing it. Great for troubleshooting.
```bash
set -x # Enable debug trace mode
set +x # Disable debug trace mode
```

**Trap Command**
Catches system signals (like script exit or CTRL+C) and forces a specific action.
```bash
# Deletes the temporary file whenever the script exits, even on failure
trap 'rm -f /tmp/temp_file.txt' EXIT
```
