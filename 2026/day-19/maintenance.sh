#!/bin/bash 


LOG_FILE="/var/log/maintenance.log"

exec >> "$LOG_FILE" 2>&1

echo "maintaines startes $(date +"%Y-%m-%d_%H-%M-%S")"

./rotate.sh ./new_check


./backup.sh ./data ./backup


echo "maintanence sucessfully  $(date +"%Y-%m-%d_%H-%M-%S")"
