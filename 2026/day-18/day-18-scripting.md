# Day 18 – Shell Scripting: Functions & Intermediate Concepts

> **Goal:** Write cleaner, reusable scripts using functions, strict mode, local variables, and real-world patterns.

---

## Task 1: Basic Functions — `functions.sh`

### Script

```bash
#!/bin/bash
# Task 1: Basic Functions

greet() {
    local name="$1"
    echo "Hello, ${name}!"
}

add() {
    local a="$1"
    local b="$2"
    local sum=$(( a + b ))
    echo "Sum of ${a} + ${b} = ${sum}"
}

# Call both functions
greet "DevOps Engineer"
greet "Shubham"
add 10 25
add 100 200
```

### Output

```
Hello, DevOps Engineer!
Hello, Shubham!
Sum of 10 + 25 = 35
Sum of 100 + 200 = 300
```

### Explanation

- Functions are defined with the syntax `function_name() { ... }`
- Arguments are accessed inside the function as `$1`, `$2`, etc.
- Using `local` for variables inside functions prevents them from leaking into global scope.

---

## Task 2: Functions with Return Values — `disk_check.sh`

### Script

```bash
#!/bin/bash
# Task 2: Functions with Return Values

check_disk() {
    echo "=== Disk Usage ==="
    df -h /
    echo ""
}

check_memory() {
    echo "=== Memory Usage ==="
    free -h
    echo ""
}

# Main section
check_disk
check_memory
```

### Output

```
=== Disk Usage ===
Filesystem      Size  Used Avail Use% Mounted on
none            9.9G  2.2M  9.9G   1% /

=== Memory Usage ===
               total        used        free      shared  buff/cache   available
Mem:           9.0Gi        13Mi       9.0Gi          0B       9.7Mi       9.0Gi
Swap:             0B          0B          0B
```

### Explanation

- Shell functions don't "return" values like other languages — they print output to stdout, which can be captured with `$(function_name)`.
- `df -h` shows human-readable disk usage; `free -h` shows human-readable memory stats.
- Each function acts as a self-contained unit — making the script modular and easy to maintain.

---

## Task 3: Strict Mode — `strict_demo.sh`

### What does each flag do?

| Flag | Behavior |
|------|----------|
| `set -e` | **Exit immediately** if any command returns a non-zero exit code. Prevents the script from continuing after an error. |
| `set -u` | **Treat unset/undefined variables as errors.** Instead of silently using an empty string, the script exits immediately — catches typos in variable names. |
| `set -o pipefail` | **A pipeline fails if ANY command in it fails**, not just the last one. Without this, `false \| true` would exit 0. |

### Script

```bash
#!/bin/bash
# Task 3: Strict Mode Demo
set -euo pipefail

echo "=== Strict Mode Demo ==="
echo "Script is running with set -euo pipefail"
echo ""

# Demonstrating set -u: using undefined variable would cause immediate exit
# Uncomment below to see set -u in action:
# echo "Undefined: $UNDEFINED_VAR"

# Demonstrating set -e: a failing command exits the script
# Uncomment below to see set -e in action:
# ls /nonexistent_directory

# Demonstrating set -o pipefail: piped command failure
# Uncomment below to see pipefail in action:
# cat /nonexistent_file | grep "something"

# Safe usage with defined variables
GREETING="Hello from strict mode!"
echo "$GREETING"

if df -h / > /dev/null 2>&1; then
    echo "Disk check passed."
fi

echo ""
echo "Script completed successfully — strict mode kept things safe!"
```

### Output

```
=== Strict Mode Demo ===
Script is running with set -euo pipefail

Hello from strict mode!
Disk check passed.

Script completed successfully — strict mode kept things safe!
```

### What happens when you violate each rule?

**`set -u` — Undefined variable:**
```bash
echo "$UNDEFINED_VAR"
# → bash: UNDEFINED_VAR: unbound variable
# Script exits immediately with code 1
```

