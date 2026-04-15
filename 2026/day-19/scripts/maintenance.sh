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
