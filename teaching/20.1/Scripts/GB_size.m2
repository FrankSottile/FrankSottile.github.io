-- GB_size.m2
--
--  This was run in class on 13 January
--
R = QQ[x,y,z]
I = ideal(x*y^2+x*z+x^4-y, y*z+y*x^2+y-z, 3*z*x+z*y^2+z-y)
I = gb I
gens I
S = QQ[y,x,z]
I = ideal(x*y^2+x*z+x^4-y, y*z+y*x^2+y-z, 3*z*x+z*y^2+z-y)
I = gb I
gens I
T = QQ[z,y,x]
I = ideal(x*y^2+x*z+x^4-y, y*z+y*x^2+y-z, 3*z*x+z*y^2+z-y)
I = gb I
gens I
