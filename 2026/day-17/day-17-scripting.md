


# Day 17 - Shell Scripting: Loops, Arguments & Error Handling

## Task 1: For Loops
A `for` loop iterates over a list of items. Bash arrays require specific syntax `"${ARRAY[@]}"` to read all items, or you can use sequence generators like `{1..10}`.

**`for_loop.sh`:**
```bash
#!/bin/bash
ARR=("apple" "banana" "orange" "grape" "mango")
for x in "${ARR[@]}"; do
    echo "$x"
done

```

**`count.sh`:**

```bash
#!/bin/bash
for num in {1..10}; do
    echo "$num"
done

```

## Task 2: While Loops

A `while` loop runs continuously as long as a specific condition evaluates to true.

**`countdown.sh`:**

```bash
#!/bin/bash
read -p "Enter a starting number: " num
while [[ $num -ge 0 ]]; do
    echo "$num"
    num=$((num-1))
done
echo "Done!"

```

## Task 3: Command-Line Arguments

Command-line arguments allow users to pass data directly into the script upon execution without waiting for an interactive prompt.

* `$0`: The name of the script.
* `$1`, `$2`: The first and second arguments passed.
* `$#`: The total count of arguments passed.
* `$@`: A list of all arguments passed.

**`greet.sh`:**

```bash
#!/bin/bash
if [[ $# -eq 0 ]]; then
    echo "Usage: ./greet.sh <name>"
else
    echo "Hello, $1!"
fi

```

**`args_demo.sh`:**

```bash
#!/bin/bash
echo "The name of the script is $0"
echo "The total number of arguments $#"
echo "Every single argument passed: $@"

```

## Task 4 & 5: Package Installation & Error Handling

This script combines a root-user check (`$EUID`), array iteration, and conditional execution (`if/else`) to automate package management safely.

**`install_packages.sh`:**

```bash
#!/bin/bash

# Task 5: Error Handling (Root Check)
if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root! Use sudo."
   exit 1
fi

# Task 4: Install Packages
ARR=("nginx" "curl" "wget")

for x in "${ARR[@]}"; do
    if dpkg -s "$x" &> /dev/null; then
        echo "$x is already installed."
    else
        echo "Installing $x..."
        apt-get install -y "$x"
    fi
done

```

## 3 Key Learnings

1. **Bash Arrays are Unique:** Unlike Python lists, Bash arrays separate items with spaces (not commas) and require the `" ${ARRAY[@]} "` syntax to expand all elements within a loop.
2. **Arguments Enable Automation:** Utilizing `$1`, `$@`, and checking argument counts with `$#` allows scripts to be fully non-interactive and pipeline-ready.
3. **Safety Checks Prevent Chaos:** Using `$EUID` to enforce root privileges prevents a script from partially executing and failing halfway through when permissions are denied.

```
