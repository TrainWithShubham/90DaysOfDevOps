# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## Task 1: Input and Validation
Your script should:

- Accept the path to a log file as a command-line argument
- Exit with a clear error message if no argument is provided
- Exit with a clear error message if the file doesn't exist
- Task 2: Error Count

<img width="446" height="495" alt="image" src="https://github.com/user-attachments/assets/5b97c4bf-1870-4359-9b0d-775cf781af29" />

## Task 2: Error Count
- Count the total number of lines containing the keyword ERROR or Failed
- Print the total error count to the console

  <img width="593" height="119" alt="image" src="https://github.com/user-attachments/assets/912d9bcf-2616-4b1f-83ff-7e2b721b1969" />

## Task 3: Critical Events
- Search for lines containing the keyword CRITICAL
- Print those lines along with their line number

<img width="788" height="325" alt="image" src="https://github.com/user-attachments/assets/1aa3ee15-2ec7-47d3-b8e8-49085dc68d92" />

## Task 4: Top Error Messages
- Extract all lines containing ERROR
- Identify the top 5 most common error messages
- Display them with their occurrence count, sorted in descending order
<img width="488" height="380" alt="image" src="https://github.com/user-attachments/assets/d381df05-09a1-42d1-a148-c249d2efaca9" />

## Task 5: Summary Report
Generate a summary report to a text file named log_report_<date>.txt (e.g., log_report_2026-02-11.txt). The report should include:
Date of analysis
Log file name
Total lines processed
Total error count
Top 5 error messages with their occurrence count
List of critical events with line numbers

<img width="1031" height="588" alt="image" src="https://github.com/user-attachments/assets/4e3d262d-e356-4daf-9673-eaf0a6fa9753" />



## OUTPUT
<img width="1658" height="304" alt="image" src="https://github.com/user-attachments/assets/7e6c3f56-7476-45bb-b8b0-4951a64091ff" />

## What commands/tools you used (grep, awk, sort, uniq, etc.)
Ans : grep

## What you learned (3 key points)
- use of grep
- generate summary report
- Error Counting



