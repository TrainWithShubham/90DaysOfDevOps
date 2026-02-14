#!/bin/bash    # Tells the system to run this script using Bash.

set -euo pipefail  # Enables strict error handling --> This makes the script safer and more predictable.

: <<'EOF'
print_header() Function
$1 = first argument passed to the function
local = variable exists only inside this function

EOF

print_header() {
	local title="$1"
	echo
	echo "===================================="
	              echo "$title"
        echo "===================================="
}

host_and_os() {
	print_header "Hostname and OS"
	echo "Hostname: $(hostname)"

	if [[ -r /etc/os-release ]]; then # -r → checks if a file is readable -r → checks if a file is readable
		. /etc/os-release # OR source /etc/os-release 
: <<'SOURCE'
When you source a file:
Bash executes its contents in the current shell
Any variables defined in that file become available
NAME="Ubuntu"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
ID=ubuntu
PRETTY_NAME="Ubuntu 22.04.3 LTS"
SOURCE
		echo "OS: ${PRETTY_NAME}"
	else
		echo "OS: Unknown (no /etc/os-release)"
	fi

	echo "Kernel: $(uname -r)"
}

print_uptime() {
	print_header "Uptime"
	if uptime -p >/dev/null 2>&1; then
		uptime -p
	else
		uptime
	fi
}

disk_top5() {
	print_header "Disk usage (Top 5 diretories under /)"
	# -x stay on one filesystem, -h human readable, --max-depth=1 top level folders
	# Permission errors are expected on some systems, so we silence them.
	du -xh / --max-depth=1 2>/dev/null | sort -hr | head -n 5
}

memory_usage() {
	print_header "Memory uasge"
	free -h
}

top_cpu_processes() {
	print_header "Top 5 CPU-consuming proceees"
       	# Show header + top 5 rows
	ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
}

main() {
	host_and_os
	print_uptime
	disk_top5
	memory_usage
	top_cpu_processes
}

main "$@"