**`set -e` — Failing command:**
```bash
ls /nonexistent_directory
# → ls: cannot access '/nonexistent_directory': No such file or directory
# Script exits immediately — no further commands run
```

**`set -o pipefail` — Failed pipe:**
```bash
cat /nonexistent_file | grep "something"
# → Without pipefail: exit code = 0 (grep succeeded, even though cat failed)
# → With pipefail:    exit code = 1 (cat failed, so the whole pipeline fails)
```

---

## Task 4: Local Variables — `local_demo.sh`

### Script

```bash
#!/bin/bash
# Task 4: Local Variables Demo

# Function using LOCAL variables (safe — no leakage)
with_local() {
    local my_var="I am LOCAL"
    local counter=42
    echo "[inside with_local] my_var = $my_var"
    echo "[inside with_local] counter = $counter"
}

# Function using GLOBAL variables (unsafe — leaks outside)
without_local() {
    my_var="I am GLOBAL (leaked!)"
    counter=99
    echo "[inside without_local] my_var = $my_var"
    echo "[inside without_local] counter = $counter"
}

echo "=== Test 1: Function with local variables ==="
with_local
echo "[outside] my_var = '${my_var:-NOT SET}'"
echo "[outside] counter = '${counter:-NOT SET}'"

echo ""
echo "=== Test 2: Function without local variables ==="
without_local
echo "[outside] my_var = '${my_var:-NOT SET}'"
echo "[outside] counter = '${counter:-NOT SET}'"

echo ""
echo "=== Key Takeaway ==="
echo "Always use 'local' inside functions to avoid polluting global scope!"
```

### Output

```
=== Test 1: Function with local variables ===
[inside with_local] my_var = I am LOCAL
[inside with_local] counter = 42
[outside] my_var = 'NOT SET'
[outside] counter = 'NOT SET'

=== Test 2: Function without local variables ===
[inside without_local] my_var = I am GLOBAL (leaked!)
[inside without_local] counter = 99
[outside] my_var = 'I am GLOBAL (leaked!)'
[outside] counter = '99'

=== Key Takeaway ===
Always use 'local' inside functions to avoid polluting global scope!
```

### Explanation

- When `local` is used, the variable only exists within the function's scope.
- Without `local`, variables set inside a function bleed into the global scope — this can cause subtle, hard-to-debug bugs when multiple functions use the same variable name.
- Always default to `local` in functions unless you specifically intend global side effects.

---

## Task 5: System Info Reporter — `system_info.sh`

### Script

```bash
#!/bin/bash
# Task 5: System Info Reporter
set -euo pipefail

SEPARATOR="=============================================="

print_header() {
    local title="$1"
    echo ""
    echo "$SEPARATOR"
    echo "  $title"
    echo "$SEPARATOR"
}

host_info() {
    print_header "Hostname & OS Info"
    echo "Hostname   : $(hostname)"
    echo "OS         : $(uname -o 2>/dev/null || uname -s)"
    echo "Kernel     : $(uname -r)"
    echo "Arch       : $(uname -m)"
    if [ -f /etc/os-release ]; then
        local pretty_name
        pretty_name=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
        echo "Distro     : $pretty_name"
    fi
}

uptime_info() {
    print_header "Uptime"
    uptime -p 2>/dev/null || uptime
    echo "Boot time  : $(who -b 2>/dev/null | awk '{print $3, $4}' || echo 'N/A')"
}

disk_info() {
    print_header "Disk Usage (Top 5 by Size)"
    echo "Filesystem       Size  Used  Avail  Use%  Mounted On"
    df -h --output=source,size,used,avail,pcent,target 2>/dev/null | \
        tail -n +2 | sort -k2 -rh | head -5 || \
        df -h | tail -n +2 | head -5
}

memory_info() {
    print_header "Memory Usage"
    free -h
}

top_cpu_processes() {
    print_header "Top 5 CPU-Consuming Processes"
    printf "%-8s %-10s %-6s %-6s %s\n" "PID" "USER" "CPU%" "MEM%" "COMMAND"
    ps aux --sort=-%cpu 2>/dev/null | \
        awk 'NR>1 {printf "%-8s %-10s %-6s %-6s %s\n", $2, $1, $3, $4, $11}' | head -5
}

main() {
    echo ""
    echo "  *** SYSTEM INFO REPORT ***"
    echo "  Generated: $(date '+%Y-%m-%d %H:%M:%S')"

    host_info
    uptime_info
    disk_info
    memory_info
    top_cpu_processes

    echo ""
    echo "$SEPARATOR"
    echo "  End of Report"
    echo "$SEPARATOR"
    echo ""
}

main
```

