#!/bin/bash
#
# Enable strict mode for safer scripting
# -e: exit on error
# -u: error on undefined variable
# -o pipefail: catch pipeline failures
set -euo pipefail

: <<'README'
Backup script with cleanup (delete backups older than N days)

Usage:
  ./backup.sh <path to your source> <path to backup folder>
README

usage() {
  echo "Usage: $0 <source_dir> <backup_dir>" >&2
  exit 1
}

# Validate required arguments (must be exactly 2)
(( $# == 2 )) || usage

# Script Arguments
source_dir="$1"   # Directory to back up
backup_dir="$2"   # Directory where backups will be stored

# Backup Settings
#timestamp="$(date '+%Y-%m-%d')"                        # Example: 2026-02-08
timestamp="$(date '+%Y-%m-%d-%H-%M-%S')"               # Example: 2026-02-08-10:45:59
backup_file="${backup_dir}/backup-${timestamp}.tar.gz" # Required format
retention_days=7                                      # Delete backups older than 7 days

# Ensure source directory exists; exit if not found
[[ -d "$source_dir" ]] || { echo "Source directory not found: $source_dir" >&2; exit 1; }

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

create_backup() {
  # Create a .tar.gz archive of the source directory
  # -C makes the archive cleaner (stores relative paths, not full absolute paths)
  tar -czf "$backup_file" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"    # List the contents of a gzip-compressed tar archive.

  # Verify the archive exists and is not empty
  if [[ ! -s "$backup_file" ]]; then
    echo "Error: Backup archive was not created successfully: $backup_file" >&2
    exit 1
  fi

  # Print archive name and size
  # Size (human readable)
  archive_size="$(du -h "$backup_file" | awk '{print $1}')"
  echo "Backup created: $(basename "$backup_file")"
  echo "Backup size:    $archive_size"
}

cleanup_old_backups() {
  # Delete backups older than retention_days
  # Also count how many were deleted
  deleted_count=$(find "$backup_dir" -type f -name "backup-*.tar.gz" -mtime +"$retention_days" -print -delete | wc -l)
  echo "Old backups deleted (> ${retention_days} days): $deleted_count"
}

main() {
  create_backup
  cleanup_old_backups
}

main

