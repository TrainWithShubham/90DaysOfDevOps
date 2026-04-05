#!/bin/bash
# Day 16 - Task 4a: If-Else Conditions — Number Check
# This script takes a number and determines if it is positive, negative, or zero

read -p "Enter a number: " NUM

if [ "$NUM" -gt 0 ]; then
    echo "$NUM is a positive number ✅"
elif [ "$NUM" -lt 0 ]; then
    echo "$NUM is a negative number ❌"
else
    echo "The number is zero 🔵"
fi
