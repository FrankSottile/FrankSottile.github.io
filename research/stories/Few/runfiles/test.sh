#!/bin/bash
cp -f data.initial data
declare -i begin=1
declare -i end=1
while [ $begin -le $end ]; do
 nice -n 20 maple -q realSols.maple
 cp data data.last
 let begin=begin+1
done

