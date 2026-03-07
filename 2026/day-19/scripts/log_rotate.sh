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
