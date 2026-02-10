# Day 10 Challenge

## Files Created
devops.txt
notes.txt
script.sh
Folder - project 

## Permission Changes

Before permission change -
devops.txt = 664 (-rw-rw-r-- )
notes.txt =  664 (-rw-rw-r-- )
script.sh = 664 (-rw-rw-r-- ) 
project = 775 (drwxrwxr-x)

After permission change task -
devops.txt = 444 (-r—r—r—)
notes.txt =  640 (-rw-r----- )
script.sh = 764 (-rwxrw-r-- )
project = 755 (drwxr-xr-x )


## Commands Used
Task 1 :
touch devops.txt
echo 'hello there' > notes.txt
 echo 'Hello DevOps' >> script.sh
 ll notes.txt script.sh 
 
Task 2 :
vi script.sh
 cat /etc/passwd | head -n 5
 cat /etc/passwd | tail -n 5


Task 3 :
ll devops.txt notes.txt script.sh 
Output :
-r--r--r-- 1 ubuntu ubuntu 12 Feb  6 12:35 devops.txt
-rw-r----- 1 ubuntu ubuntu 57 Feb  6 11:15 notes.txt
-rwxrw-r-- 1 ubuntu ubuntu 13 Feb  6 12:36 script.sh*

devops.txt - Owner/Group/Others can only read file.
notes.txt - Owner can read & write to the file. Group members can only read file & other users cannot do any action.
Script.sh - Owner can read,write & execute the file. Group members can read & write to the file but other users can only read the file.



Task 4 :
chmod 764 script.sh
./script.sh 
chmod 444 devops.txt
chmod 640 notes.txt
 mkdir -p project
chmod 755 project/


## What I Learned
Key points :
1. To create file & folders with correct permission to make .sh files executable. 
2. Permissions change for security purpose.
3. How to make particular file/folder with specific permission.
4. Read/write/execute permission table.
