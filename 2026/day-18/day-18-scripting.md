# Day 18 - Shell Scripting: Functions & Intermediate Concepts

**Date:** February 18, 2026  
**Focus:** Writing cleaner, reusable scripts with functions and strict mode

---

## What Are Functions in Bash?

Functions are reusable blocks of code that:
- Reduce code duplication
- Make scripts more organized and maintainable
- Enable modular design
- Can accept arguments and return values

**Basic syntax:**
```bash
function_name() {
    # commands
    echo "Hello from function"
}

# Call the function
function_name
```

---

## Task 1: Basic Functions

### functions.sh
```bash
#!/bin/bash

# Script: functions.sh
# Purpose: Demonstrate basic functions with arguments
# Date: 2026-02-18

echo "================================"
echo "     Functions Demonstration    "
echo "================================"
echo ""

# ── Function 1: Greet ───────────────────────────────────
greet() {
    local NAME=$1
    echo "Hello, $NAME!"
}

# ── Function 2: Add Two Numbers ─────────────────────────
add() {
    local NUM1=$1
    local NUM2=$2
    local SUM=$((NUM1 + NUM2))
    echo "Sum of $NUM1 + $NUM2 = $SUM"
}

# ── Main Execution ──────────────────────────────────────
echo "Test 1: Greeting function"
greet "DevOps Learner"
greet "Rahul"
greet "Priya"

echo ""
echo "Test 2: Addition function"
add 5 3
add 10 20
add 100 250

echo ""
echo "================================"
```

**Make executable and run:**
```bash
chmod +x functions.sh
./functions.sh
```

**Output:**
```
================================
     Functions Demonstration    
================================

Test 1: Greeting function
Hello, DevOps Learner!
Hello, Rahul!
Hello, Priya!

Test 2: Addition function
Sum of 5 + 3 = 8
Sum of 10 + 20 = 30
Sum of 100 + 250 = 350

================================
```

---

## Task 2: Functions with Return Values

### disk_check.sh
```bash
#!/bin/bash

# Script: disk_check.sh
# Purpose: Check disk and memory usage using functions
# Date: 2026-02-18

set -euo pipefail

echo "================================"
echo "   System Resource Checker      "
echo "================================"
echo ""

# ── Function: Check Disk Usage ──────────────────────────
check_disk() {
    echo "Disk Usage:"
    echo "--------------------------------"
    df -h / | awk 'NR==1 {print "  " $0} NR==2 {print "  " $0}'
    
    # Get usage percentage
    USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    echo ""
    if [ "$USAGE" -gt 80 ]; then
        echo "  ⚠️  WARNING: Disk usage is above 80%!"
    elif [ "$USAGE" -gt 90 ]; then
        echo "  🔴 CRITICAL: Disk usage is above 90%!"
    else
        echo "  ✅ Disk usage is healthy (${USAGE}%)"
    fi
}

# ── Function: Check Memory Usage ────────────────────────
check_memory() {
    echo "Memory Usage:"
    echo "--------------------------------"
    free -h | awk '{print "  " $0}'
    
    # Get available memory percentage
    TOTAL=$(free -m | awk 'NR==2 {print $2}')
    AVAILABLE=$(free -m | awk 'NR==2 {print $7}')
    PERCENT=$((AVAILABLE * 100 / TOTAL))
    
    echo ""
    if [ "$PERCENT" -lt 10 ]; then
        echo "  🔴 CRITICAL: Less than 10% memory available!"
    elif [ "$PERCENT" -lt 20 ]; then
        echo "  ⚠️  WARNING: Less than 20% memory available!"
    else
        echo "  ✅ Memory is healthy (${PERCENT}% available)"
    fi
}

# ── Main Execution ──────────────────────────────────────
echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

check_disk
echo ""
echo "================================"
echo ""
check_memory

echo ""
echo "================================"
echo "Resource check complete!"
echo "================================"
```

