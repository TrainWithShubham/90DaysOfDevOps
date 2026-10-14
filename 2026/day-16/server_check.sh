#!/bin/bash

SERVICE="ssh"

read -r -p "Do you want to check the status ssh Y/N ?: " ANSWER


if [[ $ANSWER == "y" ]]
then
        systemctl status $SERVICE

        if systemctl is-active --quiet $SERVICE
        then
                echo "$SERVICE is active"

        else
                echo "$SERVICE is not active"

        fi

else
        echo "Skipped."

fi

  


