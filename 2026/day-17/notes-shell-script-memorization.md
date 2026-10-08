# Shell Scripting Commands – Simple Revision Notes

## What is Shell Scripting?

Shell scripting means writing Linux commands inside a file so we can run them again and again automatically.

Example:

```bash
./hello.sh
```

This runs the commands written inside `hello.sh`.

---

# 1. How We Create a Shell Script

## Create a script file

```bash
vim hello.sh
```

Purpose:

```text
Creates or opens a shell script file.
```

Memory trick:

```text
vim = write/edit file
```

---

## Add shebang

```bash
#!/bin/bash
```

Purpose:

```text
Tells Linux to run this file using Bash shell.
```

Memory trick:

```text
#! = use this interpreter
/bin/bash = Bash location
```

---

## Make file executable

```bash
chmod +x hello.sh
```

Purpose:

```text
Gives permission to run the script.
```

Memory trick:

```text
chmod = change mode/permission
+x = add execute permission
```

---

## Run script

```bash
./hello.sh
```

Purpose:

```text
Runs the script from current directory.
```

Memory trick:

```text
./ = run from here
```

---

# 2. echo Command

```bash
echo "Hello, DevOps!"
```

Purpose:

```text
Prints text on the screen.
```

Memory trick:

```text
echo = say something
```

Example:

```bash
echo "Script completed successfully"
```

---

# 3. Variables

```bash
NAME="Asma"
ROLE="DevOps Engineer"
```

Purpose:

```text
Stores values inside names.
```

Memory trick:

```text
Variable = small box storing value
```

Example:

```bash
echo "Hello, I am $NAME and I am a $ROLE"
```

Meaning:

```text
$NAME prints the value stored in NAME.
$ROLE prints the value stored in ROLE.
```

Important rule:

```text
No spaces around =
```

Correct:

```bash
NAME="Asma"
```

Wrong:

```bash
NAME = "Asma"
```

---

# 4. Single Quotes vs Double Quotes

## Double quotes

```bash
echo "Hello $NAME"
```

Purpose:

```text
Shows variable value.
```

Output:

```text
Hello Asma
```

---

## Single quotes

```bash
echo 'Hello $NAME'
```

Purpose:

```text
Prints exactly what is written.
```

Output:

```text
Hello $NAME
```

Memory trick:

```text
Double quotes = variable works
Single quotes = variable sleeps
```

---

# 5. read Command

```bash
read -p "Enter your name: " NAME
```

Purpose:

```text
Takes input from user and stores it in variable.
```

Memory trick:

```text
read = ask user
-p = prompt/message
```

Example:

```bash
read -p "Enter your favourite tool: " TOOL
echo "Your favourite tool is $TOOL"
```

---

# 6. If-Else Condition

```bash
if [ $NUM -gt 0 ]
then
    echo "Positive number"
else
    echo "Zero or negative"
fi
```

Purpose:

```text
Makes decision inside script.
```

Memory trick:

```text
if = check
then = do this
else = otherwise
fi = finish if
```

Important:

```text
Spaces are required inside [ ]
```

Correct:

```bash
if [ $NUM -gt 0 ]
```

Wrong:

```bash
if [$NUM -gt 0]
```

---

# 7. Number Conditions

```bash
-gt
```

Purpose:

```text
Greater than
```

Example:

```bash
if [ $NUM -gt 0 ]
```

---

```bash
-lt
```

Purpose:

```text
Less than
```

Example:

```bash
if [ $NUM -lt 0 ]
```

---

```bash
-eq
```

Purpose:

```text
Equal to
```

Example:

```bash
if [ $# -eq 0 ]
```

Memory trick:

```text
gt = greater than
lt = less than
eq = equal
```

---

# 8. File Check

```bash
if [ -f "$FILE" ]
then
    echo "File exists"
else
    echo "File does not exist"
fi
```

Purpose:

```text
Checks if a file exists.
```

Memory trick:

```text
-f = file
```

Example:

```bash
read -p "Enter filename: " FILE
if [ -f "$FILE" ]
then
    echo "File exists"
else
    echo "File does not exist"
fi
```

---

# 9. Service Check

```bash
systemctl is-active ssh
```

Purpose:

```text
Checks if SSH service is active.
```

Memory trick:

```text
systemctl = control system services
is-active = is service running?
```

Example:

```bash
SERVICE="ssh"
systemctl is-active $SERVICE
```

---

# 10. For Loop

```bash
for fruit in apple banana mango orange grapes
do
    echo "Fruit: $fruit"
done
```

Purpose:

```text
Repeats work for each item in a list.
```

Memory trick:

```text
for = one by one
do = start work
done = finish loop
```

Flow:

```text
apple → print
banana → print
mango → print
orange → print
grapes → print
```

---

# 11. For Loop with Numbers

```bash
for num in {1..10}
do
    echo "Number: $num"
done
```

Purpose:

```text
Prints numbers from 1 to 10.
```

Memory trick:

```text
{1..10} = range from 1 to 10
```

---

# 12. While Loop

```bash
while [ $NUM -ge 0 ]
do
    echo "Countdown: $NUM"
    NUM=$((NUM-1))
done
```

