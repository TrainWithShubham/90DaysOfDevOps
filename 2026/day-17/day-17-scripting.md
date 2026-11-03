# Day 17 – Shell Scripting: Loops, Arguments & Error Handling 🚀

Completed Day 17 of my #90DaysOfDevOps journey.

Today I practiced Shell Scripting concepts and created multiple automation scripts:

## Tasks Completed:

✅ For Loop

* Created `for_loop.sh`

  * Loops through a list of fruits and prints each fruit
* Created `count.sh`

  * Prints numbers 1 to 10 using a for loop

✅ While Loop

* Created `countdown.sh`

  * Takes user input
  * Counts down to 0 using a while loop
  * Prints "Done!" after completion

✅ Command-Line Arguments

* Created `greet.sh`

  * Used `$1` to accept name input
  * Added argument validation
* Created `args_demo.sh`

  * Practiced:

    * `$0` → script name
    * `$#` → number of arguments
    * `$@` → all arguments

✅ Package Installation Automation

* Created `install_packages.sh`
* Added:

  * Package list using variables
  * for loop automation
  * Package checking using `dpkg -s`
  * Install missing packages
  * Skip already installed packages
  * Root user validation

✅ Error Handling

* Created `safe_script.sh`
* Practiced:

  * `set -e` for stopping script on failure
  * `||` operator for handling errors
  * Directory creation
  * Navigation
  * File creation

## Key Learnings:

1. Shell scripts can automate repetitive server tasks.
2. Loops help process multiple items easily.
3. Error handling makes scripts safer and more reliable.

All scripts and documentation added to my Day-17 folder.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham

