#!/bin/bash


if [ "$EUID" -ne 0 ]; then
	echo "Run as root"
	exit 1
fi

packages="nginx curl wget"

for package in $packages
do

	if dpkg -s $package >/dev/null 2>&1
	then
		echo "$package is alrady installed"

        else 
		echo "Installing $package.."
		sudo apt-install -y $package

	fi

done
