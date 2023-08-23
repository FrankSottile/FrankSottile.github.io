ls -A -F | cut --delimiter=/ --fields=1 -s | cut --delimiter=F --fields=2 -s |
while read u
do
 cd F$u
 ls *.data |  cut --delimiter=. --fields=-2 > temp
  cat temp |
 while read v
 do
  maple -q -c "NAME:=\"$v\":" ../Done/CheckSums.maple
 done
 rm -f temp

 cd ../
done

