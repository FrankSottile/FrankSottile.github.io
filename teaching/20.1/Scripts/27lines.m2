--27lines.m2
--
-- This script studies the lines on a cubic surface in 3-space
--
R = QQ[x,y,z];
--
--  We set the random seed so that the computations in this file are repeatable
--
setRandomSeed 101
--
--  Create a random inhomogeneous cubic polynomial 
--
F = random(3,R)+random(2,R)+random(1,R)+random(-10,10)
--
-- A line in 3-space is given by a point     p = [a b 0] 
--   in the xy-plane and a direction vector  v = [c d 1]
-- It is parametrised by p + l*v 
-- We make a ring in which parametrizations of lines may be expressed
--
S = QQ[a,b,c,d,l];
--
--  We substitute the parametrisation into the cubic polynomial F
--
CubicOnLine = map(S,R,{ a+l*c, b+l*d, l})
G = CubicOnLine F
--
-- We extract the coefficients of l; these vanish exactly when l lies on 
--  our cubic F, and then we make it into an ideal
--
(M,C) = coefficients(G, Variables => {l})
LoC = ideal C
--
-- Make the coordinate ring for lines, with variables a,b,c,d
--
T = QQ[a,b,c,d];
myMap = map(T,S);
Lines = myMap LoC;
--
--  We compute its dimension and degree
--
dim Lines
degree Lines

-- Check out the size of the polynomials in the Groebner basis
--
-- gens gb Lines
--
