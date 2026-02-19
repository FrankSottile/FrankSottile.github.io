-- Frank's sandbox for free resolutions
S = QQ[x,y,z]
Mr = res coker matrix{ { x^3+y^3+z^3 } }
betti Mr
Mr = res coker matrix{ { x, x^3+y^3+z^3 } }
Mr.dd
betti Mr

-------------------------
R = QQ[x,y,z,w]
I = ideal { x*z-y^2, x*w-y*z, y*w-z^2 }
dim I
degree I
Mr = res coker gens I
Mr.dd
betti Mr

Mr = res coker matrix { { x^2, x*y, y^2, x*z, y*z, z^2, x*w, y*w, z*w, w^2 } }
betti Mr

I = ideal { x^2 + 2*x*y - 3*z*w + 5*z^2 + x*w, y^3 + 7*x^2*z - 11*x*z^2 + y^2*w, 
                          z^4-x^2*y^2 + 13*x*y*w^2 + 17*y*z^2*w +z*w^3 } 
Mr = res coker gens I
betti Mr
dim I, degree I

