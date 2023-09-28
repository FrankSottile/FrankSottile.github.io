restart
printWidth = 120
R=QQ[z_1..z_3,x_(0,0,0)..x_(1,1,1), MonomialOrder => Eliminate 3]

f = 0
for i from 0 to 1 do   for j from 0 to 1 do for k from 0 to 1 do f = f+x_(i,j,k)*z_1^i*z_2^j*z_3^k
f
I = ideal ( f, diff(z_1,f), diff(z_2,f), diff(z_3,f) )
dim I
J = gb I
L = first entries gens J
L_0
L_1
