#!/bin/bash

SOURCE_DIR=$1
BACKUP_DIR=$2

DATE=$(date +%Y-%m-%d)

BACKUP_FILE="backup-$DATE.tar.gz"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source folder not found"
    exit 1
fi

tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"

echo "Backup completed"

echo "Backup file name: $BACKUP_FILE"

du -h "$BACKUP_DIR/$BACKUP_FILE"
