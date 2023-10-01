#!/bin/bash

export PYTHONPATH=$PYTHONPATH:src/
date  >  Tests_G2n.txt
declare -i n=13
declare -i N=22
while [ $n -le $N ]; do
  nice python src/frank.py -k 2 -n $n -f 'A'
  cat A >> Tests_G2n.txt
  let n=n+1
done
date
