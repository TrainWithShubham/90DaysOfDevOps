# 📝 Day 06 Task - Linux Fundamentals: Read and Write Text Files

**Author:** Rashid Khan 
**Batch:** #90DaysOfDevOps (2026)

---

## 📌 Overview
File manipulation (creating, writing, appending, and inspecting) is a core foundational skill in DevOps. System configurations, deployment logs, and automation scripts are all plain text files. Mastering CLI file I/O operations enables faster debugging and seamless scripting.

---

## 🛠️ Step-by-Step Hands-on Execution & Output Log

### 1. File Creation & Line Overwriting (`>`)
Created an empty file `notes.txt` and initialized it with the first line using stdout redirection (`>`):
```bash
touch notes.txt
echo "Line 1: Initializing Linux File I/O Practice" > notes.txt
```

### 2. Appending Lines (>>)
Appended new log entries without overwriting existing file content using (`>>`):
```bash
echo "Line 2: Appending logs using standard redirection" >> notes.txt
```

### 3. Simultaneous Output & Append (tee -a)
Used (`tee -a`) to append a new line to the file while simultaneously piping stdout to the terminal:
```bash
echo "Line 3: Writing and displaying live via tee" | tee -a notes.txt
```
#### Terminal Output:
Line 3: Writing and displaying live via tee

### 4. Reading Full File Content (cat)
Inspected the complete contents of (`notes.txt`):
```bash
cat notes.txt
```
#### Terminal Output:
Line 1: Initializing Linux File I/O Practice
Line 2: Appending logs using standard redirection
Line 3: Writing and displaying live via tee

### 5. Inspecting File Parts (head & tail)
Extracted specific top and bottom lines for quick log auditing:
```bash
# Read first 2 lines
head -n 2 notes.txt

# Read last 2 lines
tail -n 2 notes.txt
``` 
#### Terminal Output (head -n 2):
Line 1: Initializing Linux File I/O Practice
Line 2: Appending logs using standard redirection
#### Terminal Output (tail -n 2):
Line 2: Appending logs using standard redirection
Line 3: Writing and displaying live via tee
