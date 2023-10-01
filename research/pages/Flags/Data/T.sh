This will give the list of files names *.data

ls *data | cut --delimiter=. --fields=-2


ls -t $OUT.*
This can be used to compare if $OUT.data is newer or older than $OUT.html



date -r filename +%s
This prints out the time since 1970 in seconds that filename was last modified


This will print out directory  names  beginning with F, but cutting the F


ls -A -F | cut --delimiter=/ --fields=1 -s | cut --delimiter=F --fields=2 -s
