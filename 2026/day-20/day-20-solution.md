# Day 20 – Log Analyzer and Report Generator

## Overview

A Bash script that ingests a server log file, extracts key metrics with `awk`, `grep`, `sort`, and `uniq`, then writes a formatted summary report. An optional archive feature moves the processed log into a timestamped `archive/` directory.

---

## Script: `log_analyzer.sh`

```bash
#!/usr/bin/env bash
# =============================================================================
# log_analyzer.sh – Day 20 Bash Scripting Challenge
# Analyzes a log file and generates a daily summary report.
# =============================================================================

set -euo pipefail

# ─── Colour helpers ──────────────────────────────────────────────────────────
RED='\033[0;31m'; YELLOW='\033[1;33m'; GREEN='\033[0;32m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

# ─── Task 1 : Input & Validation ─────────────────────────────────────────────
if [[ $# -lt 1 ]]; then
    echo -e "${RED}[ERROR]${RESET} No log file provided."
    echo "Usage: $0 <path-to-log-file>"
    exit 1
fi

LOG_FILE="$1"

if [[ ! -f "$LOG_FILE" ]]; then
    echo -e "${RED}[ERROR]${RESET} File not found: '$LOG_FILE'"
    exit 1
fi

REPORT_DATE=$(date +%Y-%m-%d)
REPORT_FILE="log_report_${REPORT_DATE}.txt"

echo -e "${BOLD}${CYAN}========================================${RESET}"
echo -e "${BOLD}${CYAN}   Log Analyzer – $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
echo -e "${BOLD}${CYAN}========================================${RESET}"
echo ""

# ─── Task 2 : Error Count ────────────────────────────────────────────────────
# awk counts lines that contain ERROR or Failed (case-sensitive)
TOTAL_ERRORS=$(awk '/ERROR|Failed/{count++} END{print count+0}' "$LOG_FILE")
TOTAL_LINES=$(awk 'END{print NR}' "$LOG_FILE")

echo -e "${BOLD}Total lines processed :${RESET} $TOTAL_LINES"
echo -e "${BOLD}Total errors (ERROR|Failed) :${RESET} ${RED}${TOTAL_ERRORS}${RESET}"
echo ""

# ─── Task 3 : Critical Events ────────────────────────────────────────────────
echo -e "${YELLOW}--- Critical Events ---${RESET}"

# awk prints line number + content for every CRITICAL line
CRITICAL_LINES=$(awk '/CRITICAL/{printf "Line %d: %s\n", NR, $0}' "$LOG_FILE")

if [[ -z "$CRITICAL_LINES" ]]; then
    echo "  (none found)"
else
    echo "$CRITICAL_LINES"
fi
echo ""

# ─── Task 4 : Top 5 Error Messages ──────────────────────────────────────────
echo -e "${YELLOW}--- Top 5 Error Messages ---${RESET}"

# awk extracts the "message" portion (fields 4 onward) from ERROR lines,
# then sort | uniq -c | sort -rn ranks by frequency.
TOP5=$(awk '/ERROR/{
    msg = ""
    for (i=4; i<=NF; i++) msg = (msg == "" ? $i : msg " " $i)
    print msg
}' "$LOG_FILE" \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -5 \
    | awk '{cnt=$1; $1=""; sub(/^ /,""); printf "%-5s %s\n", cnt, $0}')

if [[ -z "$TOP5" ]]; then
    echo "  (no ERROR lines found)"
else
    echo "$TOP5"
fi
echo ""

# ─── Task 5 : Generate Summary Report ───────────────────────────────────────
{
    echo "============================================"
    echo "  LOG ANALYSIS REPORT"
    echo "  Generated : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "============================================"
    echo ""
    echo "Log File      : $LOG_FILE"
    echo "Analysis Date : $REPORT_DATE"
    echo "Total Lines   : $TOTAL_LINES"
    echo "Total Errors  : $TOTAL_ERRORS"
    echo ""
    echo "--------------------------------------------"
    echo "Top 5 Error Messages"
    echo "--------------------------------------------"
    if [[ -z "$TOP5" ]]; then
        echo "  (no ERROR lines found)"
    else
        echo "$TOP5"
    fi
    echo ""
    echo "--------------------------------------------"
    echo "Critical Events"
    echo "--------------------------------------------"
    if [[ -z "$CRITICAL_LINES" ]]; then
        echo "  (none found)"
    else
        echo "$CRITICAL_LINES"
    fi
    echo ""
    echo "============================================"
    echo "  END OF REPORT"
    echo "============================================"
} > "$REPORT_FILE"

echo -e "${GREEN}[OK]${RESET} Report saved → ${BOLD}${REPORT_FILE}${RESET}"
echo ""

# ─── Task 6 (Optional) : Archive Processed Log ───────────────────────────────
ARCHIVE_DIR="archive"

read -r -p "Archive '$LOG_FILE' to ./${ARCHIVE_DIR}/? [y/N] " ARCHIVE_CHOICE
case "${ARCHIVE_CHOICE,,}" in
    y|yes)
        mkdir -p "$ARCHIVE_DIR"
        mv "$LOG_FILE" "$ARCHIVE_DIR/"
        echo -e "${GREEN}[OK]${RESET} Log archived → ${BOLD}${ARCHIVE_DIR}/$(basename "$LOG_FILE")${RESET}"
        ;;
    *)
        echo "Skipping archive."
        ;;
esac

echo ""
echo -e "${BOLD}${CYAN}Analysis complete.${RESET}"
```

