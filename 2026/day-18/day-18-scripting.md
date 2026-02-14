# Day 18 – Shell Scripting: Functions & Slightly Advanced Concepts


### Task 1: Basic Functions
1. Create `functions.sh` with:
   - A function `greet` that takes a name as argument and prints `Hello, <name>!`
   - A function `add` that takes two numbers and prints their sum
   - Call both functions from the script

```bash
#!/bin/bash

greet() {
    read -p "Enter the name: " name
    read -p "Enter the first-number: " a
    read -p "Enter the second-number: " b
    echo "sum of two number $((a+b))"   
}

greet
```

### Task 2: Functions with Return Values
1. Create `disk_check.sh` with:
   - A function `check_disk` that checks disk usage of `/` using `df -h`
   - A function `check_memory` that checks free memory using `free -h`
   - A main section that calls both and prints the results

```bash

#!/bin/bash

check_disk() {
    echo "Disk Usage Report"
    df -h /

}
check_memory() {
    echo "Memory Usage Report"
    free -h

}
check_disk
check_memory
```

### Task 3: Strict Mode — `set -euo pipefail`
1. Create `strict_demo.sh` with `set -euo pipefail` at the top

2. Try using an **undefined variable** — what happens with `set -u`?
   -Because set -u prevents the use of variables that are not defined.

3. Try a command that **fails** — what happens with `set -e`?
   -The script immediately exits and does not execute any further commands.

4. Try a **piped command** where one part fails — what happens with `set -o pipefail`?
   -If any command in the pipeline fails, the entire pipeline fails and the script exits.

**Document:** What does each flag do?
- `set -e` →Exits the script immediately if any command returns a non-zero (error) status.

- `set -u` →Treats the use of undefined variables as an error and exits the script.

- `set -o pipefail` →Returns a failure status if any command in a pipeline fails, not just the last command.


### Task 4: Local Variables
1. Create `local_demo.sh` with:
   - A function that uses `local` keyword for variables
   - Show that `local` variables don't leak outside the function
   - Compare with a function that uses regular variables

```bash
--------------------------LOCAL----------------------------------
INPUT:
#!/bin/bash
my_function() {
    name="Om"
    echo "Inside function: $name"
}
my_function
echo "Outside function: $name"
OUTPUT:
Inside function: Om
Outside function: Om

-----------------------GLOBAL------------------------------------
INPUT:
#!/bin/bash
my_function() {
    local name="Om"
    echo "Inside function: $name"
}
my_function
echo "Outside function: $name"
OUTPUT:
Inside function: Om
Outside function:Nothing will print

```


### Task 5: Build a Script — System Info Reporter
Create `system_info.sh` that uses functions for everything:
1. A function to print **hostname and OS info**
2. A function to print **uptime**
3. A function to print **disk usage** (top 5 by size)
4. A function to print **memory usage**
5. A function to print **top 5 CPU-consuming processes**
6. A `main` function that calls all of the above with section headers
7. Use `set -euo pipefail` at the top

