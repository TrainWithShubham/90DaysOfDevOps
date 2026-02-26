# Day 17 - Shell Scripting: Loops, Arguments & Error Handling

**Date:** February 17, 2026  
**Focus:** Mastering loops, command-line arguments, and error handling in bash

---

## Task 1: For Loop

### for_loop.sh
```bash
#!/bin/bash

# Script: for_loop.sh
# Purpose: Loop through a list of 5 fruits and print each one

echo "================================"
echo "       Fruits List              "
echo "================================"
echo ""

# Loop through list of fruits
for fruit in Apple Banana Cherry Mango Watermelon
do
    echo "Fruit: $fruit"
done

echo ""
echo "================================"
```

**Make executable and run:**
```bash
chmod +x for_loop.sh
./for_loop.sh
```

**Output:**
```
================================
       Fruits List              
================================

Fruit: Apple
Fruit: Banana
Fruit: Cherry
Fruit: Mango
Fruit: Watermelon

================================
```

---

### count.sh
```bash
#!/bin/bash

# Script: count.sh
# Purpose: Print numbers 1 to 10 using a for loop

echo "================================"
echo "     Counting 1 to 10           "
echo "================================"
echo ""

# Method 1: Using range {1..10}
echo "Numbers from 1 to 10:"
for i in {1..10}
do
    echo "$i"
done

echo ""
echo "================================"
```

**Make executable and run:**
```bash
chmod +x count.sh
./count.sh
```

**Output:**
```
================================
     Counting 1 to 10           
================================

Numbers from 1 to 10:
1
2
3
4
5
6
7
8
9
10

================================
```

---

## Task 2: While Loop

### countdown.sh
```bash
#!/bin/bash

# Script: countdown.sh
# Purpose: Countdown from user input to 0 using while loop

echo "================================"
echo "       Countdown Timer          "
echo "================================"
echo ""

# Get number from user
read -p "Enter a number to countdown from: " NUMBER

# Validate input is a number
if ! [[ "$NUMBER" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number!"
    exit 1
fi

echo ""
echo "Counting down from $NUMBER:"
echo "--------------------------------"

# Countdown using while loop
while [ $NUMBER -gt 0 ]
do
    echo "$NUMBER"
    NUMBER=$((NUMBER - 1))
    sleep 0.5    # Small delay for visual effect
done

echo "0"
echo ""
echo "Done!"
echo "================================"
```

**Make executable and run:**
```bash
chmod +x countdown.sh
./countdown.sh
```

**Sample Run:**
```
================================
       Countdown Timer          
================================

Enter a number to countdown from: 5

Counting down from 5:
--------------------------------
5
4
3
2
1
0

Done!
================================
```

---

## Task 3: Command-Line Arguments

### greet.sh
```bash
#!/bin/bash

# Script: greet.sh
# Purpose: Greet user by name passed as argument
# Usage: ./greet.sh <name>

# Check if argument was provided
if [ $# -eq 0 ]; then
    echo "Usage: ./greet.sh <name>"
    exit 1
fi

# Get name from first argument
NAME=$1

# Print greeting
echo "Hello, $NAME!"
```

**Make executable and test:**
```bash
chmod +x greet.sh
```

**Run without argument:**
```bash
./greet.sh
```
**Output:**
```
Usage: ./greet.sh <name>
```

**Run with argument:**
```bash
./greet.sh Rahul
```
**Output:**
```
Hello, Rahul!
```

**Run with multiple word name:**
```bash
./greet.sh "Rahul Kumar"
```
**Output:**
```
Hello, Rahul Kumar!
```

---

### args_demo.sh
```bash
#!/bin/bash

# Script: args_demo.sh
# Purpose: Demonstrate command-line arguments
# Usage: ./args_demo.sh arg1 arg2 arg3 ...

echo "================================"
echo "   Command-Line Arguments Demo  "
echo "================================"
echo ""

# Print script name ($0)
echo "Script name:         $0"
echo ""

# Print total number of arguments ($#)
echo "Number of arguments: $#"
echo ""

# Print all arguments ($@)
echo "All arguments:       $@"
echo ""

# Print individual arguments if available
if [ $# -ge 1 ]; then
    echo "First argument (\$1): $1"
fi

if [ $# -ge 2 ]; then
    echo "Second argument (\$2): $2"
fi

if [ $# -ge 3 ]; then
    echo "Third argument (\$3): $3"
fi

echo ""
echo "================================"
```

**Make executable and test:**
```bash
chmod +x args_demo.sh
```

