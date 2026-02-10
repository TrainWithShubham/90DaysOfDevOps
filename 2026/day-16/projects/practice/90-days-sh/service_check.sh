#!/bin/bash
read -p "Enter service name: " service_name
read -p "Do you want to check the status of $service_name? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    systemctl status "$service_name"

    if systemctl is-active --quiet "$service_name"; then
        echo "$service_name is ACTIVE"
    else
        echo "$service_name is NOT active"
    fi

elif [[ "$choice" == "n" || "$choice" == "N" ]]; then
    echo "Skipped."
else
    echo "Invalid choice. Please enter y or n." >&2
    exit 1
fi

