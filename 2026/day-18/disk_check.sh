#!/bin/bash


check_disk() {

echo "====== Disk ======="

df -h  /
 

}

check_memory() {

echo "===== memory ======"

free -h

}

check_disk

check_memory



