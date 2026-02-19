# Day 16 – Shell Scripting Basics

**Date:** 2026-02-19  
**Author:** Rameez Ahmed  
**Challenge:** Start your shell scripting journey — learn the fundamentals every script needs  
**Reference:** [90DaysOfDevOps](https://github.com/LondheShubham153/90DaysOfDevOps)

---

## 📋 Overview

**Shell scripting** is the art of automating tasks on Linux by writing sequences of commands in a text file that the shell interpreter executes line-by-line. For a DevOps Engineer, shell scripts are the **first tool in your automation toolbox** — they glue together system commands, enable repeatable workflows, and form the backbone of CI/CD pipelines, provisioning scripts, and monitoring systems.

> **🎯 Why Shell Scripting Matters for DevOps:**  
> Every server interaction — from deploying applications to rotating logs — can be captured in a script and executed consistently across hundreds of machines. The difference between an operator and an engineer is **automation**, and that starts here.

---

## 🏗️ How a Shell Script Executes

Understanding the execution flow helps you debug scripts effectively:

```
┌──────────────────────────────────────────────────────────────────┐
│                     SHELL SCRIPT EXECUTION FLOW                  │
└──────────────────────────────────────────────────────────────────┘

  📝 script.sh                         🖥️ Terminal
  ┌─────────────────────┐
  │ #!/bin/bash          │ ──── ① Shebang tells the OS which
  │                      │        interpreter to use (/bin/bash)
  │ NAME="Rameez"        │ ──── ② Variables are stored in memory
  │                      │
  │ read -p "Input: " X  │ ──── ③ read pauses and waits for
  │                      │        user input from stdin
  │ if [ "$X" = "y" ];   │ ──── ④ Conditions are evaluated
  │   then               │        (exit code 0 = true)
  │     echo "Yes!"      │ ──── ⑤ Commands run sequentially
  │ fi                   │        top to bottom
  └─────────────────────┘

         │
         ▼
  ┌─────────────────────────────────────────────┐
  │              EXECUTION SEQUENCE              │
  │                                             │
  │  Step 1: OS reads shebang → launches bash   │
  │  Step 2: bash reads file line-by-line        │
  │  Step 3: Each line is parsed & executed      │
  │  Step 4: Variables are replaced (expanded)   │
  │  Step 5: Output goes to stdout/stderr        │
  │  Step 6: Exit code returned (0 = success)    │
  └─────────────────────────────────────────────┘
```

---

## 🔑 Core Concepts at a Glance

| Concept | What It Does | Syntax Example |
|---------|-------------|----------------|
| **Shebang** | Tells the OS which interpreter to use | `#!/bin/bash` |
| **Variables** | Store and reuse values | `NAME="Rameez"` |
| **echo** | Print text to standard output | `echo "Hello, $NAME"` |
| **read** | Accept user input from keyboard | `read -p "Enter: " VAR` |
| **if-else** | Conditional branching logic | `if [ cond ]; then ... fi` |
| **Exit Codes** | `0` = success, non-zero = failure | `echo $?` to check |
| **Comments** | Lines starting with `#` are ignored | `# This is a comment` |
| **chmod** | Change file permissions to make executable | `chmod +x script.sh` |

---

## 🛠️ Challenge Tasks

### Task 1: Your First Script — `hello.sh`

The simplest possible script that teaches the two most fundamental concepts: the **shebang** and **echo**.

#### 📄 Script Code

```bash
#!/bin/bash
# Day 16 - Task 1: Your First Script
# This script prints a greeting message to the terminal

echo "Hello, DevOps!"
```

#### ▶️ How to Run

```bash
# Step 1: Make the script executable
chmod +x hello.sh

# Step 2: Run the script
./hello.sh
```

#### 📤 Output

```
Hello, DevOps!
```

#### 🔬 Deep Dive: The Shebang (`#!/bin/bash`)

The **shebang** (also called **hashbang**) is the very first line of a script. It tells the operating system which interpreter should execute the file.

```
  #!/bin/bash
  ││ └──────── Path to the interpreter binary
  │└────────── ! (bang)
  └─────────── # (hash/sharp)
```

**What happens if you remove the shebang?**

| Scenario | Behavior |
|----------|----------|
| Running with `./hello.sh` | The system uses the **current shell** (could be `bash`, `zsh`, `sh`, `dash`, etc.) — this may produce unexpected results if the script uses bash-specific features |
| Running with `bash hello.sh` | Works fine because you explicitly told the OS to use `bash` |
| On a server with `sh` as default | Bash-specific syntax like `[[ ]]` or `(( ))` will **fail** |

> **💡 Best Practice:** **Always include the shebang.** It makes your scripts portable and self-documenting. In production, `#!/bin/bash` is the standard, but for maximum portability use `#!/usr/bin/env bash`.

---

### Task 2: Variables — `variables.sh`

Variables are the building blocks of any script — they let you store data, pass configuration, and build dynamic commands.

#### 📄 Script Code

```bash
#!/bin/bash
# Day 16 - Task 2: Variables
# Demonstrates variable assignment and the difference between single and double quotes

NAME="Rameez"
ROLE="DevOps Engineer"

# Double quotes — variables are expanded (interpolated)
echo "Hello, I am $NAME and I am a $ROLE"

# Single quotes — everything is treated as a literal string (no expansion)
echo 'Hello, I am $NAME and I am a $ROLE'
```

#### ▶️ How to Run

```bash
chmod +x variables.sh
./variables.sh
```

#### 📤 Output

```
Hello, I am Rameez and I am a DevOps Engineer
Hello, I am $NAME and I am a $ROLE
```

#### 🔬 Deep Dive: Single Quotes vs Double Quotes

This is one of the most common sources of confusion in shell scripting:

```
┌─────────────────────────────────────────────────────────────────┐
│                  QUOTING BEHAVIOR IN BASH                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Double Quotes " "                    Single Quotes ' '         │
│  ┌─────────────────────────┐         ┌─────────────────────┐   │
│  │ • Variables EXPANDED     │         │ • Everything LITERAL │   │
│  │ • $NAME → "Rameez"      │         │ • $NAME → "$NAME"   │   │
│  │ • Command sub works      │         │ • No expansion      │   │
│  │ • Backslash escapes work │         │ • Nothing is special│   │
│  │ • Backticks work         │         │ • Safest quoting    │   │
│  └─────────────────────────┘         └─────────────────────┘   │
│                                                                 │
│  Example:                             Example:                  │
│  echo "Hi $NAME" → Hi Rameez         echo 'Hi $NAME' → Hi $NAME│
│  echo "$(date)"  → 2026-02-19...     echo '$(date)' → $(date)  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

| Quote Type | Variables | Commands | Special Chars | Use When |
|------------|-----------|----------|---------------|----------|
| **Double `" "`** | ✅ Expanded | ✅ `$(cmd)` works | ✅ `\n`, `\t` work | You need variable substitution |
| **Single `' '`** | ❌ Literal | ❌ Literal | ❌ All literal | You want exact text, no processing |
| **None** | ✅ Expanded | ✅ Works | ⚠️ Word splitting risk | Simple single-word values only |

> **⚠️ Variable Assignment Rules:**
> - **No spaces** around `=`: `NAME="Rameez"` ✅ but `NAME = "Rameez"` ❌
> - Variable names are **case-sensitive**: `$name` ≠ `$NAME`
> - By convention, use **UPPERCASE** for environment/global variables and **lowercase** for local ones

---

### Task 3: User Input with `read` — `greet.sh`

Interactive scripts that can accept user input at runtime are essential for building tools your team can use.

#### 📄 Script Code

```bash
#!/bin/bash
# Day 16 - Task 3: User Input with read
# This script asks for the user's name and favourite tool, then greets them

read -p "Enter your name: " NAME
read -p "Enter your favourite tool: " TOOL

echo "Hello $NAME, your favourite tool is $TOOL"
```

#### ▶️ How to Run

```bash
chmod +x greet.sh
./greet.sh
```

#### 📤 Output

```
Enter your name: Rameez
Enter your favourite tool: Docker
Hello Rameez, your favourite tool is Docker
```

#### 🔬 Deep Dive: The `read` Command

```
┌──────────────────────────────────────────────────────────────┐
│                    read COMMAND OPTIONS                       │
├─────────────┬────────────────────────────────────────────────┤
│ Flag        │ What It Does                                   │
├─────────────┼────────────────────────────────────────────────┤
│ -p "text"   │ Display a prompt before reading input          │
│ -s          │ Silent mode (hide input) — good for passwords  │
│ -t 5        │ Timeout after 5 seconds                        │
│ -n 1        │ Read only 1 character (no Enter needed)        │
│ -r          │ Don't treat backslash as escape character       │
│ -a ARRAY    │ Read into an array variable                    │
└─────────────┴────────────────────────────────────────────────┘
```

**Practical examples:**

```bash
# Read a password (hidden input)
read -sp "Enter password: " PASSWORD
echo ""   # New line since -s suppresses it

# Read with a timeout (useful in automation)
read -t 10 -p "Continue? (y/n): " ANSWER

# Read a single keypress
read -n 1 -p "Press any key to continue..."
```

> **💡 DevOps Tip:** In CI/CD pipelines, scripts usually receive input via **environment variables** or **command-line arguments** instead of `read`, since there's no human to type. Use `read` for interactive tools; use `$1`, `$2`, or `$ENV_VAR` for automated scripts.

---

### Task 4: If-Else Conditions

Conditional logic is the brain of your scripts — it lets them make decisions and respond to different situations.

#### Task 4a: Number Checker — `check_number.sh`

#### 📄 Script Code

```bash
#!/bin/bash
# Day 16 - Task 4a: If-Else Conditions — Number Check
# This script takes a number and determines if it is positive, negative, or zero

read -p "Enter a number: " NUM

if [ "$NUM" -gt 0 ]; then
    echo "$NUM is a positive number ✅"
elif [ "$NUM" -lt 0 ]; then
    echo "$NUM is a negative number ❌"
else
    echo "The number is zero 🔵"
fi
```

#### ▶️ How to Run

```bash
chmod +x check_number.sh
./check_number.sh
```

#### 📤 Output (3 runs)

```
# Run 1:
Enter a number: 42
42 is a positive number ✅

# Run 2:
Enter a number: -7
-7 is a negative number ❌

# Run 3:
Enter a number: 0
The number is zero 🔵
```

---

#### Task 4b: File Checker — `file_check.sh`

#### 📄 Script Code

```bash
#!/bin/bash
# Day 16 - Task 4b: If-Else Conditions — File Check
# This script asks for a filename and checks whether it exists

read -p "Enter a filename to check: " FILENAME

if [ -f "$FILENAME" ]; then
    echo "✅ File '$FILENAME' exists!"
    echo "   Size: $(du -h "$FILENAME" | cut -f1)"
    echo "   Last modified: $(stat -c '%y' "$FILENAME" | cut -d'.' -f1)"
else
    echo "❌ File '$FILENAME' does NOT exist."
fi
```

#### ▶️ How to Run

```bash
chmod +x file_check.sh
./file_check.sh
```

#### 📤 Output

```
# Checking an existing file:
Enter a filename to check: hello.sh
✅ File 'hello.sh' exists!
   Size: 4.0K
   Last modified: 2026-02-19 17:15:32

# Checking a non-existent file:
Enter a filename to check: ghost.txt
❌ File 'ghost.txt' does NOT exist.
```

#### 🔬 Deep Dive: If-Else Syntax & Test Operators

**The anatomy of an if statement:**

```
  if [ condition ]; then     ← Opening (note the spaces inside [ ])
      command1               ← Runs if condition is TRUE (exit code 0)
      command2
  elif [ condition2 ]; then  ← Optional: additional condition
      command3
  else                       ← Optional: fallback if nothing matched
      command4
  fi                         ← Closing (fi = if backwards)
```

> **⚠️ Critical Syntax Rules:**
> - **Spaces inside `[ ]` are mandatory**: `[ "$X" -gt 0 ]` ✅ vs `["$X" -gt 0]` ❌
> - **Quote your variables**: `[ "$NUM" -gt 0 ]` ✅ vs `[ $NUM -gt 0 ]` ❌ (breaks with empty input)
> - **Semicolon before `then`** (or put `then` on next line)

**Common Test Operators:**

| Category | Operator | Meaning | Example |
|----------|----------|---------|---------|
| **Numbers** | `-eq` | Equal | `[ "$a" -eq "$b" ]` |
| | `-ne` | Not equal | `[ "$a" -ne "$b" ]` |
| | `-gt` | Greater than | `[ "$a" -gt 10 ]` |
| | `-lt` | Less than | `[ "$a" -lt 10 ]` |
| | `-ge` | Greater or equal | `[ "$a" -ge 5 ]` |
| | `-le` | Less or equal | `[ "$a" -le 100 ]` |
| **Strings** | `=` | Equal | `[ "$a" = "yes" ]` |
| | `!=` | Not equal | `[ "$a" != "no" ]` |
| | `-z` | Is empty | `[ -z "$a" ]` |
| | `-n` | Is not empty | `[ -n "$a" ]` |
| **Files** | `-f` | File exists (regular) | `[ -f /etc/hosts ]` |
| | `-d` | Directory exists | `[ -d /var/log ]` |
| | `-r` | File is readable | `[ -r config.yml ]` |
| | `-w` | File is writable | `[ -w /tmp/output ]` |
| | `-x` | File is executable | `[ -x ./deploy.sh ]` |
| | `-s` | File is non-empty | `[ -s logfile.log ]` |
| **Logic** | `-a` or `&&` | AND | `[ cond1 ] && [ cond2 ]` |
| | `-o` or `\|\|` | OR | `[ cond1 ] \|\| [ cond2 ]` |
| | `!` | NOT | `[ ! -f file ]` |

---

### Task 5: Combine It All — `server_check.sh`

This script brings together everything: variables, `read`, and `if-else` — simulating a real-world DevOps tool that checks service health.

#### 📄 Script Code

```bash
#!/bin/bash
# Day 16 - Task 5: Combine It All — Server Status Checker
# This script combines variables, user input, and if-else logic
# to check whether a system service is active or not

SERVICE="nginx"

echo "============================================"
echo "  🖥️  Server Service Checker"
echo "============================================"
echo ""
echo "Service selected: $SERVICE"
echo ""

read -p "Do you want to check the status of '$SERVICE'? (y/n): " CHOICE

if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "Y" ]; then
    echo ""
    echo "Checking status of '$SERVICE'..."
    echo "--------------------------------------------"

    if systemctl is-active --quiet "$SERVICE"; then
        echo "✅ Service '$SERVICE' is ACTIVE and running."
    else
        echo "❌ Service '$SERVICE' is NOT active."
    fi

    echo "--------------------------------------------"
    echo ""
    echo "Full status output:"
    systemctl status "$SERVICE" --no-pager 2>/dev/null || echo "(Could not retrieve full status)"
