#!/bin/bash

# -------------------------------
# Task 1: Input and Validation
# -------------------------------

# 1. Check if argument is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide log file path."
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE="$1"

# 2. Check if file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi

echo "Log file '$LOG_FILE' found. Ready for processing..."
