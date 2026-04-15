# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

## Task
Apply everything from Days 16–18 in real-world mini projects.

You will:
- Write a **log rotation** script
- Write a **server backup** script
- Schedule them with **crontab**

---

## Expected Output
- A markdown file: `day-19-project.md`
- All scripts you write during the tasks

---

## Challenge Tasks

### Task 1: Log Rotation Script
Create `log_rotate.sh` that:
1. Takes a log directory as an argument (e.g., `/var/log/myapp`)
2. Compresses `.log` files older than 7 days using `gzip`
3. Deletes `.gz` files older than 30 days
4. Prints how many files were compressed and deleted
5. Exits with an error if the directory doesn't exist

---

### Task 2: Server Backup Script
Create `backup.sh` that:
1. Takes a source directory and backup destination as arguments
2. Creates a timestamped `.tar.gz` archive (e.g., `backup-2026-02-08.tar.gz`)
3. Verifies the archive was created successfully
4. Prints archive name and size
5. Deletes backups older than 14 days from the destination
6. Handles errors — exit if source doesn't exist

---

### Task 3: Crontab
1. Read: `crontab -l` — what's currently scheduled?
2. Understand cron syntax:
   ```
   * * * * *  command
   │ │ │ │ │
   │ │ │ │ └── Day of week (0-7)
   │ │ │ └──── Month (1-12)
   │ │ └────── Day of month (1-31)
   │ └──────── Hour (0-23)
   └────────── Minute (0-59)
   ```
3. Write cron entries (in your markdown, don't apply if unsure) for:
   - Run `log_rotate.sh` every day at 2 AM
   - Run `backup.sh` every Sunday at 3 AM
   - Run a health check script every 5 minutes

---

### Task 4: Combine — Scheduled Maintenance Script
Create `maintenance.sh` that:
1. Calls your log rotation function
2. Calls your backup function
3. Logs all output to `/var/log/maintenance.log` with timestamps
4. Write the cron entry to run it daily at 1 AM

---

## Hints
- Compress old files: `find /path -name "*.log" -mtime +7 -exec gzip {} \;`
- Timestamp: `date +%Y-%m-%d`
- Tar: `tar -czf backup.tar.gz /source/dir`
- Cron edit: `crontab -e`
- Log with timestamp: `echo "$(date): message" >> logfile`

---

## Documentation

Create `day-19-project.md` with:
- Each script's code
- Sample outputs
- Cron entries you wrote
- What you learned (3 key points)

---

## Submission
1. Add your scripts and `day-19-project.md` to `2026/day-19/`
2. Commit and push to your fork

---

## Reference Video

[![Watch the video](https://img.youtube.com/vi/PZYJ33bMXAw/0.jpg)](https://youtu.be/PZYJ33bMXAw?si=RzEzOSom7-FqnopA)

---

## Learn in Public

Share your shell scripting projects on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
