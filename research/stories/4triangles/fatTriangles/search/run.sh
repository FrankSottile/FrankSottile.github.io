#!/bin/bash
declare -i begin=1
declare -i   end=500000
while [ $begin -le $end ]; do
 nice -n 20 maple -c "_seed:=$begin:" -q numberOfLines.maple
 let begin=begin+1
done

mail -s "Done" sottile@msri.org

