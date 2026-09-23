#!/bin/bash
<< readme
This script checks disk usage of / and free memory
Usage:
./disk_check.sh
readme

function check_disk {
    echo "=== Disk Usage (/) ==="
    df -h /
}

function check_memory {
    echo "=== Memory Usage ==="
    free -h
}

# Main section
check_disk
echo ""
check_memory