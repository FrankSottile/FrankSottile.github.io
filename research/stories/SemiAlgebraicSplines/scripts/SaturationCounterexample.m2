-- counterexample to containment for r=5 --
-- Currently Remark 11, but that may change --
S=QQ[x,y,z]
f=x*z+x^2+x*y+y^2;
g=y*z+x^2+x*y+2*y^2;
h=x*z+y*z+x^2+x*y+3*y^2;
r=5;
I=ideal(f^r,g^r,h^r);
--to ensure that saturate(I)==saturate(I,z), check that radical(I)=ideal(x,y)--
radical(I)==ideal(x,y)
--the following code, when executed, gives a table listing:
--1. The power r to which f,g,h are raised
--2. The degrees of the resulting schemes I and J
--3. Whether I is contained in J
--4. Whether the saturation of I is equal to J 
netList apply(toList(1..5),r->(
	I=ideal(f^r,g^r,h^r);
        J=ideal(x^r,y^r,(x+y)^r);
	{concatenate("r=",toString(r)),concatenate("Deg(I)=",toString(hilbertPolynomial(I,Projective=>false))),concatenate("Deg(J)=",toString(hilbertPolynomial(J,Projective=>false))),concatenate("I subset J? ",toString(isSubset(I,J))),concatenate("I:m^infty=J? ",toString(J==saturate(I,z)))}
	))

