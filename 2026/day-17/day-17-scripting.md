# Day 17 Challenge – Shell Scripting: Loops, Arguments & Error Handling

All scripts should be made executable before running:
```bash
chmod +x <script-name>.sh
./<script-name>.sh
```

---

## Task 1: For Loops

### `for_loop.sh` — Iterating a list

```bash
#!/bin/bash

for fruit in apple banana cherry mango strawberry; do
    echo "Fruit: $fruit"
done
```

**Output:**
```
Fruit: apple
Fruit: banana
Fruit: cherry
Fruit: mango
Fruit: strawberry
```

---

### `count.sh` — Counting 1 to 10

```bash
#!/bin/bash

for (( i=1; i<=10; i++ )); do
    echo "$i"
done
```

**Output:**
```
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
```

**Two for loop styles in bash:**

| Style | Syntax | Best for |
|-------|--------|----------|
| List iteration | `for item in a b c; do` | Looping over words, filenames, array elements |
| C-style counter | `for (( i=1; i<=10; i++ ))` | Numeric ranges, index-based loops |

You can also use `for i in {1..10}; do` as a shorter alternative to the C-style form for simple numeric ranges.

---

## Task 2: While Loop

### `countdown.sh`

```bash
#!/bin/bash

read -p "Enter a number to count down from: " NUM

if ! [[ "$NUM" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a positive integer."
    exit 1
fi

while [ "$NUM" -ge 0 ]; do
    echo "$NUM"
    (( NUM-- ))
done

echo "Done!"
```

**Example run:**
```
Enter a number to count down from: 5
5
4
3
2
1
0
Done!
```

**Example run (bad input):**
```
Enter a number to count down from: abc
Error: Please enter a positive integer.
```

**Key pattern — input validation with regex:** `[[ "$NUM" =~ ^[0-9]+$ ]]` checks that the input is only digits. The `!` negates it — if the input is *not* a number, we exit early. Always validate user input before using it in arithmetic — passing a string to `-ge` causes a cryptic error.

**While loop anatomy:**
```bash
while [ condition ]; do
    # body
done
```
The condition is re-evaluated before every iteration. Use `break` to exit early; use `continue` to skip to the next iteration.

---

## Task 3: Command-Line Arguments

### `greet_args.sh` — Argument with usage guard

```bash
#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Usage: ./greet_args.sh <name>"
    exit 1
fi

NAME="$1"
echo "Hello, $NAME!"
```

**Example runs:**
```
$ ./greet_args.sh Alex
Hello, Alex!

$ ./greet_args.sh
Usage: ./greet_args.sh <name>
```

---

### `args_demo.sh` — Inspecting all arguments

```bash
#!/bin/bash

echo "Script name : $0"
echo "Total args  : $#"
echo "All args    : $@"

INDEX=1
for arg in "$@"; do
    echo "  Arg $INDEX: $arg"
    (( INDEX++ ))
done
```

**Example run:**
```
$ ./args_demo.sh devops linux bash scripting
Script name : ./args_demo.sh
Total args  : 4
All args    : devops linux bash scripting
  Arg 1: devops
  Arg 2: linux
  Arg 3: bash
  Arg 4: scripting
```

**Positional variable reference:**

| Variable | Meaning |
|----------|---------|
| `$0` | The script's name (as invoked) |
| `$1` … `$9` | First through ninth argument |
| `${10}` | Tenth argument and beyond (braces required) |
| `$#` | Total number of arguments passed |
| `$@` | All arguments as separate quoted words — safe to loop over |
| `$*` | All arguments as a single string — loses argument boundaries if quoted differently |

**Always prefer `"$@"` over `"$*"` when looping** — `"$@"` preserves argument boundaries even when arguments contain spaces (e.g., `"hello world"` stays as one argument, not two).

---

## Task 4: Install Packages via Script

### `install_packages.sh`

```bash
#!/bin/bash

# Root check
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root. Use: sudo ./install_packages.sh"
    exit 1
fi

PACKAGES=("nginx" "curl" "wget")

echo "=== Package Installation Check ==="
echo ""

for pkg in "${PACKAGES[@]}"; do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "[SKIP]    $pkg is already installed."
    else
        echo "[INSTALL] $pkg not found — installing..."
        apt-get install -y "$pkg" &> /dev/null

        if dpkg -s "$pkg" &> /dev/null; then
            echo "[OK]      $pkg installed successfully."
        else
            echo "[ERROR]   $pkg installation failed."
        fi
    fi
done

echo ""
echo "=== Done ==="
```

**Example output (all already installed):**
```
=== Package Installation Check ===

[SKIP]    nginx is already installed.
[SKIP]    curl is already installed.
[SKIP]    wget is already installed.

=== Done ===
```

