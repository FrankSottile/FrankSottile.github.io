--Sottile.m2
--
-- This Macaulay2 script is from The Macaulay2 session at the 2017 CIMPA School in Ibadan
-- 12 June 2017
--
-- With special thanks to Bernd Sturmfels, Madeline Brandt, and Taylor Brysiewicz
--
----------------------------------------------------------------------------
--  To get started, let us make a ring 
QQ[x]
-- This has one variable and coefficients in the raitional numbers, Q
-- Let us make a polynomial in this ring
f = x^2 - 3*x + 2
--  and factor it
factor(f)
--  It factors (x-2)(x-1)
-- Another polynomial does not factor
factor (  x^2 - 2*x + 2 )
-- While both polynomials factor into linear factors over the real numbers,
--  only the first does so over Q, and Macaulay 2 does not change the ground field.
-------------------------------------------------------------------------------------
restart
-- This clears the variables and other names
QQ[x,y,z,w,s,t]
-- Let us make an ideal in theis six dimensional ring
I = ideal ( w - s^3 , x - s^2*t , y - s*t^2 , z - t^3 )
--
-- We eliminate the s and t variables from this ideal
J = eliminate ( {s,t} , I )
--
-- The ideal I is the ideal of a the graph of the map C^2 -> C^4 given by
--    ( s , t ) |---> ( s^3 , s^2*t , s*t^2 , t^3 )
-- eliminating variables corresponds to projection to the C^4 factor,
-- so the ideal J is the ideal of the image of the map.
-- The components of the map are homogeneous separately in (s,t) and in (x,y,z,w),
-- and I is a homogeneous ideal, so the image is a subvariety of projective 3-space.
--
codim J
-- This has codimension 2, so it is a curve.   Unlike in linear algebra, these
-- three nonlinear equations only lower the dimension by 2 and not 3.  This is
-- one source of the complication of nonlinear algebra over linear algebra.
---------------------------------------------------------------------------------
restart
-- another ring
QQ[x,y,z,w]
-- Macaulay 2 has matrices, whose arguments are a list of lists,
--  in this case two lists, each of length three.
--  The is a list of the rows of the matrix
M = matrix( { { x , y , z } , { y , z , w } } )
--
--                               2      3
--  Notice that the output is   R  <-- R
--
-- Here, R is our ring, QQ[x,y,z,w], and R^2, R^3 mean the free modules 
-- over R, and Macaulay 2 considers a matrix to be a map of free modules.
--
-- Macaulay 2 computes minors of matrices
I = minors( 2 , M )
--
--  There are three, and you have seen this ideal before.
---------------------------------------------------------------------------------
restart
--
--  Let us study a more involved example, and show how we may use indexed variables
QQ[ x_1 .. x_3 , y_1 .. y_4 , z_(1,1) .. z_(3,4) ]
--
-- Notice hox3w clever the 12 third z variables are created!
--
-- We want to study the map C^3 x C^4 --> Mat(3x4, C) that sends columns
--  vectors x \in C^3  and y in C^4  to  x y^T, a 3 x 4 matrix.
--
-- The graph of this map, in the coordinates provided is defined by 
--  x_i y_j = z_(i,j)  for i=1..3 and j=1..4
--
I = ideal flatten for i from 1 to 3 list for j from 1 to 4 list x_i*y_j - z_(i,j) 
--
-- It pays to take a minute and understand this compact statement.
--  On the right is a for loop: "for j from 1 to 4 list x_i*y_j - z_(i,j)"
--  This makes a list of length 4 with entries  x_i*y_1 - z_(i,1) , .. ,  x_i*y_4 - z_(i,4)
-- 
-- This is wrapped into another list, where i ranges from 1 to 3.  Altogether, these statements
-- create a list of length tree, whose entries are lists of length four with entries " x_i*y_j - z_(i,j)"
--
-- Above, we used such a list of lists to create a matrix, here we 'flatten' it to create a list of length 12.
--
-- Finally, this list of length 12 is turned into an ideal, I
--
-- As before, we compute the ideal of the image by eliminating the x and y variables.
--  While there is a clever way to do this, we will do it in a straightforward, but simple manner
--
J = eliminate ( {x_1,x_2,x_3,y_1,y_2,y_3,y_4} , I )
--
-- Let us compute some information about this image from the ideal
codim J
degree(J)
-- Notice that the parentheses () are not necessarily needed:  degree(I) is the same as 'degree I'
-- 
numgens J
--
-- We ask that you examine the generators of I, and try to explain what they are and why there are 18.
--
-- Let us create a matrix of format 3x4 with variable entries,  z_(i,j)
--
M = matrix for i from 1 to 3 list for j from 1 to 4 list z_(i,j)
--
-- Now make the ideal of its 2x2 minors
--
K = minors ( 2 , M )
--
--  Check that the elimination ideal is the ideal of 2x2 minors of M
K == J
--
------------------------------------------
--
--  Madeline Brandt's Macaulay 2 code from Exercise 4 from Sturmfel's first exercise sheet.
--
restart
 QQ[a_0..a_1,b_0..b_1,c_0..c_1,p_(0,0,0)..p_(1,1,1)]
 flatten flatten for i from 0 to 1 list for j from 0 to 1 list for k from 0 to 1 list a_i*b_j*c_k - p_(i,j,k)
 I = ideal(o2)
 J = eliminate({a_0,a_1,b_0,b_1,c_0,c_1},I)
 K = substitute(J,QQ[support(J)])
 loadPackage("gfanInterface")
 L = initialIdeal({3,5,11,11,2,3,19,7},K)
 primaryDecomposition L
----------------------------------------------------------------------