---

## Sample Output

Running against `sample_log.log` (50 lines, mixed INFO / ERROR / CRITICAL / Failed):

```
========================================
   Log Analyzer – 2026-02-28 09:54:16
========================================

Total lines processed : 50
Total errors (ERROR|Failed) : 33

--- Critical Events ---
Line 27: 2025-07-29 09:08:27 CRITICAL Disk space below threshold (usage: 92%)
Line 36: 2025-07-29 09:50:55 CRITICAL Database connection lost (host: db-primary:5432)
Line 47: 2025-07-29 10:45:52 CRITICAL CPU temperature exceeded safe limit (98°C)

--- Top 5 Error Messages ---
7     Connection timed out for host 192.168.1.10
3     File not found: /var/data/config.yml
3     Disk I/O error on /dev/sda1
2     File not found: /tmp/session_cache
2     Connection timed out for host 10.0.0.5

[OK] Report saved → log_report_2026-02-28.txt
```

### Generated report (`log_report_2026-02-28.txt`)

```
============================================
  LOG ANALYSIS REPORT
  Generated : 2026-02-28 09:54:16
============================================

Log File      : sample_log.log
Analysis Date : 2026-02-28
Total Lines   : 50
Total Errors  : 33

--------------------------------------------
Top 5 Error Messages
--------------------------------------------
7     Connection timed out for host 192.168.1.10
3     File not found: /var/data/config.yml
3     Disk I/O error on /dev/sda1
2     File not found: /tmp/session_cache
2     Connection timed out for host 10.0.0.5

--------------------------------------------
Critical Events
--------------------------------------------
Line 27: 2025-07-29 09:08:27 CRITICAL Disk space below threshold (usage: 92%)
Line 36: 2025-07-29 09:50:55 CRITICAL Database connection lost (host: db-primary:5432)
Line 47: 2025-07-29 10:45:52 CRITICAL CPU temperature exceeded safe limit (98°C)

============================================
  END OF REPORT
============================================
```

---

## Tools & Commands Used

| Tool | Purpose |
|------|---------|
| `awk` | Count lines, extract fields, print with line numbers, format output |
| `sort` | Alphabetically sort extracted messages before counting |
| `uniq -c` | Count consecutive duplicate lines |
| `sort -rn` | Sort numerically in descending order (highest count first) |
| `head -5` | Limit output to top 5 results |
| `date` | Generate the report filename and timestamp |
| `mkdir -p` | Create archive directory safely (no error if exists) |
| `mv` | Move the processed log into the archive |

### Key `awk` patterns used

```bash
# Count matching lines
awk '/ERROR|Failed/{count++} END{print count+0}' file

# Count all lines
awk 'END{print NR}' file

# Print line number + full line for matches
awk '/CRITICAL/{printf "Line %d: %s\n", NR, $0}' file

# Extract message (fields 4 onward) from ERROR lines
awk '/ERROR/{
    msg = ""
    for (i=4; i<=NF; i++) msg = (msg == "" ? $i : msg " " $i)
    print msg
}' file

# Reformat uniq -c output (left-align count, strip leading space)
awk '{cnt=$1; $1=""; sub(/^ /,""); printf "%-5s %s\n", cnt, $0}'
```

---

## 3 Key Learnings

1. **`awk` is a complete text-processing language inside Bash.** Using `NR` for line numbers, `NF` for field counts, and looping over `$i` fields makes it possible to replace many `grep | cut | sed` pipelines with a single, readable `awk` block.

