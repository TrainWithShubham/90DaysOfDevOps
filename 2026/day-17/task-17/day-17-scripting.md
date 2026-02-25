## Day 17 – Shell Scripting: Loops, Arguments & Error Handling
# Task 1: For Loop
- Create for_loop.sh that Loops through a list of 5 fruits and prints each one
```
#!/bin/bash

# List of fruits
fruits=("Apple" "Banana" "Mango" "Orange" "Grapes")
- Prints numbers 1 to 10 using a for loop
# Loop through each fruit
for fruit in "${fruits[@]}"
do
    echo "Fruit: $fruit"
done
```
- Create count.sh that Prints numbers 1 to 10 using a for loop
```
#!/bin/bash

for num in {1..10}
do
    echo $num
done
```
# Task 2: While Loop 
- Takes a number from the user, Counts down to 0 using a while loop, Prints "Done!" at the end
```
#!/bin/bash

read -p "Enter a number: " num

while [ "$num" -ge 0 ]
do
    echo $num
    ((num--))
done

echo "Done!"
```
# Task 3: Command-Line Arguments
- Accepts a name as $1, Prints Hello, <name>!, If no argument is passed, prints "Usage: ./greet.sh "
```
if [ $# -eq 0 ]; then
 echo "Usage:./greet.sh"
else
 echo "Hello, $1"
fi
```
- Create args_demo.sh that:Prints total number of arguments $#, Prints all arguments $@, Prints the script name ($0)
```
#!/bin/bash
echo "Script name: $0"
echo "Total number of arguments: $#"
echo "All arguments: $@"
```
# Task 4: Install Packages via Script
```
#!/bin/bash

packages=("nginx" "curl" "wget")

echo "**** Updating packages list ****"
# -qq = very quietly, -q = quiet or --quiet , --quiet --quiet . 
apt-get update -qq


for package in "${packages[@]}";
do
        echo "***** Checking $package ***** "
        if dpkg -s "$package" &> /dev/null; then
                version=$(dpkg -s "$package" | awk '/^Version:/ {print $2}')
                echo "$package is already Installed Version: $version"

        else
                echo "***** $package not found. Installing ***** "

                if apt-get install -y "$package" &> /dev/null; then
                        echo "Successfully installed $package"
                else
                        echo "Failed to Install $package"
                fi
        fi
done
```
# Task 5: Error Handling
- Create safe_script.sh that:Uses set -e at the top (exit on error), Tries to create a directory /tmp/devops-test, Tries to navigate into it, Creates a file inside
Uses || operator to print an error if any step fails
```
#!/bin/bash

# Exit immediately if a command exits with non-zero status
set -e

echo "Creating directory..."
mkdir /tmp/devops-test || { echo "Directory already exists"; exit 1; }
# The { ...; } is a command group. It lets you run multiple commands after ||.
```