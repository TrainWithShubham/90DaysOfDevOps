#!/usr/bin/env bash
set -euo pipefail

# ----------------------------
# log_rotate.sh
# Usage: ./log_rotate.sh /path/to/logdir
# ----------------------------

# Check if exactly one argument is provided
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <log_directory>" >&2
    exit 2
fi

LOG_DIR="$1"

# Check if the directory exists
if [[ ! -d "$LOG_DIR" ]]; then
    echo "Error: Directory does not exist." >&2
    exit 1
fi

# Count .log files older than 7 days and compress them
compressed_count=$(find "$LOG_DIR" -type f -name "*.log" -mtime +7 -print -exec gzip {} + | wc -l)

# Count .gz files older than 30 days and delete them
deleted_count=$(find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -print -exec rm -f {} + | wc -l)

# Print results
echo "Files compressed: $compressed_count"
echo "Files deleted: $deleted_count"

exit 0

