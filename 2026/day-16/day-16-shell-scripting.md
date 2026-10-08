# Day 16 – Shell Scripting Basics

## Task 1: Your First Script

### hello.sh

```bash
#!/bin/bash

echo "Hello, DevOps!"
```

### Commands Used

```bash
chmod +x hello.sh
./hello.sh
```

### Output

```text
Hello, DevOps!
```

### What happens if we remove the shebang line?

The shebang line tells Linux which interpreter should run the script.

```bash
#!/bin/bash
```

Without the shebang, the script may:

- run incorrectly
- use a different shell
- show interpreter errors

---

# Task 2: Variables

### variable.sh

```bash
#!/bin/bash

NAME="Asma"
ROLE="DevOps Engineer"

echo "Hello, I am $NAME and I am a $ROLE"
```

### Commands Used

```bash
chmod +x variable.sh
./variable.sh
```

### Output

```text
Hello, I am Asma and I am a DevOps Engineer
```

### Single Quotes vs Double Quotes

Double quotes allow variable expansion:

```bash
echo "Hello $NAME"
```

Single quotes print variables as plain text:

```bash
echo 'Hello $NAME'
```

---

# Task 3: User Input with read

### greet.sh

```bash
#!/bin/bash

read -p "Enter your name: " NAME
read -p "Enter your favourite tool: " TOOL

echo "Hello $NAME, your favourite tool is $TOOL"
```

### Commands Used

```bash
chmod +x greet.sh
./greet.sh
```

### Output

```text
Enter your name: Asma
Enter your favourite tool: Kubernetes

Hello Asma, your favourite tool is Kubernetes
```

### Observation

The `read` command allows shell scripts to take user input during execution.

---

# Task 4: If-Else Conditions

### check_numb.sh

```bash
#!/bin/bash

read -p "Enter a number: " NUM

if [ $NUM -gt 0 ]
then
    echo "Positive number"

elif [ $NUM -lt 0 ]
then
    echo "Negative number"

else
    echo "Zero"
fi
```

### Commands Used

```bash
chmod +x check_numb.sh
./check_numb.sh
```

### Output Examples

```text
Enter a number: 1
Positive number
```

```text
Enter a number: -1
Negative number
```

```text
Enter a number: 0
Zero
```

### Observation

The `if-elif-else` condition allows shell scripts to make decisions based on user input.

---

# File Check Script

### file.sh

```bash
#!/bin/bash

read -p "Enter filename: " FILE

if [ -f "$FILE" ]
then
    echo "File exists"

else
    echo "File does not exist"
fi
```

### Commands Used

```bash
chmod +x file.sh
./file.sh
```

### Output Examples

```text
Enter filename: hello.sh
File exists
```

```text
Enter filename: abc.txt
File does not exist
```

### Observation

The `-f` condition checks whether a file exists in the current directory.

---

# Task 5: Combine It All

### server_check.sh

```bash
#!/bin/bash

SERVICE="ssh"

read -p "Do you want to check the service status? (y/n): " CHOICE

if [ "$CHOICE" = "y" ]
then
    systemctl is-active $SERVICE

else
    echo "Skipped"
fi
```

### Commands Used

```bash
chmod +x server_check.sh
./server_check.sh
```

### Output Example 1

```text
Do you want to check the service status? (y/n): y
active
```

### Output Example 2

```text
Do you want to check the service status? (y/n): n
Skipped
```

### Observation

The script combined:

- variables
- user input
- if-else conditions
- systemctl command execution

---

# What I Learned

1. Shell scripts automate Linux tasks using Bash commands.
2. Variables and `read` help scripts accept dynamic user input.
3. `if-else` conditions allow scripts to make decisions automatically.
