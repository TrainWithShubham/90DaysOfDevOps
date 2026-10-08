# Day 12 – Revision Notes (Days 01–11)

## Goal

Today I revised all the topics from Days 01–11 and practiced Linux commands again to improve my confidence and understanding.

This revision helped me remember important Linux basics, file management, permissions, users, groups, troubleshooting, and service management.

---

# Day 01 – Learning Plan

On Day 01, I created my DevOps learning plan.

What I learned:

- Importance of consistency and daily practice
- My goal is to become a DevOps Engineer
- I want strong skills in Linux, Docker, Kubernetes, AWS, and troubleshooting
- Hands-on practice is very important in DevOps

---

# Day 02 – Linux Basics

I learned basic Linux architecture and terminal usage.

Topics practiced:

- Linux directories
- Navigation commands
- Understanding how Linux systems work
- Using terminal commands daily

Commands practiced:

- pwd
- ls
- cd
- clear

What I learned:

- Linux is command-line based
- Navigation commands are important for daily work

---

# Day 03 – Linux Commands Cheat Sheet

I practiced important Linux commands.

Commands practiced:

- ls -l
- mkdir
- touch
- cp
- mv
- rm
- cat
- history
- whoami

What I learned:

- File management commands are used every day
- ls -l is very useful for checking permissions and ownership

---

# Day 04 – Shell Scripting Basics

I learned simple shell scripting concepts.

Topics practiced:

- Variables
- Echo statements
- Simple scripts
- Running script files

Commands practiced:

- echo
- nano
- chmod +x

What I learned:

- Scripts help automate repetitive tasks
- Linux automation starts with scripting basics

---

# Day 05 – Linux Troubleshooting

I practiced troubleshooting and process management.

Commands practiced:

- ps aux
- top
- systemctl status
- journalctl
- grep

What I learned:

- How to check running processes
- How to verify service status
- How to read logs for troubleshooting

---

# Day 06 – File Management

I practiced working with files and folders.

Commands practiced:

- touch
- mkdir
- cp
- mv
- rm

What I learned:

- How to create, copy, move, and remove files
- Folder organization is important

---

# Day 07 – File Permissions

I practiced Linux file permissions.

Commands practiced:

- chmod
- ls -l

What I learned:

- Read, write, and execute permissions
- Permission numbers like 400, 600, and 755
- File security is important in Linux

Example:

chmod 600 notes.txt

---

# Day 08 – Users and Groups

I practiced creating users and groups.

Commands practiced:

- adduser
- addgroup
- usermod
- id

What I learned:

- Linux uses users and groups for access control
- Users can belong to multiple groups

Example:

sudo addgroup test

sudo adduser noumu

sudo usermod -aG test noumu

---

# Day 09 – Ownership Management

I practiced ownership commands.

Commands practiced:

- chown
- ls -l

What I learned:

- chown changes owner and group
- Ownership controls file access

Example:

sudo chown noumu:test test-note.txt

---

# Day 10 – Process and Service Management

I practiced service monitoring and logs.

Commands practiced:

- systemctl status nginx
- journalctl -u nginx
- ps aux

What I learned:

- How to check if services are healthy
- How to troubleshoot using logs

---

# Day 11 – File Ownership Challenge

I revised ownership and permissions again.

Topics practiced:

- Ownership verification
- User and group management
- Permission checking

Commands practiced:

- ls -l
- chown
- chmod
- id

What I learned:

- Ownership and permissions work together
- Linux troubleshooting improves with practice

---

# Day 12 – Revision Practice

Today I revised all previous topics and practiced again.

Commands practiced:

- ls -l
- chmod
- chown
- adduser
- addgroup
- usermod
- systemctl
- journalctl
- cp
- mkdir
- touch

---

# User and Group Practice Example

Today I created a user and group using the example below.

Commands used:

sudo addgroup test

sudo adduser noumu

sudo usermod -aG test noumu

id noumu

touch test-note.txt

sudo chown noumu:test test-note.txt

ls -l

What I learned:

- How to create users and groups
- How to verify groups using id
- How to change file ownership
- How to check permissions using ls -l

---

# Important Commands I Remember

1. ls -l

- Checks permissions, owner, and group

2. chmod

- Changes file permissions

3. chown

- Changes ownership

4. systemctl status

- Checks service health

5. journalctl

- Reads logs for troubleshooting

6. ps aux

- Shows running processes

7. cp

- Copies files

8. mkdir

- Creates folders

---

# Mini Self-Check

## Which commands save me the most time?

- ls -l
- systemctl status
- journalctl -u

These commands help quickly troubleshoot Linux systems.

---

## How do I check if a service is healthy?

Commands used:

systemctl status nginx

ps aux | grep nginx

journalctl -u nginx

---

## How do I safely change ownership and permissions?

Example:

sudo chown noumu:test test-note.txt

chmod 600 test-note.txt

---

## What will I improve in the next 3 days?

- Linux troubleshooting
- Docker practice
- Kubernetes basics
- Better command confidence
- More hands-on practice

---

# Key Takeaways

- Repeating commands improves memory
- Linux permissions and ownership are very important
- Troubleshooting mistakes helped me learn better
- Daily practice is increasing my confidence
- Hands-on learning is the best way to improve in DevOps

#90DaysOfDevOps
#DevOpsKaJosh
#TrainWithShubham
