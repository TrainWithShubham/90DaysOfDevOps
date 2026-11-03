#!/bin/bash


read -r -p " Enter the number ": number

if [[ $number < 0 ]]; then
	echo "Negetive"


elif [[ $number > 0 ]]; then
	echo "postive"

else
	echo "zero"
	
fi 
