--The code in the following script is for computing examples in the paper "Bivariate Semi-algebraic Splines."
--In the comments below all numbered Examples, Lemmas, etc. refer to the numbering in that paper.
--If the user does not have Macaulay2 installed, it can be used at the website: http://habanero.math.cornell.edu:3690/
--Copy and paste the commands below into the browser interface.

--We will use the command `generalizedSplines' from the following package:
loadPackage "AlgebraicSplines"
--The documentation for this function may be found at:
--http://www2.macaulay2.com/Macaulay2/doc/Macaulay2-1.15/share/doc/Macaulay2/AlgebraicSplines/html/_generalized__Splines.html
--The command `generalizedSplines' computes the kernel of the map in Lemma 2.1

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
------Code for computing dimensions in Table 1, over the mesh in Figure 1----------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

---Underlying polynonial ring has three variables (everything is homogenized)
S=QQ[x,y,z]

--This is a list of adjacent faces which intersect in an arc of the mesh in Figure 1
--The faces are numbered as follows:
--Top middle (purple): 0
--Top right (pink): 1
--Right middle (blue): 2
--Bottom right (yellow): 3
--Bottom middle (green): 4
--Bottom left (pink): 5
--Left middle (blue): 6
--Top left (yellow): 7
--The following list records arcs as intersections of faces corresponding
--to the labels indicated above
E={{0,1},{1,2},{2,3},{3,4},{4,5},{5,6},{6,7},{0,7},{0,4}};

--The two parabolic equations in Figure 1
f=y*z+x^2-z^2;--curve on top between two interior vertices
g=y*z-x^2+z^2;--curve on bottom between two interior vertices

--The pairs in E are labeled by the edge form defining the arc along which the
--corresponding faces intersect.  This is recorded in I below.
--The first entry corresponds to {0,1}, the second to {1,2}, etc. (reading through
--list of edges E defined above)
I={f,g,f,g,g,f,g,f,y};

--Create the module of semi-algebraic splines on the mesh in Figure 1--
r=1--global smoothness parameter
M=generalizedSplines(E,apply(I,h->h^(r+1)))
--compute the Hilbert polynomial of M
hilbertPolynomial(M,Projective=>false)

--Create Table 1:
HEADER=join({"r\\d"},apply(14,i->i),{"Polynomial"})
--Copy and paste the following lines defining 'MIDDLEROWS' as a block
MIDDLEROWS=apply(4,r->(
	M=generalizedSplines(E,apply(I,h->h^(r+1)));
	hp=hilbertPolynomial(M,Projective=>false);
	join({r},apply(14,i->hilbertFunction(i,M)),{hp})
	))
BOTTOMROW=join({""},apply(14,i->hilbertFunction(i,S)),hilbertPolynomial(S,Projective=>false))
--Execute the above three commands.  The next command will format these into Table 1.
netList(join({HEADER},MIDDLEROWS,{BOTTOMROW}))

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
------Code for computations in Examples 3.1,3.5------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
S=QQ[x,y,z];--coordinate ring for domain P^2
--the polynomials making the net in Example 3.1
f=x^2-y*z; 
g=y^2-x*z; 
h=z^2+x*y;
N={f,g,h};

R=QQ[u,v,w];--coordinate ring for codomain P^2

--The pullback map of rings phi:R->S
phi=map(S,R,N)

----------------------------------------------------------------------
---Auxilliary function for computing edge forms in nets: Copy and past this entire block of code.
---Inputs: A net N, a list L of homogeneous coordinates of points in P^2
---Output: The (in most cases unique) form of N which passes through the points
-------specified by L
----------------------------------------------------------------------
edgeForm=(N,L)->(
    S := ring(first N);
    G := gens S;
    eval := apply(L,v->(
	    apply(length N,i->(
		    sub(N_i,apply(length G,j->(G_j=>v_j)))
		    ))
	    ));
    M = (matrix eval)||(matrix{N});
    det M
    )
----------------------------------------------------------------------

--Vertices for mesh Delta in Figure 3 (symmetric coordinates)
V={{1,1,1},{1,2,1},{2,1,1},{3/11,2,1},{5/2,5/2,1},{2,3/11,1}};
--Slightly altered coordinates to yield non-symmetric Morgan-Scot mesh Delta'
V'={{1,1,1},{1,2,1},{2,1,1},{3/11,2,1},{5/2,3,1},{2,3/11,1}};

--pairs of indices of vertices connected by arcs in mesh Delta in Figure 3
E={{1,3},{0,1},{0,2},{2,5},{1,2},{0,5},{0,3},{1,4},{2,4}};

--Forms defining arcs of edges of mesh in Figure 3 (these are in the same order as
--figure 3, but differ by constant multiple)
I=apply(E,e->(edgeForm(N,V_e)))
--Forms defining arcs of edges of non-symmetric Morgan Scot mesh in Figure 3
I'=apply(E,e->(edgeForm(N,V'_e)))

--This is a list of adjacent faces which intersect in an arc of the mesh in Figure 3
--The faces are numbered as follows:
--(faces are described by their bounding arcs as labeled in Figure 3):
--Face abg: 0
--Face ak: 1
--Face bce: 2
--Face cdf: 3
--Face dl: 4
--Face ekl: 5
--Face fg: 6
--Ordering in DE matches ordering in E
DE={{0,1},{0,2},{2,3},{3,4},{2,5},{3,6},{0,6},{1,5},{4,5}};

