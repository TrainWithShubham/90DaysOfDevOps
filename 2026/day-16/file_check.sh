#!/bin/bash

read -p "Enter the file name you hav eot check: " file_name

if [[ -f $file_name ]]; then
    echo "File $file_name exists"
else
    echo "File $file_name doesn't exists"

fi 

