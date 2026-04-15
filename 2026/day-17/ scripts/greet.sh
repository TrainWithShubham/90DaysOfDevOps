#!/bin/bash

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: ./greet.sh <name>"
else
    echo "Hello, $1!"
fi
