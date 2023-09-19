restart
------PROBLEM 4------
--Be sure to use rational numbers to compute your Groebner basis. 
--Floating point arithmetic can cause problems!
R = QQ[x,y,MonomialOrder=>Lex]

F = {1574*y^2-625*y*x-1234*y+334*x^4-4317*x^3+19471*x^2 -34708*x+19764+45*x^2*y-244*y^3,
45*x^2*y-305*y*x-2034*y-244*y^3-95*x^2+655*x+264+1414*y^2,
-33*x^2*y+197*y*x+2274*y+38*x^4-497*x^3+2361*x^2-4754*x +1956+244*y^3-1414*y^2};

I = ideal F
G = gens gb I

--Notice that the first equation can be considered a univariate polynomial in y.
--There are many ways to solve univariate polynomials and polynomial systems.
------Example: The "roots" command for univariate polynomials. 

f = G_(0,0)
yValues = roots sub(f,QQ[y])
use R

--Now substitute these values into the equations of our Groebner basis!
--If y=1/2, x must satisfy the equations given below.

H = sub(G,y=>1/2)
J = gens gb ideal H
xValues = roots sub(J_(0,0),QQ[x])
use R

--So (1,1/2) is a solution and the ONLY solution when y=1/2.
--if y=1, x must satisfy the equations given below.

H = sub(G,y=>1)
J = gens gb ideal H
xValues	= roots	sub(J_(0,0),QQ[x])
use R

--So (3,1) and (4,1) are solutions and the ONLY solutions when y=1.
--if y=2, x must satisfy the equations given below.

H = sub(G,y=>2)
J = gens gb ideal H
xValues	= roots	sub(J_(0,0),QQ[x])
use R

--So (4,2) and (5,2) are solutions and the ONLY solutions when y=2.
--if y=3, x must satisfy the equations given below.

H = sub(G,y=>3)
J = gens gb ideal H
xValues	= roots	sub(J_(0,0),QQ[x])
use R

--So (3/2,3) and (5,3) are solutions and the ONLY solutions when y=3.

--In total, we found 7 solutions,
--(1,1/2), (3,1), (4,1), (4,2), (5,2), (3/2,3), and (5,3).



restart
------PROBLEM 5------

R = QQ[x,y,z]
I = ideal {x+y+z-3,x^2+y^2+z^2-5,x^3+y^3+z^3-7}

(x^4+y^4+z^4)%I

--Notice this means x^4+y^4+z^4-9 is an element of I.
--If we evaluate this at x=a, y=b, z=c, we get a^4+b^4+c^4-9=0.
--So a^4+b^4+c^4=9.

(x^5+y^5+z^5)%I

--as above, this implies that a^5+b^5+c^5=29/3. 
--29/3 is not 11, so the pattern does not continue.

--Try plugging in different values of n.

n=9
(x^n+y^n+z^n)%I



restart
------PROBLEM 5 (CHALLENGE)------
--If we consider the sequence x_1=a+b+c=3, x_2=a^2+b^2+c^2=5, ..
--we would like a recursive formula for the rest of the x_i.
--
--If a, b, and c satisfy some univariate polynomial f(x),
--then there is a linear recurrence among the x_i.
--
--For example, if a, b, and c satisfy f(x)=x^2+3x-4,
--then we there is a linear recurrence x_(n+2)+3x_(n+1)-4x_n=0.
--(Check this!)
--
--So we look for a polynomial that a, b, and c satisfy.

R = QQ[x,y,z]
I = ideal {x+y+z-3,x^2+y^2+z^2-5,x^3+y^3+z^3-7}

(x*y+x*z+y*z)%I
(x*y*z)%I

--This implies ab+ac+bc=2 and abc=-2/3.
--Therefore, a, b, and c satisfy the univariate polynomial
--
--(x-a)(x-b)(x-c) = x^3 - (a+b+c)x^2 + (ab+ac+bc)x - abc 
--                = x^3 - 3x^2 + 2x + 2/3.
--
--In particular, this implies that the x_i satisfy the difference equation
--
--x_(n+3) - 3x_(n+2) + 2x_(n+1) + 2/3x_n = 0,
--
--with initial conditions x_1=3, x_2=5, x_3=7.

--we can test this!

L = (3,5,7)
L = append(L,( (p,q,r)=take(L,-3); 3*r-2*q-2/3*p ) )



restart
------PROBLEM 6------

R = QQ[x,y,z]
f = x^2+y^2+z^2-4
g = 4*x^2-4*y^2+(2*z-3)^2-1

resultant(f,g,z)

--Since the leading coefficients of z in f and g
--are constant, pi(V(f,g)) = V(Res(f,g,z)).
--We can check this in Macaulay2 pretty easily.

I = ideal {f,g}
eliminate(I,z)
