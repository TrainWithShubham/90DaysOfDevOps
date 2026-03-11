# Day 16 - Shell Scripting Basics

--------

## Task1 : First Script in hello.sh

```bash
#!/bin/bash

echo "Hello DevOps!"
```
When i remove shebang line it will automatically predict for bash and shell.

```shell
chmod +x hello.sh 
./hello.sh
```
----------

## Task 2: Variables
created a `variables.sh` file

```bash
#!/bin/bash


read -p 'Enter your name' NAME
read -p 'Enter your role' ROLE

echo 'Hello, I am a $NAME and I am a $ROLE'
```
```shell
chmod 755 variables.sh
./variables.sh
```
---------
## Task 3: User Input with read
created a `greet.sh` file
```bash

#!/bin/bash


read -p "Enter Your Name" NAME
read -p "Enter Your Favourite Tool" TOOL

echo "Hello, $NAME your favourite tool is $TOOL"
```
```shell
chmod 755 greet.sh
./greet.sh
```
---------
## Task 4: If-Else Conditions
1. created a `check_number.sh` file.
```bash
#!/bin/bash


read -p "Enter a Number" NUM

if [ $NUM -lt 0 ]
then
        echo "$NUM number is negative"
elif [ $NUM -gt 0 ]
then
        echo "$NUM number is positive"
else
        echo "$NUM number is zero"
fi
```
```shell
chmod 755 check_number.sh
./check_number.sh
```
2. created a `file_check.sh` file.
```bash
#!/bin/bash


echo -e "Enter the file name: \c"

read file_name

if [ -f $file_name ]
then
        echo "file exist and file name is $file_name"
else
        echo "file doesn't exist $file_name"
fi
```
```shell
chmod 755 file_check.sh
./file_check.sh
```
--------
## Task 5: Combine It All
 created a `service_check.sh` file.
```bash
#!/bin/bash


read -p "Enter the service name" service_name

read -p "Do you want to check the status? (y/n)" state

if [ $state==y ]
then
        echo "service status $service_name is checking"
        systemctl is-active $service_name

        if [ $? -eq 0 ]
        then
                echo "$service_name is running...."
        else
                echo "$service_name is not running"
        fi
else
        echo "Skipped"
fi
```
```shell
chmod 755 service_check.sh
./service_check.sh
```
-------
## 3 key points
- When you writing a variable with read give a space between variable name and string.
- When you writing a conditional statement always close condition with `fi`.
- When you printing variables's value make sure it is in double qoute don't use single qoute.


----------


