#!/bin/bash
read -p "Enter a number: " n

if (( n > 0 )); then
  echo "Positive"
elif (( n < 0 )); then
  echo "Negative"
else
  echo "Zero"
fi

