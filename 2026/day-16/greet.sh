#!/bin/bash
# Day 16 - Task 3: User Input with read
# This script asks for the user's name and favourite tool, then greets them

read -p "Enter your name: " NAME
read -p "Enter your favourite tool: " TOOL

echo "Hello $NAME, your favourite tool is $TOOL"