**Output:**
```
================================
   System Resource Checker      
================================

Timestamp: 2026-02-18 17:00:00

Disk Usage:
--------------------------------
  Filesystem      Size  Used Avail Use% Mounted on
  /dev/sda3        46G   12G   32G  27% /

  ✅ Disk usage is healthy (27%)

================================

Memory Usage:
--------------------------------
                total        used        free      shared  buff/cache   available
  Mem:           15Gi       4.2Gi       8.1Gi       156Mi       3.5Gi        11Gi
  Swap:         2.0Gi          0B       2.0Gi

  ✅ Memory is healthy (73% available)

================================
Resource check complete!
================================
```

---

## Task 3: Strict Mode - `set -euo pipefail`

### Understanding Strict Mode
```bash
set -e           # Exit immediately if any command fails
set -u           # Treat unset variables as errors
set -o pipefail  # Fail if any command in a pipe fails

# Combined:
set -euo pipefail
```

---

### strict_demo.sh
```bash
#!/bin/bash

# Script: strict_demo.sh
# Purpose: Demonstrate set -euo pipefail behavior
# Date: 2026-02-18

echo "================================"
echo "  Strict Mode Demonstration     "
echo "================================"
echo ""

# ── Demo 1: Without strict mode ────────────────────────
echo "Demo 1: WITHOUT strict mode"
echo "--------------------------------"
# Commenting out set commands to show behavior without them

echo "Using undefined variable:"
echo "UNDEFINED_VAR = $UNDEFINED_VAR_TEST"  # Prints empty string
echo "Script continues..."
echo ""

# ── Demo 2: With set -u ────────────────────────────────
echo "Demo 2: WITH set -u (error on undefined variables)"
echo "--------------------------------"
set -u

echo "Trying to use undefined variable with set -u:"
# This will cause error:
# echo "$ANOTHER_UNDEFINED_VAR"  # Would exit with error
echo "Using defined variable:"
DEFINED_VAR="I exist!"
echo "DEFINED_VAR = $DEFINED_VAR"
echo ""

# ── Demo 3: With set -e ────────────────────────────────
echo "Demo 3: WITH set -e (exit on error)"
echo "--------------------------------"
set -e

echo "This command will succeed:"
ls /tmp > /dev/null
echo "  ✅ ls succeeded, script continues"

echo ""
echo "This command would fail and stop script:"
echo "  ls /nonexistent-directory"
# ls /nonexistent-directory  # Would exit script immediately
echo "  (commented out to continue demo)"
echo ""

# ── Demo 4: With set -o pipefail ───────────────────────
echo "Demo 4: WITH set -o pipefail (catch pipe failures)"
echo "--------------------------------"
set -o pipefail

echo "Without pipefail, this would hide the failure:"
echo "  cat /nonexistent | sort"
echo "  (only 'sort' return code would matter)"
echo ""

echo "With pipefail, any failure in pipe causes error:"
echo "  cat /etc/hosts | grep localhost | wc -l"
cat /etc/hosts | grep localhost | wc -l
echo "  ✅ Pipeline succeeded"

echo ""
echo "================================"
echo "Strict mode demo complete!"
echo "================================"
```

**Output:**
```
================================
  Strict Mode Demonstration     
================================

Demo 1: WITHOUT strict mode
--------------------------------
Using undefined variable:
UNDEFINED_VAR = 
Script continues...

Demo 2: WITH set -u (error on undefined variables)
--------------------------------
Trying to use undefined variable with set -u:
Using defined variable:
DEFINED_VAR = I exist!

Demo 3: WITH set -e (exit on error)
--------------------------------
This command will succeed:
  ✅ ls succeeded, script continues

This command would fail and stop script:
  ls /nonexistent-directory
  (commented out to continue demo)

Demo 4: WITH set -o pipefail (catch pipe failures)
--------------------------------
Without pipefail, this would hide the failure:
  cat /nonexistent | sort
  (only 'sort' return code would matter)

With pipefail, any failure in pipe causes error:
  cat /etc/hosts | grep localhost | wc -l
  1
  ✅ Pipeline succeeded

================================
Strict mode demo complete!
================================
```

---

### What Each Flag Does

