#!/bin/bash

# Script: disk_check.sh
# Purpose: Check disk and memory usage using functions
# Date: 2026-02-18

set -euo pipefail

echo "================================"
echo "   System Resource Checker      "
echo "================================"
echo ""

# ── Function: Check Disk Usage ──────────────────────────
check_disk() {
    echo "Disk Usage:"
    echo "--------------------------------"
    df -h / | awk 'NR==1 {print "  " $0} NR==2 {print "  " $0}'
    
    # Get usage percentage
    USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    echo ""
    if [ "$USAGE" -gt 80 ]; then
        echo "  ⚠️  WARNING: Disk usage is above 80%!"
    elif [ "$USAGE" -gt 90 ]; then
        echo "  🔴 CRITICAL: Disk usage is above 90%!"
    else
        echo "  ✅ Disk usage is healthy (${USAGE}%)"
    fi
}

# ── Function: Check Memory Usage ────────────────────────
check_memory() {
    echo "Memory Usage:"
    echo "--------------------------------"
    free -h | awk '{print "  " $0}'
    
    # Get available memory percentage
    TOTAL=$(free -m | awk 'NR==2 {print $2}')
    AVAILABLE=$(free -m | awk 'NR==2 {print $7}')
    PERCENT=$((AVAILABLE * 100 / TOTAL))
    
    echo ""
    if [ "$PERCENT" -lt 10 ]; then
        echo "  🔴 CRITICAL: Less than 10% memory available!"
    elif [ "$PERCENT" -lt 20 ]; then
        echo "  ⚠️  WARNING: Less than 20% memory available!"
    else
        echo "  ✅ Memory is healthy (${PERCENT}% available)"
    fi
}

# ── Main Execution ──────────────────────────────────────
echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

check_disk
echo ""
echo "================================"
echo ""
check_memory

echo ""
echo "================================"
echo "Resource check complete!"
echo "================================"
```

