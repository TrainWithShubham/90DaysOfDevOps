# Day 17 – Shell Scripting: Loops, Arguments & Error Handling
-------

## 1. Handling Command-Line Arguments
- Arguments allow you to pass data into your script at runtime without hardcoding values.

| Variable | 	Description |
| -------- | ------------ |
| $0 | The name of the script itself. |
| $1, $2...$n |	The first, second, etc., arguments passed. |
| $# |	The total number of arguments provided. |
| $@ |	All arguments passed (useful for looping through them). |
| $? |	The exit status of the last command (0 = success, 1+ = error). |

-----------
## Task 1: For Loop
1. Created a `for_loop.sh` script file 
```bash
#!/bin/bash

fruits=("Apple" "Banana" "Greps" "Mango" "Orange")

for fruit in "${fruits[@]}";
do
        echo "Fruit: $fruit"
done
```
Output:
```shell
ubuntu@ip-172-31-23-228:~/day17$ chmod 755 for_loop.sh
ubuntu@ip-172-31-23-228:~/day17$ ./for_loop.sh
Fruit: Apple
Fruit: Banana
Fruit: Greps
Fruit: Mango
Fruit: Orange
````
2. Created a `count.sh` script file
- code
```bash
 #!/bin/bash

for i in {1..10};
do
        echo "Number: $i"
done
```
- Output:
```shell
ubuntu@ip-172-31-23-228:~/day17$ chmod 755 count.sh
ubuntu@ip-172-31-23-228:~/day17$ ./count.sh
Number: 1
Number: 2
Number: 3
Number: 4
Number: 5
Number: 6
Number: 7
Number: 8
Number: 9
Number: 10
```
---------
## Task 2: While Loop
Created a `countdown.sh` script file
- code:
```bash
#!/bin/bash

echo -n "Enter a number to start the countdown:"
read count
while [ $count -ge 0 ];
do
        echo "$count"
        ((count--))
        sleep 1
done
echo "Done!"
```
- Output:
```shell
ubuntu@ip-172-31-23-228:~/day17$ chmod 755 countdown.sh
ubuntu@ip-172-31-23-228:~/day17$ ./countdown.sh
Enter a number to start the countdown:5
5
4
3
2
1
0
Done!
```
------------
## Task 3: Command-Line Arguments
1. Created a `greet.sh` script file.
- code:
```bash
#!/bin/bash


if [ -z "$1" ]; then
        echo "Usage: ./greet.sh"
else
        echo "Hello, $1!"
fi
```
- Output
```shell
ubuntu@ip-172-31-23-228:~/day17$ chmod 755 countdown.sh
ubuntu@ip-172-31-23-228:~/day17$ ./greet.sh
Usage: ./greet.sh
ubuntu@ip-172-31-23-228:~/day17$ ./greet.sh rajkumar
Hello, rajkumar!
```
2. Created a `args_demo.sh` script file.
- code:
```bash
#!/bin/bash

echo "-------Argument Demo------"
echo "Total Number of Arguments (\$#): $#"
echo "All Arguments (\$@): $@"
echo "-----------------"
```
- Output
```shell
ubuntu@ip-172-31-23-228:~/day17$ chmod 755 args_demo.sh
ubuntu@ip-172-31-23-228:~/day17$ ./args_demo.sh
-------Argument Demo------
Total Number of Arguments ($#): 0
All Arguments ($@):
-----------------
ubuntu@ip-172-31-23-228:~/day17$ ./args_demo.sh devops python raja
-------Argument Demo------
Total Number of Arguments ($#): 3
All Arguments ($@): devops python raja
-----------------
```
-------------
## Task 4: Install Packages via Script
1. Created a `install_packages.sh` script file
- code:
```bash
#!/bin/bash
# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)."
  exit 1
fi
# List of packages to manage
PACKAGES=("nginx" "curl" "wget")
echo "Starting package check..."
for pkg in "${PACKAGES[@]}"; do
    # Check if the package is installed via dpkg
    if dpkg -s "$pkg" > /dev/null 2>&1; then
        echo "[SKIP] $pkg is already installed."
    else
        echo "[INSTALLING] $pkg not found. Installing now..."
        # Install the package
        apt-get update > /dev/null 2>&1
        apt-get install -y "$pkg" > /dev/null 2>&1
        # Error Handling: Check if the installation succeeded
        if [ $? -eq 0 ]; then
            echo "[SUCCESS] $pkg installed successfully."
        else
                echo "[ERROR] Failed to install $pkg."
        fi
    fi
done
echo "All tasks complete."
```
- Output
```shell
ubuntu@ip-172-31-23-228:~/day17$ chmod 755 install_packages.sh
ubuntu@ip-172-31-23-228:~/day17$ ./install_packages.sh
Please run as root (use sudo).
ubuntu@ip-172-31-23-228:~/day17$ sudo ./install_packages.sh
Starting package check...
[SKIP] nginx is already installed.
[SKIP] curl is already installed.
[SKIP] wget is already installed.
All tasks complete.
```
----------
## Task 5: Error Handling
1. Created a `safe_script.sh` script file
- code:
```bash
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

DIR="/tmp/devops-test"

echo "Starting safe operations..."

# Use || to provide context before the script potentially exits
mkdir "$DIR" 2>/dev/null || echo "Note: Directory already exists or cannot be created"

cd "$DIR" || { echo "Failed to enter directory"; exit 1; }

touch devops_is_awesome.txt || { echo "Failed to create file"; exit 1; }

echo "Success! File created in $DIR"
```
- Output
```shell
ubuntu@ip-172-31-23-228:~/day17$ chmod 755 safe_script.sh
ubuntu@ip-172-31-23-228:~/day17$ ./safe_script.sh
Starting safe operations...
Success! File created in /tmp/devops-test
ubuntu@ip-172-31-23-228:~/day17$ ./safe_script.sh
Starting safe operations...
Note: Directory already exists or cannot be created
Success! File created in /tmp/devops-test
```
2. Modified `install_packages.sh` script file to `install_packages2.sh` script file.
- code:
```bash
#!/bin/bash

# Root Check Error Handling
if [ "$EUID" -ne 0 ]; then
    echo "CRITICAL ERROR: This script must be run as root."
    echo "Please use: sudo $0"
    exit 1
fi

PACKAGES=("nginx" "curl" "wget")

for pkg in "${PACKAGES[@]}"; do
    if dpkg -s "$pkg" > /dev/null 2>&1; then
        echo "[SKIP] $pkg is already here."
    else
        echo "[INSTALL] Attempting to install $pkg..."
        apt-get update > /dev/null 2>&1
        apt-get install -y "$pkg" > /dev/null 2>&1 || echo "[FAIL] Could not install $pkg"
    fi
done
```
- Output
```shell

ubuntu@ip-172-31-23-228:~/day17$ chmod 755 install_packages2.sh
ubuntu@ip-172-31-23-228:~/day17$ ./install_packages2.sh
CRITICAL ERROR: This script must be run as root.
Please use: sudo ./install_packages2.sh
ubuntu@ip-172-31-23-228:~/day17$ sudo ./install_packages2.sh
[SKIP] nginx is already here.
[SKIP] curl is already here.
[SKIP] wget is already here.
```
----------------
 ## 3 Key Point
- when you writing list of variables make sure there is no space between variable and list.
- When you writing for loop always use for new line with ; do.
- When you writing if condition always close with fi

-----------