| Flag | What it does | Example |
|------|--------------|---------|
| `set -e` | Exit immediately if any command returns non-zero exit code | `false; echo "Won't print"` → Script exits |
| `set -u` | Treat unset variables as errors and exit | `echo "$UNDEFINED"` → Script exits with error |
| `set -o pipefail` | Return value of pipeline is value of rightmost command to exit with non-zero status | `false \| true` → Returns 1 (fail) instead of 0 |

**Detailed explanations:**

**`set -e` - Exit on error**
```bash
# WITHOUT set -e:
false
echo "This prints"     # Runs even though previous failed

# WITH set -e:
set -e
false
echo "Never prints"    # Script exits after false
```

**`set -u` - Error on undefined variables**
```bash
# WITHOUT set -u:
echo "$UNDEFINED"      # Prints empty line, continues

# WITH set -u:
set -u
echo "$UNDEFINED"      # Error: UNDEFINED: unbound variable
```

**`set -o pipefail` - Catch pipe failures**
```bash
# WITHOUT pipefail:
false | true
echo $?                # Prints: 0 (only checks last command)

# WITH pipefail:
set -o pipefail
false | true
echo $?                # Prints: 1 (checks all commands in pipe)
```

---

## Task 4: Local Variables

### local_demo.sh
```bash
#!/bin/bash

# Script: local_demo.sh
# Purpose: Demonstrate local vs global variables in functions
# Date: 2026-02-18

set -euo pipefail

echo "================================"
echo "   Local Variables Demo         "
echo "================================"
echo ""

# ── Global variable ─────────────────────────────────────
GLOBAL_VAR="I am global"

# ── Function WITHOUT local (bad practice) ───────────────
function_without_local() {
    LEAKED_VAR="I leaked out!"
    echo "  Inside function_without_local:"
    echo "    LEAKED_VAR = $LEAKED_VAR"
}

# ── Function WITH local (good practice) ─────────────────
function_with_local() {
    local LOCAL_VAR="I stay inside"
    echo "  Inside function_with_local:"
    echo "    LOCAL_VAR = $LOCAL_VAR"
}

# ── Function modifying global ───────────────────────────
modify_global() {
    local LOCAL_COPY=$GLOBAL_VAR
    GLOBAL_VAR="Modified by function"
    echo "  Inside modify_global:"
    echo "    LOCAL_COPY = $LOCAL_COPY"
    echo "    GLOBAL_VAR = $GLOBAL_VAR"
}

# ── Demonstration ───────────────────────────────────────
echo "Demo 1: Function WITHOUT local keyword"
echo "Before calling function_without_local:"
echo "  LEAKED_VAR is not set yet"
echo ""

function_without_local

echo ""
echo "After calling function_without_local:"
echo "  LEAKED_VAR = $LEAKED_VAR"  # Variable leaked!
echo "  ⚠️  Variable leaked to global scope!"
echo ""

echo "================================"
echo ""

echo "Demo 2: Function WITH local keyword"
function_with_local

echo ""
echo "After calling function_with_local:"
echo "  Trying to access LOCAL_VAR..."
# This would fail with set -u:
# echo "  LOCAL_VAR = $LOCAL_VAR"
echo "  LOCAL_VAR doesn't exist outside function ✅"
echo ""

echo "================================"
echo ""

echo "Demo 3: Modifying global variable"
echo "Before calling modify_global:"
echo "  GLOBAL_VAR = $GLOBAL_VAR"
echo ""

modify_global

echo ""
echo "After calling modify_global:"
echo "  GLOBAL_VAR = $GLOBAL_VAR"  # Changed!
echo ""

echo "================================"
echo ""

echo "Best Practices:"
echo "  ✅ Always use 'local' for function variables"
echo "  ✅ Prevents accidental global variable pollution"
echo "  ✅ Makes functions more predictable and safer"
echo "  ❌ Avoid modifying global variables from functions"
echo ""

echo "================================"
```

