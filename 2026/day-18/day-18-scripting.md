# Day 18 – Shell Scripting: Functions & Slightly Advanced Concepts
--------
## Task 1: Basic Functions
1. created `functions.sh` script file.
- Code
```bash
#!/bin/bash

greet() {
        local name="$1"
        echo "Hello, $name!"
}

add() {
        local num1="$1"
        local num2="$2"
        local sum=$((num1 + num2))
        echo "The sum of $num1 and $num2 is: $sum"
}

greet "Alice"
add 15 27
```
- Output
```shell
ubuntu@ip-172-31-23-228:~/day18$ chmod 755 functions.sh
ubuntu@ip-172-31-23-228:~/day18$ ./functions.sh
Hello, Alice!
The sum of 15 and 27 is: 42
```
------------
## Task 2: Functions with Return Values
1. created `disk_check.sh` script file.
- Code
```bash
#!/bin/bash

check_disk() {
        echo "---Disk Usage (Root/)---"
        df -h /
        # grep '/' isolates the root partition
        echo ""
}

check_memory(){
        echo "--Memory Usage--"
        free -h
        echo ""
}

main(){
        echo "==================="
        echo "SYSTEM HEALTH CHECK"
        echo "==================="
        check_disk
        check_memory
        echo "Check completed successfully."
}

main
```
- Output
```shell
ubuntu@ip-172-31-23-228:~/day18$ chmod 755 disk_check.sh
ubuntu@ip-172-31-23-228:~/day18$ ./disk_check.sh
===================
SYSTEM HEALTH CHECK
===================
---Disk Usage (Root/)---
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       6.8G  2.2G  4.6G  33% /

--Memory Usage--
               total        used        free      shared  buff/cache   available
Mem:           914Mi       391Mi       132Mi       2.7Mi       593Mi       522Mi
Swap:             0B          0B          0B

Check completed successfully.
```
-------
## Task 3: Strict Mode — set -euo pipefail
1. created `strict_demo.sh` script file.
- Code
---
```bash
#!/bin/bash

set -euo pipefail

echo "--- Testing set -u (Undefined Variables) ---"
# This will trigger an error because 'USER_NAME' is not defined
# echo "Hello, $USER_NAME"

echo "--- Testing set -e (Command Failure) ---"
# This will fail because the directory doesn't exist
# ls /non_existent_directory_123

echo "--- Testing set -o pipefail (Pipeline Failure) ---"
# Without pipefail, 'echo' succeeding would hide 'grep' failing.
# With pipefail, the failure of 'grep' stops the script.
# cat /etc/passwd | grep "non-existent-user-xyz" | wc -l

echo "If you see this, the script didn't crash!"
```
- Output
```shell
ubuntu@ip-172-31-23-228:~/day18$ chmod 755 strict_demo.sh
ubuntu@ip-172-31-23-228:~/day18$ ./strict_demo.sh
--- Testing set -u (Undefined Variables) ---
./strict_demo.sh: line 7: USER_NAME: unbound variable
ubuntu@ip-172-31-23-228:~/day18$ ./strict_demo.sh
--- Testing set -u (Undefined Variables) ---
--- Testing set -e (Command Failure) ---
ls: cannot access '/non_existent_directory_123': No such file or directory
ubuntu@ip-172-31-23-228:~/day18$ ./strict_demo.sh
--- Testing set -u (Undefined Variables) ---
--- Testing set -e (Command Failure) ---
--- Testing set -o pipefail (Pipeline Failure) ---
0
ubuntu@ip-172-31-23-228:~/day18$ ./strict_demo.sh
--- Testing set -u (Undefined Variables) ---
--- Testing set -e (Command Failure) ---
--- Testing set -o pipefail (Pipeline Failure) ---
If you see this, the script didn't crash!
```
-------
## Task 4: Local Variables
1. created `local_demo.sh` script file.
- Code
```bash
#!/bin/bash

set -euo pipefail
# Initialize a global variable
name="Global Alice"
leaky_function() {
    # This variable is NOT local
    name="Leaky Bob"
    echo "Inside leaky_function: name = $name"
}

safe_function() {
    # This variable IS local
    local name="Safe Charlie"
    echo "Inside safe_function: name = $name"
}

echo "Starting value: $name"
# 1. Test the Safe Function
safe_function
echo "Value after safe_function: $name"
echo "(Result: Global variable was protected!)"
echo "--------------------------------"
# 2. Test the Leaky Function
leaky_function
echo "Value after leaky_function: $name"
echo "(Result: Global variable was OVERWRITTEN!)"
```
- Output
```shell
ubuntu@ip-172-31-23-228:~/day18$ chmod 755 local_demo.sh
ubuntu@ip-172-31-23-228:~/day18$ ./local_demo.sh
Starting value: Global Alice
Inside safe_function: name = Safe Charlie
Value after safe_function: Global Alice
(Result: Global variable was protected!)
--------------------------------
Inside leaky_function: name = Leaky Bob
Value after leaky_function: Leaky Bob
(Result: Global variable was OVERWRITTEN!)
```
-------
## Task 5: Build a Script — System Info Reporter
1. created `system_info.sh` script file.
- Code
```bash
#!/bin/bash

# Enable Unofficial Bash Strict Mode
set -euo pipefail
IFS=$'\n\t'
print_header() {
    local title="$1"
    echo -e "\n\033[1;34m=== $title ===\033[0m"
}
get_os_info() {
    print_header "HOSTNAME & OS"
    echo "Hostname: $(hostname)"
    # Extract OS name from os-release
    local os_name=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
    echo "Operating System: $os_name"
}
get_uptime() {
    print_header "SYSTEM UPTIME"
    uptime -p
}
get_disk_usage() {
    print_header "TOP 5 DIRECTORIES BY SIZE (/)"
    # Uses du to find sizes, sorts numerically, and takes top 5
    # Note: Redirecting errors to /dev/null to hide permission warnings
    du -ah / 2>/dev/null | sort -rh | head -n 5
}
get_memory_usage() {
    print_header "MEMORY USAGE"
    free -h
}
get_cpu_processes() {
    print_header "TOP 5 CPU-CONSUMING PROCESSES"
    # pcpu = % CPU usage, comm = command name
    ps -eo pcpu,comm --sort=-pcpu | head -n 6
}
# Main Logic
main() {
    echo -e "\033[1;32mSYSTEM DATA REPORT - $(date)\033[0m"
    get_os_info
    get_uptime
    get_memory_usage
    get_cpu_processes
    get_disk_usage
    echo -e "\n\033[1;32mReport Generated Successfully.\033[0m"
}
main
```
- Output
```shell
ubuntu@ip-172-31-23-228:~/day18$ chmod 755 system_info.sh
ubuntu@ip-172-31-23-228:~/day18$ ./system_info.sh
SYSTEM DATA REPORT - Thu Feb 12 11:35:15 UTC 2026

=== HOSTNAME & OS ===
Hostname: ip-172-31-23-228
Operating System: Ubuntu 24.04.3 LTS

=== SYSTEM UPTIME ===
up 1 hour, 32 minutes

=== MEMORY USAGE ===
               total        used        free      shared  buff/cache   available
Mem:           914Mi       393Mi       130Mi       2.7Mi       594Mi       520Mi
Swap:             0B          0B          0B

=== TOP 5 CPU-CONSUMING PROCESSES ===
%CPU COMMAND
 0.0 sshd
 0.0 snapd
 0.0 amazon-ssm-agen
 0.0 systemd
 0.0 kworker/0:1-events

=== TOP 5 DIRECTORIES BY SIZE (/) ===
3.3G    /
1.5G    /usr
1.0G    /snap
894M    /usr/lib
750M    /var
```
----------
## Explanation of `set -euo pipefail`.
1. The Safety Header
The command `set -euo pipefail` is known as the Unofficial Bash Strict Mode.

| Flag |	Name |	Function |
| ---- | ----- | --------- |
| -e |	errexit |	The script stops immediately if any command fails (returns non-zero). No more "ghost" executions after an error. |
| -u |	nounset |	The script crashes if you refer to a variable that hasn't been defined. Prevents typos like $BAKUP_DIR instead of $BACKUP_DIR. |
| -o pipefail |	pipefail |	If any part of a pipeline fails (e.g., grep failing in `cat file. |

----------
## 3 Key Points

- When you define variable in function scope use with `local` keyword before variable.
- If you defining a variable in function without `local` it will overwritten the global variable.
- Always make sure when you defining a variable don't give space between variable and value.


---------------
















