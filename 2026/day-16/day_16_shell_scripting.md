Day 16 - 90 Days Of DevOps

## 🐧 Topic: Shell Scripting Basics

Today I started my Shell Scripting journey and learned the fundamentals of Bash scripting used in Linux automation.

## 📚 What I Learned

### 1. Shebang and First Shell Script

Created my first shell script using:

```bash
#!/bin/bash

Learned that shebang tells Linux which interpreter should execute the script.

Executed scripts using:

chmod +x hello.sh
./hello.sh
2. Variables in Shell Script

Learned how to store and reuse values using variables.

Example:

NAME="Chaitanya"
ROLE="DevOps Engineer"

echo "Hello, I am $NAME and I am a $ROLE"

Also learned the difference between single quotes and double quotes.

Double quotes allow variables to work.
Single quotes treat everything as normal text.
3. User Input Using read

Created scripts that take input from users.

Example:

read -p "Enter your name: " NAME

Learned how scripts can interact with users dynamically.

4. If-Else Conditions

Practiced decision-making in Bash.

Created scripts for:

Checking whether a number is positive, negative, or zero
Checking whether a file exists

Learned the structure:

if
elif
else
fi
5. Automation Script

Created a server checking script.

The script:

Stores a service name in a variable
Takes user confirmation
Checks service status using:
systemctl status

This helped me understand how DevOps engineers automate daily Linux tasks.

📝 Scripts Created
hello.sh
variables.sh
greet.sh
check_number.sh
file_check.sh
server_check.sh
🧠 Key Takeaways
Shell scripting helps automate repetitive Linux tasks.
Variables make scripts reusable and easier to manage.
Conditions help scripts make decisions automatically.
🚀 Day 16 Completed Successfull
