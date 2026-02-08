# Shell Scripting Basics


# Challenge Tasks

Starting 16 days task
--------------------------------------------

## Task 1:   First Script


 1.  Create a file  `hello.sh`
2.  Add the shebang line  `#!/bin/bash`  at the top
3.  Print  `Hello, DevOps!`  using  `echo`
4.  Make it executable and run it

2026/day-16/Capture.PNG




### NOTE: 


## Task 2:   Variables


1.  Create  `variables.sh`  with:
    -   A variable for your  `NAME`
    -   A variable for your  `ROLE`  (e.g., "DevOps Engineer")
    -   Print:  `Hello, I am <NAME> and I am a <ROLE>`
2.  Try using single quotes vs double quotes — what's the difference?

----

## Task 3: User Input with read
1.  Create  `greet.sh`  that:
    -   Asks the user for their name using  `read`
    -   Asks for their favourite tool
    -   Prints:  `Hello <name>, your favourite tool is <tool>`

## Task 4: 

1.  Create  `check_number.sh`  that:
    
    -   Takes a number using  `read`
    -   Prints whether it is  **positive**,  **negative**, or  **zero**
2.  Create  `file_check.sh`  that:
    
    -   Asks for a filename
    -   Checks if the file  **exists**  using  `-f`
    -   Prints appropriate message

## Task 5:

1.  Stores a service name in a variable (e.g.,  `nginx`,  `sshd`)
2.  Asks the user: "Do you want to check the status? (y/n)"
3.  If  `y`  — runs  `systemctl status <service>`  and prints whether it's  **active**  or  **not**
4.  If  `n`  — prints "Skipped."




