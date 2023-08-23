#!/bin/bash
declare -i begin=1
declare -i end=1
while [ $begin -le $end ]; do
 maple -q ../MapleFiles/makeGrass.maple
 Singular --ticks-per-sec=100 -q temp.sing
 maple -c "iterate:=$begin:" -q ../MapleFiles/computeReal.maple
 let begin=begin+1
done
