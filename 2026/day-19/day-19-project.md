# **Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab**

## **Task**

Today task was to apply everything learned in previous days into real-world mini projects.

I implemented:

* Log rotation automation  
* Server backup automation  
* Cron scheduling  
* Combined maintenance script

This felt more practical compared to previous days.

# **Task 1 – Log Rotation Script**

## **Script: log\_rotate.sh**

\#\!/bin/bash  
set \-euo pipefail

DIR="${1:-}"

if \[ \-z "$DIR" \] || \[ \! \-d "$DIR" \]; then  
    echo "Error: Directory does not exist or not provided."  
    exit 1  
fi

ZIP\_COUNT=$(find "$DIR" \-type f \-name "\*.log" \-mtime \+7 | wc \-l)  
DEL\_COUNT=$(find "$DIR" \-type f \-name "\*.gz" \-mtime \+30 | wc \-l)

find "$DIR" \-type f \-name "\*.log" \-mtime \+7 \-exec gzip {} \\;  
find "$DIR" \-type f \-name "\*.gz" \-mtime \+30 \-exec rm \-f {} \\;

echo "Log zipped count : $ZIP\_COUNT"  
echo "Log deleted count : $DEL\_COUNT"

## **Sample Output**

Log zipped count : 4  
Log deleted count : 2

## **What I Learned**

* Must count files before modifying them.  
* Use gzip for log compression, not tar.  
* Strict mode requires safe argument handling.  
* Always quote variables in find and file paths.

# **Task 2 – Backup Script**

## **Script: backup.sh**

\#\!/bin/bash  
set \-euo pipefail

if \[ "$\#" \-ne 2 \]; then  
    echo "Usage: $0 \<source\_directory\> \<backup\_destination\>"  
    exit 1  
fi

SOURCE="$1"  
DESTINATION="$2"

if \[ \! \-d "$SOURCE" \]; then  
    echo "Error: Source directory does not exist: $SOURCE"  
    exit 1  
fi

if \[ \! \-d "$DESTINATION" \]; then  
    echo "Error: Destination directory does not exist: $DESTINATION"  
    exit 1  
fi

DATE=$(date \+%Y-%m-%d)  
ARCHIVE="$DESTINATION/backup-$DATE.tar.gz"

tar \-czf "$ARCHIVE" "$SOURCE"

if \[ \! \-f "$ARCHIVE" \] || \[ \! \-s "$ARCHIVE" \]; then  
    echo "Error: Backup archive was not created properly."  
    exit 1  
fi

echo "Backup created successfully."  
echo "Archive: $ARCHIVE"  
ls \-lh "$ARCHIVE"

find "$DESTINATION" \-type f \-name "backup-\*.tar.gz" \-mtime \+14 \-exec rm \-f {} \\;

echo "Old backups older than 14 days removed."

## **Sample Output**

Backup created successfully.  
Archive: /backup/backup-2026-02-14.tar.gz  
\-rw-r--r--  25M backup-2026-02-14.tar.gz  
Old backups older than 14 days removed.

## **What I Learned**

* Always validate argument count using $\#.  
* Use date \+%Y-%m-%d for timestamped backups.  
* Checking only exit code is not enough — verify file existence and size.  
* Always quote variables to avoid path issues.  
* Use strict mode for safer automation.

# **Task 3 – Cron Scheduling**

## **Cron Entries**

Run log rotation daily at 2 AM:

0 2 \* \* \* /scripts/log\_rotate.sh /var/log/myapp

Run backup every Sunday at 3 AM:

0 3 \* \* 0 /scripts/backup.sh /source /backup

Run health check every 5 minutes:

\*/5 \* \* \* \* /scripts/health\_check.sh

## **What I Learned**

* First field is minute, not hour.  
* 0 2 \* \* \* means exactly 2:00 AM.  
* \*/5 means every 5 minutes.  
* Cron mistakes can cause scripts to run every minute unintentionally.

# **Task 4 – Maintenance Script**

## **Script: maintenance.sh**

\#\!/bin/bash  
set \-euo pipefail

LOG\_FILE="/var/log/maintenance.log"

exec \>\> "$LOG\_FILE" 2\>&1

echo "============================================"  
echo "$(date) : maintenance started"

./log\_rotate.sh /var/log/myapp  
./backup.sh /source /backup

echo "$(date) : maintenance completed"  
echo "============================================"

## **Cron Entry**

Run daily at 1 AM:

0 1 \* \* \* /scripts/maintenance.sh

## **What I Learned**

* Do not use exec before calling other scripts.  
* exec \>\> logfile 2\>&1 redirects entire script output.  
* Spelling mistakes in file paths can break automation.  
* Keep logging simple and structured.

# **Learnings From My Mistakes**

During this task, I made several mistakes which helped me understand scripting better:

* Initially used tar instead of gzip for log rotation.  
* Forgot strict mode in early versions.  
* Incorrect command substitution syntax.  
* Wrong archive extension (.tar.g).  
* Mixed validation checks in messy way.  
* Forgot to quote variables.  
* Used wrong cron minute field.  
* Misused exec which replaces the current shell process.  
* Rushed without reviewing syntax carefully.

Correcting these improved my attention to detail.

# **Key Learnings (3 Points)**

1. Strict mode (set \-euo pipefail) makes scripts safer but requires careful validation.  
2. Proper argument validation and quoting prevents unexpected failures.  
3. Automation scripts must be precise — small mistakes can cause large impact.

