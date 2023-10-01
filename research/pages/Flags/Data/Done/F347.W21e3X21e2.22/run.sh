#!/bin/bash
declare -i begin=95
declare -i end=100
cp data data.last
cp data data.safe
while [ $begin -le $end ]; do
 nice -n 20 maple -q ../MapleFiles/makeSingular.maple
 nice -n 20 Singular-2-0-5 --ticks-per-sec=100 -q temp.sing
 nice -n 20 maple -c "iterate:=$begin:" -q ../MapleFiles/computeReal.maple
 if [ $(grep -c Coeff data) -eq 0 ]
 then
   mail -s "ERROR"  sottile@math.umass.edu   <data.safe
   exit
 fi

 rm -f temp*
 cp data.last data.safe
 cp data data.last

 let begin=begin+1
done

cp BadIdeal send
cat data >> send

mail -s  $(hostname) sottile@math.tamu.edu ruffo@math < send

rm -f send
