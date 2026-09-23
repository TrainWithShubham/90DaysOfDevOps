#!/bin/bash

# Ask the user for a number
echo "Enter a number to start countdown:"
read num

# Countdown using while loop
while [ $num -ge 0 ]
do
    echo $num
    num=$((num-1))
done

# Final message
echo "Done!"
