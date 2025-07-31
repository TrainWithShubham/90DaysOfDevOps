#!/bin/bash

# Fail on error, undefined variable, or failed pipeline
set -euo pipefail

# Function to check if file exists
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <log_file>"
  exit 1
fi

log_file="$1"

if [[ ! -f "$log_file" ]]; then
  echo "Error: File '$log_file' not found!"
  exit 1
fi

# Set pattern for error messages (case-insensitive)
pattern='ERROR|Failed'

# Count total lines processed
total_lines=$(wc -l < "$log_file")

# Count number of error messages
error_count=$(grep -Ei "$pattern" "$log_file" | wc -l)

# Extract top 5 most frequent error messages
top_errors=$(grep -Ei "$pattern" "$log_file" | sort | uniq -c | sort -nr | head -5)

# Find all critical events with line numbers (case-insensitive)
critical=$(grep -in "CRITICAL" "$log_file")

# Generate timestamp for report
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
report_file="summary_report_$timestamp.txt"

# Write report to file
{
  echo "Log Analysis Report - $timestamp"
  echo "---------------------------------"
  echo "Log File: $log_file"
  echo "Total Lines Processed: $total_lines"
  echo "Total Error Count: $error_count"
  echo
  echo "Top 5 Error Messages:"
  echo "$top_errors"
  echo
  echo "Critical Events (with line numbers):"
  echo "$critical"
} > "$report_file"

echo "✅ Summary report generated: $report_file"

