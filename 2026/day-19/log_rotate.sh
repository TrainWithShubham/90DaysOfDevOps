#!/bin/bash

set -euo pipefail

LOG_DIR=$1

if [ ! -d "$LOG_DIR" ]; then
    echo "Error : Directory doesn't exist"
    exit 1
fi

echo "Checking log directory: $LOG_DIR"

COMPRESSED=$(find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \; | wc -l)

DELETED=$(find "$LOG_DIR" -name "*.gz" -mtime +30 -delete | wc -l)

echo "Compressed files: $COMPRESSED"

echo "Deleted old compressed files: $DELETED"

echo "Log rotation completed"
