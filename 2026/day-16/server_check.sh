#!/bin/bash

SERVICE="nginx"

read -p "Do you want to check the status? (y/n): " choice

if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    if systemctl is-active --quiet $SERVICE; then
        echo "The service '$SERVICE' is active."
    else
        echo "The service '$SERVICE' is not active."
    fi
elif [ "$choice" = "n" ] || [ "$choice" = "N" ]; then
    echo "Skipped."
else
    echo "Invalid choice. Please enter y or n."
fi
