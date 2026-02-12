#!/bin/bash
#
: <<'EOF'
${array[*]} expands all elements into a single string, while ${array[@]} expands each element as a separate argument.
For commands like apt-get install, ${array[@]} is preferred to preserve argument boundaries.
EOF

set -e   # Exit immediately if any command fails (non-zero exit status).

# Root check (required)
if (( EUID != 0 )); then
  echo "Run as root (use: sudo ./install_pkgs.sh)" >&2
  exit 1
fi

apt-get update -y >/dev/null
packages=("nginx" "curl" "wget")
missing_pkgs=()

for pkg in "${packages[@]}"; do
  if dpkg -s "$pkg" &>/dev/null; then
    echo "$pkg is already installed. Skipping."
  else
    echo "$pkg missing."
    missing_pkgs+=("$pkg")  # Adds missing package to an array.
  fi
done

# Install all missing packages in one go
if (( ${#missing_pkgs[@]} > 0 )); then
  echo "⬇️ Installing: ${missing_pkgs[*]}"   # Print as one string
  apt-get install -y "${missing_pkgs[@]}"   # Install as separate args
  echo "Installation complete."
else
  echo "All packages already installed."
fi

