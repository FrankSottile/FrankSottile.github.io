restart
printWidth = 120
R=QQ[x_1..x_5,x_(1,2),x_(1,3),x_(1,4),x_(1,5),x_(2,3),x_(2,4),x_(2,5),x_(3,4),x_(3,5),x_(4,5), MonomialOrder => Eliminate 5]
M=matrix{ {x_1    ,x_(1,2),x_(1,3),x_(1,4),x_(1,5)},
          {x_(1,2),x_2    ,x_(2,3),x_(2,4),x_(2,5)},
	  {x_(1,3),x_(2,3),x_3    ,x_(3,4),x_(3,5)},
	  {x_(1,4),x_(2,4),x_(3,4),x_4    ,x_(4,5)},
	  {x_(1,5),x_(2,5),x_(3,5),x_(4,5),x_5    }}
I = minors(3,M)
gens I
J = gb I
(flatten generators(J))_0
(flatten gens J)_1