**Example output (nginx missing):**
```
=== Package Installation Check ===

[INSTALL] nginx not found — installing...
[OK]      nginx installed successfully.
[SKIP]    curl is already installed.
[SKIP]    wget is already installed.

=== Done ===
```

**Example output (run without root):**
```
Error: This script must be run as root. Use: sudo ./install_packages.sh
```

**Key patterns:**

- `PACKAGES=("nginx" "curl" "wget")` — bash array syntax; elements in parentheses, space-separated
- `"${PACKAGES[@]}"` — expand all array elements as separate quoted words (mirrors `"$@"` for arguments)
- `&> /dev/null` — redirects both stdout and stderr to `/dev/null`, suppressing all output from `dpkg -s` and `apt-get` so only our custom status messages are shown
- `$EUID` — the effective user ID; `0` means root. More reliable than checking `$USER = "root"` since `EUID` reflects `sudo` escalation correctly

---

## Task 5: Error Handling

### `safe_script.sh`

```bash
#!/bin/bash

set -e

TARGET_DIR="/tmp/devops-test"
TARGET_FILE="$TARGET_DIR/hello.txt"

echo "=== Safe Script: Error Handling Demo ==="
echo ""

mkdir "$TARGET_DIR" || echo "[WARN] Directory '$TARGET_DIR' already exists — continuing."

echo "[INFO] Changing into $TARGET_DIR"
cd "$TARGET_DIR" || { echo "[ERROR] Could not cd into $TARGET_DIR. Aborting."; exit 1; }

echo "[INFO] Creating hello.txt"
touch hello.txt || { echo "[ERROR] Could not create hello.txt. Aborting."; exit 1; }

echo "Hello from safe_script.sh — $(date)" > hello.txt

echo ""
echo "[OK] All steps completed successfully."
echo "[OK] File contents:"
cat hello.txt
```

**First run (directory doesn't exist):**
```
=== Safe Script: Error Handling Demo ===

[INFO] Changing into /tmp/devops-test
[INFO] Creating hello.txt

[OK] All steps completed successfully.
[OK] File contents:
Hello from safe_script.sh — Sun Feb 22 10:30:00 UTC 2026
```

**Second run (directory already exists):**
```
=== Safe Script: Error Handling Demo ===

[WARN] Directory '/tmp/devops-test' already exists — continuing.
[INFO] Changing into /tmp/devops-test
[INFO] Creating hello.txt

[OK] All steps completed successfully.
[OK] File contents:
Hello from safe_script.sh — Sun Feb 22 10:31:45 UTC 2026
```

**Error handling patterns explained:**

| Pattern | Behaviour |
|---------|-----------|
| `set -e` | Script exits immediately if any command returns a non-zero exit code — no silent failures |
| `cmd \|\| echo "message"` | If `cmd` fails, run the fallback (print message, use alternative command, etc.) |
| `cmd \|\| { echo "msg"; exit 1; }` | If `cmd` fails, print message *and* exit — the `{ }` groups multiple commands after `\|\|` |
| `set -u` | Exit if an undefined variable is used — catches typos like `$PACAKGES` |
| `set -o pipefail` | Makes a pipeline fail if *any* command in it fails, not just the last one |

**Production-grade scripts typically open with:**
```bash
set -euo pipefail
```
This catches exit code failures (`-e`), undefined variables (`-u`), and pipeline failures (`-o pipefail`) — the three most common sources of silent bugs in shell scripts.

---

## What I Learned

1. **`"$@"` vs `"$*"` is not a style choice — it's a correctness issue** — both expand all positional arguments, but `"$@"` keeps each argument as its own quoted word. If an argument contains a space (e.g., `"hello world"`), `"$@"` passes it as one argument, while `"$*"` splits it into two. In a loop like `for arg in "$@"`, this matters every time a user passes a filename with spaces. Defaulting to `"$@"` is the correct and safe habit.

2. **`set -e` is a safety net, not a replacement for explicit error handling** — `set -e` silently exits the script the moment any command fails, which is better than a script that powers through errors and corrupts state. But combined with `||` fallbacks, you get the best of both worlds: the script halts on unexpected failures, while anticipated failures (like a directory already existing) are handled gracefully with a message instead of an abort. Use `set -euo pipefail` at the top of every non-trivial script.

3. **Arrays make package lists maintainable** — hardcoding packages as a space-separated string (`PACKAGES="nginx curl wget"`) works until a package name contains a space or you need to do per-element operations. Bash arrays (`PACKAGES=("nginx" "curl" "wget")`) store elements cleanly and expand safely with `"${PACKAGES[@]}"`. In a real DevOps context — provisioning scripts, bootstrap automation, CI setup — the package list will change over time, and an array makes adding/removing entries a one-line edit with no risk of breaking the loop logic.