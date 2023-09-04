R = QQ[a0,a1,b0,b1,c0,c1];

-- The Ibadan tensor
T = 7*a0*b0*c0+19*a0*b0*c1+3*a0*b1*c0+2*a0*b1*c1+11*a1*b0*c0+11*a1*b0*c1+5*a1*b1*c0+3*a1*b1*c1


-- Question 1:  Computing the three configurations of eigenvectors in P^1
S = QQ[x0,x1]; f = map(S,R,{x0,x1,x0,x1,x0,x1});

g1=-f(diff(a0,T))*x1 + f(diff(a1,T))*x0
g2=-f(diff(b0,T))*x1 + f(diff(b1,T))*x0
g3=-f(diff(c0,T))*x1 + f(diff(c1,T))*x0

loadPackage("NumericalAlgebraicGeometry")
--we include the equation x0+x1-1 to solve in an affine chart of projective space
S1=solveSystem({g1,x0+x1-1})
for s in S1 list for c in coordinates(s) list c/(coordinates(s))#0
--we write our solutions so that x0=1

S2=solveSystem({g2,x0+x1-1})
for s in S2 list for c in coordinates(s) list c/(coordinates(s))#0
S3=solveSystem({g3,x0+x1-1})
for s in S3 list for c in coordinates(s) list c/(coordinates(s))#0



-- Question 3:  Eigenvectors of a ternary cubic

T = QQ[x,y,z];
p = x^3+y^3+z^3;
I = minors(2, matrix {{x,y,z},{diff(x,p),diff(y,p),diff(z,p)}});
decompose I

-- Question 4:  Eigenvectors of a ternary quartic

T = QQ[x,y,z];
p = x*y*z*(x+y+z);
I = minors(2, matrix {{x,y,z},{diff(x,p),diff(y,p),diff(z,p)}});
decompose I
degree I
