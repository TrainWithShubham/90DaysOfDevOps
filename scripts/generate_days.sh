#!/usr/bin/env bash
set -euo pipefail

# Regenerate 2026 day folders if needed.
# Usage: ./scripts/generate_days.sh

python3 scripts/generate_days.py