else
    echo ""
    echo "⏭️  Skipped."
fi
```

#### ▶️ How to Run

```bash
chmod +x server_check.sh
./server_check.sh
```

#### 📤 Output (Service Active)

```
============================================
  🖥️  Server Service Checker
============================================

Service selected: nginx

Do you want to check the status of 'nginx'? (y/n): y

Checking status of 'nginx'...
--------------------------------------------
✅ Service 'nginx' is ACTIVE and running.
--------------------------------------------

Full status output:
● nginx.service - A high performance web server and reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled)
     Active: active (running) since Wed 2026-02-19 12:30:00 PKT
   Main PID: 1234 (nginx)
      Tasks: 2
     Memory: 5.6M
        CPU: 32ms
```

#### 📤 Output (User Skips)

```
============================================
  🖥️  Server Service Checker
============================================

Service selected: nginx

Do you want to check the status of 'nginx'? (y/n): n

⏭️  Skipped.
```

#### 🔬 Script Breakdown

```
┌────────────────────────────────────────────────────────────────────┐
│                    server_check.sh — FLOW DIAGRAM                  │
└────────────────────────────────────────────────────────────────────┘

  ┌──────────────────┐
  │  Start            │
  └────────┬─────────┘
           │
           ▼
  ┌──────────────────┐
  │ SERVICE="nginx"   │  ← Variable stores the service name
  │ Display banner    │
  └────────┬─────────┘
           │
           ▼
  ┌──────────────────┐
  │ read CHOICE       │  ← User inputs y or n
  └────────┬─────────┘
           │
      ┌────┴────┐
      │ y or Y? │
      └────┬────┘
       yes │         no
           │          │
           ▼          ▼
  ┌────────────┐  ┌──────────┐
  │ systemctl   │  │ "Skipped"│
  │ is-active?  │  └──────────┘
  └──────┬─────┘
    yes  │  no
         │   │
         ▼   ▼
  ┌──────┐ ┌──────────┐
  │ACTIVE│ │NOT active │
  └──────┘ └──────────┘
         │
         ▼
  ┌──────────────────┐
  │ Show full status  │
  │ (systemctl status)│
  └──────────────────┘
