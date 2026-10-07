#!/bin/bash

read -p "Enter a starting number: " num
while [[ $num -ge 0 ]]; do
    echo "$num"
    num=$((num-1))

done

echo "Done!"