#!/bin/bash

export PYTHONPATH=$PYTHONPATH:src/
date >  Tests_G3n.txt
declare -i n=11
declare -i N=17
while [ $n -le $N ]; do
  nice python src/frank.py -k 3 -n $n -f 'B'
  cat B >> Tests_G3n.txt
  let n=n+1
done
date  >> Tests_G3n.txt
