#!/bin/bash

# Script: countdown.sh
# Purpose: Countdown from user input to 0 using while loop

echo "================================"
echo "       Countdown Timer          "
echo "================================"
echo ""

# Get number from user
read -p "Enter a number to countdown from: " NUMBER

# Validate input is a number
if ! [[ "$NUMBER" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number!"
    exit 1
fi

echo ""
echo "Counting down from $NUMBER:"
echo "--------------------------------"

# Countdown using while loop
while [ $NUMBER -gt 0 ]
do
    echo "$NUMBER"
    NUMBER=$((NUMBER - 1))
    sleep 0.5    # Small delay for visual effect
done

echo "0"
echo ""
echo "Done!"
echo "================================"
```
