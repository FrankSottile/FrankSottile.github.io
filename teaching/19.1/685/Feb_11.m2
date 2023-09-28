--Feb_11.m2
--
-- This is a Macaulay2 script to do some of the exercises
--   from Cox, Little, and O'Shea, before we fully
--     understand the theory of Groebner bases.
---------------------------------------------------------------------------------
--
-- We always need to define the ring we are working in.  This ring will suffice for all examples  
--  
R = QQ[t,u, x,y,z]
-- Let's first do an example from Section I.3
--
--  We encode the parametrization of the tangents to the rational
--    normal curve in an ideal
--
TRNC = ideal( x-(t+u), y-(t^2+2*t*u), z-(t^3+3*t^2*u) )

--  Macaulay2 will eliminate variables from an ideal.  In this case,
--    we get the equation for the tangent variety to the rational normal
--    curve, as expressed in Section I.3
eliminate( TRNC, {t,u} )

----------------------------------------------------------------------------------
-- Let us do another one, Exercise 11 in Section I.3
--
Param = ideal ( x-(t*(u^2-t^2)), y-(u), z-(u^2-t^2) )
eliminate(Param,{t,u})

----------------------------------------------------------------------------------
--
--  We can keep the same ring for this next one, Problem 3(c) on page 35
--
I = ideal ( 2*x^2+3*y^2-11, x^2-y^2-3 )
--
--  Let us compute a different generating set, a Groebner or standard basis for 
gens gb I
-- Note that this basis for I is the second pair of polynomials

---------------------------------------------------------------------------------
--
-- Problem 17 Section I.5
--
-- the radical of an ideal J is I(V(J))
--
I = ideal gens  gb ideal(x^5-2*x^4+2*x^2-x, x^5-x^4-2*x^3+2*x^2+x-1)  ;
--
--  Factorizing the polynomial generator
--

factor I_0
radical(I)
---------------------------------------------------------------------------------
--
-- Problem 1(c) Section II.1
--
I =ideal gens gb ( ideal(x^3-6*x^2+12*x-8, 2*x^3-10*x^2+16*x-8 ) );
I_0
f=x^2-4*x+4
-- If the answer is 0, then x^2-4*x+4 lies in the ideal
f%I
J =ideal gens gb ( ideal(x^4-6*x^2+12*x-8, 2*x^3-10*x^2+16*x-8 ) );
-- If the answer is 0, then x^2-4*x+4 lies in the ideal
J_0



---------------------------------------------------------------------------------
--
-- Some plane curves
--
-- A crazy plane curve, illustrating Problem 5 in Section II.1"
I = ideal( x - (t^3-6*t^2+12*t-8), y - (t^5-2*t^4+2*t^2-t) );
E=eliminate(I,t);
E_0

