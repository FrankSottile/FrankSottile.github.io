restart
--Question 2
--create a ring
QQ[p_(0,0,0)..p_(1,1,1),a_0,a_1,b_0,b_1,c_0,c_1];
--make ideal of graph
I:=ideal flatten flatten flatten for i from 0 to 1 list for j from 0 to 1 list for k from 0 to 1 list  p_(i,j,k)-a_i*b_j*c_k;
--eliminate
J:= eliminate({a_0,a_1,b_0,b_1,c_0,c_1},I)
--check its prime
isPrime J

--Question 3
--here'sthe ibadan tesnor
U_(0,0,0)=11
U_(0,0,1)=11
U_(0,1,0)=5
U_(0,1,1)=3
U_(1,0,0)=10
U_(1,0,1)=21
U_(1,1,0)=16
U_(1,1,1)=14
--these are substitutions of the variables to the ibadan tesnors
replacements:=flatten flatten for i from 0 to 1 list for j from 0 to 1 list for k from 0 to 1 list p_(i,j,k)=>U_(i,j,k)
--this makes the substitution
for g in flatten entries gens J list sub(g,replacements)


--Question 4
--this loads gfan
loadPackage("gfanInterface")
myWeights:={1111,5,7,111,13,17,19,23}
--substitutes J to a ring that involves the relevant variables
J=sub(J,QQ[support(J),Weights=>myWeights])
--get initial ideal
inJ:= initialIdeal(myWeights,J)
--primary decompose it
primaryDecomposition(inJ)
--look at the gens in a g-basis
flatten entries gens gb(J)


--Question 5
--loadPackage("gfanInterface")
--get all the initial ideals and take their radicals and count them
S:=gfan(J)
#(unique S#0)
radInS=for s in S#0 list radical ideal s
#(unique radInS)





--to get nearest point on independence variety (euclidean distance) (question 6)
restart
R = QQ[a0,a1,b0,b1,c0,c1];
f = (7-a0*b0*c0)^2+(19-a0*b0*c1)^2+(3-a0*b1*c0)^2+(2-a0*b1*c1)^2+(11-a1*b0*c0)^2+(11-a1*b0*c1)^2+(5-a1*b1*c0)^2+(3-a1*b1*c1)^2;
I = ideal(diff(a0,f),diff(a1,f),diff(b0,f),diff(b1,f),diff(c0,f),diff(c1,f));
I = I + ideal(a0+a1-1,b0+b1-1);
I = I:ideal(a0*a1*b0*b1*c0*c1)
E=(eliminate({a0,a1,b0,b1,c0},I))_0
E=sub(E/leadCoefficient(E),CC[support(E)])
loadPackage("NumericalAlgebraicGeometry")
solveSystem({E})
--this tells us the last coordinates of the solutions


