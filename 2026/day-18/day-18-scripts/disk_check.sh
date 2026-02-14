#!/bin/bash
#
check_disk () {
	DS=$(df -h / | awk 'NR==2 {print $5+0}')
	echo "This is the percentage usage of root(/) directory : "$DS"." 
}

#==============================================

check_memory () {
	DM=$(free -mt | awk 'NR==4 {print $4}')
	echo "Free Memory "$DM MB""
}

main() {
  check_disk
  echo
  check_memory
}

main

