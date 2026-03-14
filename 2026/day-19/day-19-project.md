
# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab
## Task 1: Log Rotation Script

This script ensures your disk doesn't fill up with stale logs. It targets logs older than a 5 Days.

[script: log_rotate.sh](task-19/log_rotate.sh)

```
-c   → create a new archive
-z   → compress using gzip
-f   → specify the filename of the archive
```

**OUTPUT**

<img width="719" height="90" alt="Screenshot 2026-02-22 at 12 48 25 AM" src="https://github.com/user-attachments/assets/4a38d183-b72d-4285-814c-48f1a1deb4bb" />


## Task 2. Server Backup Script (backup.sh)

Standardized backups are vital. This script uses tar for archiving and includes a cleanup mechanism for backups older than 14 Days.

[scripts: backup.sh](task-19/backup.sh)

**OUTPUT**

<img width="728" height="175" alt="Screenshot 2026-02-22 at 12 56 36 AM" src="https://github.com/user-attachments/assets/0433258e-0e47-4216-9769-e3d31ec576a8" />


## Task 3. Crontab Entries
```
# Log rotation daily at 2 AM
0 2 * * * /Users/fahadjaseem/documents/work/90DaysOfDevOps/2026/day-19/scripts/log_rotate.sh /var/log/myapp >> /var/log/rotate.log 2>&1

# Server backup every Sunday at 3 AM  
0 3 * * 0 /Users/fahadjaseem/documents/work/90DaysOfDevOps/2026/day-19/scripts/backup.sh /etc /backup >> /var/log/backup.log 2>&1

# Daily 1 AM
0 1 * * * /Users/fahadjaseem/documents/work/90DaysOfDevOps/2026/day-19/scripts/maintenance.sh
```

## Task 4. Maintenance Script

The maintenance.sh combines both functions with logging.

[script: maintenance.sh](task-19/maintanance.sh)

**OUTPUT**

![Output](image.png)

## Key Learnings

- Exit Codes Matter: Using exit 1 on errors prevents a script from continuing blindly and potentially deleting the wrong files.

- The find Command is King: The ability to filter by time (-mtime) and execute actions (-exec) makes it the most powerful tool for cleanup tasks.

- Error Handling is Crucial: Always check if directories exist before operating on them, verify backup integrity after creation, and provide meaningful error messages. This makes scripts production-ready and prevents data loss.
