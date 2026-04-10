#!/bin/bash

# Script: greet.sh
# Purpose: Greet user by name passed as argument
# Usage: ./greet.sh <name>

# Check if argument was provided
if [ $# -eq 0 ]; then
    echo "Usage: ./greet.sh <name>"
    exit 1
fi

# Get name from first argument
NAME=$1

# Print greeting
echo "Hello, $NAME!"
```
