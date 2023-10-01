ls *.data |  cut --delimiter=. --fields=-3 > temp
 cat temp |
while read v
do
  maple -q -c "NAME:=\"$v\":" CheckSums.maple
done
rm -f temp


