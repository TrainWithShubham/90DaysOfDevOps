DAY 19 – SHELL SCRIPTING PROJECT
90 Days of DevOps

========================================
Task 1: Log Rotation Script
===========================

Script Name: log_rotate.sh

#!/bin/bash

LOG_DIR="./logs"
ARCHIVE_DIR="./archive"
DATE=$(date '+%Y-%m-%d')

mkdir -p $ARCHIVE_DIR

for file in $LOG_DIR/*.log; do
if [ -f "$file" ]; then
gzip "$file"
mv "$file.gz" "$ARCHIVE_DIR/$(basename $file)_$DATE.gz"
fi
done

echo "Log rotation completed on $DATE"

Sample Output:
Log rotation completed on 2026-03-04

========================================
Task 2: Server Backup Script
============================

Script Name: server_backup.sh

#!/bin/bash

SOURCE_DIR="./data"
BACKUP_DIR="./backup"
DATE=$(date '+%Y-%m-%d')

mkdir -p $BACKUP_DIR

tar -czf $BACKUP_DIR/backup_$DATE.tar.gz $SOURCE_DIR

echo "Backup completed successfully on $DATE"

Sample Output:
Backup completed successfully on 2026-03-04

========================================
Task 3: Crontab Entries
=======================

Open crontab:
crontab -e

Run Log Rotation daily at 12:00 AM
0 0 * * * /home/user/day19/log_rotate.sh

Run Server Backup daily at 1:00 AM
0 1 * * * /home/user/day19/server_backup.sh

========================================
Task 4: Combined – Scheduled Maintenance Script
===============================================

Script Name: maintenance.sh

#!/bin/bash

echo "Starting Scheduled Maintenance..."

bash log_rotate.sh
bash server_backup.sh

echo "Maintenance Completed Successfully!"

Make it executable:
chmod +x maintenance.sh

Single Cron Entry for Combined Script (Runs at 2:00 AM)
0 2 * * * /home/user/day19/maintenance.sh

========================================
What I Learned (3 Key Points)
=============================

1. How to automate log rotation using loops and gzip
2. How to create compressed backups using tar
3. How to schedule scripts automatically using crontab

Day 19 Completed
#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
