# Day 18 – Shell Scripting Functions & Intermediate Concepts

## Introduction

In this lab, I learned how to write cleaner and safer shell scripts using functions and strict mode.
I also practiced checking system information like memory, disk usage, uptime, and CPU usage.

This lab helped me understand how real DevOps engineers organize reusable scripts for automation and monitoring.

---

# Task 1 – Basic Functions

I created a script called `function.sh`.

In this script:

- I created a greeting function
- I created another function to add two numbers
- I learned how functions make scripts reusable and clean

### What I Learned

- Functions help avoid repeating code
- Arguments can be passed inside functions
- Functions improve readability

---

# Task 2 – Disk and Memory Check

I created `disk_check.sh`.

This script:

- Checks disk usage
- Checks memory usage
- Displays system resource information

### What I Learned

- How to monitor disk usage
- How to check free memory
- Basic monitoring commands used in Linux

---

# Task 3 – Strict Mode

I created `strict_demo.sh`.

In this task, I learned about strict mode using:

- set -e
- set -u
- set -o pipefail

### Explanation

### set -e

Stops the script immediately if a command fails.

### set -u

Stops the script if an undefined variable is used.

### set -o pipefail

Stops the pipeline if any command inside the pipeline fails.

### What I Learned

Strict mode makes scripts safer and helps avoid hidden errors in automation.

---

# Task 4 – Local Variables

I created `locl_demo.sh`.

This task helped me understand:

- Local variables only work inside functions
- Variables do not leak outside the function
- Local variables help keep scripts clean

### What I Learned

Using local variables is important for writing organized scripts.

---

# Task 5 – System Information Reporter

I created `system_info.sh`.

This script displays:

- Hostname and OS information
- System uptime
- Disk usage
- Memory usage
- Top CPU-consuming processes

I used functions for every section to keep the script modular and easy to understand.

### What I Learned

- How to organize larger scripts
- How to separate tasks using functions
- Basic Linux system monitoring

---

# Key Learnings

1. Functions make scripts reusable and easier to manage.

2. Strict mode helps create safer and more reliable scripts.

3. Linux monitoring commands are very useful for DevOps and troubleshooting.

---

# Conclusion

This lab improved my shell scripting knowledge and helped me understand how scripting is used in real DevOps environments for automation and monitoring.
