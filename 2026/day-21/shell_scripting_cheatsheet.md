
# Shell Scripting Cheat Sheet

## Quick Reference Table

| Topic | Key Syntax | Example |
| :--- | :--- | :--- |
| Variable | `VAR="value"` | `USER="Habeeb"` |
| Argument | `$1`, `$2` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop | `for i in list; do` | `for i in {1..5}; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -E "ERROR|Failed" log.txt` |
| Awk | `awk '{print $1}' file` | `awk '{ $1=$2=$3=""; print }'` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |

---

## 1. Basics
* **Shebang (`#!/bin/bash`):** Tells the OS which interpreter to use to execute the script. Must be line 1.
* **Running a script:** Make executable with `chmod +x script.sh`, then run with `./script.sh`.
* **Comments:** Single line uses `#`. Inline comments go after the command: `echo "hi" # prints hi`.
* **Variables:** Declare without spaces (`VAR=1`). Reference with `$VAR`. Double quotes (`"$VAR"`) expand the variable; single quotes (`'$VAR'`) print it literally.
* **Reading Input:** `read -p "Enter name: " name` prompts the user and saves input to `$name`.
* **Arguments:** 
  * `$0`: Script name
  * `$1`, `$2`: First and second arguments
  * `$#`: Total count of arguments passed
  * `$@`: All arguments passed
  * `$?`: Exit status of the last command (0 = success)

## 2. Operators and Conditionals
* **String Comparisons:** `=` (equal), `!=` (not equal), `-z` (string is empty), `-n` (string is not empty).
* **Integer Comparisons:** `-eq` (equal), `-ne` (not equal), `-lt` (less than), `-gt` (greater than), `-le` (less/equal), `-ge` (greater/equal).
* **File Tests:** 
  * `-f`: File exists and is a regular file.
  * `-d`: Directory exists.
  * `-e`: Exists (file or dir).
  * `-r`, `-w`, `-x`: Read, write, execute permissions.
* **Syntax:**
```bash
if [[ -d "$DIR" ]]; then
    echo "Directory exists"
elif [[ -f "$FILE" ]]; then
    echo "File exists"
else
    echo "Neither exists"
fi

```

## 3. Loops

* **For Loop (List):** `for item in "${ARRAY[@]}"; do ... done`
* **For Loop (C-Style):** `for ((i=0; i<10; i++)); do ... done`
* **While Loop:** Runs as long as condition is true. `while [[ $count -lt 5 ]]; do ... done`
* **Until Loop:** Runs until a condition becomes true. `until [[ $count -eq 5 ]]; do ... done`
* **Loop Control:** `break` exits the loop entirely. `continue` skips the current iteration and moves to the next.

## 4. Functions

* **Defining & Calling:** Define with `name() { ... }`. Call simply by typing `name`.
* **Arguments:** Handled identically to scripts (`$1`, `$2`). `greet Habeeb` passes "Habeeb" as `$1`.
* **Return vs Echo:** `return` passes an exit status (0-255) back to the script. `echo` passes text data.
* **Local Variables:** Use the `local` keyword inside functions to prevent variable leakage into the global scope.

## 5. Text Processing Commands

* **`grep`:** Searches for patterns. `-i` (case-insensitive), `-r` (recursive), `-c` (count), `-n` (line numbers), `-v` (invert match), `-E` (extended regex for multiple words).
* **`awk`:** Powerful text formatting. Use `'{print $1}'` to print column 1. Use `'{ $1=$2=""; print }'` to delete columns.
* **`sed`:** Stream editor. `s/old/new/g` substitutes text. `-i` edits the file directly (in-place).
* **`sort`:** Sorts lines. `-n` (numerical), `-r` (reverse), `-k` (sort by specific column).
* **`uniq`:** Removes duplicate lines (must be sorted first). `-c` counts occurrences.
* **`find`:** Searches file systems. `-name` (by name), `-mtime +7` (older than 7 days), `-exec` (run command on results).
* **`wc`:** Word count. `-l` outputs only the line count.
* **`head` / `tail`:** Shows first/last 10 lines. `-n 5` shows 5 lines. `tail -f` follows the file live.

## 6. Real-World Useful One-Liners

* **Find and compress log files older than 7 days:**
`find /var/log -name "*.log" -mtime +7 -exec gzip {} \;`
* **Find and delete old backups (14+ days):**
`find /backup -name "*.tar.gz" -mtime +14 -exec rm {} \;`
* **Count total ERROR or Failed events in a log:**
`grep -E "ERROR|Failed" app.log | wc -l`
* **Extract, rank, and count the top 5 most common errors:**
`grep "ERROR" app.log | awk '{ $1=$2=$3=""; print }' | sort | uniq -c | sort -rn | head -5`
* **Check top 5 largest directories/files:**
`du -sh * | sort -hr | head -n 5`

## 7. Error Handling and Debugging

* **Exit Codes:** Validate command success using `if [[ $? -eq 0 ]]`. Force script failure using `exit 1`.
* **`set -e`:** Exits the script immediately if any command returns a non-zero status.
* **`set -u`:** Treats undefined variables as an error and exits.
* **`set -o pipefail`:** Forces a pipeline to return a failure if *any* command in the pipe fails, not just the last one.
* **`set -x`:** Debug mode. Prints every command to the terminal before executing it.


