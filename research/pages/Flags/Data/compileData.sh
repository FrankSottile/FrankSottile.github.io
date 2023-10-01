#compile.sh
#
# First we read all the files that need to be processed
#
cd Done 
  ls *.data |  cut --delimiter=. --fields=-3 > ../temp.datafiles
cd ../
#
# Now, we move the data files and make pictures of the points
#
cat temp.datafiles  |
while read v
do
 echo $v | cut --delimiter=. --fields=-1   > temp.dir
 echo $v | cut --delimiter=. --fields=2,3  > temp.file
 cat temp.dir |
 while read w
 do
  cat temp.file | 
  while read u 
  do
  echo Done/$w.$u.data
  echo $w/$u.data
   mv Done/$w.$u.data $w/$u.data
   maple -q -c "NAME:=\"$w/$u\":" makePointSelection.maple
  done
 done
done
#
#  Makes the list of files
#
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
maple -q sortFiles.maple
mv -f temp.list ListOfFiles
##############################################################
maple -q makePointers.maple
#
#  Makes the new tables
#
cat temp.datafiles  |
while read v
do
 echo $v | cut --delimiter=. --fields=-1   > temp.dir
 echo $v | cut --delimiter=. --fields=2,3  > temp.file
 cat temp.dir |
 while read w
 do
  cat temp.file | 
  while read u 
  do
  x=$(echo $u |cut --delimiter=. --fields=1)
  y=$(echo $u |cut --delimiter=. --fields=2)
  maple -q -c  "Files:=[\"$w\",\"$x\",\"$y\"]:" makeTables.maple
  done
 done
done
#
#  Updates the index files and the computer information
#
maple -q makeIndex.maple
maple -q makeComputers.maple
#rm -f temp.datafiles
##rm -f temp.file
#rm -f temp.dir
