#!/bin/bash
#
echo "===== Using local variable ====="

local_example() {
	local name="khalid"
	echo "Inside function (local): $name"
}

local_example

echo "Ouside function (local)"


echo
echo "===== Using global variable ====="

global_example() {
	name="Ali"   # variable as placed global variable
	echo "Inside function (global)"
}

global_example

echo "Outside function (global): $name"

