
# Day 19 - Shell Scripting Project: Log Rotation, Backup & Crontab

## Task 1: Log Rotation Script (`log_rotate.sh`)
This script checks if a directory exists, compresses log files older than 7 days, and deletes compressed archives older than 30 days to save server space.

```bash
#!/bin/bash
LOG_DIR=$1

if [[ ! -d "$LOG_DIR" ]]; then
    echo "Error: Directory '$LOG_DIR' does not exist!"
    exit 1
fi

COMPRESS_COUNT=$(find "$LOG_DIR" -name "*.log" -mtime +7 | wc -l)
find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \;
echo "Compressed $COMPRESS_COUNT log files."

DELETE_COUNT=$(find "$LOG_DIR" -name "*.gz" -mtime +30 | wc -l)
find "$LOG_DIR" -name "*.gz" -mtime +30 -exec rm {} \;
echo "Deleted $DELETE_COUNT old compressed files."

```

## Task 2: Server Backup Script (`backup.sh`)

This script takes a source and destination, zips the directory with a dynamic date stamp, verifies the exit status (`$?`), and rotates out backups older than 14 days.

```bash
#!/bin/bash
SOURCE_DIR=$1
DEST_DIR=$2

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist!"
    exit 1
fi

mkdir -p "$DEST_DIR"
TIMESTAMP=$(date +%Y-%m-%d)
BACKUP_FILE="$DEST_DIR/backup-$TIMESTAMP.tar.gz"

tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

if [[ $? -eq 0 ]]; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi

find "$DEST_DIR" -name "*.tar.gz" -mtime +14 -exec rm {} \;

```

## Task 3: Crontab Schedules

Cron utilizes a 5-point syntax: `Minute Hour Day Month Weekday`

* Run log rotation daily at 2 AM: `0 2 * * * /path/to/log_rotate.sh`
* Run backup every Sunday at 3 AM: `0 3 * * 0 /path/to/backup.sh`
* Run health check every 5 minutes: `*/5 * * * * /path/to/healthcheck.sh`

## Task 4: Combined Maintenance Script (`maintenance.sh`)

```bash
#!/bin/bash
set -euo pipefail
LOG_FILE="/tmp/maintenance.log"

echo "Starting System Maintenance: $(date)" >> "$LOG_FILE"
bash /path/to/log_rotate.sh /tmp/dummy_logs >> "$LOG_FILE" 2>&1
bash /path/to/backup.sh /tmp/dummy_logs /tmp/my_backups >> "$LOG_FILE" 2>&1
echo "Maintenance Complete: $(date)" >> "$LOG_FILE"

```

**Cron Schedule (Daily at 1 AM):** `0 1 * * * bash /path/to/maintenance.sh`

## 3 Key Learnings

1. **The Power of `find`:** Combining `find` with `-mtime` (modified time) and `-exec` allows for powerful, one-line file management and cleanup commands.
2. **Exit Status Validation:** Checking `$?` immediately after a critical command (like `tar`) is essential for confirming a step succeeded before proceeding.
3. **Cron Automation:** Using `crontab -e` transforms manual scripts into hands-free automation. Redirecting output using `>> logfile 2>&1` ensures cron job errors aren't silently lost.