**Run without arguments:**
```bash
./args_demo.sh
```
**Output:**
```
================================
   Command-Line Arguments Demo  
================================

Script name:         ./args_demo.sh

Number of arguments: 0

All arguments:       

================================
```

**Run with multiple arguments:**
```bash
./args_demo.sh DevOps Linux Bash
```
**Output:**
```
================================
   Command-Line Arguments Demo  
================================

Script name:         ./args_demo.sh

Number of arguments: 3

All arguments:       DevOps Linux Bash

First argument ($1): DevOps
Second argument ($2): Linux
Third argument ($3): Bash

================================
```

---

## Task 4: Install Packages via Script

### install_packages.sh
```bash
#!/bin/bash

# Script: install_packages.sh
# Purpose: Check and install required packages automatically
# Usage: sudo ./install_packages.sh

set -e    # Exit on error

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root!"
    echo ""
    echo "Usage:"
    echo "  sudo $0"
    echo "  sudo -i then $0"
    exit 1
fi

# Define packages to install
PACKAGES=("nginx" "curl" "wget")

# Statistics
INSTALLED=0
SKIPPED=0

echo "================================"
echo "   Package Installation Script  "
echo "================================"
echo ""
echo "Packages to check: ${PACKAGES[@]}"
echo "Total: ${#PACKAGES[@]} packages"
echo ""
echo "================================"

# Loop through each package
for PACKAGE in "${PACKAGES[@]}"
do
    echo ""
    echo "Checking: $PACKAGE"
    echo "--------------------------------"

    # Check if package is installed
    if dpkg -s "$PACKAGE" &> /dev/null; then
        # Package is already installed
        VERSION=$(dpkg -s "$PACKAGE" | grep "^Version:" | awk '{print $2}')
        echo "Status:  Already installed ✓"
        echo "Version: $VERSION"
        echo "Action:  SKIPPED"
        SKIPPED=$((SKIPPED + 1))
    else
        # Package not installed, install it
        echo "Status:  Not installed"
        echo "Action:  INSTALLING..."

        # Install package
        apt-get install -y "$PACKAGE" &> /dev/null

        if [ $? -eq 0 ]; then
            echo "Result:  Installed successfully ✓"
            INSTALLED=$((INSTALLED + 1))
        else
            echo "Result:  Installation failed ✗"
        fi
    fi
done

# Summary
echo ""
echo "================================"
echo "        Summary Report          "
echo "================================"
echo "Total packages checked: ${#PACKAGES[@]}"
echo "Installed:              $INSTALLED"
echo "Skipped (already present): $SKIPPED"
echo ""
echo "Installation complete!"
echo "================================"
```

**Run as root:**
```bash
chmod +x install_packages.sh
sudo ./install_packages.sh
```

**Sample Output:**
```
================================
   Package Installation Script  
================================

Packages to check: nginx curl wget
Total: 3 packages

================================

Checking: nginx
--------------------------------
Status:  Not installed
Action:  INSTALLING...
Result:  Installed successfully ✓

Checking: curl
--------------------------------
Status:  Already installed ✓
Version: 7.88.1-10ubuntu1
Action:  SKIPPED

Checking: wget
--------------------------------
Status:  Already installed ✓
Version: 1.21.3-1ubuntu1
Action:  SKIPPED

================================
        Summary Report          
================================
Total packages checked: 3
Installed:              1
Skipped (already present): 2

Installation complete!
================================
```

**If run without root:**
```
Error: This script must be run as root!

Usage:
  sudo ./install_packages.sh
  sudo -i then ./install_packages.sh
```

---

## Task 5: Error Handling

### safe_script.sh
```bash
#!/bin/bash

# Script: safe_script.sh
# Purpose: Demonstrate error handling with set -e and || operator
# Date: 2026-02-17

set -e    # Exit immediately if a command fails

echo "================================"
echo "     Safe Script Demo           "
echo "================================"
echo ""

# Step 1: Create directory
echo "Step 1: Creating directory /tmp/devops-test"
mkdir /tmp/devops-test || echo "Directory already exists (not an error)"
echo "  ✓ Directory ready"
echo ""

# Step 2: Navigate into directory
echo "Step 2: Navigating to /tmp/devops-test"
cd /tmp/devops-test || { echo "  ✗ Error: Cannot cd into directory"; exit 1; }
echo "  ✓ Now in: $(pwd)"
echo ""

# Step 3: Create a file
echo "Step 3: Creating test file"
echo "Hello DevOps!" > test-file.txt || { echo "  ✗ Error: Cannot create file"; exit 1; }
echo "  ✓ File created: test-file.txt"
echo ""

# Step 4: Verify file contents
echo "Step 4: Verifying file"
if [ -f test-file.txt ]; then
    echo "  ✓ File exists"
    echo "  Content: $(cat test-file.txt)"
else
    echo "  ✗ Error: File not found!"
    exit 1
fi
echo ""

# Step 5: Show file details
echo "Step 5: File details"
ls -lh test-file.txt
echo ""

echo "================================"
echo "All steps completed successfully!"
echo "================================"
```

