#!/bin/bash

# Script: strict_demo.sh
# Purpose: Demonstrate set -euo pipefail behavior
# Date: 2026-02-18

echo "================================"
echo "  Strict Mode Demonstration     "
echo "================================"
echo ""

# ── Demo 1: Without strict mode ────────────────────────
echo "Demo 1: WITHOUT strict mode"
echo "--------------------------------"
# Commenting out set commands to show behavior without them

echo "Using undefined variable:"
echo "UNDEFINED_VAR = $UNDEFINED_VAR_TEST"  # Prints empty string
echo "Script continues..."
echo ""

# ── Demo 2: With set -u ────────────────────────────────
echo "Demo 2: WITH set -u (error on undefined variables)"
echo "--------------------------------"
set -u

echo "Trying to use undefined variable with set -u:"
# This will cause error:
# echo "$ANOTHER_UNDEFINED_VAR"  # Would exit with error
echo "Using defined variable:"
DEFINED_VAR="I exist!"
echo "DEFINED_VAR = $DEFINED_VAR"
echo ""

# ── Demo 3: With set -e ────────────────────────────────
echo "Demo 3: WITH set -e (exit on error)"
echo "--------------------------------"
set -e

echo "This command will succeed:"
ls /tmp > /dev/null
echo "  ✅ ls succeeded, script continues"

echo ""
echo "This command would fail and stop script:"
echo "  ls /nonexistent-directory"
# ls /nonexistent-directory  # Would exit script immediately
echo "  (commented out to continue demo)"
echo ""

# ── Demo 4: With set -o pipefail ───────────────────────
echo "Demo 4: WITH set -o pipefail (catch pipe failures)"
echo "--------------------------------"
set -o pipefail

echo "Without pipefail, this would hide the failure:"
echo "  cat /nonexistent | sort"
echo "  (only 'sort' return code would matter)"
echo ""

echo "With pipefail, any failure in pipe causes error:"
echo "  cat /etc/hosts | grep localhost | wc -l"
cat /etc/hosts | grep localhost | wc -l
echo "  ✅ Pipeline succeeded"

echo ""
echo "================================"
echo "Strict mode demo complete!"
echo "================================"