2. **`sort | uniq -c | sort -rn` is the canonical frequency-ranking pipeline.** The first `sort` is required to bring identical lines together (since `uniq` only collapses *adjacent* duplicates); `uniq -c` prefixes each unique line with its count; `sort -rn` then orders by count descending.

3. **`set -euo pipefail` makes scripts production-safe.** `-e` exits on any command failure, `-u` treats unset variables as errors, and `-o pipefail` catches failures in the middle of a pipeline — together they prevent silent bugs where a script happily continues after a critical step fails.

---

## Files

```
2026/day-20/
├── log_analyzer.sh       # Main script
├── sample_log.log        # Sample log for testing
├── log_report_YYYY-MM-DD.txt  # Generated on each run
└── day-20-solution.md    # This document
```

---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

## ⚙️ Script Code — `log_analyzer.sh` using grep

```bash
#!/bin/bash

# ---- Input Validation ----

if [ $# -eq 0 ]; then
  echo "Error: Please provide a log file path."
  echo "Usage: $0 <log_file>"
  exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
  echo "Error: File does not exist: $LOG_FILE"
  exit 1
fi

DATE=$(date +%Y-%m-%d)
REPORT="log_report_${DATE}.txt"

echo "Analyzing log file: $LOG_FILE"

# ---- Error Count ----

ERROR_COUNT=$(grep -E "ERROR|Failed" "$LOG_FILE" | wc -l)

echo "Total Errors: $ERROR_COUNT"

# ---- Critical Events ----

echo
echo "--- Critical Events ---"

CRITICAL_OUTPUT=$(grep -n "CRITICAL" "$LOG_FILE")

if [ -z "$CRITICAL_OUTPUT" ]; then
  echo "No critical events found."
else
  echo "$CRITICAL_OUTPUT" | sed 's/^/Line /'
fi

# ---- Top 5 Error Messages ----

echo
echo "--- Top 5 Error Messages ---"

TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" \
  | awk '{$1=$2=$3=""; sub(/^ +/, ""); print}' \
  | sort \
  | uniq -c \
  | sort -rn \
  | head -5)

echo "$TOP_ERRORS"

# ---- Generate Report ----

TOTAL_LINES=$(wc -l < "$LOG_FILE")

{
  echo "===== Log Analysis Report ====="
  echo "Date: $DATE"
  echo "Log File: $LOG_FILE"
  echo "Total Lines: $TOTAL_LINES"
  echo "Total Errors: $ERROR_COUNT"
  echo

  echo "--- Top 5 Error Messages ---"
  echo "$TOP_ERRORS"
  echo

  echo "--- Critical Events ---"
  if [ -z "$CRITICAL_OUTPUT" ]; then
    echo "No critical events found."
  else
    echo "$CRITICAL_OUTPUT" | sed 's/^/Line /'
  fi

} > "$REPORT"

echo
echo "Report generated: $REPORT"

# ---- Archive Processed Logs (Optional) ----

ARCHIVE_DIR="archive"
mkdir -p "$ARCHIVE_DIR"
mv "$LOG_FILE" "$ARCHIVE_DIR/"

echo "Log file moved to $ARCHIVE_DIR/"
```

---

## ▶️ How to Run

```bash
chmod +x log_analyzer.sh
./log_analyzer.sh sample.logs
```

---

## 🖥️ Sample Console Output

```
Analyzing log file: sample.logs

Total Errors: 23

--- Critical Events ---
Line 1: 2026-02-27 15:40:34 [CRITICAL] - 3479
Line 3: 2026-02-27 15:40:34 [CRITICAL] - 27031
...

--- Top 5 Error Messages ---
8 Disk full
5 Segmentation fault
4 Out of memory
3 Invalid input
2 Failed to connect

Report generated: log_report_2026-02-27.txt
Log file moved to archive/
```

---

## 📊 Generated Report Sample

**File:** `log_report_2026-02-27.txt`

```
===== Log Analysis Report =====
Date: 2026-02-27
Log File: sample.logs
Total Lines: 100
Total Errors: 23

--- Top 5 Error Messages ---
8 Disk full
5 Segmentation fault
4 Out of memory
3 Invalid input
2 Failed to connect

--- Critical Events ---
Line 1: 2026-02-27 15:40:34 [CRITICAL] - 3479
Line 3: 2026-02-27 15:40:34 [CRITICAL] - 27031
...
```

---

## 🧰 Tools & Commands Used

* **grep** → Pattern searching
* **awk** → Text processing
* **sort** → Sorting output
* **uniq -c** → Counting occurrences
* **wc -l** → Line counting
* **sed** → Formatting output
* **date** → Dynamic report filename
* **mkdir / mv** → File management
