#!/bin/bash

# Step 1 — Clean Old Test Data
#
rm -rf /tmp/source_test /tmp/backup_test

mkdir -p /tmp/source_test


3 Step 2 — Create Sample Data to Backup

touch /tmp/source_test/file1.txt

touch /tmp/source_test/file2.log

echo "This is test content" > /tmp/source_test/file3.txt


# Verify (Screenshot this (shows source data before backup)

ls -l /tmp/source_test

: <<'More'
Step 3 — Run Backup Script
bash /home/ubuntu/projects/shell-script/day-19/backup.sh /tmp/source_test /tmp/backup_test

Expected output:
Backup created: backup-2026-02-16.tar.gz
Backup size:    4.0K
Old backups deleted (> 14 days): 0
Screenshot this output.

Step 4 — Verify Backup File Created
ls -l /tmp/backup_test
You should see:
backup-2026-02-16.tar.gz

Step 5 — Verify Archive Contents
Screenshot this — it proves backup integrity.
You should see:
source_test/
source_test/file1.txt
source_test/file2.log
source_test/file3.txt

Step 6 — Simulate Old Backup for Cleanup Test
Create a fake old backup:
touch /tmp/backup_test/backup-2026-01-01.tar.gz
touch -d "20 days ago" /tmp/backup_test/backup-2026-01-01.tar.gz

Verify:
ls -l /tmp/backup_test

Step 7 — Run Script Again (Cleanup Should Happen)

bash /home/ubuntu/projects/shell-script/day-19/backup.sh /tmp/source_test /tmp/backup_test

Expected output:
Old backups deleted (> 7 days): 1

Step 8 — Verify Old Backup Deleted

ls -l /tmp/backup_test  # Old file should be gone.


Clean Screenshot Version (All-in-One)
This gives one clean terminal view.

echo "===== BEFORE ====="
ls -l /tmp/source_test

echo "===== RUN BACKUP ====="
bash /home/ubuntu/projects/shell-script/day-19/backup.sh /tmp/source_test /tmp/backup_test

echo "===== AFTER ====="
ls -l /tmp/backup_test

More


