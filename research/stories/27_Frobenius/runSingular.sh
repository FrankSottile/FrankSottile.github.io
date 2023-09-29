echo "int lastTime=0;" > lastTime.ascii
for n in {1..100};  do
   echo $n >> counter.txt
   nohup nice Singular < ../27lines.sing > out.txt
done
