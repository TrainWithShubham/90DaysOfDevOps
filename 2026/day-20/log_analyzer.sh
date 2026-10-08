#!/bin/bash

LOG_FILE=$1

if [ $# -eq 0 ]; then
    echo "Please provide log file"
    exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found"
    exit 1
fi

echo "Analyzing log file: $LOG_FILE"

echo
echo "Total Error Count:"
grep -ic "error" "$LOG_FILE"

echo
echo "Critical Events:"
grep -in "critical" "$LOG_FILE"

echo
echo "Top 5 Errors:"
grep "error" "$LOG_FILE" | awk -F'] ' '{print $3}' | sort | uniq -c | sort -rn | head -5

REPORT_FILE="log_report_$(date +%Y-%m-%d).txt"

{
echo "Log Analysis Report"
echo "Date: $(date)"
echo "Log File: $LOG_FILE"
echo "Total Lines: $(wc -l < "$LOG_FILE")"
echo "Total Error Count: $(grep -ic "error" "$LOG_FILE")"
echo
echo "Top 5 Errors:"
grep "error" "$LOG_FILE" | awk -F'] ' '{print $3}' | sort | uniq -c | sort -rn | head -5
echo
echo "Critical Events:"
grep -in "critical" "$LOG_FILE"
} > "$REPORT_FILE"

echo
echo "Report created: $REPORT_FILE"
