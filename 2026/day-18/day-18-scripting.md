# Day 18 – Shell Scripting: Functions & Slightly Advanced Concepts

## Task 1: Basic Functions
Create functions.sh with:
  - A function greet that takes a name as argument and prints Hello, <name>!
- A function add that takes two numbers and prints their sum
- Call both functions from the script

<img width="408" height="475" alt="image" src="https://github.com/user-attachments/assets/b58685f4-d973-49a4-9693-c6dbdc4e2d72" />
<img width="481" height="76" alt="image" src="https://github.com/user-attachments/assets/5ed04eaa-0cae-406a-9aa0-4f471a5a2f45" />

## Task 2: Functions with Return Values
 Create disk_check.sh with:
 -  A function check_disk that checks disk usage of / using df -h
 -  A function check_memory that checks free memory using free -h
 -  A main section that calls both and prints the results
<img width="705" height="653" alt="image" src="https://github.com/user-attachments/assets/8242d626-b197-4333-8bed-a0de29fbe38e" />
<img width="1011" height="345" alt="image" src="https://github.com/user-attachments/assets/3e5c7db0-b7dd-4ce1-b278-ba2f06055365" />

## Task 3: Strict Mode — set -euo pipefail

Create strict_demo.sh with set -euo pipefail at the top
Try using an undefined variable — what happens with set -u?
Try a command that fails — what happens with set -e?
Try a piped command where one part fails — what happens with set -o pipefail?

<img width="970" height="488" alt="image" src="https://github.com/user-attachments/assets/6ae0566b-f8e5-45f0-a70b-efbd8ee57d08" />

Document: What does each flag do?

set -e → It will do command failure
set -u → It will do undefied fail
set -o pipefail → if pipeline fail it will throw error


## Create local_demo.sh with:

A function that uses local keyword for variables
Show that local variables don't leak outside the function
Compare with a function that uses regular variables

<img width="1139" height="654" alt="image" src="https://github.com/user-attachments/assets/44c2ff16-d7ab-452f-b481-203b657b4624" />
<img width="554" height="169" alt="image" src="https://github.com/user-attachments/assets/a1b7be5e-ca77-44b2-bcad-876a9e441f45" />

## Task 5: Build a Script — System Info Reporter

Create system_info.sh that uses functions for everything:

- A function to print hostname and OS info
- A function to print uptime
- A function to print disk usage (top 5 by size)
- A function to print memory usage
- A function to print top 5 CPU-consuming processes
- A main function that calls all of the above with section headers
Use set -euo pipefail at the top
Output should look clean and readable.

<img width="707" height="627" alt="image" src="https://github.com/user-attachments/assets/e96bf17e-2e06-4014-824b-fa1d342a4bc7" />
<img width="820" height="619" alt="image" src="https://github.com/user-attachments/assets/7ab91d1d-10df-49cc-a9f2-43730cbd654c" />


## What you learned (3 key points)
- how to write function
- usage of set -euo
- local and global variable













