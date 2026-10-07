#!/bin/bash
set -euo pipefail

# 1. Test undefined variable (Trigger for -u)
echo "My name is $UNDEFINED_VAR"

# 2. Test failing command (Trigger for -e)
cat /non_existent_file.txt
echo "This line should never print if set -e works!"

# 3. Test pipe failure (Trigger for -o pipefail)
ls /fake_directory | grep "something"
echo "This line should also never print!"