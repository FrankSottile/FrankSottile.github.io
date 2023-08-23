--pencil.m2
-- This computes the Hilbert function and Hilbert polynomial for the example of a quadratic 
-- pencil given by three quadrics
----------------------------------------------------------------------
--The ambient ring
S=QQ[x,y,z];
--curvilinear boundaries
F1=x^2-6*x*y-2*x*z+y^2+6*y*z;      
F2=x^2+6*x*y-2*x*z+y^2-6*y*z;      
F3=3*x^2-2*x*y-6*x*z+3*y^2+2*y*z;  
--the hilbertFunction and hilbertPolynomial of the curviliear spline determined by F1, F2 and F3.
-- Table 1
netList
 apply(toList(0..12),r->(
	A=matrix{
  {1,-1,0,F1^(r+1),0,0},
  {0,1,-1,0,F2^(r+1),0},  
  {-1,0,1,0,0,F3^(r+1)}  
    };	{concatenate("r=",toString(r)),concatenate("hilbFun : ",toString(for i from 0 to 40 list hilbertFunction(i,ker A))),concatenate("hilbPoly : ",toString(hilbertPolynomial(ker A,Projective=>false)))}
	))




