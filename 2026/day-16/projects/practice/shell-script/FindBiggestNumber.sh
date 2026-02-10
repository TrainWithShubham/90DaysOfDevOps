#!/bin/bash

# Check number of arguments
if (( $# != 3 )); then
  echo "Usage: $0 num1 num2 num3" >&2
  exit 1
fi

# Assign arguments
n1=$1
n2=$2
n3=$3

# Compare numbers
if (( n1 > n2 && n1 > n3 )); then
  echo "$n1 is the biggest number"

elif (( n2 > n1 && n2 > n3 )); then
  echo "$n2 is the biggest number"

elif (( n3 > n1 && n3 > n2 )); then
  echo "$n3 is the biggest number"

elif (( n1 == n2 && n2 == n3 )); then
  echo "All three numbers are equal"

else
  echo "Two numbers are equal and largest"
fi

