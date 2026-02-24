# Day 17 – Shell Scripting: Loops, Arguments & Error Handling


### Task 1: For Loop

1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one

```bash
#!/bin/bash

fruits=("Apple" "Banana" "Mango" "Orange" "Grapes")

for fruit in "${fruits[@]}"
do
  echo "$fruit"
done
```
2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop

```bash

#!/bin/bash

for i in {1..10}
do
  echo "$i"
done

```


### Task 2: While Loop

1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end

```bash
#!/bin/bash

echo "Enter a number:"
read num

while [ "$num" -ge 0 ]
do
  echo "$num"
  num=$((num - 1))
done

echo "Done!"

```

### Task 3: Command-Line Arguments

1. Create `greet.sh` that:
   - Accepts a name as `$1`
   - Prints `Hello, <name>!`
   - If no argument is passed, prints "Usage: ./greet.sh <name>"

```bash
#!/bin/bash

if [ -z "$1" ]
then
  echo "Usage: ./greet.sh <name>"
else
  echo "Hello, $1!"
fi

```

2. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)

```bash
#!/bin/bash

echo "Script name: $0"
echo "Total number of arguments: $#"
echo "All arguments: $@"

```

### Task 4: Install Packages via Script
1. Create `install_packages.sh` that:
   - Defines a list of packages: `nginx`, `curl`, `wget`
   - Loops through the list
   - Checks if each package is installed (use `dpkg -s` or `rpm -q`)
   - Installs it if missing, skips if already present
   - Prints status for each package

```bash
#!/bin/bash

packages="nginx curl wget"

for pkg in $packages
do
    echo "Checking package: $pkg"

    if dpkg -s $pkg >/dev/null 2>&1
    then
        echo "$pkg is already installed. Skipping..."
    else
        echo "$pkg is not installed. Installing now..."

        apt install -y $pkg

        echo "$pkg installation completed."
    fi

    echo "-----------------------------"
done


```

### Task 5: Error Handling
1. Create `safe_script.sh` that:
   - Uses `set -e` at the top (exit on error)
   - Tries to create a directory `/tmp/devops-test`
   - Tries to navigate into it
   - Creates a file inside
   - Uses `||` operator to print an error if any step fails

```bash
#!/bin/bash

set -e

echo "Script is starting..."

mkdir /tmp/devops-test || echo "Directory already exists"

cd /tmp/devops-test || echo "Error while entering the directory"

touch demo.txt || echo "File could not be created"

echo "File and directory created successfully "


```

2. Modify your `install_packages.sh` to check if the script is being run as root — exit with a message if not.

---

## Hints
- For loop: `for item in list; do ... done`
- While loop: `while [ condition ]; do ... done`
- Arguments: `$1` first arg, `$#` count, `$@` all args
- Check root: `if [ "$EUID" -ne 0 ]; then echo "Run as root"; exit 1; fi`
- Check package: `dpkg -s <pkg> &> /dev/null && echo "installed"`

```bash
#!/bin/bash

if [ "$EUID" -ne 0 ]
then
    echo "This script must be run as root user"
    echo "Please use 'sudo -i' or 'sudo ./install_packages.sh'"
    exit 1
fi

packages="nginx curl wget"

echo "✅ Script is running as root user"
echo "-----------------------------"

for pkg in $packages
do
    echo "Checking package: $pkg"

    if dpkg -s $pkg &> /dev/null
    then
        echo "$pkg is already installed. Skipping..."
    else
        echo "$pkg is not installed. Installing now..."

        apt install -y $pkg

        echo "$pkg installation completed."
    fi

    echo "-----------------------------"
done

echo "All packages process completed"


```