**Output:**
```
================================
   Local Variables Demo         
================================

Demo 1: Function WITHOUT local keyword
Before calling function_without_local:
  LEAKED_VAR is not set yet

  Inside function_without_local:
    LEAKED_VAR = I leaked out!

After calling function_without_local:
  LEAKED_VAR = I leaked out!
  ⚠️  Variable leaked to global scope!

================================

Demo 2: Function WITH local keyword
  Inside function_with_local:
    LOCAL_VAR = I stay inside

After calling function_with_local:
  Trying to access LOCAL_VAR...
  LOCAL_VAR doesn't exist outside function ✅

================================

Demo 3: Modifying global variable
Before calling modify_global:
  GLOBAL_VAR = I am global

  Inside modify_global:
    LOCAL_COPY = I am global
    GLOBAL_VAR = Modified by function

After calling modify_global:
  GLOBAL_VAR = Modified by function

================================

Best Practices:
  ✅ Always use 'local' for function variables
  ✅ Prevents accidental global variable pollution
  ✅ Makes functions more predictable and safer
  ❌ Avoid modifying global variables from functions

================================
```

---

## Task 5: System Info Reporter

### system_info.sh
```bash
#!/bin/bash

# Script: system_info.sh
# Purpose: Comprehensive system information reporter using functions
# Date: 2026-02-18

set -euo pipefail

# ── Colour Codes ────────────────────────────────────────
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly MAGENTA='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'  # No Colour

# ── Helper Functions ────────────────────────────────────
print_header() {
    local TITLE=$1
    echo ""
    echo -e "${CYAN}${BOLD}========================================${NC}"
    echo -e "${CYAN}${BOLD}  $TITLE${NC}"
    echo -e "${CYAN}${BOLD}========================================${NC}"
}

print_section() {
    local SECTION=$1
    echo ""
    echo -e "${BLUE}${BOLD}── $SECTION ──${NC}"
}

# ── Function: Hostname & OS Info ────────────────────────
show_system_info() {
    print_section "System Information"
    
    echo "Hostname:     $(hostname)"
    echo "Kernel:       $(uname -r)"
    echo "OS:           $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo "Architecture: $(uname -m)"
    echo "Date & Time:  $(date '+%Y-%m-%d %H:%M:%S %Z')"
}

# ── Function: Uptime ────────────────────────────────────
show_uptime() {
    print_section "System Uptime"
    
    local UPTIME_INFO=$(uptime -p)
    local UPTIME_SINCE=$(uptime -s)
    
    echo "Uptime:       $UPTIME_INFO"
    echo "Running since: $UPTIME_SINCE"
    
    # Load average
    local LOAD=$(uptime | awk -F'load average:' '{print $2}')
    echo "Load average: $LOAD"
}

# ── Function: Disk Usage ────────────────────────────────
show_disk_usage() {
    print_section "Disk Usage (Top 5 Filesystems)"
    
    echo ""
    df -h | head -1
    df -h | tail -n +2 | sort -k5 -rn | head -5
    
    echo ""
    echo "Largest directories in /var:"
    du -sh /var/* 2>/dev/null | sort -rh | head -5
}

# ── Function: Memory Usage ──────────────────────────────
show_memory_usage() {
    print_section "Memory Usage"
    
    echo ""
    free -h
    
    echo ""
    local TOTAL=$(free -m | awk 'NR==2 {print $2}')
    local USED=$(free -m | awk 'NR==2 {print $3}')
    local AVAILABLE=$(free -m | awk 'NR==2 {print $7}')
    local PERCENT=$((USED * 100 / TOTAL))
    
    echo "Summary:"
    echo "  Total:     ${TOTAL}M"
    echo "  Used:      ${USED}M (${PERCENT}%)"
    echo "  Available: ${AVAILABLE}M"
    
    if [ "$PERCENT" -gt 80 ]; then
        echo -e "  ${RED}⚠️  Memory usage is high!${NC}"
    else
        echo -e "  ${GREEN}✅ Memory usage is healthy${NC}"
    fi
}

# ── Function: Top CPU Processes ─────────────────────────
show_top_processes() {
    print_section "Top 5 CPU-Consuming Processes"
    
    echo ""
    echo "PID    USER       CPU%  MEM%  COMMAND"
    echo "----------------------------------------"
    ps aux --sort=-%cpu | awk 'NR>1 {printf "%-6s %-10s %5s %5s  %s\n", $2, $1, $3, $4, $11}' | head -5
}

# ── Function: Network Info ──────────────────────────────
show_network_info() {
    print_section "Network Information"
    
    echo ""
    echo "Active interfaces:"
    ip -brief addr show | grep -v "lo" | head -3
    
    echo ""
    echo "Listening ports (top 5):"
    ss -tulpn 2>/dev/null | grep LISTEN | head -5 | awk '{print "  " $5, $7}' || echo "  (no data - run as root for details)"
}

# ── Function: Recent Logins ─────────────────────────────
show_recent_logins() {
    print_section "Recent Login Activity"
    
    echo ""
    echo "Last 5 logins:"
    last -5 -F | head -5
}

# ── Main Function ───────────────────────────────────────
main() {
    # Clear screen for clean output
    clear
    
    # Title
    echo -e "${MAGENTA}${BOLD}"
    cat << "EOF"
╔════════════════════════════════════════╗
║   SYSTEM INFORMATION REPORTER          ║
║   90 Days of DevOps - Day 18           ║
╚════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    
    # Call all info functions
    show_system_info
    show_uptime
    show_disk_usage
    show_memory_usage
    show_top_processes
    show_network_info
    show_recent_logins
    
    # Footer
    print_header "Report Complete"
    echo ""
    echo -e "${GREEN}Generated on: $(date)${NC}"
    echo -e "${GREEN}Hostname: $(hostname)${NC}"
    echo ""
}

# ── Execute Main ────────────────────────────────────────
main
```

