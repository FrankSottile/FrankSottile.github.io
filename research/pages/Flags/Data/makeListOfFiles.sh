ls -A -F | cut --delimiter=/ --fields=1 -s | cut --delimiter=F --fields=2 -s |
while read u 
do
 echo "Data[F$u]:=[" >> temp.list
 cd F$u
 ls *.data |  cut --delimiter=. --fields=-2 > ../tmp.F
 cd ../ 
 cat tmp.F | 
 while read v 
 do 
  echo "\"$v\"," >> temp.list
 done 
 rm tmp.F
 echo "NULL]:" >> temp.list
done 
maple sortFiles.maple
mv -f temp.list ListOfFiles
