#!/bin/bash

# ==============================
# Maintenance Script
# ==============================

LOG_FILE="/var/log/maintanance.log"
# Function to log messages with timestamp
log()
{
    echo "$(date '+%Y:%m:%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

#Source both scripts

rotate_logs()
{
    log "Starting log rotation..."
    sudo bash ./log_rotate.sh /home/ubuntu/logs 2>&1 | tee -e "$LOG_FILE"
    echo "Log rotation completed."
}

run_backup(){
    log "starting backup.."
    sudo bash ./backup.sh /app-logs /backups 2>&1 | tee -e "$LOG_FILE"
    log "Backup completed"
}

#call the functions
rotate_logs
run_backup

log "Maintanance Completed Successfully!"
