#!/bin/bash
SERVICE=nginx
read -p "Do you want to check the status? (y/n) - " STATUS
if [ "$STATUS" = "Y" ] || [ "$STATUS" = "y" ]
then 
	if sudo systemctl is-active --quiet $SERVICE && sudo systemctl is-enabled --quiet $SERVICE
	then 
		echo "$SERVICE is active and running"
	else 
		echo "$SERVICE is inactive"
	fi
elif [ "$STATUS" = "N" ] || [ "$STATUS" = "n" ]
then 
	echo "Skipped"
else
	echo "Invalid input. please enter y or n."
fi
