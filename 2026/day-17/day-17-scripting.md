# Day 17 – Shell Scripting: Loops, Arguments & Error Handling
## Task 1: For Loop
1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one
Script:
 <img width="560" height="196" alt="Screenshot 2026-03-08 005057" src="https://github.com/user-attachments/assets/35aaec12-caca-47a8-a7b4-bee014d4b5e4" />
Output:

<img width="734" height="196" alt="Screenshot 2026-03-08 005141" src="https://github.com/user-attachments/assets/151495d0-5358-4ea6-ab9e-a647d047689e" />


2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop
   
   - [Script]
   
   <img width="727" height="200" alt="image" src="https://github.com/user-attachments/assets/fed54648-d71f-45f0-b313-94366ea5a4aa" />

   - Output:
     <img width="745" height="384" alt="Screenshot 2026-03-08 005425" src="https://github.com/user-attachments/assets/8025a0a4-bc39-423f-a57f-a4a0033545fc" />

---

## Task 2: While Loop
1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end

  - [Script]
    <img width="449" height="290" alt="Screenshot 2026-03-08 005908" src="https://github.com/user-attachments/assets/78a5b561-fa62-4036-9df5-0da5eac1d8ed" />
   
   -[Countdown]
   <img width="843" height="294" alt="Screenshot 2026-03-08 010045" src="https://github.com/user-attachments/assets/df077efb-0e36-4475-b0b5-51379f9c13a8" />

---

## Task 3: Command-Line Arguments
1. Create `greet.sh` that:
   - Accepts a name as `$1`
   - Prints `Hello, <name>!`
   - If no argument is passed, prints "Usage: ./greet.sh <name>"
   
   - [Script]
   
   <img width="565" height="212" alt="image" src="https://github.com/user-attachments/assets/33bc57c4-5cc8-4cb9-bfc2-210c29f34e06" />
   
   - OUTPUT
     <img width="811" height="414" alt="Screenshot 2026-03-08 010915" src="https://github.com/user-attachments/assets/551a1a12-45ae-4d6f-9cb2-445d3ef2ac76" />

3. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)
   
   - [Script]
     <img width="454" height="235" alt="image" src="https://github.com/user-attachments/assets/6c6e5c95-679f-4a5d-a616-dcb6b8ea1ec1" />

   - OUTPUT
     <img width="792" height="204" alt="image" src="https://github.com/user-attachments/assets/066d6b0f-aff5-4ff7-bf21-c281791ea7fe" />

---

## Task 4: Install Packages via Script
1. Create `install_packages.sh` that:
   - Defines a list of packages: `nginx`, `curl`, `wget`
   - Loops through the list
   - Checks if each package is installed (use `dpkg -s` or `rpm -q`)
   - Installs it if missing, skips if already present
   - Prints status for each package
   
   - [Script]
   <img width="537" height="372" alt="image" src="https://github.com/user-attachments/assets/07f37fe0-2482-44e5-af1a-608daa7a0fee" />
   
   - OUTPUT:
   
   <img width="685" height="286" alt="image" src="https://github.com/user-attachments/assets/59d4c0bf-7ece-4a53-9475-9dc79eba4535" />

---

## Task 5: Error Handling
1. Create `safe_script.sh` that:
   - Uses `set -e` at the top (exit on error)
   - Tries to create a directory `/tmp/devops-test`
   - Tries to navigate into it
   - Creates a file inside
   - Uses `||` operator to print an error if any step fails
   
   - [Script]
   <img width="759" height="290" alt="image" src="https://github.com/user-attachments/assets/db2bc44f-10c5-4a33-b58c-4236215ab114" />

   - OUTPUT
   
   <img width="763" height="191" alt="image" src="https://github.com/user-attachments/assets/e38898c4-3a9a-4c46-9fff-1f69976da5bf" />
  

2. Modify your `install_packages.sh` to check if the script is being run as root — exit with a message if not.

   - [Script]
   <img width="537" height="372" alt="image" src="https://github.com/user-attachments/assets/d00d7029-f8f5-46a1-b1a7-ee36bbd82b44" />
   
   - OUTPUT 


| **Command (Terminal Prompt)**  | **Output in Terminal**                          |
| ------------------------------ | ----------------------------------------------- |
| `$ ./install_packages.sh`      | `Error: Please run this script as root.`        |
| `$ sudo ./install_packages.sh` | `Running as root. Starting package check...`    |
|                                | `Checking nginx...`                             |
|                                | `Status - nginx is already installed.`          |
|                                | `-----------------------------`                 |
|                                | `Checking curl...`                              |
|                                | `Status - curl is not installed. Installing...` |
|                                | `Status - curl installed successfully.`         |
|                                | `-----------------------------`                 |
|                                | `Checking wget...`                              |
|                                | `Status - wget is already installed.`           |
|                                | `-----------------------------`                 |


     
     ------------------------
---


## What I Learned

* Used for loops to iterate over lists and number ranges
* Used while loops for countdown logic with user input
* Handled command-line arguments using $1, $#, $@, $0
* Added usage messages for missing arguments
* Took user input using read
* Automated package installation (nginx, curl, wget)
* Checked package status using dpkg -s
* Added root user validation using $EUID
* Implemented error handling with set -e and ||
* Created safe scripts to avoid failures and overwrites
