#!/bin/bash
declare -i begin=81484
declare -i end=100000
cp data data.last
cp data data.safe
while [ $begin -le $end ]; do
 nice -n 20 maple -q ../MapleFiles/makeGrass.maple
 nice -n 20 Singular --ticks-per-sec=100 -q temp.sing
 nice -n 20 maple -c "iterate:=$begin:" -q ../MapleFiles/computeReal.maple
 if [ $begin -le 100 ]; then
   nice -n 20 maple -q ../MapleFiles/coeffHeightList.maple
 fi
 if [ $begin -eq 100 ]; then
   nice -n 20 maple -q ../MapleFiles/coeffHeight.maple
   rm -f coeffHeight
 fi
 if [ $(grep -c Coeff data) -eq 0 ]
 then
   mail -s "ERROR"  sottile@msri.org   <data.safe
   exit
 fi

 rm -f temp*
 cp data.last data.safe
 cp data data.last

 let begin=begin+1
done

cp BadIdeal send
cat data >> send

mail -s  $(hostname) sottile@msri.org ruffo@math.umass.edu  soproun@math.umass.edu < send

rm -f send
