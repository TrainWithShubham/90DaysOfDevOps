#!/bin/bash


LOG_DIR=$1

if [ -z $LOG_DIR ]; then

	echo "Error : missing directory argument"
	echo -e "\n"
	echo "uses: $0 /path/to/directory"
	exit 1

fi

check_dir() {
	
	if [ ! -d $LOG_DIR ]; then
		echo "Directory does not exitst."
		exit 1

	fi

}

compress_file() {

    COMPRESSED=$(find "$LOG_DIR" -type f -name "*.log" -mtime +7 | wc -l)

    find "$LOG_DIR" -type f -name "*.log" -mtime +7 -exec gzip {} \;

    echo "Compressed files: $COMPRESSED"
}

deleted_file() {

    DELETED=$(find "$LOG_DIR" -type f -name "*.gz" -mtime +30 | wc -l)

    find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -delete

    echo "Deleted files: $DELETED"
}




check_dir
compress_file
deleted_file
