
**1. Create your Markdown File:**
Open VS Code, navigate to your `2026/day-16/` folder, create `day-16-shell-scripting.md`, and paste this inside:

```markdown
# Day 16 - Shell Scripting Basics

## Task 1: Your First Script & The Shebang
The shebang (`#!/bin/bash`) at the top of a script tells the operating system exactly which interpreter to use to execute the file. If you omit it, Linux will default to the user's current shell. While this might work on my machine, it can break the script if shared with another user whose default shell is different (like `zsh` or `sh`).

```bash
#!/bin/bash
echo "Hello, DevOps!"

```

## Task 2: Variables & Quotation Marks

In Bash, variables must be declared without spaces around the equals sign (e.g., `NAME="Habeeb"`).

* **Double Quotes (`" "`):** Bash evaluates variables inside double quotes (e.g., `"Hello $NAME"` prints "Hello Habeeb").
* **Single Quotes (`' '`):** Bash treats everything as a literal string (e.g., `'Hello $NAME'` literally prints "Hello $NAME").

```bash
#!/bin/bash
NAME="Habeeb"
ROLE="DevOps Engineer"
echo "Hello, I am $NAME and I am a $ROLE"

```

## Task 3: User Input

The `read` command captures user input and stores it directly into a variable. Using the `-p` flag allows you to prompt the user and store the input in a single line of code.

```bash
#!/bin/bash
read -p "Enter your name: " name
read -p "Enter your favourite tool: " tool
echo "Hello $name, your favourite tool is $tool"

```

## Task 4: If-Else Conditions

Bash syntax for if-else statements is incredibly strict. Conditions require physical spaces inside the brackets `[[ ]]`. Furthermore, math comparisons require flags like `-gt` (greater than) and `-eq` (equal to), rather than standard mathematical symbols.

```bash
#!/bin/bash
read -p "Enter a number: " number 

if [[ $number -gt 0 ]]; then
    echo "the number is positive"
elif [[ $number -eq 0 ]]; then 
    echo "the number is zero"
else 
    echo "the number is negative"
fi

```

## Task 5: Combine It All (Server Check)

This script combines variable assignment, user input, string comparison (`==`), and direct command execution to check the status of a specific server service.

```bash
#!/bin/bash
service="sshd"
read -p "Do you want to check the status? (y/n) " answer

if [[ $answer == 'y' ]]; then
    systemctl status $service
else
    echo "Skipped."
fi

```

## 3 Key Learnings

1. **Syntax is Unforgiving:** Unlike Python, Bash variables cannot have spaces around the `=` sign, and `if` statement brackets require strict internal spacing.
2. **String vs Math Operators:** You cannot mix comparison operators. `-eq` and `-gt` are strictly for integers, while `==` is used for string text.
3. **Command Execution:** Running a command inside a script requires simply typing the command. Wrapping it in `$()` is reserved for command substitution (saving the output).

