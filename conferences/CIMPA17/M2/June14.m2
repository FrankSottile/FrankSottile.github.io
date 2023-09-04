R = QQ[x,y,z]
A = x+y+z
B = x*y + x*z +y*z
C = x*y*z
I = ideal(A,B,C)
dim I
degree(I)
gens gb I
D = x^4+y^4+z^4
D % I
kernel matrix { { A , B , C , D } }
S = QQ[a,b,c,d]
g = map ( R, S , {A,B,C,D} )
g(a^2-b*c)
g(a^2+c)
kernel (g)
