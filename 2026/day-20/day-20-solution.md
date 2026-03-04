DAY 20 – LOG ANALYZER SOLUTION

---

## 1️⃣ SCRIPT CODE

#!/bin/bash

log_file="sample.log"
report_file="log_report_$(date '+%Y-%m-%d').txt"

total_lines=$(wc -l < "$log_file")
total_errors=$(grep -c "ERROR" "$log_file")

top_errors=$(grep "ERROR" "$log_file" | 
awk -F'ERROR ' '{print $2}' | 
sort | uniq -c | sort -nr | head -5)

critical_events=$(grep -n "CRITICAL" "$log_file")

{
echo "Log Analysis Report"
echo "Date of Analysis: $(date '+%Y-%m-%d')"
echo "Log File: $log_file"
echo "Total Lines Processed: $total_lines"
echo "Total Errors: $total_errors"
echo ""
echo "Top 5 Error Messages:"
echo "$top_errors"
echo ""
echo "Critical Events (with line numbers):"
echo "$critical_events"
} > "$report_file"

echo "Report generated: $report_file"

---

## 2️⃣ SAMPLE OUTPUT

Log Analysis Report
Date of Analysis: 2026-03-04
Log File: sample.log
Total Lines Processed: 250
Total Errors: 18

Top 5 Error Messages:
5 Database connection failed
4 Disk space low
3 Timeout occurred
3 Invalid user input
2 File not found

Critical Events (with line numbers):
45: 2026-03-04 CRITICAL Database crashed
178: 2026-03-04 CRITICAL Memory overflow

---

## 3️⃣ COMMANDS / TOOLS USED

grep   – To filter ERROR and CRITICAL logs
wc     – To count total lines
awk    – To extract error message text
sort   – To arrange output
uniq   – To count duplicate messages
head   – To get top 5 results
date   – To generate report filename
Redirection ( > ) – To write output to file

---

## 4️⃣ WHAT I LEARNED (3 KEY POINTS)

1. How to analyze log files using grep and awk.
2. How to count and rank repeated log messages using sort and uniq.
3. How to generate structured reports automatically using Bash scripting.

---

## End of Day 20 Solution
