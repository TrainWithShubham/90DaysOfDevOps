# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab



## Challenge Tasks

### Task 1: Log Rotation Script
Create `log_rotate.sh` that:
1. Takes a log directory as an argument (e.g., `/var/log/myapp`)
2. Compresses `.log` files older than 7 days using `gzip`
3. Deletes `.gz` files older than 30 days
4. Prints how many files were compressed and deleted
5. Exits with an error if the directory doesn't exist

```bash

#!/bin/bash
# 1. Check user ne directory di hai ya nahi
if [ $# -eq 0 ]
then
        echo "provide lod directary path"
        exit 1
fi
log_dir=$1
# 2. Check directory exist karti hai ya nahi
if [ ! -d "$log_dir" ]
then
        echo "Directory not exist"
        exit 1
fi
echo "--------------------------------------------------------"
compressed=0
deleted=0
# 3. 7 din purane .log files compress karo
for file in "$log_dir"/*.log
do
        if [ -f "$file" ]
        then
                if [ $(find "$file" -mtime +7 | wc -l) -eq 1 ]
                then
                        gzip "$file"
                        compressed=$((compressed+1))
                fi
        fi
done
# 4. 30 din purane .gz files delete karo
for file in "$log_dir"/*.gz
do
        if [ -f "$file" ]
        then
                if [ $(find "$file" -mtime +30 | wc -l) -eq 1 ]
                then
                        rm "$file"
                        deleted=$((deleted+1))
                fi
        fi
done
echo "-----------------------------"
echo "Files compressed : $compressed"
echo "Files deleted    : $deleted"
echo "Done"
```



### Task 2: Server Backup Script
Create `backup.sh` that:
1. Takes a source directory and backup destination as arguments
2. Creates a timestamped `.tar.gz` archive (e.g., `backup-2026-02-08.tar.gz`)
3. Verifies the archive was created successfully
4. Prints archive name and size
5. Deletes backups older than 14 days from the destination
6. Handles errors — exit if source doesn't exist



```bash
#!/bin/bash
# 1. arguments check
if [ $# -ne 2 ]
then
    echo "Usage: ./backup.sh <source_folder> <backup_folder>"
    exit 1
fi
source=$1
backup=$2
# 6. source exist nahi to exit
if [ ! -d "$source" ]
then
    echo "Source folder does not exist!"
    exit 1
fi
# 2. timestamp archive
date=$(date +%Y-%m-%d)
archive="backup-$date.tar.gz"
tar -czf "$backup/$archive" "$source"
# 3. verify archive bana ya nahi
if [ -f "$backup/$archive" ]
then
    echo "Backup created"
else
    echo "Backup failed"
    exit 1
fi
# 4. name aur size print
echo "File name: $archive"
du -h "$backup/$archive"
# 5. 14 din purane delete
old=$(find "$backup" -name "backup-*.tar.gz" -mtime +14 | wc -l)
find "$backup" -name "backup-*.tar.gz" -mtime +14 -delete
echo "Old backups deleted: $old"

```


### Task 4: Combine — Scheduled Maintenance Script
Create `maintenance.sh` that:
1. Calls your log rotation function
2. Calls your backup function
3. Logs all output to `/var/log/maintenance.log` with timestamps
4. Write the cron entry to run it daily at 1 AM


```bash
!/bin/bash

LOGFILE="/var/log/maintenance.log"

log(){
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOGFILE
}

echo "" >> $LOGFILE
log "========== MAINTENANCE STARTED =========="

###################################
log "Starting Log Rotation"
echo "----- Log Rotation Output -----" >> $LOGFILE
/home/om/log_project/log_rotate.sh /home/om/log_project/test_logs >> $LOGFILE 2>&1
log "Log Rotation Finished"

###################################
log "Starting Backup"
echo "----- Backup Output -----" >> $LOGFILE
/home/om/server-backup-project/backup.sh /home/om/server-backup-project/data /home/om/server-backup-project/backups >> $LOGFILE 2>&1
log "Backup Finished"

log "========== MAINTENANCE COMPLETED =========="
```