Purpose:

```text
Keeps running while condition is true.
```

Memory trick:

```text
while = as long as
-ge = greater than or equal
```

Example:

```text
If NUM is 5, keep running until it becomes less than 0.
```

---

# 13. Arithmetic

```bash
NUM=$((NUM-1))
```

Purpose:

```text
Subtracts 1 from NUM.
```

Memory trick:

```text
$(( )) = math box
```

Example:

```bash
COUNT=$((COUNT+1))
```

---

# 14. Command-Line Arguments

## First argument

```bash
$1
```

Purpose:

```text
First value passed when running script.
```

Example:

```bash
./greetAgain.sh Asma
```

Here:

```text
$1 = Asma
```

---

## Script name

```bash
$0
```

Purpose:

```text
Shows script name.
```

Example:

```bash
echo "Script name: $0"
```

---

## Total arguments

```bash
$#
```

Purpose:

```text
Counts how many arguments were passed.
```

Example:

```bash
./args_demo.sh apple mango banana
```

Here:

```text
$# = 3
```

---

## All arguments

```bash
$@
```

Purpose:

```text
Shows all arguments.
```

Example:

```bash
echo "All arguments: $@"
```

Output:

```text
apple mango banana
```

Memory trick:

```text
$1 = first item
$0 = script name
$# = number of items
$@ = all items
```

---

# 15. Package Check

```bash
dpkg -s nginx
```

Purpose:

```text
Checks if nginx package is installed.
```

Memory trick:

```text
dpkg = Debian package manager
-s = status
```

Example:

```bash
if dpkg -s nginx > /dev/null 2>&1
then
    echo "nginx is already installed"
else
    echo "Installing nginx"
fi
```

---

# 16. Hide Output

```bash
> /dev/null 2>&1
```

Purpose:

```text
Hides normal output and error output.
```

Simple meaning:

```text
Do the check silently.
```

Memory trick:

```text
/dev/null = dustbin
```

---

# 17. Install Package

```bash
sudo apt install -y nginx
```

Purpose:

```text
Installs nginx package.
```

Memory trick:

```text
sudo = admin power
apt install = install software
-y = yes automatically
```

---

# 18. Error Handling with set -e

```bash
set -e
```

Purpose:

```text
Stops script when any command fails.
```

Memory trick:

```text
-e = exit on error
```

---

# 19. Error Handling with ||

```bash
mkdir /tmp/devops-test || echo "Directory already exists"
```

Purpose:

```text
If first command fails, run second command.
```

Memory trick:

```text
|| = or else
```

Meaning:

```text
Create directory OR ELSE print error message.
```

---

# 20. mkdir Command

```bash
mkdir /tmp/devops-test
```

Purpose:

```text
Creates a directory.
```

Memory trick:

```text
mkdir = make directory
```

---

# 21. cd Command

```bash
cd /tmp/devops-test
```

Purpose:

```text
Moves into a directory.
```

Memory trick:

```text
cd = change directory
```

---

# 22. touch Command

```bash
touch testfile.txt
```

Purpose:

```text
Creates an empty file.
```

Memory trick:

```text
touch = touch/create file
```

---

# 23. ls Command

```bash
ls
```

Purpose:

```text
Lists files and folders.
```

---

# 24. ls -l Command

```bash
ls -l
```

Purpose:

```text
Lists files with permissions, owner, group, size, and date.
```

Memory trick:

```text
-l = long list
```

---

# 25. chmod Number Example

```bash
chmod 776 hello.sh
```

Purpose:

```text
Gives permission using numbers.
```

Simple meaning:

```text
Owner = read/write/execute
Group = read/write/execute
Others = read/write
```

Better simple command:

```bash
chmod +x hello.sh
```

Purpose:

```text
Adds execute permission.
```

---

# Script Creation Flow

```text
1. Create file
2. Add shebang
3. Write commands
4. Save file
5. Give execute permission
6. Run script
7. Check output
```

Commands:

```bash
vim script.sh
chmod +x script.sh
./script.sh
```

---

# Simple Memory Tricks Summary

```text
echo       = say/print
read       = ask user
NAME=value = store value
$NAME      = use stored value
if         = check condition
then       = do this
else       = otherwise
fi         = finish if
for        = repeat for each item
while      = repeat while true
do         = start loop work
done       = finish loop
$1         = first argument
$0         = script name
$#         = argument count
$@         = all arguments
-f         = file exists check
-gt        = greater than
-lt        = less than
-eq        = equal
-ge        = greater or equal
chmod +x   = make executable
./file.sh  = run script
set -e     = stop on error
||         = or else
```

---

# Full Simple Example Flow

When I run:

```bash
./greetAgain.sh Asma
```

Script sees:

```text
$0 = ./greetAgain.sh
$1 = Asma
$# = 1
```

Then it prints:

```text
Hello, Asma!
```

---

# What I Learned

1. Shell scripting helps automate Linux and DevOps tasks.
2. Variables, loops, and conditions make scripts smarter.
3. Arguments and error handling make scripts reusable and safer.
