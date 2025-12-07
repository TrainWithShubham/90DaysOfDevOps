# Day 10 Task: Log Analyzer and Report Generator

## Challenge Title: Log Analyzer and Report Generator

## Scenario

You are a system administrator responsible for managing a network of servers. Every day, a log file is generated on each server containing important system events and error messages. As part of your daily tasks, you need to analyze these log files, identify specific events, and generate a summary report.

## Task

Write a Bash script that automates the process of analyzing log files and generating a daily summary report. The script should perform the following steps:

1. **Input:** The script should take the path to the log file as a command-line argument.

2. **Error Count:** Analyze the log file and count the number of error messages. An error message can be identified by a specific keyword (e.g., "ERROR" or "Failed"). Print the total error count.

3. **Critical Events:** Search for lines containing the keyword "CRITICAL" and print those lines along with the line number.

4. **Top Error Messages:** Identify the top 5 most common error messages and display them along with their occurrence count.

5. **Summary Report:** Generate a summary report in a separate text file. The report should include:
   - Date of analysis
   - Log file name
   - Total lines processed
   - Total error count
   - Top 5 error messages with their occurrence count
   - List of critical events with line numbers

6. **Optional Enhancement:** Add a feature to automatically archive or move processed log files to a designated directory after analysis.

## Tips

- Use `grep`, `awk`, and other command-line tools to process the log file.
- Utilize arrays or associative arrays to keep track of error messages and their counts.
- Use appropriate error handling to handle cases where the log file doesn't exist or other issues arise.

## Sample Log File

A sample log file named `sample_log.log` has been provided in the same directory as this challenge file. You can use this file to test your script or use [this](https://github.com/logpai/loghub/blob/master/Zookeeper/Zookeeper_2k.log)

## How to Participate

1. Clone this repository or download the challenge file from the provided link.
2. Write your Bash script to complete the log analyzer and report generator task.
3. Use the provided `sample_log.log` or create your own log files for testing.
4. Test your script with various log files and scenarios to ensure accuracy.
5. Submit your completed script by the end of Day 10 of the 90-day DevOps challenge.

## Submission

Submit your completed script by [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) or sending the script file to the challenge organizer.

Good luck and happy scripting!

[← Previous Day](../day09/README.md) | [Next Day →](../day11/README.md)
