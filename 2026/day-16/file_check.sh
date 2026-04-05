#!/bin/bash
# Day 16 - Task 4b: If-Else Conditions — File Check
# This script asks for a filename and checks whether it exists

read -p "Enter a filename to check: " FILENAME

if [ -f "$FILENAME" ]; then
    echo "✅ File '$FILENAME' exists!"
    echo "   Size: $(du -h "$FILENAME" | cut -f1)"
    echo "   Last modified: $(stat -c '%y' "$FILENAME" | cut -d'.' -f1)"
else
    echo "❌ File '$FILENAME' does NOT exist."
fi
