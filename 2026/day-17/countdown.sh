#!/bin/bash

read -p "Enter a number to count down from: " num

while [ $num -ge 0 ]; do
    echo "$num"
    num=$((num - 1))
done

echo "Done!"

read -p "Enter a number to count down from:" num1

while [ $num1 -ge 0 ]; do
    echo "$num1"
    num1=$((num1-1))
done
echo "Done1"