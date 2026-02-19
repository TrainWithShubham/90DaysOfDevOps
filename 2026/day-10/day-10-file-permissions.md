# Day 10 – File Permissions & File Operations Challenge
---------
## Files Created
* File created `devops.txt`
* File created `notes.txt`
* File created `script.sh`

---------
## Permission Changes
* **Before** -rw-rw-r-- read and write permissions have owner and group, others have only read permission.
* **After devops.txt** -r--r--r--  read permission have owner, group and others.
* **After notes.txt** -rw-r-----  read and write permissions have owner, group have read write, others haven't any permission.
* **After script.sh** -rwxrw-r--  read, write, execute permissions have owner, group have read, write permissions and others have only read permission.

| file | permissions (Before) | permissions (after) |
| ---- | -------------------- | ------------------- |
| `devops.txt`  |`-rw-rw-r-- 1 ubuntu ubuntu 0 Feb  3 09:58` | `-r--r--r-- 1 ubuntu ubuntu    0 Feb  3 09:58` |
| `notes.txt` | `-rw-rw-r-- 1 ubuntu ubuntu 0 Feb  3 09:58` | `-rw-r----- 1 ubuntu ubuntu   87 Feb  3 10:14` |
| `script.sh` | `-rw-rw-r-- 1 ubuntu ubuntu 0 Feb  3 09:59` | `-rwxrw-r-- 1 ubuntu ubuntu  260 Feb  3 10:09` |
------

## Commands Used
| commands | Used for |
| -------- | -------- |
| `touch` | This command is use to create a new file. |
| `ls -l` | This command is use to show detailed information of files. |
|  `echo "Line 1" > notes.txt` | This command is use to write a Line 1 in file. |
| `echo "Line 2" >> notes.txt` | This command is use to append and write a Line 2 in file. |
| `echo "Line 3" /| tee -a notes.txt` | This command is use to append and print a Line 3 in file. |
| `cat notes.txt` | Cat command is use to print the file. |
| `vim script.sh` | vim is a editor in linux to write a file. for inserting press i, for save esc, :wq and hit enter. |
| `head -n 5 /etc/passwd` | This command show first 5 system's user account database. |
| `tail -n 5 /etc/passwd` | Thi command displays the last five lines of the user account file |
| `view script.sh` | This command is use for view file |
|  `vim -R script.sh` | This command is use for readonly mode in vim |
| `chmod u+x script.sh` | It add execute permission for the user (owner) of the file. |
| `./script.sh` | This command is use to execute the file |
| `mkdir -p project` | This command is use to create a directory for prevention of error if directory is existing. |
----------
When i try to write something or redirecting something to the file i got an error message.
-----
* ubuntu@ip-172-31-45-52:~$ `cat devops.txt`
* ubuntu@ip-172-31-45-52:~$ `echo "Hello devops" > devops.txt`
* `-bash: devops.txt: Permission denied`
---------
When i try to execute the file without execution permission i got an error message.
----
* ubuntu@ip-172-31-45-52:~$ `./notes.txt`
* `-bash: ./notes.txt: Permission denied`
---------
## What I Learned
* Files are not executable when it's haven't a permission for execution.
* Files aren't writable when it's haven't permission for writing.
* When you try to execute, read, write any file first check the file permissions. 

-----------







