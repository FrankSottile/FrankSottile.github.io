--Assignment3

--Problem1------------------------
R = QQ[x,y,z]
f = x*y^2*z^2 + x*z -y*z
G = {x-y^2, y-z^3, z^2-1}

--Part (a)
((f % G#0) % G#1) % G#2

--Part (b)
((f % G#1) % G#2) % G#0
((f % G#2) % G#0) % G#1


--Problem2------------------------
R = QQ[x,y,z]
I = ideal(x*y^2 + 2*x*z + x^4 -y, 7*y*z + y*x^2 + y-z, 3*z*x+z*y^2 + z -5*y)
gens gb I

S = QQ[x,y,z, MonomialOrder => Lex]
I = ideal(x*y^2 + 2*x*z + x^4 -y, 7*y*z + y*x^2 + y-z, 3*z*x+z*y^2 + z -5*y)
gens gb I

T = QQ[x,y,z, Weights =>{3,1,2}]
I = ideal(x*y^2 + 2*x*z + x^4 -y, 7*y*z + y*x^2 + y-z, 3*z*x+z*y^2 + z -5*y)
gens gb I

loadPackage "gfanInterface"
gbfan = gfan(I);

sizes = for i in gbfan list length(toString(i))
minGBindex = position(sizes, i -> i == (min sizes))  

gbfan#minGBindex

--Problem4--------------------------
elementary = (variables,k) -> sum(for subset in subsets(variables,k) list product(subset));

n = 1;
variables = for i from 1 to n list concatenate("x", toString(i));
R = QQ[reverse(variables)];
S = QQ[reverse(variables), MonomialOrder => Lex];
Rvariables = reverse(flatten entries vars R);
Svariables = reverse(flatten entries vars S);
I = ideal(for k from 1 to n list elementary(Rvariables,k))
J = ideal(for k from 1 to n list elementary(Svariables,k))
gens gb I
gens gb J
-------------------------------------------------------------------
n = 2;
variables = for i from 1 to n list concatenate("x", toString(i));
R = QQ[reverse(variables)];
S = QQ[reverse(variables), MonomialOrder => Lex];
Rvariables = reverse(flatten entries vars R);
Svariables = reverse(flatten entries vars S);
I = ideal(for k from 1 to n list elementary(Rvariables,k))
J = ideal(for k from 1 to n list elementary(Svariables,k))
gens gb I
gens gb J
-------------------------------------------------------------------
n = 3;
variables = for i from 1 to n list concatenate("x", toString(i));
R = QQ[reverse(variables)];
S = QQ[reverse(variables), MonomialOrder => Lex];
Rvariables = reverse(flatten entries vars R);
Svariables = reverse(flatten entries vars S);
I = ideal(for k from 1 to n list elementary(Rvariables,k))
J = ideal(for k from 1 to n list elementary(Svariables,k))
gens gb I
gens gb J
-------------------------------------------------------------------
