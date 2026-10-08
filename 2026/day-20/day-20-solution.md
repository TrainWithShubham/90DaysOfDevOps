# Day 20 – Log Analyzer and Report Generator

## Introduction

In this lab, I created a Bash script to analyze log files and generate a report automatically.

I used a real Apache log file for testing.
The script checks errors, critical events, and top repeated error messages.

This lab helped me understand how DevOps engineers analyze server logs for troubleshooting and monitoring.

---

# Task 1 – Input and Validation

I created `log_analyzer.sh`.

The script:

- accepts log file as input
- checks if argument is provided
- checks if file exists
- shows error message if file is missing

## Commands Used

grep

if condition

exit

echo

---

# Task 2 – Error Count

The script counts total error messages from the log file.

## Command Used

grep -ic "error"

## What I Learned

- how to search logs
- how to count matching lines
- basic log monitoring

---

# Task 3 – Critical Events

The script searches for critical events and prints line numbers.

## Command Used

grep -in "critical"

## What I Learned

- how to find important events
- how line numbers help troubleshooting

---

# Task 4 – Top 5 Error Messages

The script displays the most repeated error messages.

## Commands Used

grep

awk

sort

uniq -c

head -5

## What I Learned

- how repeated errors are identified
- how logs are summarized
- basic production-style log analysis

---

# Task 5 – Summary Report

The script generates a report file automatically.

Generated file:

log_report_2026-06-05.txt

The report includes:

- date
- log file name
- total lines
- total error count
- top 5 errors
- critical events

## What I Learned

- report generation
- file redirection
- automation using Bash scripts

---

# Sample Output

Total Error Count: 595

Top Errors:

368 mod_jk child workerEnv in error state 6

101 mod_jk child workerEnv in error state 7

44 mod_jk child workerEnv in error state 8

---

# Key Learnings

1. Bash scripting helps automate log analysis.

2. grep, awk, sort, and uniq are useful for troubleshooting.

3. Log analysis is important in DevOps and system monitoring.

---

# Conclusion

This lab improved my Linux scripting and troubleshooting skills.
I learned how to analyze real log files and generate automated reports using Bash scripting.
