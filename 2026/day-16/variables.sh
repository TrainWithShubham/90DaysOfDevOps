#!/bin/bash
# Day 16 - Task 2: Variables
# Demonstrates variable assignment and the difference between single and double quotes

NAME="Rameez"
ROLE="DevOps Engineer"

# Double quotes — variables are expanded (interpolated)
echo "Hello, I am $NAME and I am a $ROLE"

# Single quotes — everything is treated as a literal string (no expansion)
echo 'Hello, I am $NAME and I am a $ROLE'
