#!/bin/sh
if [ $# -eq 0 ]; then more <<EOF
$0 is a single command to do mass e-mailings

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
  fig2dev -L ps -m $2  $u.fig > $u.eps
done
