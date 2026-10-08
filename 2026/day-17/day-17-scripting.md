# Day 17 – Shell Scripting: Loops, Arguments & Error Handling

# Task 1: For Loop

## for_loop.sh

```bash
#!/bin/bash

for fruit in apple banana mango orange grapes
do
    echo "Fruit: $fruit"
done
```

## Commands Used

```bash
chmod +x for_loop.sh
./for_loop.sh
```

## Output

```text
Fruit: apple
Fruit: banana
Fruit: mango
Fruit: orange
Fruit: grapes
```

## Observation

The `for` loop repeats commands for every item in a list.

---

# count.sh

```bash
#!/bin/bash

for num in {1..10}
do
    echo "Number : $num"
done
```

## Commands Used

```bash
chmod +x count.sh
./count.sh
```

## Output

```text
Number : 1
Number : 2
Number : 3
Number : 4
Number : 5
Number : 6
Number : 7
Number : 8
Number : 9
Number : 10
```

## Observation

The `for` loop can also repeat commands through a sequence of numbers.

---

# Task 2: While Loop

## countdown.sh

```bash
#!/bin/bash

read -p "Enter a number: " NUM

while [ $NUM -ge 0 ]
do
    echo "Countdown: $NUM"
    NUM=$((NUM-1))
done

echo "Done!"
```

## Commands Used

```bash
chmod +x countdown.sh
./countdown.sh
```

## Output Example

```text
Enter a number: 6

Countdown: 6
Countdown: 5
Countdown: 4
Countdown: 3
Countdown: 2
Countdown: 1
Countdown: 0

Done!
```

## Observation

The `while` loop keeps running until the condition becomes false.

---

# Task 3: Command-Line Arguments

## greetAgain.sh

```bash
#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Usage: ./greet.sh <name>"

else
    echo "Hello, $1!"
fi
```

## Commands Used

```bash
chmod +x greetAgain.sh
./greetAgain.sh
./greetAgain.sh Asma
```

## Output Example 1

```text
Usage: ./greet.sh <name>
```

## Output Example 2

```text
Hello, Asma!
```

## Observation

`$1` represents the first command-line argument passed to the script.

---

# args_demo.sh

```bash
#!/bin/bash

echo "Script name: $0"
echo "Total arguments: $#"
echo "All arguments: $@"
```

## Commands Used

```bash
chmod +x args_demo.sh
./args_demo.sh apple mango banana
```

## Output

```text
Script name: ./args_demo.sh
Total arguments: 3
All arguments: apple mango banana
```

## Observation

- `$0` gives the script name
- `$#` gives total argument count
- `$@` gives all arguments passed to the script

---

# Task 4: Install Packages via Script

## install_packages.sh

```bash
#!/bin/bash

PACKAGES="nginx curl wget"

for pkg in $PACKAGES
do
    if dpkg -s $pkg > /dev/null 2>&1
    then
        echo "$pkg is already installed"

    else
        echo "Installing $pkg..."
        sudo apt install -y $pkg
    fi
done
```

## Commands Used

```bash
chmod +x install_packages.sh
./install_packages.sh
```

## Output Example

```text
Installing nginx...

curl is already installed
wget is already installed
```

## Observation

The script:

- loops through package names
- checks installation status
- installs missing packages automatically

---

# Task 5: Error Handling

## safe_script.sh

```bash
#!/bin/bash

set -e

mkdir /tmp/devops-test || echo "Directory already exists"

cd /tmp/devops-test || echo "Cannot enter directory"

touch testfile.txt || echo "Cannot create file"

echo "Script completed successfully"
```

## Commands Used

```bash
chmod +x safe_script.sh
./safe_script.sh
```

## Output Example

```text
Script completed successfully
```

## Observation

- `set -e` stops the script if an error occurs
- `||` handles errors gracefully with custom messages

---

# What I Learned

1. `for` and `while` loops automate repetitive tasks in shell scripts.
2. Command-line arguments like `$1`, `$#`, and `$@` make scripts dynamic and reusable.
3. Error handling with `set -e` and `||` improves script reliability and troubleshooting.
