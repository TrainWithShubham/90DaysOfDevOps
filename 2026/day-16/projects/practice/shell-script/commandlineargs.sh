#!/bin/bash
#
echo "Number of arguments on the command line."
echo '$#:' $#

echo "Process of the cureent process"
echo '$$:' $$

echo "Display the 3rd argument on the command line, from left to right"
echo '$3:' $3

echo "Display the name of curreent shell or program."
echo '$0:' $0

echo "Display all the arguments on the command line using * symbol."
echo '$*:' $*

echo "Display all the arguments on the command line using @ symbol."
echo '$@:' $@

