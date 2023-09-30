ls *.JPG | cut --delimiter=.  --fields=-1  |
while read u
do
 echo $u
 convert $u.JPG -resize 18% $u.sm.jpg
done