**Sample Output:**
```
╔════════════════════════════════════════╗
║   SYSTEM INFORMATION REPORTER          ║
║   90 Days of DevOps - Day 18           ║
╚════════════════════════════════════════╝

========================================
  System Information
========================================

── System Information ──
Hostname:     devops-server
Kernel:       6.8.0-49-generic
OS:           Ubuntu 24.04 LTS
Architecture: x86_64
Date & Time:  2026-02-18 17:30:00 UTC

── System Uptime ──
Uptime:       up 11 days, 11 hours, 30 minutes
Running since: 2026-02-07 06:00:00
Load average:  0.15, 0.18, 0.12

── Disk Usage (Top 5 Filesystems) ──

Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3        46G   12G   32G  27% /
/dev/sda1       974M  258M  649M  29% /boot
tmpfs           7.8G     0  7.8G   0% /dev/shm
tmpfs           1.6G  1.6M  1.6G   1% /run

Largest directories in /var:
4.2G    /var/lib
1.1G    /var/cache
512M    /var/log
128M    /var/tmp
64M     /var/spool

── Memory Usage ──

               total        used        free      shared  buff/cache   available
Mem:            15Gi       4.2Gi       8.1Gi       156Mi       3.5Gi        11Gi
Swap:          2.0Gi          0B       2.0Gi

Summary:
  Total:     15872M
  Used:      4300M (27%)
  Available: 11572M
  ✅ Memory usage is healthy

── Top 5 CPU-Consuming Processes ──

PID    USER       CPU%  MEM%  COMMAND
----------------------------------------
2456   devuser     3.2   1.8  /usr/lib/firefox
1234   root        2.1   0.5  /lib/systemd/systemd
3567   www-data    1.5   0.3  nginx:
4123   devuser     0.8   0.2  /usr/bin/code
5234   devuser     0.5   1.2  /usr/bin/docker

── Network Information ──

Active interfaces:
eth0      UP    192.168.1.105/24
docker0   UP    172.17.0.1/16

Listening ports (top 5):
  0.0.0.0:22 users:(("sshd",pid=1234))
  0.0.0.0:80 users:(("nginx",pid=2345))
  0.0.0.0:443 users:(("nginx",pid=2345))
  127.0.0.1:6379 users:(("redis-server",pid=3456))
  0.0.0.0:3000 users:(("node",pid=4567))

── Recent Login Activity ──

Last 5 logins:
devuser  pts/1    192.168.1.50  Mon Feb 18 16:45:23 2026 - still logged in
devuser  pts/0    192.168.1.50  Mon Feb 18 14:20:15 2026 - 16:30:00 (02:09)
root     tty1                   Sun Feb 17 22:10:05 2026 - 22:15:00 (00:04)

========================================
  Report Complete
========================================

Generated on: Mon Feb 18 17:30:00 UTC 2026
Hostname: devops-server
```

