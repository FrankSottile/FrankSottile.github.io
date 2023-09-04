



--praise #2
R = QQ[x];
f = x^4+x^3-x^2+x-2
g = x^3+x^2+x+1
resultant(f,g,x)
gens gb ideal(f,g)


--praise # 8
for tensors:
Section 4 in https://arxiv.org/pdf/1505.05729.pdf
For Bernd's # 4 on Eigenvectors (today) see Theorem 6.1.



--Another example
R = QQ[x,y,z];

I = ideal(
(x-y)^3-z^2,
(z-x)^3-y^2,
(y-z)^3-x^2);

codim I, degree I
decompose I
apply(oo, J->{codim J, degree J})




--Here is the relevant prime ideal in Praise's example:
R = QQ[x,y,z];
I = ideal( (x-y)^3-z^2, (z-x)^3-y^2, (y-z)^3-x^2);
J = saturate(I,ideal(x,y,z))
codim J, degree J
isPrime J
--to solve for the six solutions, we do the following
loadPackage("NumericalAlgebraicGeometry")
S=solveSystem(flatten entries gens J);
#S
--look, we have the wrong number of solutions, we should double check which evaluate to zero (or close to zero)
sols=for s in S list coordinates(s);


for s in sols list for j in flatten entries gens J list sub(j,{x=>s#0,y=>s#1,z=>s#2}

--do you see which are not solutions?




---On nilpotent matrices

R = QQ[x1,x2,x3,x4];
A = matrix {{x1,x2},{x3,x4}};
I = ideal(trace(A),det(A))
J = minors(1,A^2) 
I == radical J





