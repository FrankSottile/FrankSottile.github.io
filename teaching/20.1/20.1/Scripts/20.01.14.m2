--20.01.14.m2
--
--  This walks you through Exercise 1 in CLO Section II.3
--
R = QQ[x,y,z]
describe R
f = x^7*y^2 + x^3*y^2 - y +1
F = x*y^2-x
G = x - y^2
-- Notice that F has leading term  x*y^2 and  G has leading term -y^2
-- x^6*F has the same leading term as f, set r = f- x^6*F
r = f - x^6*F
-- The second term, x^3*y^2, of r is divisible by the leading term of F.  We reduce it
rFG = r - x^2*F
-- Now there are no more divisions possible.
-- We have found that f = (x^6+x^2)*F + r, where r = x^7 + x^3 - y +1
--
-- Let us keep the same ring, but switch the order of F and G for the division.  
-- We reduce fwith respect to G, r = f + x^7*G 
r = f + x^7*G
-- The second term, x^3*y^2, of r is divisible by G.  r = r + x^3*G 
rGF = r + x^3*G
-- Now there are no more divisions possible.
-- We have found that f = -(x^7 + x^3)*G + r, where r = x^8 + x^4 - y + 1
-- 
-- The multivariate division algorithm behaves differenty if the order of F and G is reversed
-- Order F, G, remainder is 
rFG
-- Order G, F, remainder is
rGF
-----------------------------------------------------------------------------------
S = QQ[x,y,z, MonomialOrder => Lex]
-- This ring S differs from R only in its monomial ordering
describe S
-- 
-- I need to redefine the polynomials, so they are in this ring
f = x^7*y^2 + x^3*y^2 - y +1
F = x*y^2-x
G = x - y^2
-- Notice the different leading terms, particularly for G
-- We do long division with the order F, G
-- We have the same division as before for f and F
r = f - x^6*F
-- The leading term is divisible by G and not F
r = r - x^6*G
-- Now we may reduce w.r.t. F
r = r - x^5*F
-- ...and then G:
r = r - x^5*G
-- ...and then F:
r = r - x^4*F
-- ...and then G:
r = r - x^4*G
-- ...and then F:
r = r - x^3*F
-- ...and then G:
r = r - x^3*G
-- ...and then F:
r = r - 2*x^2*F
-- ...and then G:
r = r - 2*x^2*G
-- ...and then F:
r = r - 2*x*F
-- ...and then G:
r = r - 2*x*G
-- ...and then F:
r = r - 2*F
-- ...and then G:
rFG = r - 2*G
-- This cannot be reduced further. (It was a bit tedious)
-- We have found that
--    f = (x^6+x^5+x^4+x^3+2*x^2+2*x+2)*F + (x^6+x^5+x^4+x^3+2*x^2+2*x+2)*G + r,
-- where r = 2*y^2 = y + 1
f - ((x^6+x^5+x^4+x^3+2*x^2+2*x+2)*F + (x^6+x^5+x^4+x^3+2*x^2+2*x+2)*G + rFG )
-- Let us try reductions with the order of F and G reversed.
f
G
-- We can reduce f using G:
r = f - x^6*y^2*G
-- We can reduce f using G:
r = r - x^5*y^4*G
-- We can reduce f using G:
r = r - x^4*y^6*G
-- We can reduce f using G:
r = r - x^3*y^8*G
-- We can reduce f using G:
r = r - x^2*y^10*G
-- We can reduce f using G:
r = r - x^2*y^2*G
-- We can reduce f using G:
r = r - x*y^12*G
-- We can reduce f using G:
r = r - x*y^4*G
-- We can reduce f using G:
r = r - y^14*G
-- We can reduce f using G:
rGF = r - y^6*G
-- This cannot be reduced further. (It was again, a bit tedious)
-- We have found that
--    f = (x^6*y^2+x^5*y^4+x^4*y^6+x^3*y^8+x^2*y^10+x^2*y^2+x*y^12+x*y^4+y^14+y^6)*G + 0*F +  r,
-- where r = y^16 + y^8 - y + 1
f - ((x^6*y^2+x^5*y^4+x^4*y^6+x^3*y^8+x^2*y^10+x^2*y^2+x*y^12+x*y^4+y^14+y^6)*G + rGF)
-- Again, the multivariate division algorithm behaves differenty if the order of F and G ois reversed
-- Order F, G, remainder is
rFG
-- Order G, F, remainder is 
rGF


