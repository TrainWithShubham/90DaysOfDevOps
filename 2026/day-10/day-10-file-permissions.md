# Day 10 – File Permissions & File Operations Challenge

---

## Files Created
- devops.txt

- notes.txt

- script.sh
## Permission Changes
devops.txt

**Before**

-rw-r--r--

After

-r--r--r--

notes.txt

**Before**

-rw-r--r--

**After**

-rw-r-----

script.sh

**Before**

-rw-r--r--

Execute permission:  none

**After**

-rwxr-xr-x

project/ (directory)

**After** 

drwxr-xr-x

## Commands Used
touch devops.txt
echo "Linux file permissions practice" > notes.txt
vim script.sh

ls -l

cat notes.txt
vim -R script.sh
head -n 5 /etc/passwd
tail -n 5 /etc/passwd

ls -l devops.txt notes.txt script.sh

chmod +x script.sh
./script.sh

chmod -w devops.txt
chmod 640 notes.txt

mkdir project
chmod 755 project

echo "test" >> devops.txt
chmod -x script.sh
./script.sh

ls -l
ls -ld project

## What I Learned
Day 10 me maine file creation, reading aur permission management seekha aur chmod ka use karke access control samjha.
