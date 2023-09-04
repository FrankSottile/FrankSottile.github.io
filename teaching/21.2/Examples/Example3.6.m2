restart
R=QQ[x,y,z]
I = ideal( x^3-y*z, y^3-x*z, z^3-x*y )
dim I
degree I
primaryDecomposition I
L = minimalPrimes I
L_0
primaryDecomposition saturate(I,L_0)
J = I : saturate(I,L_0)
primaryDecomposition J
minimalPrimes J
