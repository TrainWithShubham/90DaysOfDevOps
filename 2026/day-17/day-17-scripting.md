# **Day 17 – Shell Scripting: Loops, Arguments & Error Handling**

## **Objective**

To understand and practice loops, command-line arguments, package installation using scripts, and basic error handling in shell scripting.

## **Concepts Learned**

### **For Loop**

A for loop is used to repeat the same execution multiple times.  
 Instead of writing the same command again and again, we use a for loop when we want to perform the same action on multiple values or within a fixed range.

### **While Loop**

A while loop runs as long as a condition is true.  
 It is commonly used when the number of iterations depends on user input or a condition that changes during execution (increment or decrement).

### **Command-Line Arguments**

Command-line arguments are values passed to the script at runtime.  
 They allow scripts to behave dynamically instead of using hardcoded values.

* $1 → First argument

* $\# → Total number of arguments

* $@ → All arguments

* $0 → Script name

### **Error Handling**

Error handling ensures the script exits safely when something goes wrong.  
 Using set \-e makes the script stop immediately if any command fails.

## **Task 1: For Loop**

### **Fruits Loop Script**

The script prints a list of fruits one by one using a for loop.

\#\!/bin/bash  
for fruits in apple banana mango grapes guava  
do  
        echo "$fruits"  
done

### **Number Count Script (1 to 10\)**

\#\!/bin/bash  
for i in {1..10}  
do  
        echo $i  
done

## **Task 2: While Loop**

### **Countdown Script**

This script takes a number from the user and counts down to zero.

\#\!/bin/bash  
read \-p "Enter the start point of the countdown: " START\_NUM  
while \[ "$START\_NUM" \-ge 0 \]  
do  
        echo "$START\_NUM"  
        START\_NUM=$((START\_NUM \- 1))  
done  
echo "Done\!\!\!\!"

### **Observation**

The issue occurred earlier because arithmetic operations were not done using shell arithmetic syntax.  
 Using $(( )) fixed the problem.

## **Task 3: Command-Line Arguments**

### **Greet Script Using Argument**

\#\!/bin/bash  
if \[ \-z "$1" \]  
then  
        echo "Usage: ./greet.sh \<name\>"  
else  
        echo "Hello $1\!"  
fi

### **Arguments Demo Script**

\#\!/bin/bash  
echo "$0"  
echo "$\#"  
echo "$@"

## **Task 4: Install Packages via Script**

### **Why Package Check Is Required**

Installing an already installed package is unnecessary and may cause errors or conflicts.  
 Hence, checking before installation is important.

### **Package Installation Script (Root Check \+ Loop)**

\#\!/bin/bash  
if \[ $(id \-u) \-ne 0 \]  
then  
        echo "FAIL \- Login as a root user to install these packages"  
        exit 1  
else  
        apt-get update  
fi

for package\_name in nginx docker.io python3  
do  
        if dpkg \-s $package\_name &\>/dev/null  
        then  
                echo "$package\_name is already installed\!"  
        else  
                apt install $package\_name \-y  
        fi  
done

## **Task 5: Error Handling**

### **Safe Script with set \-e**

\#\!/bin/bash  
set \-e  
mkdir /tmp/devops-test || echo "Directory already exists"  
cd /tmp/devops-test  
touch new-devops-file.txt

### **Behavior**

* Script exits automatically if any unhandled command fails  
* Directory creation is handled safely  
* File creation happens only after successful directory access

## **What I Learned**

* For and while loops help avoid repetitive code  
* Command-line arguments make scripts dynamic and reusable  
* Checking user input and root access is critical in production scripts  
* set \-e helps fail fast and avoid partial execution  
* Package installation scripts should always validate system state first

## **Conclusion**

This day helped me understand how real-world automation scripts are written using loops, arguments, and error handling. These concepts are directly applicable in DevOps tasks like server setup, automation, and maintenance.

