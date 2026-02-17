#!/bin/bash
echo "===== BEFORE ====="
ls -l /tmp/source_test

echo "===== RUN BACKUP ====="
bash /home/ubuntu/projects/shell-script/day-19/backup.sh /tmp/source_test /tmp/backup_test

echo "===== AFTER ====="
ls -l /tmp/backup_test

