#!/bin/bash

# Take two numbers as input from the user
read -p "Enter first number: " num1
read -p "Enter second number: " num2

# Compare the numbers using if-else
if [ "$num1" -gt "$num2" ]; then
    echo "$num1 is greater than $num2"
elif [ "$num1" -lt "$num2" ]; then
    echo "$num1 is less than $num2"
else
    echo "$num1 is equal to $num2"
fi
