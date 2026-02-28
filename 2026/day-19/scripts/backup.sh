#!/bin/bash

set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

SOURCE="$1"
DEST="$2"

if [[ ! -d "$SOURCE" ]]; then
    echo "Error: Source directory '$SOURCE' does not exist."
    exit 1
fi

if [[ ! -d "$DEST" ]]; then
    echo "Destination directory does not exist. Creating it..."
    mkdir -p "$DEST"
fi

TIMESTAMP=$(date +"%Y-%m-%d")
ARCHIVE_NAME="backup-${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${DEST}/${ARCHIVE_NAME}"
tar -czf "$ARCHIVE_PATH" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"

if [[ ! -f "$ARCHIVE_PATH" ]]; then
    echo "Error: Backup archive was not created."
    exit 1
fi

ARCHIVE_SIZE=$(du -h "$ARCHIVE_PATH" | cut -f1)

echo "Backup successful."
echo "Archive: $ARCHIVE_NAME"
echo "Size: $ARCHIVE_SIZE"
DELETED_COUNT=0

while IFS= read -r -d '' file; do
    rm -f "$file"
    ((DELETED_COUNT++))
done < <(find "$DEST" -type f -name "backup-*.tar.gz" -mtime +14 -print0)

echo "Old backups deleted: $DELETED_COUNT"

exit 0
