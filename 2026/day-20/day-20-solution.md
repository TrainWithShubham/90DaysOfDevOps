
# Day 20 - Bash Scripting Challenge: Log Analyzer and Report Generator

## Project Overview
For this challenge, I built an automated log analyzer script (`log_analyzer.sh`). The script validates log file inputs, extracts critical system events, identifies and ranks the top 5 most frequent error messages, generates a formatted text report, and automatically archives the processed log file.

## The Script (`log_analyzer.sh`)
```bash
#!/bin/bash

# Task 1: Input and Validation
if [[ "$#" -eq 0 ]]; then
    echo "Error: No input provided. Please provide a log file."
    exit 1
fi

if [[ ! -f "$1" ]]; then
    echo "Error: Directory is missing or unable to find the file."
    exit 1
fi

# Set up variables for the report
ERROR_COUNT=$(grep -E "ERROR|Failed" "$1" | wc -l)
REPORT_DATE=$(date +%Y-%m-%d)
REPORT_FILE="log_report_$REPORT_DATE.txt"
TOTAL_LINES=$(wc -l < "$1")

# Task 5: Generate Summary Report
echo "=== Log Analysis Report ===" > "$REPORT_FILE"
echo "Date of analysis: $REPORT_DATE" >> "$REPORT_FILE"
echo "Log file name: $1" >> "$REPORT_FILE"
echo "Total lines processed: $TOTAL_LINES" >> "$REPORT_FILE"

# Task 2: Error Count
echo "Total Error/Failed count: $ERROR_COUNT" >> "$REPORT_FILE"

# Task 3: Critical Events
echo "=== Critical Events ===" >> "$REPORT_FILE"
grep -n "CRITICAL" "$1" >> "$REPORT_FILE"

# Task 4: Top 5 Error Messages
echo "=== Top 5 Error Messages ===" >> "$REPORT_FILE"
grep "ERROR" "$1" | awk '{ $1=$2=$3=""; print }' | sort | uniq -c | sort -rn | head -5 >> "$REPORT_FILE"

echo "Report successfully generated: $REPORT_FILE"

# Task 6: Archive Processed Logs
mkdir -p archive/
mv "$1" archive/
echo "Successfully moved the $1 file to archive folder."

```

## Tools & Commands Used

* **`grep -E`**: Used extended regular expressions to search for multiple keywords (`ERROR|Failed`) simultaneously.
* **`grep -n`**: Extracted exact line numbers for critical events to make debugging easier.
* **`awk`**: Blanked out the timestamp and log-level columns (`$1=$2=$3=""`) to isolate just the error messages.
* **`sort | uniq -c | sort -rn | head -5`**: A data pipeline that alphabetizes the errors, squashes identical lines together while counting them, sorts them in reverse numerical order, and truncates the output to the top 5 results.

## 3 Key Learnings

1. **Pipeline Architecture:** Stringing terminal commands together using pipes (`|`) is incredibly powerful. You can transform thousands of lines of raw server data into ranked insights using just one line of code.
2. **Output Redirection:** Utilizing `>` creates or overwrites a file, while `>>` safely appends data to the bottom. Combining these allows for dynamic, multi-step report generation.
3. **Execution Context:** Command-line arguments like `$1` only exist within the execution context of the script itself, emphasizing the difference between interactive shell commands and automated scripting.

