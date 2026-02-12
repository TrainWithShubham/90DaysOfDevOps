#!/bin/bash
#
fruits=("apple" "banana" "grapes" "mango" "orange")   #Created a Array(fruits) which has 5 elements seprated by a space, () define an array.

for fruit in "${fruits[@]}"     # "${fruits[@]}" → Expands to all elements of the array. [@] means "all elements".
do
	echo "$fruit"
done



