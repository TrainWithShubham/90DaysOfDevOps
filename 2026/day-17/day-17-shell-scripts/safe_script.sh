#!/bin/bash
#
: <<'EOF'
command1 || command2
If command1 succeeds → command2 does NOT run.
If command1 fails → command2 runs.
EOF

set -e

mkdir /tmp/devops-test || echo "Directory already exists."

cd /tmp/devops-test || { echo "Failed to enter directory" >&2; exit 1; }

touch demo.txt || { echo "Failed to create file" >&2; exit 1; }

echo "Created /tmp/devops-test/demo.txt"



