#!/bin/bash
# Day 16 - Task 5: Combine It All — Server Status Checker
# This script combines variables, user input, and if-else logic
# to check whether a system service is active or not

SERVICE="nginx"

echo "============================================"
echo "  🖥️  Server Service Checker"
echo "============================================"
echo ""
echo "Service selected: $SERVICE"
echo ""

read -p "Do you want to check the status of '$SERVICE'? (y/n): " CHOICE

if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "Y" ]; then
    echo ""
    echo "Checking status of '$SERVICE'..."
    echo "--------------------------------------------"

    if systemctl is-active --quiet "$SERVICE"; then
        echo "✅ Service '$SERVICE' is ACTIVE and running."
    else
        echo "❌ Service '$SERVICE' is NOT active."
    fi

    echo "--------------------------------------------"
    echo ""
    echo "Full status output:"
    systemctl status "$SERVICE" --no-pager 2>/dev/null || echo "(Could not retrieve full status)"
else
    echo ""
    echo "⏭️  Skipped."
fi
