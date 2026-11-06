#!/bin/bash

bold=$(tput bold)

echo "============= Welcome to account management script ===================="

#Taking input for the action
echo -e "Press -c to create account \nPress -d to delete\nPress -r to reset the password\nPress -l for List the user accouts"
read -p "Give the input : " input

#taking username input
function take_input {
        read -p "enter the username" username
}

#checking if user already exists
function check_existing_user {
        exist=$(cat /etc/passwd | grep $username | wc | awk '{print $1}')
        if [ $exist == 0 ]; then
                echo "user not exist"
        else
                echo "user exist"
        fi
}

#creating user
function create_user {
        echo "============== creating user ==============="
        sudo useradd $username
        echo "user has been created" $username
}

#deleting user

function delete_user {
        echo "============== deleting user ================"
        sudo userdel $username
        echo "User hs been deleted" $username
}

#resetting password

function reset_password {
        echo "============= Reseting Password =============="
        sudo passwd $username
        echo " Enter the New password"
        echo "Password has been resetted" $username
}

# Listing User Accounts

function list_account {
        Account=$(cat /etc/passwd | awk -F: '{ if ($3 >= 1000 && $3 < 65534) printf "User: %-15s | UID: %d\n", $1 , $3}')
        echo -e "These are the User accounts mentioned below:\n"
        echo "$Account"
}

#validating the input
if [ $input == "-c" ]; then
        echo "this is create user"
        take_input
        check_existing_user
        create_user
elif [ $input == "-d" ]; then
        echo "this is delete user"
        take_input
        check_existing_user
        delete_user
elif [ $input == "-r" ]; then
        echo "this is reset password"
        take_input
        check_existing_user
        reset_password
        elif [ $input == "-l" ]; then
        echo "This will list all the User Accounts"
        list_account
else
        echo" give the correct input"


fi


echo "================ program end ================="
             
