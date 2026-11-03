# 🐚 Shell Scripting Cheat Sheet

A quick reference guide for Shell Scripting concepts learned during the #90DaysOfDevOps challenge.

---

# 📚 Quick Reference Table

| Topic | Key Syntax | Example |
|---------|------------|----------|
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2` | `./script.sh file.txt` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For Loop | `for i in list; do` | `for i in 1 2 3; do` |
| Function | `name(){}` | `greet(){ echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i error log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g'` | `sed -i 's/foo/bar/g' file` |

---

# 1️⃣ Basics

## Shebang

```bash
#!/bin/bash
```

Tells Linux to execute the script using Bash.

---

## Running a Script

```bash
chmod +x script.sh
./script.sh
```

or

```bash
bash script.sh
```

---

## Comments

```bash
# Single line comment

echo "Hello" # Inline comment
```

---

## Variables

```bash
NAME="Chaitanya"

echo $NAME

echo "$NAME"

echo '$NAME'
```

Double quotes expand variables.

Single quotes print text literally.

---

## Reading User Input

```bash
read NAME

echo $NAME
```

Prompt example

```bash
read -p "Enter Name: " NAME
```

---

## Command Line Arguments

```bash
echo $0
echo $1
echo $2
echo $#
echo $@
echo $?
```

| Variable | Meaning |
|----------|----------|
| `$0` | Script name |
| `$1` | First argument |
| `$2` | Second argument |
| `$#` | Number of arguments |
| `$@` | All arguments |
| `$?` | Previous command exit code |

---

# 2️⃣ Operators & Conditionals

## String Comparison

```bash
[ "$A" = "$B" ]

[ "$A" != "$B" ]

[ -z "$A" ]

[ -n "$A" ]
```

---

## Integer Comparison

```bash
[ 5 -eq 5 ]

[ 5 -ne 4 ]

[ 5 -lt 8 ]

[ 5 -gt 2 ]

[ 5 -le 5 ]

[ 5 -ge 3 ]
```

---

## File Tests

```bash
-f file

-d folder

-e file

-r file

-w file

-x file

-s file
```

---

## If Else

```bash
if [ condition ]
then
    echo OK
elif [ condition ]
then
    echo YES
else
    echo NO
fi
```

---

## Logical Operators

```bash
&&

||

!
```

Example

```bash
[ -f test.txt ] && echo Exists
```

---

## Case Statement

```bash
case $1 in

start)
echo Start
;;

stop)
echo Stop
;;

*)
echo Invalid
;;

esac
```

---

# 3️⃣ Loops

## For Loop

```bash
for i in 1 2 3
do
echo $i
done
```

C Style

```bash
for((i=1;i<=5;i++))
do
echo $i
done
```

---

## While Loop

```bash
count=1

while [ $count -le 5 ]
do
echo $count
((count++))
done
```

---

## Until Loop

```bash
count=1

until [ $count -gt 5 ]
do
echo $count
((count++))
done
```

---

## Break & Continue

```bash
break

continue
```

---

## Loop Files

```bash
for file in *.log
do
echo $file
done
```

---

## Read File Line by Line

```bash
while read line
do
echo $line
done < file.txt
```

---

# 4️⃣ Functions

## Define Function

```bash
greet(){

echo "Hello"

}
```

---

## Call Function

```bash
greet
```

---

## Function Arguments

```bash
greet(){

echo $1

}

greet Chaitanya
```

---

## Return

```bash
return 0
```

Print value

```bash
echo "Done"
```

---

## Local Variable

```bash
function test(){

local NAME="DevOps"

}
```

---

# 5️⃣ Text Processing

## grep

```bash
grep error log.txt

grep -i error log.txt

grep -r error .

grep -c error log.txt

grep -n error log.txt

grep -v error log.txt

grep -E "error|warning" log.txt
```

---

## awk

```bash
awk '{print $1}' file

awk -F: '{print $1}' /etc/passwd

awk '/error/' log.txt

awk 'BEGIN{print "Start"} {print $1} END{print "Done"}'
```

---

## sed

```bash
sed 's/foo/bar/g' file

sed -i 's/foo/bar/g' file

sed '3d' file
```

---

## cut

```bash
cut -d: -f1 /etc/passwd
```

---

## sort

```bash
sort file

sort -n file

sort -r file

sort -u file
```

---

## uniq

```bash
uniq file

uniq -c file
```

---

## tr

```bash
tr a-z A-Z

tr -d '\r'
```

---

## wc

```bash
wc file

wc -l file

wc -w file

wc -c file
```

---

## head & tail

```bash
head -5 file

tail -10 file

tail -f app.log
```

---

# 6️⃣ Useful One-Liners

Delete files older than 30 days

```bash
find . -type f -mtime +30 -delete
```

Count lines in all log files

```bash
wc -l *.log
```

Replace text in multiple files

```bash
sed -i 's/http/https/g' *.conf
```

Check service

```bash
systemctl is-active nginx
```

Disk usage alert

```bash
df -h
```

Watch logs

```bash
tail -f app.log | grep ERROR
```

CSV Parsing

```bash
cut -d, -f2 employees.csv
```

JSON Parsing

```bash
jq '.name' user.json
```

---

# 7️⃣ Error Handling

Exit Status

```bash
echo $?

exit 0

exit 1
```

---

Exit on Error

```bash
set -e
```

---

Unset Variable Error

```bash
set -u
```

---

Pipe Error

```bash
set -o pipefail
```

---

Debug Mode

```bash
set -x
```

---

Trap

```bash
cleanup(){

echo Cleaning

}

trap cleanup EXIT
```

---

# 📌 Useful Tips

- Always quote variables (`"$VAR"`).
- Prefer `$(command)` over backticks.
- Use `set -euo pipefail` in production scripts.
- Keep functions small and reusable.
- Validate user input before processing.
- Add comments for complex logic.

---

## 📖 References

- Bash Manual
- GNU Coreutils
- Linux Man Pages

---

⭐ Created as part of the **#90DaysOfDevOps** challenge.
