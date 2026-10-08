# DEVOPS SHELL SCRIPTING DAILY REVISION

## Script Start

```bash id="t0xk7g"
#!/bin/bash
```

Use bash shell to run script.

---

## Run Script

```bash id="jlwm31"
chmod +x script.sh
./script.sh
bash script.sh
```

- chmod +x → execute permission
- ./script.sh → run script

---

## Variables

```bash id="jlwm32"
NAME="Asma"
echo $NAME
```

No spaces around `=`.

Wrong:

```bash id="jlwm33"
NAME = "Asma"
```

---

## User Input

```bash id="jlwm34"
read NAME
echo $NAME
```

Take user input.

---

## Script Arguments

```bash id="jlwm35"
./script.sh file.txt
```

| Variable | Meaning             |
| -------- | ------------------- |
| $0       | script name         |
| $1       | first argument      |
| $2       | second argument     |
| $#       | total arguments     |
| $?       | last command status |

---

## If Condition

```bash id="jlwm36"
if [ condition ]
then
 echo "yes"
fi
```

---

## Integer Operators

| Operator | Meaning       |
| -------- | ------------- |
| -eq      | equal         |
| -ne      | not equal     |
| -gt      | greater       |
| -lt      | less          |
| -ge      | greater equal |
| -le      | less equal    |

Example:

```bash id="jlwm37"
[ 5 -gt 2 ]
```

---

## File Checks

| Check | Meaning       |
| ----- | ------------- |
| -f    | file exists   |
| -d    | folder exists |
| -r    | readable      |
| -w    | writable      |
| -x    | executable    |

---

## For Loop

```bash id="jlwm38"
for i in 1 2 3
do
 echo $i
done
```

---

## While Loop

```bash id="jlwm39"
while read line
do
 echo $line
done
```

---

## Function

```bash id="jlwm40"
greet() {
 echo "hello"
}
```

Call:

```bash id="jlwm41"
greet
```

---

## Local Variable

```bash id="jlwm42"
local NAME="Asma"
```

Works only inside function.

---

## Grep = Search

```bash id="jlwm43"
grep "error" app.log
```

Useful:

```bash id="jlwm44"
grep -i "error" app.log
grep -c "error" app.log
grep -n "error" app.log
```

- -i → ignore case
- -c → count
- -n → line number

Memory:
grep = search logs

---

## Awk = Columns

```bash id="jlwm45"
awk '{print $1}' file.txt
```

Separator:

```bash id="jlwm46"
awk -F: '{print $1}' /etc/passwd
```

Memory:
awk = columns

---

## Sed = Replace

```bash id="jlwm47"
sed 's/old/new/g' file.txt
```

Inside file:

```bash id="jlwm48"
sed -i 's/dev/prod/g' config.txt
```

Memory:
sed = replace text

---

## Sort + Uniq

```bash id="jlwm49"
sort file.txt
uniq -c file.txt
```

Most used:

```bash id="jlwm50"
sort file.txt | uniq -c
```

Used for repeated logs/errors.

---

## WC = Count

```bash id="jlwm51"
wc -l file.txt
```

- -l → lines
- -w → words
- -c → characters

---

## Head / Tail

```bash id="jlwm52"
head -5 file.txt
tail -5 file.txt
tail -f app.log
```

Memory:
tail -f = live logs

---

## Find Command

```bash id="jlwm53"
find . -name "*.log"
```

Delete old logs:

```bash id="jlwm54"
find . -mtime +30 -delete
```

---

## Tar = Backup

```bash id="jlwm55"
tar -czf backup.tar.gz folder/
```

Memory:
tar = pack files

---

## Cron Jobs

```bash id="jlwm56"
crontab -e
crontab -l
```

Example:

```bash id="jlwm57"
0 2 * * * script.sh
```

Run daily at 2 AM.

Memory:
Minute Hour Day Month Week

---

## Strict Mode

```bash id="jlwm58"
set -e
set -u
set -o pipefail
```

- set -e → stop on error
- set -u → stop undefined variable
- pipefail → fail pipeline

---

## Debug Mode

```bash id="jlwm59"
set -x
```

Shows script execution step by step.

---

## Useful DevOps Commands

Disk usage:

```bash id="jlwm60"
df -h
```

Memory usage:

```bash id="jlwm61"
free -h
```

Processes:

```bash id="jlwm62"
ps aux
```

CPU heavy processes:

```bash id="jlwm63"
ps aux --sort=-%cpu | head
```

Live logs:

```bash id="jlwm64"
tail -f app.log
```

---

## Real DevOps One Liners

Live error monitoring:

```bash id="jlwm65"
tail -f app.log | grep error
```

Count errors:

```bash id="jlwm66"
grep -c "error" app.log
```

Top repeated errors:

```bash id="jlwm67"
grep "error" app.log | sort | uniq -c | sort -rn
```

Service status:

```bash id="jlwm68"
systemctl status nginx
```

Restart service:

```bash id="jlwm69"
systemctl restart nginx
```

---

## Quick Memory Tricks

| Command | Easy Meaning      |
| ------- | ----------------- |
| grep    | search            |
| awk     | columns           |
| sed     | replace           |
| wc      | count             |
| tar     | archive           |
| cron    | scheduler         |
| chmod   | permission        |
| uniq    | duplicates        |
| ps aux  | running processes |
