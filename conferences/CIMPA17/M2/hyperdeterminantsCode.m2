
--this writes the ibadan tensor as the sum of two rank 1 tensors (in two different ways)
S = QQ[a0,a1,b0,b1,c0,c1,d0,d1,e0,e1,f0,f1, MonomialOrder => Lex];
I = ideal(
    a0*b0*c0+d0*e0*f0 - 7, a0*b0*c1+d0*e0*f1 - 19,
    a0*b1*c0+d0*e1*f0 - 3, a0*b1*c1+d0*e1*f1 - 2,
    a1*b0*c0+d1*e0*f0 - 11, a1*b0*c1+d1*e0*f1 - 11,
    a1*b1*c0+d1*e1*f0 - 5, a1*b1*c1+d1*e1*f1 - 3,
    a0+a1-1, b0+b1-1, d0+d1-1, e0+e1-1);
dim(I)
degree(I)
toString gens gb I
loadPackage("NumericalAlgebraicGeometry")
solveSystem(flatten entries gens gb I)







--Question 4/5
T = QQ[a00,a01,a02,a10,a11,a12,a20,a21,a22,b00,b01,b02,b10,b11,b12,b20,b21,b22,t];

A = matrix {
{a00,a01,a02},
{a10,a11,a12},
{a20,a21,a22}};

B = matrix {
{b00,b01,b02},
{b10,b11,b12},
{b20,b21,b22}};

f = det(t*A+B);
I = ideal(f,diff(t,f));
I = I : ideal(det(A))
hyperdet233 = first first entries gens eliminate({t},I);
--this next line might take a while...
toString hyperdet233
# terms  hyperdet233