--Compute Hilbert polynomial for C^1 splines on mesh in Example 3.5
r=1;--global smoothness parameter

--The pairs in E are labeled by the edge form defining the arc along which the
--corresponding faces intersect.  This is recorded in L and L' below.
--The first entry corresponds to {0,1}, the second to {0,2}, etc. (reading through
--list of edges DE defined above)
L=apply(I,f->f^(r+1));--edge labels for dual edges DE
L'=apply(I',f->f^(r+1));--edge labels for non-symmetric Morgan-Scot mesh
--The module of semi-algebraic splines on the mesh Delta in Figure 5.
M=generalizedSplines(DE,L);
--The module of semi-algebraic splines on the non-symmetric Morgan-Scot mesh Delta'.
M'=generalizedSplines(DE,L');
--The Hilbert polynomial below is P(d) in Example 3.5
hilbertPolynomial(M,Projective=>false)
hilbertPolynomial(M',Projective=>false)--Hilbert polynomial is the same for non-symmetric Morgan Scot

--The differences between the dimensions of C^1 splines on the meshes Delta' and Delta are visible in the
--'Dimension' row of the tables below.  These rows appear in the lower table in Table 2.  The largest degree
--in which the two rows of each table below disagree is the postulation number, underlined in the tables in
--Table 2
hilbertComparisonTable(0,10,M')
hilbertComparisonTable(0,10,M)

--Compute vertices of Morgan-scott mesh obtained as phi(Delta) as shown in Figure 4, where Delta is the mesh
--in Figure 5
VMS=apply(V,v->apply(N,c->sub(c,{x=>v_0,y=>v_1,z=>v_2})))
--Compute vertices of Morgan-scott mesh obtained as phi(Delta'), where Delta' is the non-symmetric
--Morgan-Scot mesh
VMS'=apply(V',v->apply(N,c->sub(c,{x=>v_0,y=>v_1,z=>v_2})))
--compute splines on the mesh phi(Delta)
R=QQ[u,v,w]

--The linear forms which map to the edge forms of Delta under the pullback map
IMS=apply(I,f->(
	H = (vars R)*sub(first quotientRemainder(matrix{{f}},matrix{N}),R);
	H_(0,0)
	))
--The linear forms which map to the edge forms of Delta' under the pullback map
IMS'=apply(I',f->(
	H = (vars R)*sub(first quotientRemainder(matrix{{f}},matrix{N}),R);
	H_(0,0)
	))


--The module of splines on phi(Delta), pictured in Figure 4
r=1
MS=generalizedSplines(DE,apply(IMS,f->f^(r+1)));
MS'=generalizedSplines(DE,apply(IMS',f->f^(r+1)));
--The Hilbert polynomial below is P_phi(d) in Example 3.5
hilbertPolynomial(MS,Projective=>false)
hilbertPolynomial(MS',Projective=>false)

--The differences between the dimensions of C^1 splines on the meshes Delta' and Delta are visible in the
--'Dimension' row of the tables below.  These rows appear in the upper table in Table 2.  The largest degree
--in which the two rows of each table below disagree is the postulation number, underlined in the tables in
--Table 2
hilbertComparisonTable(0,10,MS')
hilbertComparisonTable(0,10,MS)

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
------Code for computations in Example 4.12----------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
---Underlying polynonial ring has three variables (everything is homogenized)
S=QQ[x,y,z]

--This is a list of adjacent faces which intersect in an arc of the mesh in Figure 7
--The faces are numbered as follows:
--Top middle (purple): 0
--Top right (pink): 1
--Right middle (blue): 2
--Bottom right (yellow): 3
--Bottom middle (green): 4
--Bottom left (pink): 5
--Left middle (blue): 6
--Top left (yellow): 7
--The following list records arcs as intersections of faces corresponding
--to the labels indicated above
E={{0,1},{1,2},{2,3},{3,4},{4,5},{5,6},{6,7},{0,7},{0,4}};

--Arcs encoded in E are labeled according to choices in Example 4.12.
I={y*z+(-x+z)*(-x+2*z),-2*x+y+2*z,-2*x-y+2*z,-y*z+(-x+z)*(-x+2*z),-y*z+(x+z)*(x+2*z),2*x-y+2*z,2*x+y+2*z,y*z+(x+z)*(x+2*z),y};

--Create the module of semi-algebraic splines on the mesh in Figure 7--
r=1--global smoothness parameter
M=generalizedSplines(E,apply(I,h->h^(r+1)));
--compute the Hilbert polynomial of M
hilbertPolynomial(M,Projective=>false)

--Create Table 3:
HEADER=join({"r\\d"},apply(12,i->i),{"Polynomial"})
--Copy and paste the following lines defining 'MIDDLEROWS' as a block
MIDDLEROWS=apply(5,r->(
	M=generalizedSplines(E,apply(I,h->h^(r+1)));
	hp=hilbertPolynomial(M,Projective=>false);
	join({r},apply(12,i->hilbertFunction(i,M)),{hp})
	))
--Execute the above three commands.  The next command will format these into Table 4.
netList(join({HEADER},MIDDLEROWS))