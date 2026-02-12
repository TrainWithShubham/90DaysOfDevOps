#!/bin/bash
: <<'COMMENT'
Problems:
- -le is used inside [ ], not inside (( ))
- Logic is reversed
COMMENT

#
read -p "Enter a number to countdown from: " n

while (( n >= 0 ))      # while [ "$n" -ge 0 ]
do
	echo "$n"
	((n--))
done

echo "Done!"

