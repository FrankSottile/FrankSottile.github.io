declare -i begin=1
declare -i end=2000
while [ $begin -le $end ]; do
 nice -n 20 maple -c "_seed:=$begin:" -q  Hessian.maple
 let begin=begin+1
done

