# Day 16 Challenge – Shell Scripting Basics

All scripts should be made executable before running:
```bash
chmod +x <script-name>.sh
./<script-name>.sh
```

---

## Task 1: Your First Script — `hello.sh`

```bash
#!/bin/bash
echo "Hello, DevOps!"
```

**Output:**
```
Hello, DevOps!
```

**What happens if you remove the shebang line?**

Without `#!/bin/bash`, the kernel doesn't know which interpreter to use. If you run the script directly with `./hello.sh`, your current shell (usually bash or sh) is used as a fallback — so for simple scripts it may still work. However, this is unreliable: if `echo` behaviour or syntax differs between `sh` and `bash` (e.g., arrays, `[[ ]]` conditionals, process substitution), the script silently breaks or errors. The shebang is a guarantee — it pins the interpreter regardless of who runs the script or which shell they're using.

---

## Task 2: Variables — `variables.sh`

```bash
#!/bin/bash

NAME="Alex"
ROLE="DevOps Engineer"

# Double quotes expand variables
echo "Hello, I am $NAME and I am a $ROLE"

# Single quotes treat everything literally
echo 'With single quotes: Hello, I am $NAME and I am a $ROLE'
```

**Output:**
```
Hello, I am Alex and I am a DevOps Engineer
With single quotes: Hello, I am $NAME and I am a $ROLE
```

**Single quotes vs double quotes:**

| Quote type | Behaviour | Use when |
|------------|-----------|----------|
| `"double"` | Variables and command substitutions (`$VAR`, `$(cmd)`) are expanded | You want variables to be interpreted |
| `'single'` | Everything is treated as a literal string — no expansion at all | You want the exact characters, e.g. printing a dollar sign or a regex pattern |

**Key rule:** Never put spaces around `=` when assigning variables. `NAME = "Alex"` causes a syntax error — bash interprets `NAME` as a command, not an assignment.

---

## Task 3: User Input — `greet.sh`

```bash
#!/bin/bash

read -p "Enter your name: " NAME
read -p "Enter your favourite tool: " TOOL

echo "Hello $NAME, your favourite tool is $TOOL"
```

**Example run:**
```
Enter your name: Alex
Enter your favourite tool: Terraform
Hello Alex, your favourite tool is Terraform
```

**`read` flags worth knowing:**
- `-p "prompt"` — displays a prompt on the same line before waiting for input
- `-s` — silent mode (hides input, useful for passwords)
- `-t 10` — times out after 10 seconds if no input is given

---

## Task 4: If-Else Conditions

### `check_number.sh`

```bash
#!/bin/bash

read -p "Enter a number: " NUM

if [ "$NUM" -gt 0 ]; then
    echo "$NUM is positive."
elif [ "$NUM" -lt 0 ]; then
    echo "$NUM is negative."
else
    echo "The number is zero."
fi
```

**Example runs:**
```
Enter a number: 42
42 is positive.

Enter a number: -7
-7 is negative.

Enter a number: 0
The number is zero.
```

**Integer comparison operators in bash:**

| Operator | Meaning |
|----------|---------|
| `-eq` | equal to |
| `-ne` | not equal to |
| `-gt` | greater than |
| `-lt` | less than |
| `-ge` | greater than or equal |
| `-le` | less than or equal |

---

### `file_check.sh`

```bash
#!/bin/bash

read -p "Enter a filename to check: " FILENAME

if [ -f "$FILENAME" ]; then
    echo "File '$FILENAME' exists."
else
    echo "File '$FILENAME' does not exist."
fi
```

**Example runs:**
```
Enter a filename to check: /etc/passwd
File '/etc/passwd' exists.

Enter a filename to check: /tmp/nope.txt
File '/tmp/nope.txt' does not exist.
```

**Common file test operators:**

| Flag | Tests for |
|------|-----------|
| `-f` | Regular file exists |
| `-d` | Directory exists |
| `-e` | File or directory exists (either) |
| `-r` | File is readable |
| `-w` | File is writable |
| `-x` | File is executable |
| `-s` | File exists and is non-empty |

Always **quote the variable** (`"$FILENAME"`) — if the filename contains spaces, an unquoted variable breaks the test operator into multiple arguments.

---

## Task 5: Combine It All — `server_check.sh`

```bash
#!/bin/bash

SERVICE="sshd"

read -p "Do you want to check the status of '$SERVICE'? (y/n): " ANSWER

if [ "$ANSWER" = "y" ]; then
    STATUS=$(systemctl is-active "$SERVICE")

    if [ "$STATUS" = "active" ]; then
        echo "$SERVICE is active and running."
    else
        echo "$SERVICE is NOT active. Current state: $STATUS"
    fi
elif [ "$ANSWER" = "n" ]; then
    echo "Skipped."
else
    echo "Invalid input. Please enter 'y' or 'n'."
fi
```

**Example run (service active):**
```
Do you want to check the status of 'sshd'? (y/n): y
sshd is active and running.
```

**Example run (service inactive):**
```
Do you want to check the status of 'sshd'? (y/n): y
sshd is NOT active. Current state: inactive
```

**Example run (skip):**
```
Do you want to check the status of 'sshd'? (y/n): n
Skipped.
```

**Key pattern — command substitution:** `STATUS=$(systemctl is-active "$SERVICE")` captures the output of a command into a variable. The `$(...)` syntax is the modern form; the older backtick form `` `command` `` works identically but is harder to nest and read.

---

## What I Learned

1. **The shebang line is a contract, not a courtesy** — `#!/bin/bash` doesn't just label the file; it's an instruction to the kernel to invoke that exact interpreter. Scripts without it are at the mercy of whatever shell the user happens to be running, which makes behaviour unpredictable across environments. In CI/CD pipelines where scripts run as non-interactive shells, missing shebangs are a common source of mysterious failures.

2. **Quote your variables — always** — `[ $FILENAME ]` and `[ "$FILENAME" ]` look similar but behave very differently when the variable is empty or contains spaces. An unquoted empty variable causes `[ -f ]` with no argument, which is a syntax error; an unquoted variable with spaces gets word-split into multiple arguments. The rule is simple: double-quote every variable expansion unless you deliberately need word splitting.

3. **`$()` command substitution is what makes scripts dynamic** — capturing command output into a variable (`STATUS=$(systemctl is-active sshd)`) is the bridge between running commands and making decisions based on their results. This pattern — run a command, store its output, branch on the value — is the core loop of almost every real-world ops script: check a service, check disk usage, check an API response, then act accordingly.