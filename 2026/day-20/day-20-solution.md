# **Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator**

## **Task**

Today task was to build a real-world log analyzer script.

Instead of just running grep commands manually, I automated:

* Error counting  
* Critical event extraction  
* Top 5 error messages  
* Summary report generation  
* Archiving processed logs

This felt like actual system administrator work.

# **Task 1 – Input and Validation**

## **Script (Validation Section)**

\#\!/bin/bash  
set \-euo pipefail

if \[ $\# \-ne 1 \]  
then  
        echo "Enter the logfile path while running the command as the argument"  
        exit 1  
fi

LOG\_FILE="$1"

if \[ \! \-f "$LOG\_FILE" \]  
then  
        echo "ERROR: Log file does not exist: $LOG\_FILE"  
        exit 1  
fi

## **What I Learned**

* Always validate argument count using $\#.  
* With strict mode enabled, wrong inputs can break script immediately.  
* File existence must be checked before processing.

# **Task 2 – Error Count**

## **Code**

ERROR\_COUNT=$(grep \-cEi "ERROR|Failed" "$LOG\_FILE")

## **What It Does**

* Counts lines containing ERROR or Failed  
* Case-insensitive matching  
* Stores result in ERROR\_COUNT

## **What I Learned**

* Use \-E for multiple patterns.  
* Use \-i for case-insensitive matching.  
* Use command substitution $(...) properly.

# **Task 3 – Critical Events**

## **Code**

grep \-ni "CRITICAL" "$LOG\_FILE" | awk \-F: '{print "Line " $1 ": " substr($0, index($0,$2))}'

## **Output Format Example**

Line 84: 2025-07-29 10:15:23 CRITICAL Disk space below threshold

## **What I Learned**

* grep \-n prints line numbers.  
* Using awk \-F: helps separate line number and log content.  
* substr() preserves full log message safely.

# **Task 4 – Top 5 Error Messages**

## **Code**

grep \-i "ERROR" "$LOG\_FILE" | \\  
awk '{$1=$2=$3=""; sub(/ \- \[0-9\]+$/, ""); print}' | \\  
sort | uniq \-c | sort \-rn | head \-5

## **What It Does**

1. Extract ERROR lines  
2. Remove first 3 fields (date, time, level)  
3. Remove trailing numeric IDs  
4. Count occurrences  
5. Sort descending  
6. Show top 5

## **What I Learned**

* Always sort before uniq \-c.  
* Removing unwanted fields makes counting accurate.  
* Small regex mistakes can affect grouping of errors.

# **Task 5 – Summary Report Generation**

## **Code**

TOTAL\_LINES=$(wc \-l \< "$LOG\_FILE")  
REPORT\_PATH="/consdata2/reports"  
if \[ \! \-d "$REPORT\_PATH" \]  
then  
        mkdir \-p "$REPORT\_PATH"  
fi

REPORT\_FILE="$REPORT\_PATH/log\_report\_$(date \+%Y-%m-%d).txt"

\> "$REPORT\_FILE"

echo "----------------------Log Analysis-----------------------" \>\> "$REPORT\_FILE"  
echo "" \>\> "$REPORT\_FILE"  
echo "Date of Analysis: $(date \+%Y-%m-%d)" \>\> "$REPORT\_FILE"  
echo "Log File: $LOG\_FILE" \>\> "$REPORT\_FILE"  
echo "Total Lines processed: $TOTAL\_LINES" \>\> "$REPORT\_FILE"  
echo "Total Error Count: $ERROR\_COUNT" \>\> "$REPORT\_FILE"  
echo "" \>\> "$REPORT\_FILE"

echo "------------------- TOP 5 ERROR MESSAGES \-------------------" \>\> "$REPORT\_FILE"  
grep \-i "ERROR" "$LOG\_FILE" | awk '{$1=$2=$3=""; sub(/ \- \[0-9\]+$/, ""); print}' | sort | uniq \-c | sort \-rn | head \-5 \>\> "$REPORT\_FILE"  
echo "" \>\> "$REPORT\_FILE"

echo "------------------- CRITICAL-EVENTS-------------------" \>\> "$REPORT\_FILE"  
grep \-ni "CRITICAL" "$LOG\_FILE" | awk \-F: '{print "Line " $1 ": " substr($0, index($0,$2))}' \>\> "$REPORT\_FILE"

## **What I Learned**

* Always overwrite report first using \>  
* Always quote file paths.  
* Use wc \-l \< file instead of cat file | wc \-l.  
* Create directories safely using mkdir \-p.

# **Task 6 – Archive Processed Logs**

## **Code**

ARCHIVE\_DIR="/consdata2/logs/archive"

if \[ \! \-d "$ARCHIVE\_DIR" \]  
then  
        mkdir \-p "$ARCHIVE\_DIR"  
fi

mv "$LOG\_FILE" "$ARCHIVE\_DIR/"

## **What I Learned**

* Directory must exist before moving files.  
* Variable names must be consistent (typos break script with set \-u).  
* Always quote variables in file operations.

# **Complete Script – log\_analyzer.sh**

(Full final version)

\#\!/bin/bash  
set \-euo pipefail

if \[ $\# \-ne 1 \]  
then  
        echo "Enter the logfile path while running the command as the argument"  
        exit 1  
fi

LOG\_FILE="$1"

if \[ \! \-f "$LOG\_FILE" \]  
then  
        echo "ERROR: Log file does not exist: $LOG\_FILE"  
        exit 1  
fi

ERROR\_COUNT=$(grep \-cEi "ERROR|Failed" "$LOG\_FILE")  
TOTAL\_LINES=$(wc \-l \< "$LOG\_FILE")

REPORT\_PATH="/consdata2/reports"  
mkdir \-p "$REPORT\_PATH"

REPORT\_FILE="$REPORT\_PATH/log\_report\_$(date \+%Y-%m-%d).txt"

\> "$REPORT\_FILE"

echo "----------------------Log Analysis-----------------------" \>\> "$REPORT\_FILE"  
echo "" \>\> "$REPORT\_FILE"  
echo "Date of Analysis: $(date \+%Y-%m-%d)" \>\> "$REPORT\_FILE"  
echo "Log File: $LOG\_FILE" \>\> "$REPORT\_FILE"  
echo "Total Lines processed: $TOTAL\_LINES" \>\> "$REPORT\_FILE"  
echo "Total Error Count: $ERROR\_COUNT" \>\> "$REPORT\_FILE"  
echo "" \>\> "$REPORT\_FILE"

echo "------------------- TOP 5 ERROR MESSAGES \-------------------" \>\> "$REPORT\_FILE"  
grep \-i "ERROR" "$LOG\_FILE" | awk '{$1=$2=$3=""; sub(/ \- \[0-9\]+$/, ""); print}' | sort | uniq \-c | sort \-rn | head \-5 \>\> "$REPORT\_FILE"  
echo "" \>\> "$REPORT\_FILE"

echo "------------------- CRITICAL-EVENTS-------------------" \>\> "$REPORT\_FILE"  
grep \-ni "CRITICAL" "$LOG\_FILE" | awk \-F: '{print "Line " $1 ": " substr($0, index($0,$2))}' \>\> "$REPORT\_FILE"

ARCHIVE\_DIR="/consdata2/logs/archive"  
mkdir \-p "$ARCHIVE\_DIR"  
mv "$LOG\_FILE" "$ARCHIVE\_DIR/"

# **Key Learnings (3 Points)**

1. Strict mode requires careful validation and correct variable usage.  
2. Proper quoting prevents unexpected script failures.  
3. Log analysis can be automated effectively using grep, awk, sort and uniq.

# **Git Steps**

mkdir \-p 2026/day-20  
git add .  
git commit \-m "Day 20 \- Log Analyzer and Report Generator"  
git pus

# **Learn in Public**

Today I built a log analyzer script that:

* Counts errors  
* Identifies critical events  
* Finds top recurring issues  
* Generates a structured report  
* Archives processed logs

This felt like real-world DevOps automation.