---

## All Scripts Summary
```bash
ls -lh *.sh
```

**Output:**
```
-rwxr-xr-x 1 devuser devuser  845 Feb 18 17:00 functions.sh
-rwxr-xr-x 1 devuser devuser 1.2K Feb 18 17:05 disk_check.sh
-rwxr-xr-x 1 devuser devuser 1.8K Feb 18 17:10 strict_demo.sh
-rwxr-xr-x 1 devuser devuser 2.1K Feb 18 17:15 local_demo.sh
-rwxr-xr-x 1 devuser devuser 4.5K Feb 18 17:20 system_info.sh
```

---

## What I Learned

### 1. Functions Make Scripts Modular and Reusable

**Without functions (repetitive):**
```bash
#!/bin/bash
echo "Checking disk..."
df -h /
echo "Disk check done"

echo "Checking memory..."
free -h
echo "Memory check done"

echo "Checking CPU..."
top -bn1 | head -10
echo "CPU check done"
```

**With functions (clean and reusable):**
```bash
#!/bin/bash

check_disk() {
    echo "Checking disk..."
    df -h /
}

check_memory() {
    echo "Checking memory..."
    free -h
}

check_cpu() {
    echo "Checking CPU..."
    top -bn1 | head -10
}

# Main
check_disk
check_memory
check_cpu
```

**Benefits of functions:**
- **DRY Principle:** Don't Repeat Yourself
- **Maintainability:** Fix bug once, not everywhere
- **Readability:** `main()` function reads like documentation
- **Testing:** Test individual functions separately
- **Reusability:** Import functions into other scripts

---

### 2. Strict Mode (`set -euo pipefail`) Prevents Silent Failures

**The problem with default bash:**
```bash
#!/bin/bash
# This script has HIDDEN BUGS!

cd /app                    # Fails silently if /app doesn't exist
git pull                   # Runs in WRONG directory!
systemctl restart myapp    # Restarts with OLD code!
echo "Deployment successful" # LIES!
```

**With strict mode - bugs caught immediately:**
```bash
#!/bin/bash
set -euo pipefail

cd /app                    # Script EXITS if this fails
git pull                   # Never runs if cd failed
systemctl restart myapp    # Never runs if pull failed
echo "Deployment successful" # Only prints if ALL steps succeeded
```

**Real-world impact:**

| Scenario | Without strict mode | With `set -euo pipefail` |
|----------|---------------------|--------------------------|
| `cd /missing` fails | Script continues in wrong directory | Script exits with error |
| Undefined `$VAR` | Empty string, silent bug | Error: unbound variable |
| `false \| true` pipe | Returns 0 (success) | Returns 1 (failure) |

**Best practice template:**
```bash
#!/usr/bin/env bash
set -euo pipefail

# Optional: log errors with line numbers
trap 'echo "Error on line $LINENO"' ERR

# Your code here
```

---

### 3. Local Variables Prevent Function Side Effects

**The danger of global variables:**
```bash
#!/bin/bash
CONFIG="/etc/app/config"

deploy() {
    CONFIG="/tmp/temp-config"   # OOPS! Modified global
    echo "Using $CONFIG"
}

deploy
echo "Config: $CONFIG"          # Now broken everywhere!
# Output: Config: /tmp/temp-config  (unexpected!)
```

**Safe with local variables:**
```bash
#!/bin/bash
CONFIG="/etc/app/config"

deploy() {
    local CONFIG="/tmp/temp-config"   # Stays in function
    echo "Using $CONFIG"
}

deploy
echo "Config: $CONFIG"          # Still correct!
# Output: Config: /etc/app/config  (as expected!)
```

