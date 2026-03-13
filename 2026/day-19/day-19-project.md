## Challenge Tasks

### Task 1: Log Rotation Script
if [ $# -ne 1 ];then
        display_usage
fi
if [ ! -d "${source_dir}" ];then
        echo "directory does not exists"
        exit 1
fi
COUNT=$(find "$1" -type f -name "*.log" -mtime +7 | wc -l )
if [ "$COUNT" -gt 0 ]; then
        find "$1" -type f -name "*.log" -mtime +7 -exec gzip {} \;
fi

COUNT2=$(find "$1" -type f -name "*.gz" -mtime +30 | wc -l )
if [ "$COUNT2" -gt 0 ];then
        find "$1" -type f -name "*.gz" -mtime +30 -exec rm {} \;
fi

echo "Log Rotation Summary:"
echo "Compressed files: $COUNT"
echo "Deleted files: $COUNT2"

`output`

ubuntu@ip-172-31-27-220:~$ cat /var/log/myapp
cat: /var/log/myapp: Is a directory
ubuntu@ip-172-31-27-220:~$ ls -l /var/log/myapp
total 0
-rw-r--r-- 1 root root 0 Feb 15 11:12 test.log
ubuntu@ip-172-31-27-220:~$ sudo ./log_rotate.sh /var/log/myapp
Log Rotation Summary:
Compressed files: 1
Deleted files: 0
ubuntu@ip-172-31-27-220:~$ ls -l /var/log/myapp
total 4
-rw-r--r-- 1 root root 29 Feb 15 11:12 test.log.gz
ubuntu@ip-172-31-27-220:~$
### Task 2: Server Backup Script
#!/bin/bash
set -e

# Arguments
source_dir="$1"
backup_dir="$2"
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory '$source_dir' does not exist."
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Archive name and path
archive_name="backup
archive_path="${backup_dir}/${archive_name}"

# Create the backup
tar -czf "$archive_path" -C "$source_dir"

# Verify archive creation
if [ -f "$archive_path" ]; then
    archive_size=$(du -h "$archive_path" | cut -f1)
    echo "Backup created successfully: $archive_name"
    echo "Size: $archive_size"
else
    echo "Error: Backup failed!"
    exit 1
fi

# Delete backups older than 14 days
find "$backup_dir" -name "backup-*.tar.gz" -type f -mtime +14 -exec rm -f {} \;

echo "Old backups deleted (older than 14 days)."

~
`output`
ubuntu@ip-172-31-27-220:~$ ./backup.sh /home/ubuntu/data /home/ubuntu/backups
Backup created successfully: backup-2026-02-26-12-05-47.tar.gz
Size: 4.0K
Old backups deleted (older than 14 days).
ubuntu@ip-172-31-27-220:~$ ls -lh /home/ubuntu/backups
total 12K
-rw-rw-r-- 1 ubuntu ubuntu 111 Feb 25 12:30 backup-2026-02-25-12-30-35.tar.gz
-rw-rw-r-- 1 ubuntu ubuntu 215 Feb 25 12:31 backup-2026-02-25-12-31-13.tar.gz
-rw-rw-r-- 1 ubuntu ubuntu 215 Feb 26 12:05 backup-2026-02-26-12-05-47.tar.gz
ubuntu@ip-172-31-27-220:~$

### Task 4: Combine — Scheduled Maintenance Script
#!/bin/bash

LOG_FILE="/var/log/maintenance.log"
LOG_DIR="/home/ubuntu/logs"
SOURCE_DIR="/home/ubuntu/data"
BACKUP_DIR="/home/ubuntu/backups"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "===== Maintenance Started ====="

# Run Log Rotation (pass log directory)
if /usr/bin/bash /home/ubuntu/log_rotate.sh "$LOG_DIR" >> "$LOG_FILE" 2>&1; then
    log "Log rotation completed successfully."
else
    log "Log rotation failed!"
fi

# Run Backup
if /usr/bin/bash /home/ubuntu/backup.sh "$SOURCE_DIR" "$BACKUP_DIR" >> "$LOG_FILE" 2>&1; then
    log "Backup completed successfully."
else
    log "Backup failed!"
fi

log "===== Maintenance Finished ====="
log ""
~
~
`output`
ubuntu@ip-172-31-27-220:~$ sudo ./maintenance.sh
sudo cat /var/log/maintenance.log
[2026-02-26 12:15:02] ===== Maintenance Started =====
<path not defined>
[2026-02-26 12:15:02] Log rotation failed!
/home/ubuntu/backup.sh: line 38: syntax error near unexpected token `('
[2026-02-26 12:15:02] Backup failed!
[2026-02-26 12:15:02] ===== Maintenance Finished =====
[2026-02-26 12:15:02]
[2026-02-26 12:17:36] ===== Maintenance Started =====
<path not defined>
[2026-02-26 12:17:36] Log rotation failed!
Backup created successfully: backup-2026-02-26-12-17-36.tar.gz
Size: 4.0K
Old backups deleted (older than 14 days).
[2026-02-26 12:17:36] Backup completed successfully.
[2026-02-26 12:17:36] ===== Maintenance Finished =====
[2026-02-26 12:17:36]
[2026-02-26 12:20:07] ===== Maintenance Started =====
Usage: /home/ubuntu/log_rotate.sh <log_directory>
[2026-02-26 12:20:07] Log rotation failed!
Backup created successfully: backup-2026-02-26-12-20-07.tar.gz
Size: 4.0K
Old backups deleted (older than 14 days).
[2026-02-26 12:20:07] Backup completed successfully.