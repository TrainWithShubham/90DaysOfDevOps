# Shell Scripting Cheat Sheet

## Task 1: Basics

---

### 1) Shebang (`#!/bin/bash`)

**What it does:**
Tells the operating system which interpreter should run the script.

**Why it matters:**
Without it, the system may use a different shell (like `sh`) and some Bash features may fail.

**Example:**

```bash
#!/bin/bash
echo "This script runs using Bash"
```

---

### 2) Running a Script

#### Make script executable

```bash
chmod +x script.sh
```

#### Run using relative path

```bash
./script.sh
```

#### Run using bash explicitly

```bash
bash script.sh
```

**Note:** `./script.sh` requires executable permission, but `bash script.sh` does not.

---

### 3) Comments

#### Single line comment

```bash
# This is a comment
```

#### Inline comment

```bash
echo "Hello"  # prints greeting
```

---

### 4) Variables

#### Declare variable

```bash
name="Om"
```

#### Use variable

```bash
echo $name
echo "$name"
```

#### Quoting difference

```bash
echo "$name"   # variable expands
echo '$name'   # printed literally
```

---

### 5) Reading User Input (`read`)

```bash
echo "Enter your name:"
read username

echo "Hello $username"
```

Inline input:

```bash
read -p "Enter age: " age
echo "You are $age years old"
```

---

### 6) Command-line Arguments

```bash
echo "Script name: $0"
echo "First argument: $1"
echo "Total arguments: $#"
echo "All arguments: $@"
echo "Last command status: $?"
```

**Run example:**

```bash
bash script.sh apple mango banana
```

**Output example:**

```
Script name: script.sh
First argument: apple
Total arguments: 3
All arguments: apple mango banana
```
# Shell Scripting Cheat Sheet

## Task 1: Basics

---

### 1) Shebang (`#!/bin/bash`)

**What it does:**
Tells the operating system which interpreter should run the script.

**Why it matters:**
Without it, the system may use a different shell (like `sh`) and some Bash features may fail.

**Example:**

```bash
#!/bin/bash
echo "This script runs using Bash"
```

---

### 2) Running a Script

#### Make script executable

```bash
chmod +x script.sh
```

#### Run using relative path

```bash
./script.sh
```

#### Run using bash explicitly

```bash
bash script.sh
```

**Note:** `./script.sh` requires executable permission, but `bash script.sh` does not.

---

### 3) Comments

#### Single line comment

```bash
# This is a comment
```

#### Inline comment

```bash
echo "Hello"  # prints greeting
```

---

### 4) Variables

#### Declare variable

```bash
name="Om"
```

#### Use variable

```bash
echo $name
echo "$name"
```

#### Quoting difference

```bash
echo "$name"   # variable expands
echo '$name'   # printed literally
```

---

### 5) Reading User Input (`read`)

```bash
echo "Enter your name:"
read username

echo "Hello $username"
```

Inline input:

```bash
read -p "Enter age: " age
echo "You are $age years old"
```

---

### 6) Command-line Arguments

```bash
echo "Script name: $0"
echo "First argument: $1"
echo "Total arguments: $#"
echo "All arguments: $@"
echo "Last command status: $?"
```

**Run example:**

```bash
bash script.sh apple mango banana
```

**Output example:**

```
Script name: script.sh
First argument: apple
Total arguments: 3
All arguments: apple mango banana
```

---

## Task 2: Operators and Conditionals

### String comparisons

```bash
[ "$a" = "$b" ]   # equal
[ "$a" != "$b" ]  # not equal
[ -z "$a" ]        # empty string
[ -n "$a" ]        # non-empty
```

### Integer comparisons

```bash
[ $a -eq $b ]  # equal
[ $a -ne $b ]  # not equal
[ $a -lt $b ]  # less than
[ $a -gt $b ]  # greater than
[ $a -le $b ]  # <=
[ $a -ge $b ]  # >=
```

### File test operators

```bash
[ -f file ]  # regular file
[ -d dir ]   # directory
[ -e path ]  # exists
[ -r file ]  # readable
[ -w file ]  # writable
[ -x file ]  # executable
[ -s file ]  # not empty
```

### if / elif / else

```bash
if [ $age -ge 18 ]; then
  echo "Adult"
elif [ $age -ge 13 ]; then
  echo "Teen"
else
  echo "Child"
fi
```

### Logical operators

```bash
[ $a -gt 5 ] && echo "big"
[ $a -lt 5 ] || echo "small"
! [ -f file.txt ] && echo "missing"
```

### Case statement

```bash
case $choice in
  start) echo "Starting" ;;
  stop)  echo "Stopping" ;;
  *)     echo "Unknown" ;;
esac
```

---

## Task 3: Loops

### for (list)

```bash
for name in Ram Shyam Hari; do
  echo $name
done
```

### for (C-style)

```bash
for ((i=1;i<=5;i++)); do
  echo $i
done
```

### while loop

```bash
i=1
while [ $i -le 5 ]; do
  echo $i
  ((i++))
done
```

### until loop

```bash
i=1
until [ $i -gt 5 ]; do
  echo $i
  ((i++))
done
```

### break / continue

```bash
for i in {1..5}; do
  [ $i -eq 3 ] && continue
  [ $i -eq 5 ] && break
  echo $i
done
```

### Loop files

```bash
for file in *.log; do
  echo $file
done
```

### Loop command output

```bash
cat file.txt | while read line; do
  echo $line
done
```

---

## Task 4: Functions

### Define & call

```bash
greet() {
  echo "Hello $1"
}

greet Om
```

### Arguments inside function

```bash
add() {
  echo $(($1 + $2))
}
add 3 5
```

### return vs echo

```bash
square() {
  return $(($1*$1))  # numeric small values only
}

square 5
echo $?   # return code
```

### local variables

```bash
func() {
  local temp=10
  echo $temp
}
```

---

## Task 5: Text Processing Commands

### grep

```bash
grep "error" file
grep -i "error" file
grep -r "error" /var/log
grep -c "error" file
grep -n "error" file
grep -v "info" file
grep -E "fail|error" file
```

### awk

```bash
awk '{print $1}' file
awk -F, '{print $2}' data.csv
awk '/error/ {print $0}' file
awk 'BEGIN{print "start"} END{print "end"}' file
```

### sed

```bash
sed 's/cat/dog/' file
sed '/error/d' file
sed -i 's/old/new/g' file
```

### cut

```bash
cut -d, -f1 data.csv
```

### sort / uniq

```bash
sort file
sort -n file
sort -r file
sort file | uniq
sort file | uniq -c
```

### tr

```bash
echo "HELLO" | tr 'A-Z' 'a-z'
echo "abc123" | tr -d '0-9'
```

### wc

```bash
wc -l file
wc -w file
wc -c file
```

### head / tail

```bash
head -5 file
tail -5 file
tail -f logfile
```

---

## Task 6: Useful One-Liners

```bash
# delete files older than 7 days
find . -type f -mtime +7 -delete

# count lines in all log files
wc -l *.log

# replace text in multiple files
sed -i 's/old/new/g' *.txt

# check if service running
systemctl is-active nginx

# disk usage alert
df -h | awk '$5>80 {print "High usage: "$0}'

# live error monitoring
tail -f app.log | grep --line-buffered ERROR
```

---

## Task 7: Error Handling and Debugging

```bash
exit 0   # success
exit 1   # failure
echo $?  # last command status
```

```bash
set -e        # exit on error
set -u        # unset variable error
set -o pipefail
set -x        # debug trace
```

### trap cleanup

```bash
cleanup() {
  echo "Cleaning up"
}
trap cleanup EXIT
```









