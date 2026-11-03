# Day 19 – Shell Scripting Project

## Objective

Learn to automate common Linux maintenance tasks using Bash scripting and Cron.

---

## Task 1 – Log Rotation Script

### Features

- Accepts log directory as an argument
- Compresses `.log` files older than 7 days
- Deletes `.gz` files older than 30 days
- Validates directory existence
- Prints compressed and deleted file count

---

## Task 2 – Backup Script

### Features

- Accepts source and destination directories
- Creates timestamped `.tar.gz` backup
- Verifies successful backup creation
- Displays archive name and size
- Deletes backups older than 14 days
- Validates source directory

---

## Task 3 – Cron Jobs

### Log Rotation

```cron
0 2 * * * bash /home/devops/90DaysOfDevOps/2026/day-19/rotate.sh /var/log/apache2
```

### Weekly Backup

```cron
0 3 * * 0 bash /home/devops/90DaysOfDevOps/2026/day-19/backup.sh /home/devops/90DaysOfDevOps/2026/day-19/data /home/devops/90DaysOfDevOps/2026/day-19/backup
```

### Health Check

```cron
*/5 * * * * bash /home/devops/90DaysOfDevOps/2026/day-19/healthcheck.sh
```

---

## Task 4 – Maintenance Script

The maintenance script:

- Executes the log rotation script
- Executes the backup script
- Logs execution details with timestamps
- Can be scheduled using Cron

Cron:

```cron
0 1 * * * bash /home/devops/90DaysOfDevOps/2026/day-19/maintenance.sh
```

---

## Sample Output

```
Maintenance Started - 2026-07-10 22:11:09

Compressed files: 0
Deleted files: 0

Backup created successfully

Archive Name:
backup-2026-07-10_22-11-09.tar.gz

Archive Size:
4.0K

Maintenance Completed
```

---

# What I Learned

- How to automate log rotation using Bash.
- How to create compressed backups using tar and gzip.
- How to automate maintenance tasks using Cron jobs.
