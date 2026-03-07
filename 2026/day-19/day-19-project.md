# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab
-----
## Task 1: Log Rotation Script
Created a file log_rotate.sh
- Code:
```bash
#!/bin/bash

set -euo pipefail
# If total arguments not equal to 1 then script will exited.
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

LOG_DIR="$1"
# if directory does not exists then script will exited.
if [[ ! -d "$LOG_DIR" ]]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

# Get files first (store in arrays)
# log files find if files are older than 7 days.
mapfile -d '' LOG_FILES < <(find "$LOG_DIR" -type f -name "*.log" -mtime +7 -print0)
# gzip files find if files are older than 30 days.
mapfile -d '' GZ_FILES  < <(find "$LOG_DIR" -type f -name "*.gz"  -mtime +30 -print0)

# It will gzip the log files which are older  than 7 days.
if (( ${#LOG_FILES[@]} > 0 )); then
    printf '%s\0' "${LOG_FILES[@]}" | xargs -0 gzip
fi

# It will removing the gzip files which are older than 30 days.
if (( ${#GZ_FILES[@]} > 0 )); then
    printf '%s\0' "${GZ_FILES[@]}" | xargs -0 rm -f
fi

echo "Files compressed: ${#LOG_FILES[@]}"
echo "Files deleted: ${#GZ_FILES[@]}"

```
- Output:
```shell
ubuntu@ip-172-31-22-48:~/day19$ ./log_rotate.sh
Usage: ./log_rotate.sh <log_directory>
ubuntu@ip-172-31-22-48:~/day19$ ./log_rotate.sh /var/log/nginx
Files compressed: 0
Files deleted: 0
ubuntu@ip-172-31-22-48:~/day19$

```

## Task 2: Server Backup Script
- Code:
```bash
#!/bin/bash

set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

SOURCE="$1"
DEST="$2"

if [[ ! -d "$SOURCE" ]]; then
    echo "Error: Source directory '$SOURCE' does not exist."
    exit 1
fi

if [[ ! -d "$DEST" ]]; then
    echo "Destination directory does not exist. Creating it..."
    mkdir -p "$DEST"
fi

TIMESTAMP=$(date +"%Y-%m-%d")
ARCHIVE_NAME="backup-${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${DEST}/${ARCHIVE_NAME}"
tar -czf "$ARCHIVE_PATH" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"


if [[ ! -f "$ARCHIVE_PATH" ]]; then
    echo "Error: Backup archive was not created."
    exit 1
fi

ARCHIVE_SIZE=$(du -h "$ARCHIVE_PATH" | cut -f1)

echo "Backup successful."
echo "Archive: $ARCHIVE_NAME"
echo "Size: $ARCHIVE_SIZE"
DELETED_COUNT=0

while IFS= read -r -d '' file; do
    rm -f "$file"
    ((DELETED_COUNT++))
done < <(find "$DEST" -type f -name "backup-*.tar.gz" -mtime +14 -print0)

echo "Old backups deleted: $DELETED_COUNT"

exit 0
```
- Output:
```shell
ubuntu@ip-172-31-22-48:~/day19$ chmod 755 backup.sh
ubuntu@ip-172-31-22-48:~/day19$ ./backup.sh
Usage: ./backup.sh <source_directory> <backup_destination>
ubuntu@ip-172-31-22-48:~/day19$ ./backup.sh /var/log/nginx /home/ubuntu/backup
Destination directory does not exist. Creating it...
Backup successful.
Archive: backup-2026-02-23.tar.gz
Size: 4.0K
Old backups deleted: 0
ubuntu@ip-172-31-22-48:~/day19$ ls -l /home/ubuntu/
total 16
drwxrwxr-x 2 ubuntu ubuntu 4096 Feb 23 11:38 backup
drwxrwxr-x 2 ubuntu ubuntu 4096 Feb 23 11:37 day19
drwxrwxr-x 3 ubuntu ubuntu 4096 Feb 23 07:53 day20
drwxrwxr-x 2 ubuntu ubuntu 4096 Feb 23 06:09 nginx
ubuntu@ip-172-31-22-48:~/day19$ ls -l /home/ubuntu/backup/
total 4
-rw-rw-r-- 1 ubuntu ubuntu 615 Feb 23 11:38 backup-2026-02-23.tar.gz

```

# Task 3: Crontab
Read: crontab -l — what's currently scheduled?
Understand cron syntax:
* * * * *  command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)


