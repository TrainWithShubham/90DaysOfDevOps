# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## Task

You are a system administrator responsible for managing a network of servers. Every day, a log file is generated on each server containing important system events and error messages. Your job is to analyze these log files, identify specific events, and generate a summary report.

Write a Bash script (`log_analyzer.sh`) that automates the process of analyzing log files and generating a daily summary report.

---

## Expected Output
- A Bash script: `log_analyzer.sh`
- A generated summary report: `log_report_<date>.txt`
- A markdown file: `day-20-solution.md` documenting your approach

---

## Challenge Tasks

### Task 1: Input and Validation
Your script should:
1. Accept the path to a log file as a command-line argument
2. Exit with a clear error message if no argument is provided
3. Exit with a clear error message if the file doesn't exist

---

### Task 2: Error Count
1. Count the total number of lines containing the keyword `ERROR` or `Failed`
2. Print the total error count to the console

---

### Task 3: Critical Events
1. Search for lines containing the keyword `CRITICAL`
2. Print those lines along with their line number

Example output:
```
--- Critical Events ---
Line 84: 2025-07-29 10:15:23 CRITICAL Disk space below threshold
Line 217: 2025-07-29 14:32:01 CRITICAL Database connection lost
```

---

### Task 4: Top Error Messages
1. Extract all lines containing `ERROR`
2. Identify the **top 5 most common** error messages
3. Display them with their occurrence count, sorted in descending order

Example output:
```
--- Top 5 Error Messages ---
45 Connection timed out
32 File not found
28 Permission denied
15 Disk I/O error
9  Out of memory
```

---

### Task 5: Summary Report
Generate a summary report to a text file named `log_report_<date>.txt` (e.g., `log_report_2026-02-11.txt`). The report should include:
1. Date of analysis
2. Log file name
3. Total lines processed
4. Total error count
5. Top 5 error messages with their occurrence count
6. List of critical events with line numbers

---

### Task 6 (Optional): Archive Processed Logs
Add a feature to:
1. Create an `archive/` directory if it doesn't exist
2. Move the processed log file into `archive/` after analysis
3. Print a confirmation message

---

## Sample Log File

A sample log file is available in this directory: `sample_log.log`

You can also pick real-world log datasets from the [LogHub repository](https://github.com/logpai/loghub) to test your script against production-like logs (e.g., ZooKeeper, HDFS, Apache, Linux syslogs).

---

## Hints
- Count errors: `grep -c "ERROR" logfile.log`
- Print with line numbers: `grep -n "CRITICAL" logfile.log`
- Top occurrences: `grep "ERROR" logfile.log | awk '{$1=$2=$3=""; print}' | sort | uniq -c | sort -rn | head -5`
- Associative arrays: `declare -A error_map`
- Date for filename: `date +%Y-%m-%d`
- Move files: `mv logfile.log archive/`

---

## Documentation

Create `day-20-solution.md` with:
- Your script's code
- Sample output from running against the sample log
- What commands/tools you used (`grep`, `awk`, `sort`, `uniq`, etc.)
- What you learned (3 key points)

---

## Submission
1. Add your scripts and `day-20-solution.md` to `2026/day-20/`
2. Commit and push to your fork

---

## Learn in Public

Share your log analyzer project on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
