#!/bin/bash

# Script: system_info.sh
# Purpose: Comprehensive system information reporter using functions
# Date: 2026-02-18

set -euo pipefail

# ── Colour Codes ────────────────────────────────────────
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly MAGENTA='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'  # No Colour

# ── Helper Functions ────────────────────────────────────
print_header() {
    local TITLE=$1
    echo ""
    echo -e "${CYAN}${BOLD}========================================${NC}"
    echo -e "${CYAN}${BOLD}  $TITLE${NC}"
    echo -e "${CYAN}${BOLD}========================================${NC}"
}

print_section() {
    local SECTION=$1
    echo ""
    echo -e "${BLUE}${BOLD}── $SECTION ──${NC}"
}

# ── Function: Hostname & OS Info ────────────────────────
show_system_info() {
    print_section "System Information"
    
    echo "Hostname:     $(hostname)"
    echo "Kernel:       $(uname -r)"
    echo "OS:           $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo "Architecture: $(uname -m)"
    echo "Date & Time:  $(date '+%Y-%m-%d %H:%M:%S %Z')"
}

# ── Function: Uptime ────────────────────────────────────
show_uptime() {
    print_section "System Uptime"
    
    local UPTIME_INFO=$(uptime -p)
    local UPTIME_SINCE=$(uptime -s)
    
    echo "Uptime:       $UPTIME_INFO"
    echo "Running since: $UPTIME_SINCE"
    
    # Load average
    local LOAD=$(uptime | awk -F'load average:' '{print $2}')
    echo "Load average: $LOAD"
}

# ── Function: Disk Usage ────────────────────────────────
show_disk_usage() {
    print_section "Disk Usage (Top 5 Filesystems)"
    
    echo ""
    df -h | head -1
    df -h | tail -n +2 | sort -k5 -rn | head -5
    
    echo ""
    echo "Largest directories in /var:"
    du -sh /var/* 2>/dev/null | sort -rh | head -5
}

# ── Function: Memory Usage ──────────────────────────────
show_memory_usage() {
    print_section "Memory Usage"
    
    echo ""
    free -h
    
    echo ""
    local TOTAL=$(free -m | awk 'NR==2 {print $2}')
    local USED=$(free -m | awk 'NR==2 {print $3}')
    local AVAILABLE=$(free -m | awk 'NR==2 {print $7}')
    local PERCENT=$((USED * 100 / TOTAL))
    
    echo "Summary:"
    echo "  Total:     ${TOTAL}M"
    echo "  Used:      ${USED}M (${PERCENT}%)"
    echo "  Available: ${AVAILABLE}M"
    
    if [ "$PERCENT" -gt 80 ]; then
        echo -e "  ${RED}⚠️  Memory usage is high!${NC}"
    else
        echo -e "  ${GREEN}✅ Memory usage is healthy${NC}"
    fi
}

# ── Function: Top CPU Processes ─────────────────────────
show_top_processes() {
    print_section "Top 5 CPU-Consuming Processes"
    
    echo ""
    echo "PID    USER       CPU%  MEM%  COMMAND"
    echo "----------------------------------------"
    ps aux --sort=-%cpu | awk 'NR>1 {printf "%-6s %-10s %5s %5s  %s\n", $2, $1, $3, $4, $11}' | head -5
}

# ── Function: Network Info ──────────────────────────────
show_network_info() {
    print_section "Network Information"
    
    echo ""
    echo "Active interfaces:"
    ip -brief addr show | grep -v "lo" | head -3
    
    echo ""
    echo "Listening ports (top 5):"
    ss -tulpn 2>/dev/null | grep LISTEN | head -5 | awk '{print "  " $5, $7}' || echo "  (no data - run as root for details)"
}

# ── Function: Recent Logins ─────────────────────────────
show_recent_logins() {
    print_section "Recent Login Activity"
    
    echo ""
    echo "Last 5 logins:"
    last -5 -F | head -5
}

# ── Main Function ───────────────────────────────────────
main() {
    # Clear screen for clean output
    clear
    
    # Title
    echo -e "${MAGENTA}${BOLD}"
    cat << "EOF"
╔════════════════════════════════════════╗
║   SYSTEM INFORMATION REPORTER          ║
║   90 Days of DevOps - Day 18           ║
╚════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    
    # Call all info functions
    show_system_info
    show_uptime
    show_disk_usage
    show_memory_usage
    show_top_processes
    show_network_info
    show_recent_logins
    
    # Footer
    print_header "Report Complete"
    echo ""
    echo -e "${GREEN}Generated on: $(date)${NC}"
    echo -e "${GREEN}Hostname: $(hostname)${NC}"
    echo ""
}

# ── Execute Main ────────────────────────────────────────
main
