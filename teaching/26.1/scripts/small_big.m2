--
--   small_big.m2
--
restart
R = QQ[x,y,z]
I = ideal(x*y^3+x*z^3+x-1, y*z^3+y*x^3+y-1, z*x^3+z*y^3+z-1)
I = gb I
gens I

S = QQ[x,y,z, MonomialOrder => Lex]
J = ideal(x*y^3+x*z^3+x-1, y*z^3+y*x^3+y-1, z*x^3+z*y^3+z-1)
J = gb J
gens J
