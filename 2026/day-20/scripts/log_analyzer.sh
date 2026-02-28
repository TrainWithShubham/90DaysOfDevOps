#!/bin/bash

set -euo pipefail

# ==============================
# Log Analyzer Script
# ==============================

# ---- Input Validation ----
if [ $# -eq 0 ]; then
    echo "ERROR: No log file provided."
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: File '$LOG_FILE' does not exist."
    exit 1
fi

DATE=$(date +%Y-%m-%d)
REPORT_FILE="log_report_${DATE}.txt"

TOTAL_LINES=$(wc -l < "$LOG_FILE")

# ---- Error Count (ERROR or Failed) ----
ERROR_COUNT=$(grep -Eic "ERROR|Failed" "$LOG_FILE" || true)

echo "Total ERROR/Failed occurrences: $ERROR_COUNT"

# ---- Critical Events ----
echo ""
echo "--- Critical Events ---"
CRITICAL_LINES=$(grep -n "CRITICAL" "$LOG_FILE" || true)

if [ -z "$CRITICAL_LINES" ]; then
    echo "No critical events found."
else
    echo "$CRITICAL_LINES"
fi

# ---- Top 5 Error Messages ----
echo ""
echo "--- Top 5 Error Messages ---"

TOP_ERRORS=$(grep -i "ERROR" "$LOG_FILE" \
    | sed -E 's/^[0-9-]+ [0-9:]+ //' \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -5 || true)

if [ -z "$TOP_ERRORS" ]; then
    echo "No ERROR messages found."
else
    echo "$TOP_ERRORS"
fi

# ---- Generate Summary Report ----
{
    echo "===== Log Analysis Report ====="
    echo "Date of Analysis: $DATE"
    echo "Log File: $LOG_FILE"
    echo "Total Lines Processed: $TOTAL_LINES"
    echo "Total ERROR/Failed Count: $ERROR_COUNT"
    echo ""

    echo "--- Top 5 Error Messages ---"
    if [ -z "$TOP_ERRORS" ]; then
        echo "No ERROR messages found."
    else
        echo "$TOP_ERRORS"
    fi

    echo ""
    echo "--- Critical Events ---"
    if [ -z "$CRITICAL_LINES" ]; then
        echo "No critical events found."
    else
        echo "$CRITICAL_LINES"
    fi

} > "$REPORT_FILE"

echo ""
echo "Summary report generated: $REPORT_FILE"

# ---- Optional: Archive Processed Log ----
ARCHIVE_DIR="archive"

if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir "$ARCHIVE_DIR"
fi

mv "$LOG_FILE" "$ARCHIVE_DIR/"

echo "Log file moved to $ARCHIVE_DIR/"
