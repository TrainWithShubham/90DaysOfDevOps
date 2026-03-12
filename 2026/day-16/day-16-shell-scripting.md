# Day 16 - Shell Scripting Basics

**Date:** February 15, 2026  
**Focus:** Learning the fundamentals of bash shell scripting

---

## What is Shell Scripting?

A shell script is a text file containing a sequence of commands that the shell
executes automatically. Instead of typing commands one by one, you write them
once and run them whenever needed.

**Why DevOps engineers write shell scripts:**
- Automate repetitive tasks (deployments, backups, health checks)
- Reduce human error in multi-step processes
- Create repeatable, documented workflows
- Schedule tasks with cron
- Build CI/CD pipeline steps

---

## Task 1: Your First Script

### Understanding the Shebang Line

The shebang `#!/bin/bash` is the first line of every bash script.
It tells the operating system which interpreter to use to run the file.
```
#!/bin/bash
│  │
│  └── Path to the bash interpreter
└───── Shebang characters (sharp + bang)
```

**Without shebang:** The OS uses the default shell (might be `sh`, `dash`,
or another shell) which may not support all bash features.

**With shebang:** Always runs with bash, regardless of what shell the user
is currently using.

---

### hello.sh
```bash
#!/bin/bash

# My first shell script
# Day 16 - 90 Days of DevOps Challenge

echo "Hello, DevOps!"
echo "Welcome to Shell Scripting!"
echo "Today is: $(date)"
echo "Running on: $(hostname)"
```

**Make executable and run:**
```bash
chmod +x hello.sh
./hello.sh
```

**Output:**
```
Hello, DevOps!
Welcome to Shell Scripting!
Today is: Sun Feb 15 17:30:00 UTC 2026
Running on: devops-server
```

---

### What Happens Without the Shebang?