**Rules for clean functions:**
```bash
my_function() {
    # ✅ GOOD: Declare all variables as local
    local INPUT=$1
    local RESULT=""
    local TEMP_FILE="/tmp/myfile"
    
    # Process using local variables
    RESULT=$(process "$INPUT")
    
    # Return via echo (stdout)
    echo "$RESULT"
}

# ❌ BAD: Don't modify globals from functions
my_bad_function() {
    GLOBAL_VAR="modified"   # Pollutes global scope
}
```

**Function best practices:**
1. Always use `local` for function variables
2. Accept input via parameters (`$1`, `$2`)
3. Return output via `echo` to stdout
4. Don't modify global state
5. Make functions pure (same input = same output)

---

## Quick Reference

### Function Syntax
```bash
# Basic function
function_name() {
    echo "Hello"
}

# Function with arguments
greet() {
    local NAME=$1
    echo "Hello, $NAME"
}
greet "DevOps"

# Function with return value (via echo)
add() {
    local SUM=$(($1 + $2))
    echo "$SUM"
}
RESULT=$(add 5 3)
echo "Result: $RESULT"
```

---

### Strict Mode
```bash
set -e           # Exit on error
set -u           # Error on undefined variable
set -o pipefail  # Catch pipe failures

# Combined:
set -euo pipefail

# With error trap:
set -euo pipefail
trap 'echo "Error on line $LINENO"' ERR
```

---

### Local Variables
```bash
my_function() {
    local VAR1="local"      # Stays in function
    VAR2="global"           # Leaks to global scope
}

my_function
echo "$VAR1"    # Error: unbound variable (with set -u)
echo "$VAR2"    # Works but bad practice
```

---

### Function Patterns
```bash
# Check function
check_disk() {
    local USAGE=$(df -h / | awk 'NR==2 {print $5}')
    echo "Disk usage: $USAGE"
}

# Validation function
validate_input() {
    local INPUT=$1
    [ -z "$INPUT" ] && { echo "Error: empty input"; return 1; }
    return 0
}

# Main function pattern
main() {
    validate_input "$1" || exit 1
    check_disk
    echo "Complete"
}

main "$@"
```

---

## Summary

**Challenge Completed:** ✅ All 5 tasks finished

**Scripts Created:**
- `functions.sh` - Basic functions with arguments
- `disk_check.sh` - Functions with system checks
- `strict_demo.sh` - Demonstrate `set -euo pipefail`
- `local_demo.sh` - Local vs global variables
- `system_info.sh` - Comprehensive system reporter

**Key Concepts Mastered:**
1. **Functions** - Modular, reusable code blocks
2. **Strict mode** - `set -euo pipefail` for safety
3. **Local variables** - Prevent side effects
4. **Return values** - Via `echo` to stdout
5. **Organized scripts** - `main()` function pattern

**Production-Ready Patterns Learned:**
- Always start with `set -euo pipefail`
- Use `local` for all function variables
- Create helper functions for repeated tasks
- Use `main()` function for entry point
- Add colour codes for better UX
- Include error handling at every step

---

**Created for:** 90 Days of DevOps Challenge - Day 18  
**Date:** February 18, 2026  
**Next Steps:** Advanced scripting, automation workflows, real-world DevOps tools

---

## LinkedIn Post

🚀 **Day 18 of #90DaysOfDevOps Complete!**

Today I mastered functions and strict mode in bash - the difference between amateur and production scripts!

**Key achievements:**
✅ Built modular functions with local variables
✅ Implemented strict mode: `set -euo pipefail`
✅ Created comprehensive system info reporter
✅ Learned to prevent silent failures

**Game-changer I discovered:**
```bash
set -euo pipefail
trap 'echo "Error on line $LINENO"' ERR
```

This catches errors that would otherwise SILENTLY DESTROY production systems!

**Favorite build:**
System info reporter with 7 functions - hostname, uptime, disk, memory, CPU, network, logins. Clean, modular, reusable! 📊
```
Without functions: 200 lines, repetitive, hard to maintain
With functions: 150 lines, organized, easy to test
```
