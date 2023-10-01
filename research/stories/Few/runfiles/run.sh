#!/bin/bash
declare -i begin=2
declare -i end=2
cp data data.last
cp data data.safe
while [ $begin -le $end ]; do
 nice -n 20 maple -q realSols.maple
 cp data.last data.safe
 cp data data.last
 grep Time data | cat >> X.time
 grep data data | cat >> X.data
 let begin=begin+1
done

