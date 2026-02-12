#!/bin/bash
#
#echo "Arguments = $#"
if (( $# < 1 ))      # $# → Number of command-line arguments passed to the script
then
	echo "Usage: $0 <name>" >&2
	exit 1
fi

echo "Hello, $1!"

