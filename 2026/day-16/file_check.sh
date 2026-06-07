#!/bin/bash

read -p "Enter a filename: " filename

if [ -f "$filename" ]; then
    echo "The file '$filename' exists."
else
    echo "The file '$filename' does not exist."
fi
