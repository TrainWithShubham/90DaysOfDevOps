# Day 19 – Shell Scripting Project  
## Log Rotation, Backup & Crontab Automation

---

## 📌 Objective

Apply concepts from Days 16–18 into real-world automation:

- Write a Log Rotation Script
- Write a Server Backup Script
- Schedule using Crontab
- Combine everything into a Maintenance Script

---

# ✅ Task 1 – Log Rotation Script

## 🎯 Requirements

- Take log directory as argument
- Compress `.log` files older than 7 days
- Delete `.gz` files older than 30 days
- Print number of files compressed and deleted
- Exit with error if directory does not exist

---

## 📜 Script: `log_rotate.sh`

```bash
#!/bin/bash

LOG_DIR=$1

# Check argument
if [ -z "$LOG_DIR" ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

# Check if directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory does not exist!"
    exit 1
fi

echo "Starting log rotation in $LOG_DIR"

# Compress .log files older than 7 days
COMPRESSED_COUNT=$(find "$LOG_DIR" -type f -name "*.log" -mtime +7 -exec gzip {} \; -print | wc -l)

# Delete .gz files older than 30 days
DELETED_COUNT=$(find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -exec rm -f {} \; -print | wc -l)

echo "Compressed files: $COMPRESSED_COUNT"
echo "Deleted files: $DELETED_COUNT"

echo "Log rotation completed successfully."
```

---

## ▶ Usage

```bash
chmod +x log_rotate.sh
./log_rotate.sh /var/log/myapp
```

---

# ✅ Task 2 – Server Backup Script

## 🎯 Requirements

- Take source and destination as arguments
- Create timestamped archive (backup-YYYY-MM-DD.tar.gz)
- Verify archive creation
- Print archive name and size
- Delete backups older than 14 days
- Exit if source directory does not exist

---

## 📜 Script: `backup.sh`

```bash
#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DATE=$(date +%Y-%m-%d)
ARCHIVE_NAME="backup-$DATE.tar.gz"

# Validate arguments
if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory does not exist!"
    exit 1
fi

# Create destination if not exists
mkdir -p "$DEST_DIR"

# Create archive
tar -czf "$DEST_DIR/$ARCHIVE_NAME" "$SOURCE_DIR"

# Verify archive
if [ -f "$DEST_DIR/$ARCHIVE_NAME" ]; then
    SIZE=$(du -h "$DEST_DIR/$ARCHIVE_NAME" | cut -f1)
    echo "Backup created successfully!"
    echo "Archive: $ARCHIVE_NAME"
    echo "Size: $SIZE"
else
    echo "Backup failed!"
    exit 1
fi

# Delete old backups older than 14 days
find "$DEST_DIR" -type f -name "backup-*.tar.gz" -mtime +14 -exec rm -f {} \;

echo "Old backups cleaned."
```

---

## ▶ Usage

```bash
chmod +x backup.sh
./backup.sh /home/appdata /backup
```

---

# ✅ Task 3 – Crontab

## 🔎 Check Current Scheduled Jobs

```bash
crontab -l
```

---

## 🕒 Cron Syntax

```
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

---

## 📌 Required Cron Entries

### Run log_rotate.sh every day at 2 AM

```bash
0 2 * * * /path/to/log_rotate.sh /var/log/myapp >> /var/log/log_rotate_cron.log 2>&1
```

### Run backup.sh every Sunday at 3 AM

```bash
0 3 * * 0 /path/to/backup.sh /home/appdata /backup >> /var/log/backup_cron.log 2>&1
```

### Run health check every 5 minutes

```bash
*/5 * * * * /path/to/health_check.sh >> /var/log/health.log 2>&1
```

---

# ✅ Task 4 – Combined Maintenance Script

## 🎯 Requirements

- Call log rotation script
- Call backup script
- Log all output to `/var/log/maintenance.log`
- Schedule daily at 1 AM

---

## 📜 Script: `maintenance.sh`

```bash
#!/bin/bash

LOG_FILE="/var/log/maintenance.log"

echo "------------------------------------" >> $LOG_FILE
echo "$(date) - Maintenance Started" >> $LOG_FILE

# Run Log Rotation
/path/to/log_rotate.sh /var/log/myapp >> $LOG_FILE 2>&1

# Run Backup
/path/to/backup.sh /home/appdata /backup >> $LOG_FILE 2>&1

echo "$(date) - Maintenance Completed" >> $LOG_FILE
```

---

## 📌 Cron Entry for Maintenance Script

```bash
0 1 * * * /path/to/maintenance.sh
```

---