### Output

```
  *** SYSTEM INFO REPORT ***
  Generated: 2026-02-25 07:11:46

==============================================
  Hostname & OS Info
==============================================
Hostname   : runsc
OS         : GNU/Linux
Kernel     : 4.4.0
Arch       : x86_64
Distro     : Ubuntu 24.04.4 LTS

==============================================
  Uptime
==============================================
up 0 minutes
Boot time  : Feb 25

==============================================
  Disk Usage (Top 5 by Size)
==============================================
Filesystem       Size  Used  Avail  Use%  Mounted On
none            1.0P     0  1.0P   0% /mnt/user-data/uploads
...

==============================================
  Memory Usage
==============================================
               total        used        free      shared  buff/cache   available
Mem:           9.0Gi        13Mi       9.0Gi          0B       9.7Mi       9.0Gi
Swap:             0B          0B          0B

==============================================
  Top 5 CPU-Consuming Processes
==============================================
PID      USER       CPU%   MEM%   COMMAND
78       root       87.5   0.0    ps
80       root       12.5   0.0    head
...

==============================================
  End of Report
==============================================
```

---

## Understanding `set -euo pipefail`

The combination `set -euo pipefail` is considered the standard "strict mode" for Bash scripting. It catches three major categories of silent failures:

**`set -e`** stops scripts from blindly continuing after a command fails. Without it, a script could fail halfway through — say, while creating a deployment artifact — and silently proceed to the next step, causing corrupted or incomplete work.

**`set -u`** catches the extremely common bug of a typo in a variable name. Without it, `$CONFIIG_PATH` (typo for `$CONFIG_PATH`) would silently expand to an empty string, causing confusing downstream errors. With `-u`, the script exits immediately with a clear error message.

**`set -o pipefail`** solves the problem that Bash only checks the exit code of the *last* command in a pipeline. The classic footgun: `grep "pattern" file.txt | wc -l` — if the file doesn't exist, `grep` fails but `wc -l` succeeds (returning `0`), so the whole pipeline exits 0. With `pipefail`, the pipeline correctly reports failure.

---

## What I Learned — 3 Key Points

**1. Functions make scripts composable and testable.**
Breaking logic into functions means each piece can be understood, tested, and reused independently. A `main()` function that calls named functions reads almost like documentation — you can understand a 200-line script just by reading `main()`.

**2. Always use `local` in functions — no exceptions.**
Without `local`, every variable in a function is a potential landmine for every other function and global scope. The habit of typing `local` first is cheap; debugging a variable collision at 2am is not.

**3. `set -euo pipefail` is not optional for production scripts.**
Silent failures are the hardest bugs to diagnose. A script that exits loudly when something goes wrong is infinitely better than one that silently corrupts state. Treat strict mode as the default, not an extra.

---

## File Structure

```
2026/day-18/
├── functions.sh        # Task 1: Basic functions
├── disk_check.sh       # Task 2: Functions with return values
├── strict_demo.sh      # Task 3: Strict mode demonstration
├── local_demo.sh       # Task 4: Local variables
├── system_info.sh      # Task 5: Full system info reporter
└── day-18-scripting.md # This documentation file
```

---

*Part of the #90DaysOfDevOps challenge — Day 18*
*#DevOpsKaJosh #TrainWithShubham*