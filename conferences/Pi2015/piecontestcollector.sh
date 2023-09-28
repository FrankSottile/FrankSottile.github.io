#!/bin/bash

# This script collects the data for the Pie Contest.

# Asks how many pies are in the contest
echo "How many pies are in the contest?"
read nPies

# Pies will be labelled with numbers - we insert a Pie in position 0; we will use the vote 0 for not valid votes
Pies=(`seq 0 $nPies`)

# A while loop to insert the votes. Each slip has 6 votes, 3 for each one of the two contests. 
while true; do
	echo "Insert the votes of the slip, as a string of six numbers, separated by a space: -if registration is complete, insert END";
	read vote
	if [[ "$vote" == "END" ]] ; then #breaks the while loop when registration is completed
		break;
	else
		Vote=($vote)
# con1 and con2 are vectors with nPies entries and each entry is the number of points of the corresponding pie
		for jj in `seq 0 $nPies`; do
			if [[ "${Vote[0]}" == "${Pies[$jj]}" ]] ; then
				let con1[$jj]=${con1[$jj]}+3;
				echo "Pie ${Vote[0]} gets 3 points in Pi Theme. Total points ${con1[$jj]}";
			fi;
			if [[ "${Vote[1]}" == "${Pies[$jj]}" ]] ; then
				let con1[$jj]=${con1[$jj]}+2;
				echo "Pie ${Vote[1]} gets 2 points in Pi Theme. Total points ${con1[$jj]}";
			fi;
			if [[ "${Vote[2]}" == "${Pies[$jj]}" ]] ; then
				let con1[$jj]=${con1[$jj]}+1;
				echo "Pie ${Vote[2]} gets 1 point in Pi Theme. Total points ${con1[$jj]}";
			fi;
			if [[ "${Vote[3]}" == "${Pies[$jj]}" ]] ; then
				let con2[$jj]=${con2[$jj]}+3;
				echo "Pie ${Vote[3]} gets 3 points in Best Looking Pie. Total points ${con2[$jj]}";
			fi;
			if [[ "${Vote[4]}" == "${Pies[$jj]}" ]] ; then
				let con2[$jj]=${con2[$jj]}+2;
				echo "Pie ${Vote[4]} gets 2 points in Best Looking Pie. Total points ${con2[$jj]}";
			fi;
			if [[ "${Vote[5]}" == "${Pies[$jj]}" ]] ; then
				let con2[$jj]=${con2[$jj]}+1;
				echo "Pie ${Vote[5]} gets 1 point in Best Looking Pie. Total points ${con2[$jj]}";
			fi;
		done;
	fi;
done;

# set to 0 the score of the pies that did not receive any vote
for jj in `seq 0 $nPies`; do
	let con1[$jj]=${con1[$jj]}+0;
	let con2[$jj]=${con2[$jj]}+0;
	done 

# con1 and con2 are recorded in a file resultsPieContest.m
echo ' ' > resultsPieContest.m
for jj in `seq 0 $nPies`; do
	printf "${Pies[$jj]},${con1[$jj]},${con2[$jj]};" >> resultsPieContest.m ;
done
