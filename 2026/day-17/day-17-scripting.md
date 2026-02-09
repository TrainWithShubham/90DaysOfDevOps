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

# Install karne wale packages ki list
packages="nginx curl wget"

# Har package ke liye loop chalega
for pkg in $packages
do
    # Batata hai kaunsa package check ho raha hai
    echo "Package check ho raha hai: $pkg"

    # Check karta hai ki package pehle se install hai ya nahi
    if dpkg -s $pkg >/dev/null 2>&1
    then
        # Agar package pehle se install hai
        echo "$pkg pehle se install hai. Skip kiya ja raha hai..."
    else
        # Agar package install nahi hai
        echo "$pkg install nahi hai. Ab install kiya ja raha hai..."
        
        # Package install karne ka command
        apt install -y $pkg

        # Install complete hone ka message
        echo "$pkg ka installation complete ho gaya."
    fi

    # Output ko clean dikhane ke liye line
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

# set -e ka matlab:
# jaise hi koi command fail hogi, script turant band ho jayegi
set -e

echo "Script start ho rahi hai..."

# Step 1: Directory banane ki koshish
# Agar directory pehle se hai, to error message print hoga
mkdir /tmp/devops-test || echo "Directory pehle se exist karti hai"

# Step 2: Directory ke andar jane ki koshish
# Agar directory nahi mili, to error message print hoga
cd /tmp/devops-test || echo "Directory ke andar jane me error aaya"

# Step 3: File create karna
# touch command file banata hai
touch demo.txt || echo "File create nahi ho payi"

echo "File aur directory successfully create ho gaye 🎉"

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

# Step 1: Check karo ki script root user se run ho rahi hai ya nahi
# Agar root nahi hai to message dikha ke script band ho jayegi
if [ "$EUID" -ne 0 ]
then
    echo " Ye script root user se run karni hogi"
    echo "Please 'sudo -i' ya 'sudo ./install_packages.sh' use karo"
    exit 1
fi

# Step 2: Install karne wale packages ki list
packages="nginx curl wget"

echo "✅ Script root user se run ho rahi hai"
echo "-----------------------------"

# Step 3: Har package ke liye loop
for pkg in $packages
do
    echo "Package check ho raha hai: $pkg"

    # Step 4: Check karo package pehle se install hai ya nahi
    if dpkg -s $pkg &> /dev/null
    then
        echo "$pkg pehle se install hai. Skip kiya ja raha hai..."
    else
        echo "$pkg install nahi hai. Ab install ho raha hai..."

        # Step 5: Package install karo
        apt install -y $pkg

        echo "$pkg ka installation complete ho gaya."
    fi

    echo "-----------------------------"
done

echo " Sab packages ka process complete ho gaya"

```
