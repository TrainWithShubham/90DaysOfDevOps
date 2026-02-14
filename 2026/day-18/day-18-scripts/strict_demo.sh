#!/bin/bash
set -euo pipefail

echo "1) set -u demo (undefined variable):"
# echo "$NOT_DEFINED"

echo "$NAME"

echo "Output: unbound variable: NAME"
echo " set -u → error if using undefined variable"
echo
echo
echo
echo "2) set -e demo (failing command):"
# ls /path/does/not/exist
echo
echo "false Command"
echo "Still running"
echo "set -e → stop script if any command fails"
echo
echo
echo

echo "3) pipefail demo:"
# echo "hello" | grep "ZZZ" | wc -l

echo
echo "If you see this line, the failing demos are still commented."

