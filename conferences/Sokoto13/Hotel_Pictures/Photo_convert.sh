ls *.1.jpg | cut --delimiter=.  --fields=-1  |
while read u
do
 echo $u
 convert $u.1.jpg -resize 80% $u.jpg
done

