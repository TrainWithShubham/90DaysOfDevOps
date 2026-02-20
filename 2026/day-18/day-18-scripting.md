# **Day 18 – Shell Scripting: Functions & Strict Mode**

## **Task**

Today task was to write cleaner and reusable shell scripts using:

* Functions

* set \-euo pipefail

* Local variables

* Structured script using main()

# **Task 1 – Basic Functions**

## **Script: functions.sh**

\#\!/bin/bash

greet() {  
    echo "Hello, $1\!"  
}

add() {  
    echo $(($1 \+ $2))  
}

greet "Shiv"  
add 3 5

## **Output**

Hello, Shiv\!  
8

## **What I Learned**

* Function does not execute until it is called.

* Arguments inside function are accessed using $1, $2.

* For arithmetic we must use $(( )).

* We should not use script arguments if not required.

# **Task 2 – Disk & Memory Check**

## **Script: disk\_check.sh**

\#\!/bin/bash

check\_disk() {  
    echo "=============================="  
    echo "        DISK USAGE"  
    echo "=============================="  
    df \-h /  
    echo  
}

check\_memory() {  
    echo "=============================="  
    echo "        MEMORY USAGE"  
    echo "=============================="  
    free \-h  
    echo  
}

main() {  
    check\_disk  
    check\_memory  
}

main

## **Output**

Shows formatted disk and memory usage.

## **What I Learned**

* main() helps structure script clearly.

* Execution is top to bottom.

* main() acts like logical entry point.

* Clean formatting makes script look professional.

# **Task 3 – Strict Mode Demo**

## **Script: strict\_demo.sh**

\#\!/bin/bash  
set \-euo pipefail

test\_undefined\_variable() {  
    echo "---- TEST: Undefined Variable \----"  
    NAME="SHIV"  
    echo "Hello $NMAE"  
}

test\_command\_failure() {  
    echo "---- TEST: Command Failure \----"  
    cat file.txt  
}

test\_pipeline\_failure() {  
    echo "---- TEST: Pipeline Failure \----"  
    ls \-l file.txt | sort  
}

\# Call only one at a time  
Test\_undefined\_variable

## **What Happens**

* set \-u → stops script if variable not defined  
* set \-e → stops script if command fails  
* set \-o pipefail → stops script if any command inside pipeline fails

## **What I Learned**

* Strict mode prevents silent errors.  
* Without pipefail, pipeline can hide failures.  
* In production automation strict mode is very important.

# **Task 4 – Local Variables**

## **Script: local\_demo.sh**

\#\!/bin/bash

value=10

with\_local\_func() {  
    echo "============================"  
    echo "     With Local Keyword     "  
    echo "============================"  
    local value=20  
}

without\_local\_func() {  
    echo "==============================="  
    echo "     Without Local Keyword     "  
    echo "==============================="  
    value=30  
}

echo "Initial value: $value"  
without\_local\_func  
echo "Modified global value: $value"  
value=10  
echo "Resetting the value to: $value"  
with\_local\_func  
echo "Not modified global value: $value"

**Output**  
Initial value: 10  
Modified global value: 30  
Resetting the value to: 10  
Not modified global value: 10

## **What I Learned**

* Variables are global by default in bash.  
* Without local, function modifies global variable.  
* Using local prevents accidental modification.  
* This avoids bugs in large scripts.

# **Task 5 – System Info Reporter**

## **Script: system\_info.sh**

\#\!/bin/bash  
set \-euo pipefail

server\_info() {  
    echo "==========================="  
    echo "        SERVER-INFO        "  
    echo "==========================="  
    echo "Hostname : $(hostname)"  
    echo "OS : $(uname \-o)"  
    echo  
}

server\_uptime() {  
    echo "==========================="  
    echo "           UPTIME          "  
    echo "==========================="  
    echo "Server Up Time : $(uptime \-p)"  
    echo  
}

server\_disk\_usage() {  
    echo "============================"  
    echo "     SERVER-DISK-USAGE      "  
    echo "============================"  
    du \-sh /\* 2\>/dev/null | sort \-hr | head \-n 5  
    echo  
}

server\_memory() {  
    echo "============================"  
    echo "       SERVER-MEMORY        "  
    echo "============================"  
    free \-h  
    echo  
}

server\_cpu\_usage() {  
    echo "============================"  
    echo "         CPU-USAGE          "  
    echo "============================"  
    ps \-eo pid,ppid,cmd,%mem,%cpu \--sort=-%cpu | head \-n 6  
    echo  
}

main() {  
    server\_info  
    server\_uptime  
    server\_disk\_usage  
    server\_memory  
    server\_cpu\_usage  
}

main

## **What I Learned**

* Strict mode can stop script if command not available.  
* Must handle permission errors properly.  
* Functions help modular design.  
* main() gives clear execution structure.  
* Clean output formatting matters in production.

# **Key Learnings (3 Points)**

1. Functions control execution flow and make script modular.  
2. set \-euo pipefail prevents silent failures.  
3. local keyword is important to avoid variable collision bugs.