```

---

## 📊 Script Summary Table

| Script | Concepts Used | File | Purpose |
|--------|--------------|------|---------|
| `hello.sh` | Shebang, `echo` | Task 1 | Print a greeting message |
| `variables.sh` | Variables, quoting | Task 2 | Demonstrate variable expansion and quoting |
| `greet.sh` | `read`, variables | Task 3 | Interactive user greeting |
| `check_number.sh` | `read`, `if-elif-else` | Task 4a | Classify numbers as positive/negative/zero |
| `file_check.sh` | `read`, `if-else`, `-f` test | Task 4b | Check if a file exists |
| `server_check.sh` | Variables, `read`, `if-else`, `systemctl` | Task 5 | Check service status interactively |

---

## 🧰 Essential Shell Scripting Command Reference

### Script Execution

| Action | Command | Example |
|--------|---------|---------|
| Make executable | `chmod +x` | `chmod +x deploy.sh` |
| Run with `./` | `./script.sh` | `./hello.sh` |
| Run with interpreter | `bash script.sh` | `bash hello.sh` |
| Run in debug mode | `bash -x script.sh` | `bash -x deploy.sh` |
| Check syntax only | `bash -n script.sh` | `bash -n deploy.sh` |

### Variable Operations

| Action | Syntax | Example |
|--------|--------|---------|
| Assign | `VAR=value` | `NAME="Rameez"` |
| Access | `$VAR` or `${VAR}` | `echo "$NAME"` |
| Default value | `${VAR:-default}` | `echo "${NAME:-Guest}"` |
| Command substitution | `$(command)` | `TODAY=$(date +%F)` |
| Arithmetic | `$((expression))` | `TOTAL=$((5 + 3))` |
| String length | `${#VAR}` | `echo "${#NAME}"` |
| Export to child processes | `export VAR` | `export PATH="/usr/local/bin:$PATH"` |

### Input/Output

| Action | Command | Example |
|--------|---------|---------|
| Print text | `echo` | `echo "Hello"` |
| Print formatted | `printf` | `printf "%-10s %s\n" "Name:" "$NAME"` |
| Read input | `read -p` | `read -p "Enter: " VAR` |
| Read silently | `read -sp` | `read -sp "Password: " PASS` |
| Redirect stdout | `>` or `>>` | `echo "log" >> file.log` |
| Redirect stderr | `2>` | `cmd 2> errors.log` |
| Redirect both | `&>` | `cmd &> output.log` |

---

## 🔄 Real-World DevOps Scenarios

### Scenario 1: Automated Health Check Script

```bash
#!/bin/bash
# Check multiple services and report their status

SERVICES=("nginx" "sshd" "docker" "cron")

echo "=============================="
echo "  SERVICE HEALTH CHECK REPORT"
echo "  $(date)"
echo "=============================="

for SVC in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SVC" 2>/dev/null; then
        echo "  ✅ $SVC — RUNNING"
    else
        echo "  ❌ $SVC — DOWN"
    fi
done
```

### Scenario 2: Deployment Pre-flight Checker

```bash
#!/bin/bash
# Verify prerequisites before deploying an application

echo "🔍 Running pre-flight checks..."

CHECKS_PASSED=true

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
    echo "  ❌ Docker is not installed"
    CHECKS_PASSED=false
else
    echo "  ✅ Docker: $(docker --version | cut -d' ' -f3)"
fi

# Check if config file exists
if [ ! -f "./config.yml" ]; then
    echo "  ❌ config.yml not found"
    CHECKS_PASSED=false
else
    echo "  ✅ config.yml found"
fi

# Check disk space (need at least 1GB free)
FREE_SPACE=$(df / --output=avail -BG | tail -1 | tr -d ' G')
if [ "$FREE_SPACE" -lt 1 ]; then
    echo "  ❌ Insufficient disk space: ${FREE_SPACE}G"
    CHECKS_PASSED=false
else
    echo "  ✅ Disk space: ${FREE_SPACE}G available"
fi

if [ "$CHECKS_PASSED" = true ]; then
    echo ""
    echo "✅ All checks passed — ready to deploy!"
else
    echo ""
    echo "❌ Pre-flight checks FAILED — fix issues before deploying."
    exit 1
fi
```

### Scenario 3: Log Rotation Script

```bash
#!/bin/bash
# Rotate application logs — keep only the last 7 days

LOG_DIR="/var/log/myapp"
RETENTION_DAYS=7

echo "🔄 Rotating logs in $LOG_DIR (keeping last $RETENTION_DAYS days)..."

if [ -d "$LOG_DIR" ]; then
    DELETED=$(find "$LOG_DIR" -name "*.log" -mtime +$RETENTION_DAYS -delete -print | wc -l)
    echo "✅ Deleted $DELETED old log files."
else
    echo "❌ Log directory $LOG_DIR does not exist."
fi
```

---

## 🆚 Script Execution Methods Compared

| Method | Command | Shebang Used? | Needs `chmod +x`? | Runs In |
|--------|---------|:------------:|:-----------------:|---------|
| Direct execution | `./script.sh` | ✅ Yes | ✅ Yes | Subshell |
| Explicit interpreter | `bash script.sh` | ❌ Ignored | ❌ No | Subshell |
| Source (dot) | `. script.sh` | ❌ Ignored | ❌ No | **Current** shell |
| Source | `source script.sh` | ❌ Ignored | ❌ No | **Current** shell |

> **💡 Key Difference:** `./script.sh` and `bash script.sh` run in a **subshell** — variables set inside the script disappear when it finishes. `source script.sh` runs in the **current** shell — variables persist. This is why you use `source ~/.bashrc` to reload your configuration.

---

## 🧹 Script Writing Best Practices

```
┌──────────────────────────────────────────────────────────────┐
│                SHELL SCRIPTING BEST PRACTICES                │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  1. #!/bin/bash           Always include the shebang         │
│                                                              │
│  2. set -euo pipefail     Exit on errors, undefined vars,    │
│                           and pipe failures (production)     │
│                                                              │
│  3. "$VARIABLE"           Always quote your variables        │
│                                                              │
│  4. # Comments            Explain WHY, not WHAT              │
│                                                              │
│  5. shellcheck            Lint your scripts before deploy    │
│                                                              │
│  6. Meaningful names      SERVICE_NAME > SN                  │
│                                                              │
│  7. Exit codes            Use exit 0 (success) / exit 1      │
│                                                              │
│  8. Error handling        Check if commands succeed           │
│                                                              │
│  9. DRY principle         Use functions for repeated logic    │
│                                                              │
│ 10. Test on staging       Never deploy untested scripts       │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### The `set -euo pipefail` Safety Net

For production scripts, always add this near the top:

```bash
#!/bin/bash
set -euo pipefail

# -e → Exit immediately if any command returns non-zero
# -u → Treat unset variables as an error
# -o pipefail → A pipeline fails if ANY command in it fails
```

| Flag | Without It | With It |
|------|-----------|---------|
| `-e` | Script continues even after errors | Script stops at first error |
| `-u` | Unset variables silently become empty | Error raised for unset variables |
| `-o pipefail` | `cmd1 | cmd2` succeeds if `cmd2` succeeds | Fails if `cmd1` OR `cmd2` fails |

---

## 🔍 Troubleshooting Guide

| Issue | Cause | Solution |
|-------|-------|----------|
| `Permission denied` when running `./script.sh` | Script is not executable | `chmod +x script.sh` |
| `command not found` when running `./script.sh` | Missing shebang or wrong interpreter path | Add `#!/bin/bash` as line 1 |
| `unexpected operator` error | Using bash syntax with `sh` | Ensure shebang is `#!/bin/bash`, not `#!/bin/sh` |
| Variables not expanding | Using single quotes `' '` | Switch to double quotes `" "` for expansion |
| `unary operator expected` | Variable is empty in `[ ]` | Quote your variable: `[ "$VAR" -gt 0 ]` |
| `integer expression expected` | Non-numeric input to `-gt`, `-lt`, etc. | Validate input before comparison |
| Script works interactively but fails in cron | Different `PATH` in cron environment | Use full paths: `/usr/bin/echo` instead of `echo` |
| `\r: command not found` | Script created on Windows (CRLF line endings) | Convert: `dos2unix script.sh` or `sed -i 's/\r$//' script.sh` |
| `read` not waiting for input in pipeline | stdin is consumed by the pipeline | Use `read < /dev/tty` for interactive input |
| Variables lost after script finishes | Script runs in a subshell | Use `source script.sh` to run in current shell |

---

## 🐛 Debugging Your Scripts

When a script doesn't behave as expected, use these techniques:

```bash
# Method 1: Run in debug mode (prints each command before executing)
bash -x ./script.sh

# Method 2: Add debug mode to specific sections of your script
set -x   # Turn on debugging
# ... commands to debug ...
set +x   # Turn off debugging

# Method 3: Check syntax without running
bash -n ./script.sh

# Method 4: Use shellcheck (static analysis linter)
shellcheck ./script.sh
```

**Debug output example (bash -x):**

```
+ NAME=Rameez
+ ROLE='DevOps Engineer'
+ echo 'Hello, I am Rameez and I am a DevOps Engineer'
Hello, I am Rameez and I am a DevOps Engineer
+ echo 'Hello, I am $NAME and I am a $ROLE'
Hello, I am $NAME and I am a $ROLE
```

> **💡 The `+` prefix** shows each command after variable expansion, letting you see exactly what bash is executing. This is invaluable for finding bugs in complex scripts.

---

## 💡 What I Learned

### 1. The Shebang Is Not Just a Formality — It's a Contract
The `#!/bin/bash` line defines which interpreter runs your script. Without it, your script becomes **non-portable** — it might work on your machine with `bash` as the default shell, but fail on a server using `dash` or `sh`. In DevOps, where scripts run across different environments (local, CI runners, production servers, containers), the shebang guarantees consistent behavior.

### 2. Quoting Variables Is a Non-Negotiable Habit
The difference between `$VAR` and `"$VAR"` can be the difference between a working deploy and a catastrophic bug. Unquoted variables undergo **word splitting** — if `FILE="my report.txt"`, then `rm $FILE` tries to delete TWO files (`my` and `report.txt`), while `rm "$FILE"` correctly handles the space. Always quote. Always.

### 3. Shell Scripts Are the Gateway to Infrastructure as Code
Every Ansible playbook, Terraform provisioner, Docker entrypoint, and CI/CD pipeline step ultimately calls shell commands. Understanding `if-else`, `read`, and `systemctl` at this level makes you fluent in the language that every DevOps tool speaks underneath. These basics don't just teach scripting — they teach **systems thinking**.

---

## 📁 Files Created

```
day-16/
├── README.md                    # Task requirements
├── day-16-shell-scripting.md    # This documentation file
├── hello.sh                     # Task 1: First script
├── variables.sh                 # Task 2: Variables and quoting
├── greet.sh                     # Task 3: User input with read
├── check_number.sh              # Task 4a: Number checker
├── file_check.sh                # Task 4b: File existence checker
└── server_check.sh              # Task 5: Service status checker
```

---

## 🚀 What's Next?

Shell scripting builds progressively. Here's the learning path ahead:

```
  Day 16 (TODAY)          Day 17+                  Day 18+
  ┌───────────────┐      ┌───────────────┐       ┌───────────────┐
  │ ✅ Shebang     │      │ • Loops        │       │ • Functions    │
  │ ✅ Variables    │ ───► │ • for/while    │ ────► │ • Arrays       │
  │ ✅ echo/read   │      │ • Case stmt    │       │ • Error handling│
  │ ✅ If-Else     │      │ • Arguments    │       │ • Cron jobs    │
  └───────────────┘      └───────────────┘       └───────────────┘
```

---
