#!/bin/bash

# backup.sh
# Usage: ./backup.sh <source_directory> <backup_destination>

# Display usage

if [ $# -ne 2 ]; then
        echo "Usage: $0 <source_directory> <backup_destination>"
        exit 1
fi

source_dir=$1
backup_dir=$2

# Check if source exists and is a directory

if [ ! -d "$source_dir" ]; then
        echo "source directory $source_dir does not exist"
        exit 1
fi

# generate timestamp

timestamp=$(date '+%Y-%m-%d-%H:%M:%S')

#ARCHIVE_NAME="backup-$TIMESTAMP.tar.gz"
#ARCHIVE_PATH="$DEST/$ARCHIVE_NAME"

# function to create a backup
backup(){
    # Create a compressed tar.gz archive of the source directory in the backup directory
    tar -czf "${backup_dir}/backup_${timestamp}.tar.gz" "${source_dir}" > /dev/null

    # Check if tar command succeeded
    if [ $? -eq 0 ]; then
        echo "Backup created successfully: backup_${timestamp}"
        # List all backups in the backup directory with their sizes
        du -h "$backup_dir"/*.tar.gz
    else
    echo "Backup failed"
        exit 1
    fi
}

# Call the backup function
backup

delete_oldbackup()
{                                                                                                                                                                
        echo "Deleting old backups"                                                                                                                              
        find "$backup_dir" -type f -name "backup_*.tar.gz" -mmin +15 -exec rm -f {} \;                                                                           
exit 0                                                                                                                                                           
}                                                                                                                                                                
                                                                                                                                                                 
delete_oldbackup        