ls F*/data G*/data |  cut --delimiter=/ --fields=-1 |
while read u
do
  cp $u/data $u.data
done
ls G*.data | cut --delimiter=G --fields=2 |
while read u 
do
 mv G$u F$u
done


