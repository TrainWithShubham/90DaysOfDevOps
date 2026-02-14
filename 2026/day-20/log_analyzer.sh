#!/bin/bash
set -euo pipefail
if [ $# -ne 1 ]
then
	echo "Enter the logfile path while running the command as the argument"
	exit 1
fi

LOG_FILE="$1" 

if [ ! -f "$LOG_FILE" ]
then
	echo "ERROR: Log file does not exist: $LOG_FILE"
	exit 1
fi

ERROR_COUNT=$(grep -cEi "ERROR|Failed" "$LOG_FILE")
echo "----------------------Log Analysis-----------------------"
TOTAL_LINES=$(wc -l < "$LOG_FILE")
REPORT_PATH="/consdata2/reports"
if [ ! -d "$REPORT_PATH" ]
then
	mkdir -p "$REPORT_PATH"
fi
REPORT_FILE="$REPORT_PATH/log_report_$(date +%Y-%m-%d).txt"

> "$REPORT_FILE"

echo "----------------------Log Analysis-----------------------" >> "$REPORT_FILE"
echo " "
echo "Date of Analysis: $(date +%Y-%m-%d)" >> "$REPORT_FILE"
echo "Log File: $LOG_FILE" >> "$REPORT_FILE"
echo "Total Lines processed: $TOTAL_LINES" >> "$REPORT_FILE"
echo "Total Error Count: $ERROR_COUNT" >> "$REPORT_FILE"
echo " " >> "$REPORT_FILE"
echo "------------------- TOP 5 ERROR MESSAGES -------------------" >> "$REPORT_FILE"
grep -i "ERROR" "$LOG_FILE" | awk '{$1=$2=$3=""; sub(/ - [0-9]+$/, ""); print}' | sort | uniq -c | sort -rn | head -5 >> "$REPORT_FILE"
echo " " >> "$REPORT_FILE"
echo "------------------- CRITICAL-EVENTS-------------------" >> "$REPORT_FILE"
grep -ni "CRITICAL" "$LOG_FILE" | awk -F: '{print "Line " $1 ": " substr($0, index($0,$2))}' >> "$REPORT_FILE"

ARCHIVE_DIR=/consdata2/logs/archive

if [ ! -d "$ARCHIVE_DIR" ]
then
	mkdir -p "$ARCHIVE_DIR"
fi
mv "$LOG_FILE" "$ARCHIVE_DIR/"
