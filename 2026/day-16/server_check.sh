#!/bin/bash

service="sshd"

read -p "Do you want to check the status? (y/n)" answer

if [[ $answer == 'y' ]]; then
    systemctl status &service
else 
    echo "skipped"

fi