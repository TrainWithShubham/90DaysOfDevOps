#!/bin/bash

set -euo pipefail

system_info() {
    echo "SYSTEM INFO"
    hostnamectl
}

uptime_info() {
    echo
    echo "UPTIME"
    uptime
}

disk_usage() {
    echo
    echo "DISK USAGE"
    du -h / | sort -rh | head -5
}

memory_usage() {
    echo
    echo "MEMORY USAGE"
    free -h
}

cpu_usage() {
    echo
    echo "TOP CPU PROCESSES"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
}

main() {
    system_info
    uptime_info
    disk_usage
    memory_usage
    cpu_usage
}

main
