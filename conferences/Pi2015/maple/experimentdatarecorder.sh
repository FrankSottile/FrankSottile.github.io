#!/bin/bash

# This script produces a string of the form [[a1,b1],[a2,b2],...,[an,bn]] containing pairs of values that are given as inputs;
# The fine inputs txt will be ready to be given as input to makeBarGraphs.maple


# Asks which experiment this data is for
echo "Input D for diameter, A for area, B for Buffon"
read letter

# Data will be recorded in a file called D-datapairs, A-datapairs or B-datapairs if the experiment is Diameter vs Circumference, Area vs Diameter or the Buffon needle.

filename="$letter-datapairs.maple"

echo $filename

# prints the first value - it is separated because no comma is needed
#echo "Input a pair of values separated by a comma or the word END to close the script"
#	read val
#	printf "[$val]" >> $filename

# while loop to print all the other values, until it breaks when one gives the string END as input
while true; do
	echo "Input a pair of values or the word END to close the script"
	read val
		if [[ "$val" == "END" ]] ; then
			break ;
		else
			sed 's/]://' $filename >> $letter-temp ;
			printf ",[$val]]:" >> $letter-temp ;
			tr -d '\n' < $letter-temp > $filename;
			tr ' ' ',' < $filename > $letter-temp
			mv $letter-temp $filename
		fi ;
	done ;
