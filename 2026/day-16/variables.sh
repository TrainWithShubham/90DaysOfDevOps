#!/bin/bash

# Variables
NAME="Shubham"
ROLE="DevOps Engineer"

# Using double quotes — variables are expanded
echo "Double quotes: Hello, I am $NAME and I am a $ROLE"

# Using single quotes — variables are NOT expanded
echo 'Single quotes: Hello, I am $NAME and I am a $ROLE'

# Explanation of the difference
echo ""
echo "--- Difference Between Single and Double Quotes ---"
echo "Double quotes (\") allow variable expansion and command substitution"
echo "Single quotes (') treat everything literally — no variable expansion"
