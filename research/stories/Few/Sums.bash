echo "N_Solved:=0:" > summary
echo "T_Time:=0:" >> summary
ls data* | 
while read u
do
 maple -q -c "read(\"$u\"):" Sum.maple
 echo $u >> X
 cat summary >>X
done