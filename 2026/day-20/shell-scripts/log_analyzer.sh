#!/bin/bash
set -euo pipefail

# ----------------------------
# Task 1: Input and Validation
# ----------------------------
T1VALID() {
echo
echo "------- Task 1: Input and Validation -------"

(( $# == 1 )) || { echo "Usage: $0 <path-to-log-file>" >&2; exit 1; }

LOG_FILE="$1"

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Error: $(basename "$LOG_FILE") does not exist!!" >&2
  exit 1
fi

echo "$(basename "$LOG_FILE") validation successful."
}

# ----------------------------
# Task 2: Error Count
# ----------------------------
T2ERRCNT() {
DATE=$(date +%F)
REPORT_FILE="log_report_${DATE}.txt"
TOTAL_LINES=$(wc -l < "$LOG_FILE")
TOTAL_ERROR_COUNT=$(grep -iE "ERROR|Failed" "$LOG_FILE" | wc -l)

echo
echo "------- Task 2: Error Count -------"
echo "Total Errors and Failed Found: $TOTAL_ERROR_COUNT"
}

# ----------------------------
# Task 3: Critical Events
# ----------------------------
T3CRTKEVNTS() {
echo
echo "------- Task 3: Critical Events -------"
echo "--- Critical Events ---"
grep -in "CRITICAL" "$LOG_FILE" | while IFS=: read -r ln msg; do
  echo "Line $ln: $msg"
done
}

# ----------------------------
# Task 4: Top 5 Error Messages
# ----------------------------
T4ERROR() {
echo
echo "------- Task 4: Top 5 Error Messages -------"
echo "--- Top 5 Error Messages ---"
grep -i "ERROR" "$LOG_FILE" \
  | awk -F 'ERROR ' 'NF>1 {print $2}' \
  | sort \
  | uniq -c | awk '{$1=$1; print}' \
  | sort -nr \
  | head -5
}

# ----------------------------
# Task 5: Summary Report
# ----------------------------
T5SUMMREP() {
echo
echo "------- Task 5: Summary Report -------"

{
  echo "=========================================="
  echo "          Daily Log Summary Report"
  echo "=========================================="
  echo "Date of analysis      : $DATE"
  echo "Log file name         : $(basename "$LOG_FILE")"
  echo "Log file path         : $LOG_FILE"
  echo "Total lines processed : $TOTAL_LINES"
  echo "Total error count     : $TOTAL_ERROR_COUNT"
  echo

  T4ERROR
  T3CRTKEVNTS

  echo "=========================================="
} > "$REPORT_FILE"

echo "Report generated: $REPORT_FILE"
}

main() {
  T1VALID "$@"
  T2ERRCNT
  T3CRTKEVNTS
  T4ERROR
  T5SUMMREP
}

main "$@"

