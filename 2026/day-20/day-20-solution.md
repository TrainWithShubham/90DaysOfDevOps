# Day 20 – Bash Scripting Challenge
# Log Analyzer and Report Generator

---

## Overview

- This project implements a Bash script (log_analyzer.sh) that analyzes system log files and generates a structured daily summary report.

- The script performs validation, extracts important events, summarizes error statistics, and produces a formatted report file.

---

## Features
- Validates log file input
- Counts total ERROR and Failed entries
- Detects CRITICAL events with line numbers
- Identifies top 5 most common error messages
- Generates a formatted daily summary repo
### Script Code
```bash
#!/bin/bash
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

```

### Sample Output (Using sample app.log)
```pgsql
------- Task 1: Input and Validation -------
app.log validation successful.

------- Task 2: Error Count -------
Total Errors and Failed Found: 16

------- Task 3: Critical Events -------
--- Critical Events ---
Line 17: 2026-02-18 09:07:55 critical CPU overheating
Line 18: 2026-02-18 09:08:44 CRITICAL Disk failure detected
Line 34: 2026-02-18 09:14:22 CRITICAL Kernel panic occurred
Line 35: 2026-02-18 09:15:55 CRITICAL Security breach detected

------- Task 4: Top 5 Error Messages -------
--- Top 5 Error Messages ---
4 Timeout while calling upstream service
3 Database connection failed
3 Authentication failed for user admin
2 Unable to write to log file
2 Payment processing failed

------- Task 5: Summary Report -------
Report generated: log_report_2026-02-19.txt
```


```text
ubuntu@ip-172-31-28-117:~/projects/shell-script/day-20$ curl -O https://raw.githubusercontent.com/logpai/loghub/master/Apache/Apache_2k.log
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  167k  100  167k    0     0  1456k      0 --:--:-- --:--:-- --:--:-- 1466k
ubuntu@ip-172-31-28-117:~/projects/shell-script/day-20$ ls
Apache_2k.log  app.log  app1.log  log_analyzer.sh  log_report_2026-02-19.txt
ubuntu@ip-172-31-28-117:~/projects/shell-script/day-20$ bash log_analyzer.sh ./Apache_2k.log

------- Task 1: Input and Validation -------
Apache_2k.log validation successful.

------- Task 2: Error Count -------
Total Errors and Failed Found: 595

------- Task 3: Critical Events -------
--- Critical Events ---
ubuntu@ip-172-31-28-117:~/projects/shell-script/day-20$
```
---

## Tools and Commands Used
- grep – pattern matching in log files
- awk – text extraction and formatting
- sort – sorting output
- uniq -c – counting duplicate lines
- wc -l – counting total lines
- date – generating report date
- basename – extracting filename from path
- Bash functions – modular script design
- I/O redirection (>) – writing report to file
---

### What I Learned (3 Key Points)
1. Practical Use of Linux Text Processing Tools
- I learned how powerful command-line tools like grep, awk, sort, uniq, and wc are for analyzing large log files efficiently. By combining them in pipelines, I was able to filter, extract, count, and rank log data without needing any external scripting language.

2. Writing Modular and Maintainable Bash Scripts
- Refactoring the script into functions improved readability and maintainability. I learned how argument passing works in Bash functions and how variable scope behaves when using "$@" and global variables.

3. Real-World Log Analysis Concepts
- I understood how log formats differ (application logs vs Apache logs) and how error detection strategies must adapt accordingly. For example:

- Application logs rely on keywords like ERROR, Failed, CRITICAL

- Apache logs use HTTP status codes (4xx, 5xx) to indicate errors

- This reinforced the importance of understanding the structure of log data before analyzing it.

