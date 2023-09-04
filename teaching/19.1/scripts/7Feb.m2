R = QQ[x,y]
f = 2+5*x^2*y+7*x*y^2
g = 11*x+13*x^4+17*x^2*y^2
GB = gb(ideal(f,g))
gens GB


--
--  Frank tried to run Buchberger's algorithm by hand on 
--   this.   Can you complete it?
--

-- Compute the S polynomial of f and g, and then reduce it
leadTerm(f),leadTerm(g)
h = 13*x^2*f - 5*y*g
leadTerm(h)
h = 5*h - 91*x*y*f
leadTerm(h)
h = 5*h + 1062*y^2*f
leadTerm(f),leadTerm(g),leadTerm(h)
--
-- Now we have a new monomial.  Compute the S poly of f and h, and reduce
--
k = 5*x*h - 7434*y^3*f
leadTerm(k),leadTerm(h)
k = (k + 7*y*h)/125
--
--  Here is a new monomial
--
leadTerm(f),leadTerm(g),leadTerm(h),leadTerm(k)
--
--  But maybe we can use it to reduce g
--
g = 2*g- x*k
leadTerm(g)
g-11*x*f
--
--  Remove g and next try the S polynomial of h and k
--
leadTerm(f),leadTerm(h),leadTerm(k)
--
--   Run the rest of Buchberger's algorithm 'by hand'
--
