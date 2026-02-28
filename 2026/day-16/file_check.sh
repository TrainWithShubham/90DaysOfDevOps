#!/bin/bash
read -p "Enter the filename: " FILENAME

if [ -f ./$FILENAME ]
then echo "File exists"
else
	echo "File does not exists"
fi
