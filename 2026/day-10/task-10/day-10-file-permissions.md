# Day 10 – File Permissions & File Operations Challenge
## Challenge Tasks
# Task 1: Create Files
- Create empty file - `touch devops.txt`
- Create notes.txt with some content using cat or echo - `echo "This is my devops notes file" > notes.txt`
- Create script.sh using vim with content: echo "Hello DevOps" - `vim script.sh`
- Chek permissions - `ls -l`
# Task 2: Read Files
- Read notes.txt using cat - `cat notes.txt`
- View script.sh in vim read-only mode - `vim script.sh` and exit by press esc & :q + enter
- Display first 5 lines of /etc/passwd using head - `head -n 5 /etc/passwd`
- Display last 5 lines of /etc/passwd using tail - `tail -n 5 /etc/passwd`
# Task 3: Understand & Modify Permissions
# 1 : Make script.sh executable → run it with ./script.sh 
- step 1: first check the permission by `ls -l script.sh` > -rw-rw-r-- 1 ubuntu ubuntu 20 Feb 13 11:27 script.sh
- Step 2: It doesn't have exceute permission to run as an script hence set permission to execute - `chmod 775 script.sh`
- now check the permission - `ls -l script.sh` > -rwxrwxr-x 1 ubuntu ubuntu 20 Feb 13 11:27 script.sh
- Now run it as an script - `./script.sh` > Hello Devops , will show the file content as it gets the execute permission.
# 2 : Set devops.txt to read-only (remove write for all)
- Set devops.txt to read-only (remove write for all) - `chmod 444 devops.txt` > -r--r--r-- 1 ubuntu ubuntu 0 Feb 13 11:24 devops.txt OR we can give execute and read only permission > `chmod 555 devops.txt` > -r-xr-xr-x 1 ubuntu ubuntu 0 Feb 13 11:24 devops.txt
- Set notes.txt to 640 (owner: rw, group: r, others: none) > `chmod 640 notes.txt` > -rw-r----- 1 ubuntu ubuntu 29 Feb 13 11:25 notes.txt
- Create directory project/ with permissions 755 
Steps:
- `mkdir project`
- `ls  -ld project` - to check the permission of the directory - drwxrwxr-x 2 ubuntu ubuntu 4096 Feb 13 11:47 project
- `chmod 755 project` - permission set to directory - drwxr-xr-x 2 ubuntu ubuntu 4096 Feb 13 11:47 project
# Task 4: Test Permissions
- Try writing to a read-only file - what happens? - You cannot write to a read-only file because it does not have write (w) permission, so the system blocks any modification attempts.
- Try executing a file without execute permission - You cannot execute a file without execute (x) permission because the system does not allow it to run as a program.
- Document the error messages -
# Issue:
- I initially got confused between the passwd command and the /etc/passwd file.

# Clarification:
- passwd is a command used to set or change user passwords.
- /etc/passwd is a system file that stores user account information (username, UID, home directory, shell), not actual passwords.

# Key Learning:
- Similar names in Linux can represent different things — one is a command, the other is a configuration file.





