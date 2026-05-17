# Shell Scripting Basics

## Task 1: First Script
1. Create a file `hello.sh`
2. Add the shebang line `#!/bin/bash` at the top
3. Print `Hello, DevOps!` using `echo`
4. Make it executable and run it

[Script](scripts/hello.sh)

* What happens if you remove the shebang line?
 - The script runs after removing shebang line :
    - `./hello.sh` - The kernel checks for a shebang to identify the interpreter.If no shebang is found, the script is executed using the current shell.
    - `bash hello.sh` - The script is explicitly executed by the Bash shell,independent of the presence of a shebang.
    - `sh hello.sh` - The script is executed using the `sh shell`,which may differ in behavior from bash

![echo](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-16/images/echo.png)

---

## Task 2: Variables
1. Create `variables.sh` with:
   - A variable for your `NAME`
   - A variable for your `ROLE` (e.g., "DevOps Engineer")
   - Print: `Hello, I am <NAME> and I am a <ROLE>`
2. Try using single quotes vs double quotes — what's the difference?
 * Using double quote `" "` - Allow **variable expansion**
 * Using single quote `' '` - Treat every character exactly as written

[Script](scripts/variables.sh)

![variable](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-16/images/variables.png)

---

## Task 3: User Input with read
1. Create `greet.sh` that:
   - Asks the user for their name using `read`
   - Asks for their favourite tool
   - Prints: `Hello <name>, your favourite tool is <tool>`

[Script](scripts/greet.sh)

![greet](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-16/images/greet.png)

---

## Task 4: If-Else Conditions
1. Create `check_number.sh` that:
   - Takes a number using `read`
   - Prints whether it is **positive**, **negative**, or **zero**

[Script](scripts/check_number.sh)

![check_number](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-16/images/check_number.png)


2. Create `file_check.sh` that:
   - Asks for a filename
   - Checks if the file **exists** using `-f`
   - Prints appropriate message

[Script](scripts/file_check.sh)

![file_check](https://github.com/srdangat/90DaysOfDevOps/blob/master/2026/day-16/images/file_check.png)

---

## Task 5: Combine It All
Create `server_check.sh` that:
1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's **active** or **not**
4. If `n` — prints "Skipped."

[Script](scripts/check_server.sh)

![server_check](images/server_check.png)


## What I learned -


* How to write and execute Bash shell scripts using the shebang (`#!/bin/bash`),variables,and user input with `read`.
* How variable assignment works in Bash,including accessing variables with `$` and understanding single vs double quotes.
* How to control script flow using conditional statements (`if`, `elif`, `else`) and test operators (`-f`, `-gt`, `-lt`).
* How to check file existence and numeric conditions inside shell scripts.
* How to suppress command output using redirection (`> /dev/null `).
* How to use `systemctl is-active` to programmatically check whether a service is running instead of relying on verbose status output.
