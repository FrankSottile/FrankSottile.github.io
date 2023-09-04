restart
printWidth = 120
R=QQ[x_(0,0)..x_(1,4),p_(0,1),p_(0,2),p_(0,3),p_(0,4),p_(1,2),p_(1,3),p_(1,4),p_(2,3),p_(2,4),p_(3,4), MonomialOrder => Eliminate 10]
M=matrix{ {x_(0,0),x_(0,1),x_(0,2),x_(0,3),x_(0,4)},
          {x_(1,0),x_(1,1),x_(1,2),x_(1,3),x_(1,4)}}
I = 0
for i from 0 to 3 do   for j from i+1 to 4 do    I = I + ideal(p_(i,j) - (x_(0,i)*x_(1,j)-x_(1,i)*x_(0,j)) )
J = gb I
L = first entries gens J
take(L,5)
L_5
