#!/bin/bash


SOURCE_DIR=$1
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR=$2


if [ -z "$SOURCE_DIR" ] || [ -z "$BACKUP_DIR" ]; then

	echo "Uses: $0 <source_directory> <backup_directory>"
 
        exit 1
fi



backup() {
 

	ARCHIVE="${BACKUP_DIR}/backup-$TIMESTAMP.tar.gz"

        tar -czf "$ARCHIVE" "$SOURCE_DIR"


        if [ $? -eq 0 ]; then
		

		echo "backup created sucessfully"

	else
		echo "backup failes"


	fi


	
}

archive_name_size() {

                                                     
	echo "Archive Name: $(basename  "$ARCHIVE")"

	echo "Archive size  $(du -sh "$ARCHIVE"| cut -f1)" 


}


delete_backup() {


	ls -t "$BACKUP_DIR"/backup-* | tail -n +6 | xargs -I {} rm -- "{}"



}


check_source() {


       if  [ ! -d $SOURCE_DIR ]; then

	 echo " Uses: directory not exist"
	 exit 1

       fi

	}

backup
archive_name_size
delete_backup
check_source


