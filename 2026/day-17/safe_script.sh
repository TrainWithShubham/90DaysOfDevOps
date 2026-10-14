#!/bin/bash

set -e

mkdir -p /tmp/devops-test || echo "directory is alrady created"

cd /tmp/devops-test || echo "this is not this folder "

touch devops.txt || echo  "your file fail to make "

echo " all steps sucessfully"
