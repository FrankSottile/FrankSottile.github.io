#!/bin/bash

export PYTHONPATH=$PYTHONPATH:src/
date
python src/frank.py -k 2 -n 4 -f 'Tests_py.txt'
declare -i n=5
declare -i N=13
while [ $n -le $N ]; do
  nice python src/frank.py -k 2 -n $n -f 'A'
  cat A >> Tests_py.txt
  let n=n+1
done

let n=5
let N=11
while [ $n -le $N ]; do
  nice python src/frank.py -k 3 -n $n -f 'A'
  cat A >> Tests_py.txt
  let n=n+1
done

let n=6
let N=9
while [ $n -le $N ]; do
  nice python src/frank.py -k 4 -n $n -f 'A'
  cat A >> Tests_py.txt
  let n=n+1
done
date
