#!/bin/bash
#
# Creating a function To Greet the all arguments($@)
# Creating another func of addition
#
greet () {
	if [[ $# -eq 0 ]]; then
		echo "Usage: $0 [name1] [name2] [name3]"
		return 1
	fi

	for name in "$@"; do
		echo "-------"
		echo "welcome"
		echo "-------"
		echo "Hello, $name!"
	done
}
	
#greet "$@"

# "============================================="

add () {
	local a="$1"
	local b="$2"
	if [[ $# -ne 2 ]]; then
		echo "usage: $0 [number1] [number2]"
		return 1
	else
		echo "Sum of "$a" and "$b":" $(( a+b ))
	fi
}

greet khalid
add 2 3

