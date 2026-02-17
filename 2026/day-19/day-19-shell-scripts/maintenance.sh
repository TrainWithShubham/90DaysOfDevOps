#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="/var/log/maintenance.log"
#LOG_FILE="$HOME/maintenance.log"

# Function to log messages with timestamp
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

main() {

    log "===== Maintenance Job Started ====="

    # Run Log Rotation
    log "Running log rotation..."
    /home/ubuntu/projects/shell-script/day-19/log_rotate.sh /var/log/myapp >> "$LOG_FILE" 2>&1
    log "Log rotation completed."

    # Run Backup
    log "Running backup..."
    /home/ubuntu/projects/shell-script/day-19/backup.sh /path/source /path/backup >> "$LOG_FILE" 2>&1
    log "Backup completed."

    log "===== Maintenance Job Finished ====="
    echo "" >> "$LOG_FILE"
}

main

