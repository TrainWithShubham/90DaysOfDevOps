#!/bin/bash

# Script: functions.sh
# Purpose: Demonstrate basic functions with arguments
# Date: 2026-02-18

echo "================================"
echo "     Functions Demonstration    "
echo "================================"
echo ""

# ── Function 1: Greet ───────────────────────────────────
greet() {
    local NAME=$1
    echo "Hello, $NAME!"
}

# ── Function 2: Add Two Numbers ─────────────────────────
add() {
    local NUM1=$1
    local NUM2=$2
    local SUM=$((NUM1 + NUM2))
    echo "Sum of $NUM1 + $NUM2 = $SUM"
}

# ── Main Execution ──────────────────────────────────────
echo "Test 1: Greeting function"
greet "DevOps Learner"
greet "Rahul"
greet "Priya"

echo ""
echo "Test 2: Addition function"
add 5 3
add 10 20
add 100 250

echo ""
echo "================================"
