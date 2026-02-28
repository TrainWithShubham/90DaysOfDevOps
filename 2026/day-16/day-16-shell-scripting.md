# **Day 16 – Shell Scripting Basics**

## **Task Objective**

The objective of Day 16 was to understand shell scripting fundamentals and implement them using hands-on scripts. The focus was on learning how scripts are executed, handling variables, taking user input, applying conditional logic, and combining all concepts into a real-world DevOps script.

## **Task 1: Shebang and First Script**

### **Shebang (`#!/bin/bash`)**

The shebang tells the operating system which interpreter should be used to execute the script. Without a shebang, the script execution depends on how and where it is run, which can lead to unpredictable behavior in automation or production environments.

### **Script: `hello.sh`**

\#\!/bin/bash  
echo "Hello DevOps\!\!\!"

### **Observation**

The script executed even after removing the shebang when run from an interactive Bash shell. However, this behavior is unreliable and should not be depended on. In real-world and production scripts, the shebang is mandatory to ensure consistent execution.

## **Task 2: Variables**

### **Concept**

A variable is used to store values that can change during script execution. Variables help avoid hardcoding values and allow scripts to work dynamically.

### **Script: `variables.sh`**

\#\!/bin/bash  
NAME="Shivkumar Konnuri"  
ROLE="DevOps Engineer"  
echo "I am $NAME and I am $ROLE"

### **Key Learnings**

* Variables must not have spaces around `=`  
* Variables are expanded only when **double quotes** are used  
* Single quotes treat variables as literal text and do not expand them  
* Variable naming consistency is important

## **Task 3: User Input using `read`**

### **Concept**

The `read` command is used to accept user input at runtime, making scripts dynamic instead of hardcoded.

### **Script: `greet.sh`**

\#\!/bin/bash  
read \-p "Enter your name: " NAME  
read \-p "Enter your favorite tool: " TOOL  
echo "Hello $NAME, your favorite tool is $TOOL"

### **Sample Output**

Enter your name: Shiv  
Enter your favorite tool: Docker  
Hello Shiv, your favorite tool is Docker

### **Key Learnings**

* `read -p` allows prompting the user for input  
* Variable names are case-sensitive  
* Consistent variable naming avoids confusion and bugs

## **Task 4: Conditional Logic (If–Else)**

### **Concept**

An `if–else` condition checks whether a condition is true or false and performs actions accordingly. Conditional logic allows scripts to make decisions during execution.

### 

### 

### **Task 4.1: Number Check Script**

### **Script: `check_number.sh`**

\#\!/bin/bash  
read \-p "Enter your number: " NUM

if \[ "$NUM" \-gt 0 \]  
then  
        echo "$NUM is positive"  
elif \[ "$NUM" \-lt 0 \]  
then  
        echo "$NUM is negative"  
else  
        echo "$NUM is zero"  
fi

### **Sample Output**

Enter your number: 4  
4 is positive

Enter your number: \-2  
\-2 is negative

Enter your number: 0  
0 is zero

### **Key Learnings**

* `-gt`, `-lt`, and `-eq` are used for numeric comparisons  
* Correct syntax (`then`, `fi`) is mandatory  
* Shell scripting is strict about syntax

### **Task 4.2: File Existence Check**

### **Script: `file_check.sh`**

\#\!/bin/bash  
read \-p "Enter the filename: " FILENAME

if \[ \-f "./$FILENAME" \]  
then  
        echo "File exists"  
else  
        echo "File does not exist"  
fi

### **Sample Output**

Enter the filename: dummy.txt  
File exists

Enter the filename: dummy1.txt  
File does not exist

### **Key Learnings**

* `-f` checks for the existence of a regular file  
* Scripts should handle both success and failure cases clearly

## **Task 5: Combining All Concepts – Service Status Check**

### **Script: `server_check.sh`**

\#\!/bin/bash  
SERVICE=nginx  
read \-p "Do you want to check the status? (y/n) \- " STATUS

if \[ "$STATUS" \= "Y" \] || \[ "$STATUS" \= "y" \]  
then  
        if sudo systemctl is-active \--quiet $SERVICE && sudo systemctl is-enabled \--quiet $SERVICE  
        then  
                echo "$SERVICE is active and running"  
        else  
                echo "$SERVICE is inactive"  
        fi  
elif \[ "$STATUS" \= "N" \] || \[ "$STATUS" \= "n" \]  
then  
        echo "Skipped"  
else  
        echo "Invalid input. please enter y or n."  
fi

### **Sample Output**

Do you want to check the status? (y/n) \- y  
nginx is active and running

Do you want to check the status? (y/n) \- n  
Skipped

### **Key Learnings**

* String comparisons must use `=` and variables must be quoted  
* `-eq` is only for numeric comparison  
* Quoting variables prevents script failure on empty input  
* `systemctl is-active` and `systemctl is-enabled` are useful for service health checks  
* Combining multiple scripting concepts results in real-world DevOps automation

## **Overall Learnings (Day 16\)**

* Shell scripts should be written defensively  
* Quoting variables is critical for stability  
* Single and double quotes behave differently  
* Syntax discipline is essential in shell scripting  
* Real DevOps scripts combine logic, input, and system commands

## **Conclusion**

Day 16 provided a strong foundation in shell scripting by focusing on practical scripts that resemble real production scenarios. The hands-on approach helped reinforce best practices and common pitfalls encountered in real-world DevOps work.