-- Table1.m2
-- This generates Table 1, the Hilbert Function and Hilbert polynomial
--  for the splines on the cell complex of Figure 1
----------------------------------------------------------------------
--The ambient ring
S=QQ[x,y,z];
--curvilinear boundaries
F1=x;                      -- y-axis
F2=(x-z)^2+(y+z)^2-2*z^2;  -- circle centred at (1,-1) and radius 2
F3=(x)^2+(y-z)^2-z^2;      -- circle centred at (0,1) and radius 1
--the hilbertFunction and hilbertPolynomial of the curviliear spline determined by F1, F2 and F3.
-- Table 1
netList apply(toList(0..6),r->(
	A=matrix{
  {1,-1,0,F1^(r+1),0,0},
  {0,1,-1,0,F2^(r+1),0},  
  {-1,0,1,0,0,F3^(r+1)}  
    };	{concatenate("r=",toString(r)),concatenate("hilbFun : ",toString(for i from 0 to 15 list hilbertFunction(i,ker A))),concatenate("hilbPoly : ",toString(hilbertPolynomial(ker A,Projective=>false)))}
	))




