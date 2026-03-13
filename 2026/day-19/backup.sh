#!/bin/bash

# this is a script for backup with a 5 day rotation
# usage : ./backup.sh <path to your source> <path to backup folder>

function display_usage {
    echo "usage : ./backup.sh <path to your source> <path to backup folder>"
}

# check arguments
if [ $# -ne 2 ]; then
    display_usage
    exit 1
fi

source_dir=$1
backup_dir=$2
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

function create_backup {

    zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null

    if [ $? -eq 0 ]; then
        echo "Backup generated successfully for ${timestamp}"
    else
        echo "Backup failed"
        exit 1
    fi
}

function perform_rotation {

    max_backups=5

    backups=($(ls -t "${backup_dir}"/backup_*.zip 2>/dev/null))

    echo "Current backups:"
    echo "${backups[@]}"

    if [ ${#backups[@]} -gt $max_backups ]; then

        backups_to_delete=("${backups[@]:$max_backups}")

        for backup in "${backups_to_delete[@]}"
        do
            rm -f "$backup"
            echo "Deleted old backup: $backup"
        done
    fi
}

create_backup
perform_rotation