```bash
# m h  dom mon dow   command
0 2 * * * /home/ubuntu/log_rotzte.sh >> /var/log/log_rotate.log 2>&1
0 3 * * * /home/ubuntu/backup.sh >> /var/log/backup.log 2>&1
*/5 * * * * /home/ubuntu/health_check.sh >> /var/log/health_check.log 2>&1
0 1 * * * /home/ubuntu/maintenance.sh >> /var/log/maintenance.log 2>&1

```
```shell
ubuntu@ip-172-31-22-48:~/day19$ systemctl status cron
● cron.service - Regular background program processing daemon
     Loaded: loaded (/usr/lib/systemd/system/cron.service; enabled; preset: enabled)
     Active: active (running) since Mon 2026-02-23 11:33:34 UTC; 8min ago
       Docs: man:cron(8)
   Main PID: 509 (cron)
      Tasks: 1 (limit: 1015)
     Memory: 1000.0K (peak: 5.1M)
        CPU: 306ms
     CGroup: /system.slice/cron.service
             └─509 /usr/sbin/cron -f -P

Feb 23 11:42:01 ip-172-31-22-48 CRON[1643]: (ubuntu) CMD (/home/ubuntu/health_check.sh >> /var/log/health_check.log 2>&1)
Feb 23 11:42:01 ip-172-31-22-48 CRON[1644]: (ubuntu) CMD (/home/ubuntu/log_rotzte.sh >> /var/log/log_rotate.log 2>&1)
Feb 23 11:42:01 ip-172-31-22-48 CRON[1641]: pam_unix(cron:session): session opened for user ubuntu(uid=1000) by ubuntu(uid=0)
Feb 23 11:42:01 ip-172-31-22-48 CRON[1645]: (ubuntu) CMD (/home/ubuntu/backup.sh >> /var/log/backup.log 2>&1)
Feb 23 11:42:01 ip-172-31-22-48 CRON[1642]: (CRON) info (No MTA installed, discarding output)
Feb 23 11:42:01 ip-172-31-22-48 CRON[1640]: (CRON) info (No MTA installed, discarding output)
Feb 23 11:42:01 ip-172-31-22-48 CRON[1640]: pam_unix(cron:session): session closed for user ubuntu
Feb 23 11:42:01 ip-172-31-22-48 CRON[1642]: pam_unix(cron:session): session closed for user ubuntu
Feb 23 11:42:01 ip-172-31-22-48 CRON[1641]: (CRON) info (No MTA installed, discarding output)
Feb 23 11:42:01 ip-172-31-22-48 CRON[1641]: pam_unix(cron:session): session closed for user ubuntu

```
- When i used cronjob for every minute it will running every minute and giving me output like that----
- you can run one more command for checking runtime status `tail -f /var/log/syslog`
```shell
ubuntu@ip-172-31-22-48:~/day19$ grep CRON /var/log/syslog
2026-02-23T05:12:57.054671+00:00 ip-172-31-22-48 cron[598]: (CRON) INFO (pidfile fd = 3)
2026-02-23T05:12:57.054678+00:00 ip-172-31-22-48 cron[598]: (CRON) INFO (Running @reboot jobs)
2026-02-23T05:15:01.300656+00:00 ip-172-31-22-48 CRON[1479]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
2026-02-23T05:17:01.331501+00:00 ip-172-31-22-48 CRON[1819]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
2026-02-23T05:25:01.350787+00:00 ip-172-31-22-48 CRON[1896]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
2026-02-23T05:35:01.372316+00:00 ip-172-31-22-48 CRON[1907]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
2026-02-23T05:45:01.387127+00:00 ip-172-31-22-48 CRON[1957]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
2026-02-23T05:55:01.426046+00:00 ip-172-31-22-48 CRON[1968]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
2026-02-23T06:05:01.479487+00:00 ip-172-31-22-48 CRON[1982]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
2026-02-23T06:15:01.514104+00:00 ip-172-31-22-48 CRON[2015]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
2026-02-23T06:17:01.530476+00:00 ip-172-31-22-48 CRON[2098]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
2026-02-23T06:25:01.554580+00:00 ip-172-31-22-48 CRON[2134]: (root) CMD (test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.daily; })
2026-02-23T06:25:01.566399+00:00 ip-172-31-22-48 CRON[2135]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
2026-02-23T06:25:01.574482+00:00 ip-172-31-22-48 CRON[2137]: (ubuntu) CMD (/home/ubuntu/health_check.sh >> /var/log/health_check.log 2>&1)
2026-02-23T06:25:01.591367+00:00 ip-172-31-22-48 CRON[2133]: (CRON) info (No MTA installed, discarding output)
2026-02-23T06:28:01.671434+00:00 ip-172-31-22-48 CRON[2168]: (ubuntu) CMD (/home/ubuntu/health_check.sh >> /var/log/health_check.log 2>&1)
2026-02-23T06:28:01.678864+00:00 ip-172-31-22-48 CRON[2169]: (ubuntu) CMD (/home/ubuntu/log_rotzte.sh >> /var/log/log_rotate.log 2>&1)
2026-02-23T06:28:01.684817+00:00 ip-172-31-22-48 CRON[2170]: (ubuntu) CMD (/home/ubuntu/backup.sh >> /var/log/backup.log 2>&1)
2026-02-23T06:28:01.687846+00:00 ip-172-31-22-48 CRON[2165]: (CRON) info (No MTA installed, discarding output)
2026-02-23T06:28:01.694190+00:00 ip-172-31-22-48 CRON[2167]: (CRON) info (No MTA installed, discarding output)
2026-02-23T06:28:01.696214+00:00 ip-172-31-22-48 CRON[2166]: (CRON) info (No MTA installed, discarding output)
2026-02-23T06:29:01.711538+00:00 ip-172-31-22-48 CRON[2175]: (ubuntu) CMD (/home/ubuntu/health_check.sh >> /var/log/health_check.log 2>&1)
2026-02-23T06:29:01.736867+00:00 ip-172-31-22-48 CRON[2172]: (CRON) info (No MTA installed, discarding output)
2026-02-23T06:29:01.754377+00:00 ip-172-31-22-48 CRON[2176]: (ubuntu) CMD (/home/ubuntu/log_rotzte.sh >> /var/log/log_rotate.log 2>&1)
2026-02-23T06:29:01.770667+00:00 ip-172-31-22-48 CRON[2177]: (ubuntu) CMD (/home/ubuntu/backup.sh >> /var/log/backup.log 2>&1)
2026-02-23T06:29:01.792857+00:00 ip-172-31-22-48 CRON[2173]: (CRON) info (No MTA installed, discarding output)
2026-02-23T06:29:01.796199+00:00 ip-172-31-22-48 CRON[2174]: (CRON) info (No MTA installed, discarding output)
2026-02-23T06:30:01.862478+00:00 ip-172-31-22-48 CRON[2284]: (ubuntu) CMD (/home/ubuntu/backup.sh >> /var/log/backup.log 2>&1)
2026-02-23T06:30:01.888561+00:00 ip-172-31-22-48 CRON[2285]: (ubuntu) CMD (/home/ubuntu/health_check.sh >> /var/log/health_check.log 2>&1)
2026-02-23T06:30:01.889022+00:00 ip-172-31-22-48 CRON[2286]: (ubuntu) CMD (/home/ubuntu/log_rotzte.sh >> /var/log/log_rotate.log 2>&1)

```

