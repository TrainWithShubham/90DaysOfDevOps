#!/bin/bash

# Check if file path is provided
if [ -z "$1" ]; then
  echo "❌ Usage: $0 <log_file>"
  exit 1
fi

log_file="$1"

if [ ! -f "$log_file" ]; then
  echo "❌ File not found: $log_file"
  exit 1
fi

# Variables
report="log_summary_$(date '+%Y-%m-%d').txt"
total_lines=$(wc -l < "$log_file")
error_count=$(grep -E "ERROR|Failed" "$log_file" | wc -l)
top_errors=$(grep -E "ERROR|Failed" "$log_file" | sort | uniq -c | sort -nr | head -5)
critical=$(grep -n "CRITICAL" "$log_file")
log_name=$(basename "$log_file")

# Write report
{
  echo "📝 Log Analysis Report"
  echo "Date: $(date)"
  echo "Log File: $log_name"
  echo "Total Lines: $total_lines"
  echo "Total Errors: $error_count"
  echo
  echo "🔥 Top 5 Error Messages:"
  echo "$top_errors"
  echo
  echo "🚨 Critical Events (with line numbers):"
  echo "$critical"
} > "$report"

echo "✅ Report generated: $report"