**Make executable and run:**
```bash
chmod +x safe_script.sh
./safe_script.sh
```

**First Run Output:**
```
================================
     Safe Script Demo           
================================

Step 1: Creating directory /tmp/devops-test
  ✓ Directory ready

Step 2: Navigating to /tmp/devops-test
  ✓ Now in: /tmp/devops-test

Step 3: Creating test file
  ✓ File created: test-file.txt

Step 4: Verifying file
  ✓ File exists
  Content: Hello DevOps!

Step 5: File details
-rw-r--r-- 1 devuser devuser 14 Feb 17 17:30 test-file.txt

================================
All steps completed successfully!
================================
```

**Second Run Output (directory exists):**
```
================================
     Safe Script Demo           
================================

Step 1: Creating directory /tmp/devops-test
Directory already exists (not an error)
  ✓ Directory ready

Step 2: Navigating to /tmp/devops-test
  ✓ Now in: /tmp/devops-test

Step 3: Creating test file
  ✓ File created: test-file.txt

Step 4: Verifying file
  ✓ File exists
  Content: Hello DevOps!

Step 5: File details
-rw-r--r-- 1 devuser devuser 14 Feb 17 17:31 test-file.txt

================================
All steps completed successfully!
================================
```

---

### Updated install_packages.sh with Root Check

The `install_packages.sh` script already includes root checking. Here's the relevant section:
```bash
# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root!"
    echo ""
    echo "Usage:"
    echo "  sudo $0"
    echo "  sudo -i then $0"
    exit 1
fi
```

**Test as non-root:**
```bash
./install_packages.sh
```
**Output:**
```
Error: This script must be run as root!

Usage:
  sudo ./install_packages.sh
  sudo -i then ./install_packages.sh
```

---

## All Scripts Summary
```bash
ls -l *.sh
```

**Output:**
```
-rwxr-xr-x 1 devuser devuser  412 Feb 17 17:00 for_loop.sh
-rwxr-xr-x 1 devuser devuser  389 Feb 17 17:05 count.sh
-rwxr-xr-x 1 devuser devuser  634 Feb 17 17:10 countdown.sh
-rwxr-xr-x 1 devuser devuser  328 Feb 17 17:15 greet.sh
-rwxr-xr-x 1 devuser devuser  789 Feb 17 17:20 args_demo.sh
-rwxr-xr-x 1 devuser devuser 1456 Feb 17 17:25 install_packages.sh
-rwxr-xr-x 1 devuser devuser  923 Feb 17 17:30 safe_script.sh
```

---

## What I Learned

### 1. For Loops Make Repetitive Tasks Simple

**Without loops:**
```bash
echo "Apple"
echo "Banana"
echo "Cherry"
echo "Mango"
echo "Watermelon"
```

**With loops:**
```bash
for fruit in Apple Banana Cherry Mango Watermelon; do
    echo "$fruit"
done
```

**Key benefits:**
- Less code to write and maintain
- Easy to add or remove items
- Can process dynamic lists (files, command output)

**Real-world applications:**
```bash
# Process all log files
for log in /var/log/*.log; do
    grep "ERROR" "$log"
done

# Check multiple services
for service in nginx docker ssh; do
    systemctl status $service
done

# Backup multiple directories
for dir in /etc /home /var/www; do
    tar -czf backup-$(basename $dir).tar.gz $dir
done
```

---

### 2. Command-Line Arguments Make Scripts Flexible and Reusable

**Hard-coded (inflexible):**
```bash
#!/bin/bash
SERVICE="nginx"
systemctl restart $SERVICE
```

**With arguments (reusable):**
```bash
#!/bin/bash
SERVICE=$1
systemctl restart $SERVICE

# Usage:
# ./restart.sh nginx
# ./restart.sh docker
# ./restart.sh apache2
```