# Task 4: Combine — Scheduled Maintenance Script

- Code: 
```bash
#!/bin/bash

# ===== Configuration =====
LOG_FILE="/var/log/maintenance.log"
LOG_ROTATE_SCRIPT="/home/ubuntu/day19/log_rotate.sh"
BACKUP_SCRIPT="/home/ubuntu/day19/backup.sh"

# ===== Timestamp Function =====
timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

# ===== Logging Wrapper =====
log() {
    echo "$(timestamp) - $1" >> "$LOG_FILE"
}

# ===== Begin Maintenance =====
log "===== Maintenance Job Started ====="

# Run log rotation
if [ -x "$LOG_ROTATE_SCRIPT" ]; then
    log "Starting log rotation..."
    "$LOG_ROTATE_SCRIPT" >> "$LOG_FILE" 2>&1
    log "Log rotation completed with exit code $?"
else
    log "ERROR: Log rotation script not found or not executable."
fi

# Run backup
if [ -x "$BACKUP_SCRIPT" ]; then
    log "Starting backup..."
    "$BACKUP_SCRIPT" >> "$LOG_FILE" 2>&1
    log "Backup completed with exit code $?"
else
    log "ERROR: Backup script not found or not executable."
fi

log "===== Maintenance Job Finished ====="
echo "" >> "$LOG_FILE"

```

- Output:
```shell
ubuntu@ip-172-31-22-48:~/day19$ ls
backup.sh  log_rotate.sh  maintenance.sh
ubuntu@ip-172-31-22-48:~/day19$ chmod 755 maintenance.sh
ubuntu@ip-172-31-22-48:~/day19$ ./maintenance.sh
./maintenance.sh: line 15: /var/log/maintenance.log: Permission denied
./maintenance.sh: line 15: /var/log/maintenance.log: Permission denied
./maintenance.sh: line 24: /var/log/maintenance.log: Permission denied
./maintenance.sh: line 15: /var/log/maintenance.log: Permission denied
./maintenance.sh: line 15: /var/log/maintenance.log: Permission denied
./maintenance.sh: line 33: /var/log/maintenance.log: Permission denied
./maintenance.sh: line 15: /var/log/maintenance.log: Permission denied
./maintenance.sh: line 15: /var/log/maintenance.log: Permission denied
./maintenance.sh: line 40: /var/log/maintenance.log: Permission denied
ubuntu@ip-172-31-22-48:~/day19$ sudo ./maintenance.sh

```

```shell
ubuntu@ip-172-31-22-48:~/day19$ ls -l /var/log
total 1228
lrwxrwxrwx  1 root      root                39 Dec 12 10:00 README -> ../../usr/share/doc/systemd/README.logs
drwxr-xr-x  2 landscape landscape         4096 Feb 23 05:13 landscape
-rw-rw-r--  1 root      utmp            292292 Feb 23 11:34 lastlog
-rw-r--r--  1 root      root               456 Feb 23 12:06 maintenance.log
```

------

# What you learned 
- 3 key points

- File management with find and mtime
-Automating file lifecycle management is critical for production systems.

- Error handling in shell scripts (set -e, input validation)
 Defensive scripting prevents silent failures.

- Cron scheduling & automation
 Reliable infrastructure depends on scheduled, unattended tasks.

🔎 Best Practice Notes

- Maintenance scripts that write to /var/log must run with sudo

- Always use absolute paths in cron jobs

- Redirect both standard output and standard error in production scripts

- Validate inputs before destructive operations (rm)


-----------
