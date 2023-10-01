ls *.data |  cut --delimiter=. --fields=-3 > temp
 cat temp |
while read v
do
#echo $v
  maple -q -c "NAME:=\"$v\":" CheckTitles.maple
done
rm -f temp



