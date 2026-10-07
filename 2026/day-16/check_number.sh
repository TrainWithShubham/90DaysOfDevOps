#!/bin/bash

read -p "Enter a number: " number 

if [[ $number -gt 0 ]]; then
    echo "the number is positive"

elif [[ $number -eq 0 ]]; then 
    echo "the number is zero"

else 
    echo "the number is negative"
fi