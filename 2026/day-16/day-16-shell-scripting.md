## Challenge Tasks

### Task 1: Your First Script
### hello.sh i create variables inside this
#!/bin/bash

echo "Hello, Devops"

NAME="AKASH"
ROLE="DEVOPS ENGINEER"
echo "with '' "
echo 'Hello, I am $NAME and I am a $ROLE'

### output
ubuntu@ip-172-31-27-220:~$ vim hello.sh
"hello.sh" [New] 4L, 35B written
ubuntu@ip-172-31-27-220:~$ chmod +x hello.sh
ubuntu@ip-172-31-27-220:~$ ./hello.sh
Hello, Devops
ubuntu@ip-172-31-27-220:~$


**Document:** What happens if you remove the shebang line?
it still runs because this has .sh as when we execute the file it throws format error bash detect this error ENOEXEC and runs the file itself

### Task 2: Variables

### hello.sh i create variables inside this
#!/bin/bash

echo "Hello, Devops"

NAME="AKASH"
ROLE="DEVOPS ENGINEER"
echo "with '' "
echo 'Hello, I am $NAME and I am a $ROLE'

### output
## with double quotes
ubuntu@ip-172-31-27-220:~$ ./hello.sh
Hello, Devops
Hello, I am AKASH and I am a DEVOPS ENGINEER


 ## with singe quote
ubuntu@ip-172-31-27-220:~$ ./hello.sh
Hello, Devops
with ''
Hello, I am $NAME and I am a $ROLE
ubuntu@ip-172-31-27-220:~$

The difference in both quotes is in single it read as line and  $ variable and do not print its value 

### Task 3: User Input with read
### greet.sh
#!/bin/bash
read -p "Enter your name :" Name
read -p "what is your favourote tool:" tool
echo "Hello $Name , your favourite tool is $tool"

### output
ubuntu@ip-172-31-27-220:~$ vim greet.sh
ubuntu@ip-172-31-27-220:~$ ./greet.sh
Enter your name :akash
what is your favourote tool:docker
Hello akash , your favourite tool is docker
ubuntu@ip-172-31-27-220:~$

### Task 4: If-Else Conditions

1. Create `check_number.sh` that:
### check_numeber.sh

#!/bin/bash
read -p "Enter a number: " Num

if [ "$Num" -gt 0 ]; then
    echo "Positive"
elif [ "$Num" -lt 0 ]; then
    echo "Negative"
else
    echo "Zero"
fi

### output
ubuntu@ip-172-31-27-220:~$ vim check_number.sh
ubuntu@ip-172-31-27-220:~$  10L, 162B written
ubuntu@ip-172-31-27-220:~$ ./check_number.sh
Enter a number: 23
Positive
ubuntu@ip-172-31-27-220:~$ ./check_number.sh
Enter a number: 0
Zero
ubuntu@ip-172-31-27-220:~$ ./check_number.sh
Enter a number: -9
Negative
ubuntu@ip-172-31-27-220:~$

2. Create `file_check.sh` that:
### file_check.sh
#!/bin/bash
read -p "enter filename : " file
if [ -f $file ]; then
        echo "file exists"
else
        echo "file not present"
fi

### output
ubuntu@ip-172-31-27-220:~$ ls
0         bank-heist       devops-file.txt  greet.sh       hello.sh        prac   project-config.yaml
app-logs  check_number.sh  file_check.sh    heist-project  nginx-logs.txt  prace  team-notes.txt
ubuntu@ip-172-31-27-220:~$ ./file_check.sh
enter filename : devops-file.txt
file exists
ubuntu@ip-172-31-27-220:~$ ./file_check.sh
enter filename : deo
file not present
ubuntu@ip-172-31-27-220:~$

### Task 5: Combine It All
### server_check.sh

Name="nginx"
read -p "Do you want to check the status? (y/n)" Ans
if [ $Ans = 'y' ]; then
        echo "systemctl status $Name"
        STATUS=$(systemctl is-active nginx)

        if [ "$STATUS" = "active" ]; then
                echo "Nginx is running"
        fi
else
        echo "Skipped"

fi

### output
ubuntu@ip-172-31-27-220:~$ ./server_check.sh
Do you want to check the status? (y/n)y
systemctl status nginx
Nginx is running
ubuntu@ip-172-31-27-220:~$
ubuntu@ip-172-31-27-220:~$ vim server_check.sh
ubuntu@ip-172-31-27-220:~$ ./server_check.sh
Do you want to check the status? (y/n)y
systemctl status nginx
Nginx is running
ubuntu@ip-172-31-27-220:~$ ./server_check.sh
Do you want to check the status? (y/n)n
Skipped
ubuntu@ip-172-31-27-220:~$


i larned about shell commands
i learned about if else conditions
i learned about checking files and server by writing scripts