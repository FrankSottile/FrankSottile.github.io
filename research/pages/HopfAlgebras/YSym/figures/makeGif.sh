#!/bin/sh
if [ $# -eq 0 ]; then more <<EOF
$0 is a single command to massively make .gif files

  **************************************************

    Usage:  makeEps.sh TreeFile  Size

 TreeFile should have one tree per line
 **************************************************
EOF
        exit
fi
cat $1 |
while read u 
do
echo $u
  fig2dev -L gif -m $2  $u.fig $u.gif
done