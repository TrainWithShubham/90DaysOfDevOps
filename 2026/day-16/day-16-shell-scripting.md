# Shell Scripting Basics


# Challenge Tasks

Starting 16 days task
--------------------------------------------

## Task 1:   First Script


 1.  Create a file  `hello.sh`
2.  Add the shebang line  `#!/bin/bash`  at the top
3.  Print  `Hello, DevOps!`  using  `echo`
4.  Make it executable and run it
---------

<img width="936" height="211" alt="image" src="https://github.com/user-attachments/assets/fdcf2e96-cd49-488f-915f-73db40871968" />







### NOTE: If Shebang remove then no changes happened, its take default #!/bin/bash. 


## Task 2:   Variables


1.  Create  `variables.sh`  with:
    -   A variable for your  `NAME`
    -   A variable for your  `ROLE`  (e.g., "DevOps Engineer")
    -   Print:  `Hello, I am <NAME> and I am a <ROLE>`
2.  Try using single quotes vs double quotes — what's the difference?

<img width="648" height="149" alt="image" src="https://github.com/user-attachments/assets/a104c0fb-6fb3-4e59-a99a-8e9855bbfe98" />
<img width="896" height="122" alt="image" src="https://github.com/user-attachments/assets/bd92f0e6-7cd8-4617-8865-4db96afc6ddd" />

- If you use single quote then variable will not come. Only it will show like Hello, I am $Name and I am $Role.

----

## Task 3: User Input with read
1.  Create  `greet.sh`  that:
    -   Asks the user for their name using  `read`
    -   Asks for their favourite tool
    -   Prints:  `Hello <name>, your favourite tool is <tool>`
  
    <img width="766" height="154" alt="image" src="https://github.com/user-attachments/assets/0570bec5-9bad-4a0b-9655-1d4368e86523" />

    - Here create the bash script greet.sh
    - Ask in the cli to  the user
    - got the print output


## Task 4: 

1.  Create  `check_number.sh`  that:
    
    -   Takes a number using  `read`
    -   Prints whether it is  **positive**,  **negative**, or  **zero**
2.  Create  `file_check.sh`  that:
    
    -   Asks for a filename
    -   Checks if the file  **exists**  using  `-f`
    -   Prints appropriate message
    
  <img width="955" height="472" alt="image" src="https://github.com/user-attachments/assets/6bb5ba50-d1de-4afc-9686-a4d34ec68098" />
  <img width="1056" height="290" alt="image" src="https://github.com/user-attachments/assets/deef393a-60a3-4b60-936d-93f2394f11d9" />


## Task 5:

1.  Stores a service name in a variable (e.g.,  `nginx`,  `sshd`)
2.  Asks the user: "Do you want to check the status? (y/n)"
3.  If  `y`  — runs  `systemctl status <service>`  and prints whether it's  **active**  or  **not**
4.  If  `n`  — prints "Skipped."