**Important argument variables:**
- `$0` - Script name
- `$1, $2, $3` - Individual arguments
- `$#` - Count of arguments
- `$@` - All arguments (recommended for loops)
- `$*` - All arguments as single string

**Best practices:**
```bash
# Always validate arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 <argument>"
    exit 1
fi

# Use meaningful variable names
USERNAME=$1
PASSWORD=$2

# Provide defaults
PORT=${1:-8080}    # Use 8080 if no argument
```

---

### 3. Error Handling Prevents Silent Failures

**Without error handling:**
```bash
#!/bin/bash
cd /app
git pull
systemctl restart myapp
# If cd fails, git pull runs in wrong directory!
# If git pull fails, we restart with old code!
```

**With error handling:**
```bash
#!/bin/bash
set -e    # Exit on any error

cd /app || { echo "Failed to cd"; exit 1; }
git pull || { echo "Git pull failed"; exit 1; }
systemctl restart myapp || { echo "Restart failed"; exit 1; }
```

**Error handling techniques:**

**1. `set -e` - Exit on error**
```bash
set -e
mkdir /tmp/test
cd /tmp/test
# If mkdir fails, script stops immediately
```

**2. `||` operator - Handle specific errors**
```bash
mkdir /tmp/test || echo "Directory already exists"
cd /tmp/test || { echo "Cannot cd"; exit 1; }
```

**3. Check exit codes**
```bash
command
if [ $? -ne 0 ]; then
    echo "Command failed!"
    exit 1
fi
```

**4. Validate before executing**
```bash
# Check if file exists
[ ! -f config.txt ] && { echo "Config missing!"; exit 1; }

# Check if running as root
[ "$EUID" -ne 0 ] && { echo "Run as root"; exit 1; }

# Check if variable is set
[ -z "$API_KEY" ] && { echo "API_KEY not set"; exit 1; }
```

---

## Quick Reference

### For Loop Syntax
```bash
# List of items
for item in item1 item2 item3; do
    echo "$item"
done

# Range
for i in {1..10}; do
    echo "$i"
done

# Files
for file in *.txt; do
    echo "$file"
done

# Array
SERVICES=("nginx" "docker" "ssh")
for service in "${SERVICES[@]}"; do
    echo "$service"
done
```

---

### While Loop Syntax
```bash
# Counter-based
COUNTER=10
while [ $COUNTER -gt 0 ]; do
    echo "$COUNTER"
    COUNTER=$((COUNTER - 1))
done

# Read from file
while IFS= read -r line; do
    echo "$line"
done < file.txt

# Infinite loop
while true; do
    echo "Press Ctrl+C to exit"
    sleep 1
done
```

---

### Arguments
```bash
$0    # Script name
$1    # First argument
$2    # Second argument
$#    # Number of arguments
$@    # All arguments (use this in loops)
$?    # Exit code of last command

# Usage check
if [ $# -eq 0 ]; then
    echo "Usage: $0 <arg>"
    exit 1
fi

# Default value
PORT=${1:-8080}
```

---

### Error Handling
```bash
set -e                 # Exit on error
set -u                 # Error on undefined variable
set -o pipefail        # Catch pipe errors

# OR operator
cmd || echo "Failed"

# AND operator
cmd && echo "Success"

# Exit with message
cmd || { echo "Error"; exit 1; }

# Check condition
[ condition ] || { echo "Failed"; exit 1; }
```

---

## Summary

**Challenge Completed:** ✅ All 5 tasks finished

**Scripts Created:** 7 scripts
- `for_loop.sh` - Loop through fruits
- `count.sh` - Count 1 to 10
- `countdown.sh` - While loop countdown
- `greet.sh` - Use command-line arguments
- `args_demo.sh` - Demonstrate all argument variables
- `install_packages.sh` - Automate package installation
- `safe_script.sh` - Error handling demonstration

**Key Concepts Mastered:**
1. **For loops** - Iterate through lists, ranges, and files
2. **While loops** - Condition-based repetition
3. **Arguments** - Make scripts flexible with `$1`, `$@`, `$#`
4. **Error handling** - `set -e`, `||` operator, validation
5. **Root checking** - Validate privileges before execution

**Skills Gained:**
- Automate repetitive tasks with loops
- Create reusable scripts with arguments
- Handle errors to prevent silent failures
- Build production-ready scripts with proper validation

---

**Created for:** 90 Days of DevOps Challenge - Day 17  
**Date:** February 17, 2026  
**Next Steps:** Functions, advanced scripting, and real-world automation projects

-
