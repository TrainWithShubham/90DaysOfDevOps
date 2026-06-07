#!/bin/bash

# Ask the user for their name
read -p "Enter your name: " name
read -p "enter the age:" age
# Ask the user for their favourite tool
read -p "Enter your favourite tool: " tool

# Print the greeting
echo "$age $name, your favourite tool is $tool"