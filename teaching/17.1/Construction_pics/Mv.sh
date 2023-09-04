ls *.JPG | cut --delimiter=.  --fields=-1  |
while read u
do
 echo $u
 mv  $u.jpg  $u_sm.jpg
done
