## Day 18 – Shell Scripting: Functions & Slightly Advanced Concepts
# Task 1: Basic Functions
- Create functions.sh with:A function greet that takes a name as argument and prints Hello, <name>! , A function add that takes two numbers and prints their sum Call both functions from the script
```
#!/bin/bash

greet()

{
read -p "Enter your name" name
echo "Hello, $name!"
}

greet

add()
{
        read -p "Enter the number 1" num1
        read -p "Enter the number 2" num2
        sum=$((num1+num2))
        echo "The sum is $sum"
}

add
```
# Task 2: Functions with Return Values
- Create disk_check.sh with:A function check_disk that checks disk usage of / using df -h, A function check_memory that checks free memory using free -h, A main section that calls both and prints the results
```
#/bin/bash

check_disk()

{
        echo "----Disk Usage Root-----"
        df -h /

}
check_memory()
{
        echo "---memory status---"
        free -h
}
check_disk
check_memory
```
# Task 3: Strict Mode — set -euo pipefail
- Create strict_demo.sh with set -euo pipefail at the top
- Try using an undefined variable — what happens with set -u?
- Try a command that fails — what happens with set -e?
- Try a piped command where one part fails — what happens with set -o pipefail?
- Document: What does each flag do?
- set -e →, set -u → & set -o pipefail 
```
#!/bin/bash
set -euo pipefail

echo "Strict mode enabled!"

# undefined variable test
echo "vale of name is: $name"

# Trying failing command
echo "Trying to list a non-existent file..."
ls name.txt

# pipe failure test
echo "Testing pipe failure..."
grep "text" name.txt | sort
echo "script completed!"
```
- set -e → Exit immediately if any command fails (non-zero exit code).
- set -u → Treat undefined variables as errors and stop the script.
- set -o pipefail → If any command in a pipeline fails, the whole pipeline fails.
# Task 4: Local Variables
- Create local_demo.sh with:A function that uses local keyword for variables, Show that local variables don't leak outside the function & Compare with a function that uses regular variables
```
#!/bin/bash

echo "=== Demonstrating local vs global variables ==="
echo

# Function using local variable
function_with_local() {
    local message="I am LOCAL"
    echo "Inside function_with_local: $message"
}

# Function using normal variable (global)
function_without_local() {
    message="I am GLOBAL"
    echo "Inside function_without_local: $message"
}

# Call first function
function_with_local

# Try accessing variable outside
echo "Outside after function_with_local: ${message:-Not Set}"
echo

# Call second function
function_without_local

# Access variable outside
echo "Outside after function_without_local: $message"
```
# Task 5: Build a Script — System Info Reporter
- Create system_info.sh that uses functions for everything:

- A function to print hostname and OS info
- A function to print uptime
- A function to print disk usage (top 5 by size)
- A function to print memory usage
- A function to print top 5 CPU-consuming processes
- A main function that calls all of the above with section headers
- Use set -euo pipefail at the top
```
#!/bin/bash

#A function to print hostname and OS info

set -euo pipefail
printsystem_info()
{
        echo "---system information--"
        echo "Host Name: $(hostname)"
        echo "OS: $(uname -s)"
        echo "kernel: $(uname -r)"
}

# A function to print uptime
print_uptime()
{                                                                                               
        echo "---uptime---"                                                                     
        uptime -p                                                                               
        echo                                                                                    
}                                                                                               
# A function to print disk usage (top 5 by size)                                                
                                                                                                
disk_usage()                                                                                    
{                                                                                               
        echo "---disk usage---"                                                                 
        sudo df -h |sort -rh |  head -n 5                                                       
}    
# A function to print memory usage                                                              
                                                                                                
memory_usage()                                                                                  
{                                                                                               
        echo "---memory usage---"                                                               
        free -h                                                                                 
}                                                                                                                                                                        
#A function to print top 5 CPU-consuming processes                                                 
print_top_process()                                                                             
{                                                                                               
        echo "--top 5 CPU consuming process---"                                                 
        ps aux --sort=-%cpu | head -n 6                                                         
}     
#A main function that calls all of the above with section headers                               
                                                                                                
main()                                                                                          
{                                                                                               
        echo "----system information report---"                                                 
        printsystem_info                                                                        
        print_uptime                                                                            
        disk_usage                                                                              
        memory_usage                                                                            
        print_top_process                                                                       
        echo "--Report completed successfully---"                                               
                                                                                                
}                                                                                               
main   
```                      