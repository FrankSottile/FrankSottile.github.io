restart

R=QQ[x_(1,1)..x_(3,3)]
M=matrix{ {x_(1,1)..x_(1,3)},    {x_(2,1)..x_(2,3)},    {x_(3,1)..x_(3,3)} }
D = det M
P = minors(2,M)
I = P*P;
apply(gens R , x -> x*D % I)

minimalPrimes I
L = primaryDecomposition I
#L
minimalPrimes L_0
minimalPrimes L_1
