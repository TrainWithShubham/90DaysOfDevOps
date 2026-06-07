#!/bin/bash

# Ask the user for a number
read -p "Enter a number: " number

# Check if the number is positive, negative, or zero
if [ $number -gt 0 ]; then
    echo "$number is positive"
elif [ $number -lt 0 ]; then
    echo "$number is negative"
else
    echo "$number is zero"
fi

read -p "enter a integer:" number1

if [ $number1 -gt 0 ]; then
   echo "$number1 is positive"
elif [ $number1 -lt 0 ]; then
    echo "$number1 is negative"
else 
   echo " $number1 is zero"
fi