# Day 19 – Shell Scripting Project

## Introduction

In this lab, I practiced real DevOps shell scripting projects.
I created scripts for log rotation, backup automation, and cron scheduling.

I also learned how Linux servers automatically manage logs and backups using scripts.

---

# Step 1 – Created Practice Folders

First, I created folders for logs, backups, and source files.

## Folders Created

- myapp_logs
- source_data
- backups

## Commands Used

mkdir myapp_logs

mkdir source_data

mkdir backups

---

# Step 2 – Created Sample Files

I created sample log files and test files for backup practice.

## Commands Used

touch myapp_logs/app.log

touch myapp_logs/error.log

touch myapp_logs/old.log

echo "This is test file" > source_data/file1.txt

---

# Task 1 – Log Rotation Script

File Created: `log_rotate.sh`

## What This Script Does

- checks if log directory exists
- compresses old log files
- deletes old compressed files
- shows messages for completed tasks

## Commands Used

- find
- gzip
- if condition
- echo
- exit

## What I Learned

- how old logs are managed
- how file cleanup works
- basic automation using shell scripts

---

# Task 2 – Backup Script

File Created: `backup.sh`

## What This Script Does

- creates backup archive
- adds current date in backup name
- stores backup in backup folder
- removes old backups

## Commands Used

- tar
- date
- rm
- echo

## What I Learned

- how backup automation works
- how archive files are created
- how Linux manages backup files

---

# Task 3 – Crontab

I learned how to schedule scripts automatically using cron jobs.

## Commands Used

crontab -l

crontab -e

## Cron Examples

Run log rotation every day at 2 AM

0 2 \* \* \* /home/ubuntu/day-19/log_rotate.sh

Run backup every Sunday at 3 AM

0 3 \* \* 0 /home/ubuntu/day-19/backup.sh

Run health check every 5 minutes

_/5 _ \* \* \* /home/ubuntu/day-19/health_check.sh

## What I Learned

- how cron scheduling works
- how Linux runs scripts automatically
- importance of automation in DevOps

---

# Task 4 – Maintenance Script

File Created: `maintenance.sh`

## What This Script Does

- runs backup script
- runs log rotation script
- saves logs with timestamps

## Commands Used

- echo
- date
- script calling

## What I Learned

- combining multiple scripts
- automating maintenance tasks
- basic monitoring concepts

---

# Key Learnings

1. Shell scripting helps automate repetitive tasks.

2. Backup and log rotation are important for server maintenance.

3. Cron jobs help run scripts automatically without manual work.

---

# Conclusion

This lab improved my understanding of Linux automation, backup management, log cleanup, and cron scheduling.

I also learned how DevOps engineers use shell scripts for daily server maintenance and automation tasks.
