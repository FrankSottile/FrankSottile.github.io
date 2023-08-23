ls -A -F | cut --delimiter=/ --fields=1 -s | cut --delimiter=F --fields=2 -s |
while read u 
do
 echo $u
 ls F$u/*.data |  cut --delimiter=. --fields=-2 |  cut --delimiter=/ --fields=2 > temp
 cat temp |
 while read v
 do
  echo $v
  w=$(echo $v |cut --delimiter=. --fields=1)
  x=$(echo $v |cut --delimiter=. --fields=2)
  maple -q -c  "Files:=[\"F$u\",\"$w\",\"$x\"]:" makeTables.maple
 done
 rm -f temp
done

