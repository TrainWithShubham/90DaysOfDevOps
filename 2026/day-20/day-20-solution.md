# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

**Date: 13/02/2026**

---

## Task 1: Input and Validation

## Task 2: Error Count

## Task 3: Critical Events

## Task 4: Top Error Messages

## Task 5: Summary Report

## Task 6 (Optional): Archive Processed Logs

* Code:

```bash
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
```

* Output:

```shell
ubuntu@ip-172-31-22-48:~/day20$ ./log_analyzer.sh /home/ubuntu/day20/linux_2k.log
Total ERROR/Failed occurrences: 47

--- Critical Events ---
No critical events found.

--- Top 5 Error Messages ---
No ERROR messages found.

Summary report generated: log_report_2026-02-13.txt
Log file moved to archive/
ubuntu@ip-172-31-22-48:~/day20$ vim apache_2k.log
ubuntu@ip-172-31-22-48:~/day20$ ./log_analyzer.sh /home/ubuntu/day20/apache_2k.log
Total ERROR/Failed occurrences: 595

--- Critical Events ---
No critical events found.

--- Top 5 Error Messages ---
      5 [Sun Dec 04 19:36:07 2005] [error] mod_jk child workerEnv in error state 6
      5 [Sun Dec 04 17:01:47 2005] [error] mod_jk child workerEnv in error state 6
      4 [Sun Dec 04 20:16:15 2005] [error] mod_jk child workerEnv in error state 6
      4 [Sun Dec 04 20:11:14 2005] [error] mod_jk child workerEnv in error state 6
      4 [Sun Dec 04 20:05:59 2005] [error] mod_jk child workerEnv in error state 6

Summary report generated: log_report_2026-02-13.txt
Log file moved to archive/
ubuntu@ip-172-31-22-48:~/day20$
```

```shell

ubuntu@ip-172-31-22-48:~/day20$ ./sample_log_generator.sh
Usage: ./sample_log_generator.sh <log_file_path> <num_lines>
ubuntu@ip-172-31-22-48:~/day20$ ./sample_log_generator.sh /home/ubuntu/day20/sample_log.log 2000
Log file created at: /home/ubuntu/day20/sample_log.log with 2000 lines.
ubuntu@ip-172-31-22-48:~/day20$ ls
archive  log_analyzer.sh  log_report_2026-02-13.txt  sample_log.log  sample_log_generator.sh
ubuntu@ip-172-31-22-48:~/day20$ ./log_analyzer.sh /home/ubuntu/day20/sample_log.log
Total ERROR/Failed occurrences: 396

--- Critical Events ---
12:2026-02-13 12:39:59 [CRITICAL]  - 5481
13:2026-02-13 12:39:59 [CRITICAL]  - 16942
21:2026-02-13 12:39:59 [CRITICAL]  - 21304
23:2026-02-13 12:39:59 [CRITICAL]  - 18797
29:2026-02-13 12:39:59 [CRITICAL]  - 29584
31:2026-02-13 12:39:59 [CRITICAL]  - 32110
33:2026-02-13 12:39:59 [CRITICAL]  - 11797
41:2026-02-13 12:39:59 [CRITICAL]  - 20331
43:2026-02-13 12:39:59 [CRITICAL]  - 7622
1985:2026-02-13 12:40:02 [CRITICAL]  - 9915
1988:2026-02-13 12:40:02 [CRITICAL]  - 16882
1989:2026-02-13 12:40:02 [CRITICAL]  - 910
1990:2026-02-13 12:40:02 [CRITICAL]  - 28876
2000:2026-02-13 12:40:02 [CRITICAL]  - 6817

--- Top 5 Error Messages ---
      2 [ERROR] Invalid input - 31046
      1 [ERROR] Segmentation fault - 9580
      1 [ERROR] Segmentation fault - 9222
      1 [ERROR] Segmentation fault - 8188
      1 [ERROR] Segmentation fault - 7381

Summary report generated: log_report_2026-02-13.txt
Log file moved to archive/
ubuntu@ip-172-31-22-48:~/day20$ ls
archive  log_analyzer.sh  log_report_2026-02-13.txt  sample_log_generator.sh
ubuntu@ip-172-31-22-48:~/day20$ cd archive/
ubuntu@ip-172-31-22-48:~/day20/archive$ ls
apache_2k.log  linux_2k.log  log.txt  log_report.txt  log_report_2026-02-13.txt  sample_log.log
```

---

# What commands/tools used

grep "ERROR" logfile.log 
| awk '{$1=$2=$3=""; sub(/^   /,""); print}' 
| sort 
| uniq -c 
| sort -rn 
| head -5

Tools used:

grep

awk

sort

uniq

wc

## sed

# 3 Key Learnings

* Command Pipelines Are Powerful
  Combining grep, awk, sort, and uniq enables efficient log aggregation without complex scripting.

* Input Validation Is Critical
  Always validate arguments and file existence before processing.

* Structured Reporting Improves Observability
  Automating daily summaries improves operational visibility and reduces manual inspection effort.

---

