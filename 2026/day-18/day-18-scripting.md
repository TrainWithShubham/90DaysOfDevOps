
# Day 18 - Shell Scripting: Functions & Intermediate Concepts

## Task 1 & 2: Basic Functions & System Checks
Functions allow you to write reusable blocks of code. You can pass arguments to them exactly like you do with standalone scripts (`$1`, `$2`). You call a function simply by typing its name without parentheses.

```bash
#!/bin/bash
greet() {
    echo "Hello $1!"
}
add() {
    sum=$(( $1 + $2 ))
    echo "$sum"
}
check_disk() {
    echo "Available free storage: $(df -h | awk 'NR==2 {print$4}')"
}

greet Habeeb
add 5 10
check_disk

```

## Task 3: Strict Mode (`set -euo pipefail`)

By default, Bash fails silently and continues executing even if a command breaks. Strict mode forces the script to behave predictably and safely.

* **`set -e`**: Exit immediately if any command returns a non-zero (failure) status.
* **`set -u`**: Exit immediately if the script tries to use an undefined/unbound variable.
* **`set -o pipefail`**: Ensure that if any command within a pipeline (e.g., `cmd1 | cmd2`) fails, the entire pipeline fails, rather than just returning the exit code of the final command.

## Task 4: Local Variables

By default, variables inside Bash functions are global and can accidentally overwrite variables in the main script. Using the `local` keyword restricts the variable's scope to that specific function.

```bash
test_scope() {
    local user="Habeeb"
    global_var="I leaked out!"
}

```

## Task 5: System Info Reporter

A full diagnostic script utilizing strict mode and the `main()` function pattern to cleanly report OS details, uptime, disk usage, memory, and top CPU processes.

```bash
#!/bin/bash
set -euo pipefail

print_os_info() {
    echo "=== OS & Hostname Info ==="
    echo "$(hostnamectl)"
}

print_uptime() {
    echo "=== System Uptime ==="
    echo "$(uptime -p)"
}

disk_usage() {
    echo "=== Top 5 Disk Usage ==="
    echo "$(df -h | sort -hr -k 5 | head -n 6)"
}

memory_usage() {
    echo "=== Memory Usage ==="
    echo "$(free -h)"
}

cpu_usage() {
    echo "=== Top 5 CPU Processes ==="
    echo "$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)"
}

main() {
    echo "Starting System Diagnostic Report..."
    echo "------------------------------------"
    print_os_info
    print_uptime
    disk_usage
    memory_usage
    cpu_usage
}

main

```

## 3 Key Learnings

1. **Scope Matters:** Without the `local` keyword, function variables leak into the global environment, which can cause devastating bugs in large automation scripts.
2. **Strict Mode is Mandatory:** Using `set -euo pipefail` acts as a safety net, preventing scripts from running destructive commands if an earlier prerequisite fails or a variable is empty.
3. **The Main Function Pattern:** Grouping script execution into a single `main()` function call at the bottom of the file makes complex scripts significantly easier to read, debug, and maintain.

```
