# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## 🚀 Project Overview

Today I built a **Log Analyzer** using Bash scripting as part of the **#90DaysOfDevOps** challenge.

The script automates the process of analyzing log files by validating input, detecting errors, identifying critical events, generating a summary report, and archiving processed logs.

## ✨ Features

* Accepts a log file as a command-line argument
* Validates user input and file existence
* Counts total **ERROR** and **Failed** entries
* Displays **CRITICAL** events with line numbers
* Finds the **Top 5 most common error messages**
* Generates a daily report:

  * Date of analysis
  * Log file name
  * Total lines processed
  * Total error count
  * Top 5 error messages
  * Critical events
* Creates an `archive/` directory (if it doesn't exist)
* Moves processed log files into the archive

## 🛠️ Commands & Tools Used

* Bash
* grep
* awk
* sort
* uniq
* head
* wc
* mkdir
* mv
* date

## 📚 What I Learned

* How to automate log analysis using Bash scripting.
* How Linux pipelines (`|`) combine multiple commands to solve real-world problems.
* How DevOps engineers generate reports and archive processed logs for better log management.

This project helped me understand how automation is used in real DevOps environments to reduce manual work and improve operational efficiency.