**Test 1: Remove shebang, run with ./**
```bash
# hello_noshebang.sh (no shebang)
echo "Hello, DevOps!"
```
```bash
./hello_noshebang.sh
```

**Output:**
```
Hello, DevOps!
```

**It still works BUT:** The system uses the default shell (`/bin/sh` or
`/bin/dash` on Ubuntu), not bash. This causes problems when you use
bash-specific features:
```bash
# This works in bash but FAILS without #!/bin/bash
names=("Alice" "Bob" "Charlie")   # Bash arrays
echo "${names[@]}"                 # Bash array syntax

# Error without shebang:
# ./script.sh: 2: Syntax error: "(" unexpected
```

**Test 2: Run without ./ (as bash argument)**
```bash
bash hello.sh        # Works - explicitly using bash
sh hello.sh          # Works with sh syntax only
python3 hello.sh     # Fails - wrong interpreter
```

**Best practice:** Always include `#!/bin/bash` at the top of every script.

**Other common shebangs:**
```bash
#!/bin/bash           # Bash (most common)
#!/bin/sh             # POSIX shell (portable)
#!/usr/bin/env bash   # Finds bash in PATH (more portable)
#!/usr/bin/python3    # Python script
#!/usr/bin/env node   # Node.js script
```

---

## Task 2: Variables

### Understanding Variables in Bash

Variables store data that your script can use and reuse.

**Rules:**
- No spaces around `=` sign
- Variable names: letters, numbers, underscores (no spaces)
- Convention: UPPERCASE for constants, lowercase for local variables
- Access variable with `$` prefix: `$NAME` or `${NAME}`

---

### variables.sh
```bash
#!/bin/bash

# ── Variable Declaration ────────────────────────────────
NAME="DevOps Learner"
ROLE="DevOps Engineer"
COMPANY="TrainWithShubham"
DAYS_COMPLETED=16
CURRENT_DATE=$(date +"%B %d, %Y")   # Command substitution

# ── Basic Output ───────────────────────────────────────
echo "Hello, I am $NAME and I am a $ROLE"
echo "Company: $COMPANY"
echo "Days completed: $DAYS_COMPLETED of 90"
echo "Date: $CURRENT_DATE"

# ── String Operations ──────────────────────────────────
FULL_TITLE="$NAME - $ROLE at $COMPANY"
echo "Full title: $FULL_TITLE"

# ── Arithmetic ─────────────────────────────────────────
DAYS_REMAINING=$((90 - DAYS_COMPLETED))
echo "Days remaining: $DAYS_REMAINING"

# ── String Length ──────────────────────────────────────
echo "Name length: ${#NAME} characters"

# ── Default Values ─────────────────────────────────────
LOCATION=${LOCATION:-"India"}       # Use default if not set
echo "Location: $LOCATION"

# ── Readonly Variable ──────────────────────────────────
readonly MAX_RETRIES=3
echo "Max retries: $MAX_RETRIES"
# MAX_RETRIES=5  # This would cause an error: readonly variable
```

**Output:**
```
Hello, I am DevOps Learner and I am a DevOps Engineer
Company: TrainWithShubham
Days completed: 16 of 90
Date: February 15, 2026
Full title: DevOps Learner - DevOps Engineer at TrainWithShubham
Days remaining: 74
Name length: 13 characters
Location: India
Max retries: 3
```

---

### Single Quotes vs Double Quotes

This is one of the most important distinctions in bash scripting:
```bash
#!/bin/bash

NAME="DevOps"

# Double quotes: variables ARE expanded
echo "Hello $NAME"           # Output: Hello DevOps
echo "Today: $(date)"        # Output: Today: Sun Feb 15...

# Single quotes: variables are NOT expanded (literal)
echo 'Hello $NAME'           # Output: Hello $NAME
echo 'Today: $(date)'        # Output: Today: $(date)

# Practical example
echo "Path is: $PATH"        # Shows actual PATH variable
echo 'Path is: $PATH'        # Shows literal string $PATH

# When to use single quotes:
# - When you want literal strings (regex patterns, JSON)
# - When you don't want variable expansion
GREP_PATTERN='$HOME/.*\.sh'  # Literal pattern for grep
echo "Pattern: $GREP_PATTERN"

# When to use double quotes:
# - When you want variable expansion
# - When string contains spaces (prevents word splitting)
FILENAME="my file with spaces.txt"
ls "$FILENAME"               # Correct: treats as one argument
# ls $FILENAME               # Wrong: splits into 4 arguments
```

**Output:**
```
Hello DevOps
Today: Sun Feb 15 17:30:00 UTC 2026
Hello $NAME
Today: $(date)
Path is: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
Path is: $PATH
Pattern: $HOME/.*\.sh
```

**Key Rule:** Use double quotes around variables to prevent word splitting
and unexpected behavior: `"$variable"` not `$variable`

---

## Task 3: User Input with read

### Understanding the read Command

`read` pauses the script and waits for user input, storing it in a variable.

**Syntax variations:**
```bash
read VAR                          # Basic read
read -p "Prompt: " VAR           # With prompt message
read -s -p "Password: " PASS     # Silent (hides input)
read -t 10 -p "Input: " VAR      # 10 second timeout
read -n 1 -p "Yes/No? " CHOICE   # Read only 1 character
```

---

### greet.sh
```bash
#!/bin/bash

# ── Greeting Script with User Input ────────────────────

echo "==============================="
echo "   Welcome to DevOps Greeter   "
echo "==============================="
echo ""

# Read user's name
read -p "What is your name? " USER_NAME

# Validate input is not empty
if [ -z "$USER_NAME" ]; then
    USER_NAME="Anonymous DevOps Learner"
    echo "No name provided, using default: $USER_NAME"
fi

# Read favourite tool
read -p "What is your favourite DevOps tool? " FAV_TOOL

# Validate input
if [ -z "$FAV_TOOL" ]; then
    FAV_TOOL="Linux"
fi

# Read experience level
read -p "How many days have you been learning DevOps? " DAYS

echo ""
echo "==============================="
echo "Hello $USER_NAME, your favourite tool is $FAV_TOOL"
echo "You have been learning for $DAYS days - keep going!"
echo ""

# Personalised message based on days
if [ "$DAYS" -lt 30 ] 2>/dev/null; then
    echo "You're just getting started - the fundamentals are key!"
elif [ "$DAYS" -lt 60 ] 2>/dev/null; then
    echo "Great progress! You're building real skills now."
else
    echo "Amazing dedication! You're becoming a DevOps pro!"
fi

echo "==============================="
echo "Happy Learning! #90DaysOfDevOps"
echo "==============================="
```

**Sample Run:**
```
===============================
   Welcome to DevOps Greeter   
===============================

What is your name? Rahul
What is your favourite DevOps tool? Docker
How many days have you been learning DevOps? 16

===============================
Hello Rahul, your favourite tool is Docker
You have been learning for 16 days - keep going!

You're just getting started - the fundamentals are key!
===============================
Happy Learning! #90DaysOfDevOps
===============================
```

---

## Task 4: If-Else Conditions

### Understanding If-Else in Bash
```bash
# Basic syntax
if [ condition ]; then
    # commands if true
elif [ another_condition ]; then
    # commands if second condition true
else
    # commands if all conditions false
fi
```

**Common test operators:**

**Numeric comparisons:**
```bash
-eq   # equal to
-ne   # not equal to
-lt   # less than
-le   # less than or equal
-gt   # greater than
-ge   # greater than or equal
```

**String comparisons:**
```bash
=     # equal (use inside [ ])
!=    # not equal
-z    # empty string
-n    # non-empty string
```

**File tests:**
```bash
-f    # regular file exists
-d    # directory exists
-e    # file/directory exists
-r    # readable
-w    # writable
-x    # executable
-s    # file exists and not empty
```

---

### check_number.sh
```bash
#!/bin/bash

# ── Number Checker ──────────────────────────────────────

echo "================================"
echo "       Number Checker           "
echo "================================"

read -p "Enter a number: " NUMBER

# Validate that input is actually a number
if ! [[ "$NUMBER" =~ ^-?[0-9]+$ ]]; then
    echo "Error: '$NUMBER' is not a valid integer!"
    exit 1
fi

# Check positive, negative, or zero
if [ "$NUMBER" -gt 0 ]; then
    echo "Result: $NUMBER is POSITIVE ✓"
    echo "Square: $((NUMBER * NUMBER))"

elif [ "$NUMBER" -lt 0 ]; then
    echo "Result: $NUMBER is NEGATIVE ✗"
    ABSOLUTE=${NUMBER#-}       # Remove the minus sign
    echo "Absolute value: $ABSOLUTE"

else
    echo "Result: $NUMBER is ZERO"
    echo "Zero is neither positive nor negative"
fi

echo "================================"
```

**Sample Runs:**
```
# Run 1: Positive number
Enter a number: 42
================================
Result: 42 is POSITIVE ✓
Square: 1764
================================

# Run 2: Negative number
Enter a number: -15
================================
Result: -15 is NEGATIVE ✗
Absolute value: 15
================================

# Run 3: Zero
Enter a number: 0
================================
Result: 0 is ZERO
Zero is neither positive nor negative
================================

# Run 4: Invalid input
Enter a number: abc
Error: 'abc' is not a valid integer!
```

---

### file_check.sh
```bash
#!/bin/bash

# ── File Checker ────────────────────────────────────────

echo "================================"
echo "        File Checker            "
echo "================================"

read -p "Enter the filename to check: " FILENAME

# Check if filename was provided
if [ -z "$FILENAME" ]; then
    echo "Error: No filename provided!"
    exit 1
fi

echo ""
echo "Checking: $FILENAME"
echo "--------------------------------"

# Check if it exists at all
if [ ! -e "$FILENAME" ]; then
    echo "Status:   Does NOT exist ✗"
    echo ""
    echo "Suggestion: Create it with:"
    echo "  touch $FILENAME"
    exit 0
fi

# It exists - now check what type it is
if [ -f "$FILENAME" ]; then
    echo "Type:     Regular file ✓"

    # Check permissions
    [ -r "$FILENAME" ] && echo "Read:     Yes ✓" || echo "Read:     No ✗"
    [ -w "$FILENAME" ] && echo "Write:    Yes ✓" || echo "Write:    No ✗"
    [ -x "$FILENAME" ] && echo "Execute:  Yes ✓" || echo "Execute:  No ✗"

    # File details
    SIZE=$(du -sh "$FILENAME" | cut -f1)
    MODIFIED=$(stat -c "%y" "$FILENAME" | cut -d'.' -f1)
    OWNER=$(stat -c "%U" "$FILENAME")

    echo "Size:     $SIZE"
    echo "Modified: $MODIFIED"
    echo "Owner:    $OWNER"
    echo "Permissions: $(ls -la "$FILENAME" | awk '{print $1}')"

elif [ -d "$FILENAME" ]; then
    echo "Type:     Directory ✓"
    COUNT=$(ls "$FILENAME" | wc -l)
    echo "Contains: $COUNT items"

elif [ -L "$FILENAME" ]; then
    echo "Type:     Symbolic link"
    echo "Points to: $(readlink "$FILENAME")"

else
    echo "Type:     Special file"
fi

echo "================================"
```

**Sample Runs:**
```
# Run 1: File exists with permissions
Enter the filename to check: hello.sh
================================
Checking: hello.sh
--------------------------------
Type:     Regular file ✓
Read:     Yes ✓
Write:    Yes ✓
Execute:  Yes ✓
Size:     4.0K
Modified: 2026-02-15 17:30:00
Owner:    devuser
Permissions: -rwxr-xr-x
================================

# Run 2: File doesn't exist
Enter the filename to check: missing.txt
================================
Checking: missing.txt
--------------------------------
Status:   Does NOT exist ✗

Suggestion: Create it with:
  touch missing.txt
================================

# Run 3: Directory
Enter the filename to check: /etc
================================
Checking: /etc
--------------------------------
Type:     Directory ✓
Contains: 187 items
================================
```

---

## Task 5: Combine It All

### server_check.sh
```bash
#!/bin/bash

# ── Server Service Checker ──────────────────────────────
# Combines: variables, read, if-else, command execution

# ── Colour codes for better output ─────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'           # No Colour (reset)

# ── Configuration ───────────────────────────────────────
SERVICE="nginx"        # Default service to check
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# ── Header ──────────────────────────────────────────────
echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}        Server Service Checker              ${NC}"
echo -e "${BLUE}============================================${NC}"
echo "Time: $TIMESTAMP"
echo "Host: $(hostname)"
echo ""

# ── Ask which service to check ──────────────────────────
read -p "Enter service name to check (default: $SERVICE): " USER_SERVICE

# Use entered service or keep default
if [ -n "$USER_SERVICE" ]; then
    SERVICE="$USER_SERVICE"
fi

echo ""
echo -e "Service: ${YELLOW}$SERVICE${NC}"
echo "--------------------------------------------"

# ── Ask if user wants to check ──────────────────────────
read -p "Do you want to check the status? (y/n): " CHOICE

echo ""

# ── Process user choice ─────────────────────────────────
if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "Y" ]; then

    # Check if service exists in systemd
    if ! systemctl list-units --type=service --all | grep -q "$SERVICE"; then
        echo -e "${RED}Error: Service '$SERVICE' not found on this system${NC}"
        echo "Available services (first 10):"
        systemctl list-units --type=service --state=running \
            --no-pager --no-legend | head -10 | awk '{print "  -", $1}'
        exit 1
    fi

    # Get service status
    STATUS=$(systemctl is-active "$SERVICE" 2>/dev/null)
    ENABLED=$(systemctl is-enabled "$SERVICE" 2>/dev/null)

    # Display result based on status
    if [ "$STATUS" = "active" ]; then
        echo -e "Status:  ${GREEN}ACTIVE - Running ✓${NC}"
        echo -e "Enabled: ${GREEN}$ENABLED${NC}"

        # Get additional details
        PID=$(systemctl show "$SERVICE" --property=MainPID \
            --value 2>/dev/null)
        MEMORY=$(systemctl show "$SERVICE" \
            --property=MemoryCurrent --value 2>/dev/null)
        UPTIME=$(systemctl show "$SERVICE" \
            --property=ActiveEnterTimestamp --value 2>/dev/null)

        echo "PID:     $PID"
        echo "Since:   $UPTIME"
        echo ""
        echo "Recent logs (last 5 lines):"
        echo "--------------------------------------------"
        journalctl -u "$SERVICE" -n 5 --no-pager \
            --output=short 2>/dev/null || \
            echo "  (no logs available)"

    elif [ "$STATUS" = "inactive" ]; then
        echo -e "Status:  ${YELLOW}INACTIVE - Not running ⚠${NC}"
        echo -e "Enabled: $ENABLED"
        echo ""
        echo "Would you like to start it? (y/n)"
        read -p "Start $SERVICE? " START_CHOICE
        if [ "$START_CHOICE" = "y" ] || [ "$START_CHOICE" = "Y" ]; then
            sudo systemctl start "$SERVICE"
            NEW_STATUS=$(systemctl is-active "$SERVICE")
            if [ "$NEW_STATUS" = "active" ]; then
                echo -e "${GREEN}Service started successfully! ✓${NC}"
            else
                echo -e "${RED}Failed to start service ✗${NC}"
                echo "Check logs: journalctl -u $SERVICE -n 20"
            fi
        fi

    elif [ "$STATUS" = "failed" ]; then
        echo -e "Status:  ${RED}FAILED - Error detected ✗${NC}"
        echo ""
        echo "Last error logs:"
        echo "--------------------------------------------"
        journalctl -u "$SERVICE" -n 10 --no-pager 2>/dev/null
        echo ""
        echo "Suggested fix:"
        echo "  sudo systemctl restart $SERVICE"
        echo "  journalctl -u $SERVICE -f"

    else
        echo -e "Status: ${YELLOW}$STATUS${NC} (unknown state)"
    fi

elif [ "$CHOICE" = "n" ] || [ "$CHOICE" = "N" ]; then
    echo "Skipped."
    echo "Run again anytime: ./server_check.sh"

else
    echo -e "${RED}Invalid choice: '$CHOICE'. Please enter y or n.${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}============================================${NC}"
echo "Check complete."
echo -e "${BLUE}============================================${NC}"
```

**Sample Run 1: Active service (nginx)**
```
============================================
        Server Service Checker              
============================================
Time: 2026-02-15 17:30:00
Host: devops-server

Enter service name to check (default: nginx): 
Service: nginx
--------------------------------------------
Do you want to check the status? (y/n): y

Status:  ACTIVE - Running ✓
Enabled: enabled
PID:     2345
Since:   Sun 2026-02-15 06:00:15 UTC

Recent logs (last 5 lines):
--------------------------------------------
Feb 15 17:28:01 server nginx[2345]: GET /index.html 200
Feb 15 17:29:15 server nginx[2345]: GET /api/health 200
Feb 15 17:30:00 server nginx[2345]: GET /favicon.ico 200

============================================
Check complete.
============================================
```

**Sample Run 2: User skips check**
```
============================================
        Server Service Checker              
============================================
Time: 2026-02-15 17:31:00
Host: devops-server

Enter service name to check (default: nginx): ssh
Service: ssh
--------------------------------------------
Do you want to check the status? (y/n): n

Skipped.
Run again anytime: ./server_check.sh

============================================
Check complete.
============================================
```

**Sample Run 3: Failed service**
```
Enter service name to check (default: nginx): myapp
Service: myapp
--------------------------------------------
Do you want to check the status? (y/n): y

Status:  FAILED - Error detected ✗

Last error logs:
--------------------------------------------
Feb 15 17:25:01 server myapp[9999]: Error: Cannot connect to database
Feb 15 17:25:01 server myapp[9999]: Fatal: Startup failed
Feb 15 17:25:01 server systemd[1]: myapp.service: Failed

Suggested fix:
  sudo systemctl restart myapp
  journalctl -u myapp -f
```

---

## All Scripts Summary

### Script File Listing
```bash
ls -l *.sh
```

**Output:**
```
-rwxr-xr-x 1 devuser devuser  234 Feb 15 17:00 hello.sh
-rwxr-xr-x 1 devuser devuser  891 Feb 15 17:05 variables.sh
-rwxr-xr-x 1 devuser devuser  672 Feb 15 17:10 greet.sh
-rwxr-xr-x 1 devuser devuser  945 Feb 15 17:15 check_number.sh
-rwxr-xr-x 1 devuser devuser 1123 Feb 15 17:20 file_check.sh
-rwxr-xr-x 1 devuser devuser 2341 Feb 15 17:25 server_check.sh
```

---

## What I Learned

### 1. The Shebang Line is More Than Just a Convention

**Why `#!/bin/bash` matters:**

Without it, your script runs in the default system shell which may differ
between Linux distributions:
- Ubuntu: `/bin/dash` (faster but fewer features)
- CentOS: `/bin/sh` (basic POSIX shell)
- macOS: `/bin/zsh` (since macOS Catalina)

**Real problem this causes:**
```bash
# This ONLY works in bash, fails in sh/dash:
names=("nginx" "docker" "ssh")    # Arrays - bash only
for service in "${names[@]}"; do  # Array syntax - bash only
    systemctl status "$service"
done

# Error in sh: Syntax error: "(" unexpected
```

**Portable alternative:** `#!/usr/bin/env bash`
- Searches for bash in your PATH
- Works even if bash is not in `/bin/bash`
- Common in projects shared across different systems

**Best practice for DevOps scripts:**
```bash
#!/usr/bin/env bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures
# -e: exit on error
# -u: error on undefined variables
# -o pipefail: catch errors in pipes

# This one line makes scripts much more robust!
```

---

### 2. Variables in Bash Have Subtle but Important Rules

**The rules that catch beginners:**

**Rule 1: No spaces around `=`**
```bash
NAME="DevOps"     # Correct
NAME = "DevOps"   # Wrong! Error: NAME: command not found
```

**Rule 2: Always quote variables**
```bash
FILENAME="my file.txt"
cat $FILENAME          # Wrong: tries to cat 'my' and 'file.txt'
cat "$FILENAME"        # Correct: treats as one argument
```

**Rule 3: Command substitution**
```bash
TODAY=$(date)          # Modern way (preferred)
TODAY=`date`           # Old way (still works but avoid)
```

**Rule 4: Arithmetic**
```bash
COUNT=5
COUNT=$COUNT+1         # Wrong: COUNT="5+1" (string!)
COUNT=$((COUNT + 1))   # Correct: COUNT=6 (arithmetic)
((COUNT++))            # Also correct
```

**Rule 5: Variable scope**
```bash
MY_VAR="global"

my_function() {
    local MY_VAR="local"   # local keyword limits scope
    echo "$MY_VAR"         # prints: local
}

my_function
echo "$MY_VAR"             # prints: global (unchanged)
```

**Real DevOps application:**
```bash
#!/usr/bin/env bash
# Good scripting habits

readonly APP_NAME="myapp"           # Constants: UPPERCASE + readonly
readonly CONFIG_DIR="/etc/${APP_NAME}"

log_file="/var/log/${APP_NAME}.log" # Variables: lowercase
backup_dir="/tmp/${APP_NAME}-backup-$(date +%Y%m%d)"

# Always quote, always local in functions
create_backup() {
    local source_dir="$1"           # Use positional args with local
    local dest_dir="$2"
    cp -r "$source_dir" "$dest_dir"
}
```

---

### 3. If-Else Conditions Enable Scripts to Make Decisions

**The bracket types matter:**

**Single brackets `[ ]` (POSIX):**
```bash
if [ "$STATUS" = "active" ]; then    # String comparison
if [ "$COUNT" -gt 10 ]; then         # Numeric comparison
if [ -f "$FILE" ]; then              # File test
```

**Double brackets `[[ ]]` (Bash only):**
```bash
if [[ "$STATUS" == "active" ]]; then  # Can use == and !=
if [[ "$NAME" =~ ^[A-Z] ]]; then      # Regex matching
if [[ -f "$FILE" && -r "$FILE" ]]; then  # Logical AND
```

**Double parentheses `(( ))` for arithmetic:**
```bash
if (( COUNT > 10 )); then             # Arithmetic comparison
if (( COUNT % 2 == 0 )); then         # Modulo operation
```

**Real-world decision making in DevOps scripts:**
```bash
#!/usr/bin/env bash

deploy() {
    local environment="$1"
    local version="$2"

    # Validate environment
    if [[ "$environment" != "staging" && \
          "$environment" != "production" ]]; then
        echo "Error: Invalid environment '$environment'"
        echo "Use: staging or production"
        exit 1
    fi

    # Extra confirmation for production
    if [[ "$environment" == "production" ]]; then
        read -p "Deploy $version to PRODUCTION? Type 'yes' to confirm: " CONFIRM
        if [[ "$CONFIRM" != "yes" ]]; then
            echo "Deployment cancelled."
            exit 0
        fi
    fi

    # Check service is running before deploy
    if ! systemctl is-active --quiet nginx; then
        echo "Warning: nginx is not running!"
        echo "Starting nginx before deployment..."
        sudo systemctl start nginx
    fi

    echo "Deploying $version to $environment..."
}

deploy "production" "v2.3.4"
```

---

## Shell Scripting Quick Reference

### Essential Syntax Cheatsheet
```bash
#!/usr/bin/env bash
set -euo pipefail

# ── VARIABLES ──────────────────────────────────────────
NAME="value"                    # Assign
echo "$NAME"                    # Access (always quote!)
echo "${NAME}_suffix"           # Curly braces for clarity
readonly CONST="fixed"          # Constant (can't change)
unset NAME                      # Delete variable
export NAME                     # Make available to child processes

# ── SPECIAL VARIABLES ──────────────────────────────────
echo "$0"      # Script name
echo "$1"      # First argument
echo "$2"      # Second argument
echo "$@"      # All arguments (array)
echo "$#"      # Number of arguments
echo "$?"      # Exit code of last command
echo "$$"      # Current script's PID
echo "$!"      # PID of last background process

# ── USER INPUT ─────────────────────────────────────────
read -p "Prompt: " VAR           # Basic input
read -s -p "Password: " PASS     # Silent input
read -t 30 -p "Timeout: " VAR    # 30-second timeout
read -n 1 -p "y/n? " CHOICE      # Single character

# ── CONDITIONS ─────────────────────────────────────────
# String tests
[ -z "$VAR" ]          # Empty string
[ -n "$VAR" ]          # Non-empty string
[ "$A" = "$B" ]        # Equal strings
[ "$A" != "$B" ]       # Not equal

# Numeric tests
[ "$A" -eq "$B" ]      # Equal numbers
[ "$A" -ne "$B" ]      # Not equal
[ "$A" -lt "$B" ]      # Less than
[ "$A" -le "$B" ]      # Less than or equal
[ "$A" -gt "$B" ]      # Greater than
[ "$A" -ge "$B" ]      # Greater than or equal

# File tests
[ -e "$FILE" ]         # Exists (file or directory)
[ -f "$FILE" ]         # Regular file exists
[ -d "$DIR" ]          # Directory exists
[ -r "$FILE" ]         # Readable
[ -w "$FILE" ]         # Writable
[ -x "$FILE" ]         # Executable
[ -s "$FILE" ]         # File not empty

# ── IF-ELSE ────────────────────────────────────────────
if [ condition ]; then
    commands
elif [ condition ]; then
    commands
else
    commands
fi

# ── ARITHMETIC ─────────────────────────────────────────
RESULT=$((5 + 3))        # Addition
RESULT=$((10 - 4))       # Subtraction
RESULT=$((6 * 7))        # Multiplication
RESULT=$((15 / 4))       # Division (integer)
RESULT=$((17 % 5))       # Modulo
((COUNTER++))            # Increment
((COUNTER--))            # Decrement

# ── OUTPUT ─────────────────────────────────────────────
echo "Message"           # With newline
echo -n "No newline"     # Without newline
echo -e "Tab:\there"     # Interpret escape sequences
printf "%-10s %5d\n" "Name" 42  # Formatted output

# ── EXIT CODES ─────────────────────────────────────────
exit 0    # Success
exit 1    # General error
exit 2    # Misuse of shell command

# Check exit code of last command
if [ $? -eq 0 ]; then
    echo "Last command succeeded"
fi

# Or more idiomatically:
command && echo "Success" || echo "Failed"
```

---

### Common Script Patterns
```bash
# ── SCRIPT HEADER ──────────────────────────────────────
#!/usr/bin/env bash
set -euo pipefail
# Script: script-name.sh
# Purpose: What this script does
# Usage: ./script-name.sh [arguments]
# Date: 2026-02-15

# ── LOGGING FUNCTION ───────────────────────────────────
log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }
log "Script started"

# ── CHECK ROOT ─────────────────────────────────────────
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root"
    exit 1
fi

# ── VALIDATE ARGUMENT ──────────────────────────────────
if [ $# -eq 0 ]; then
    echo "Usage: $0 <argument>"
    exit 1
fi

# ── TRAP CLEANUP ───────────────────────────────────────
cleanup() {
    echo "Cleaning up..."
    rm -f /tmp/tempfile
}
trap cleanup EXIT    # Run cleanup on any exit
```

---

## Summary

**Challenge Completed:** ✅ All 5 tasks finished

**Scripts Created:**

| Script | Purpose | Key Concepts |
|--------|---------|-------------|
| `hello.sh` | First script | shebang, echo, command substitution |
| `variables.sh` | Variable practice | assignment, quotes, arithmetic |
| `greet.sh` | User input | read, -p flag, validation |
| `check_number.sh` | Number logic | if-elif-else, numeric comparison |
| `file_check.sh` | File testing | file test operators, -f, -d |
| `server_check.sh` | Combined script | all concepts + systemctl |

**Key Concepts Mastered:**
1. Shebang (`#!/bin/bash`) ensures correct interpreter and enables bash features
2. Variables: no spaces in assignment, always quote, use readonly for constants
3. If-else conditions: different brackets for strings, numbers, and files
4. `read` enables interactive scripts and user-driven automation
5. Combining concepts creates powerful DevOps automation tools

---

**Created for:** 90 Days of DevOps Challenge - Day 16  
**Date:** February 15, 2026  
**Focus:** Shell scripting fundamentals for DevOps automation  
**Next Steps:** Loops, functions, and arguments for more powerful scripts

---

