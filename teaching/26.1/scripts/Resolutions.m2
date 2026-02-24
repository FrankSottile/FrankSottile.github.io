--Resolutions.m2
--
-- This file shows some of Macaulay2's commends for computing free resolutions
--
----------------------------------------------------------------------------------------------
S = QQ[x,y,z]
--  Resolve a principal ideal
Mr = res coker matrix{ { x^3+y^3+z^3 } }
betti Mr
-- Do this with an indeterminate
Mr = res coker matrix{ { x, x^3+y^3+z^3 } }
Mr.dd
betti Mr
-------------------------
--  Change rings
R = QQ[x,y,z,w]
--  The rational normal curve
I = ideal { -x*z+y^2, -x*w+y*z, -y*w+z^2 }
dim I
degree I
Mr = res coker gens I
Mr.dd
betti Mr
--
--  all quadratic polynomials
--
Mr = res coker matrix { { x^2, x*y, y^2, x*z, y*z, z^2, x*w, y*w, z*w, w^2 } }
betti Mr
--
--  A complete intersection of a quadrtic, a cubic, and a quartic
--
I = ideal { x^2 + 2*x*y - 3*z*w + 5*z^2 + x*w, y^3 + 7*x^2*z - 11*x*z^2 + y^2*w, 
                          z^4-x^2*y^2 + 13*x*y*w^2 + 17*y*z^2*w +z*w^3 } 
Mr = res coker gens I
betti Mr
dim I, degree I

