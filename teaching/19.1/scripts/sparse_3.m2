{*

sparse_3_648.m2
March 12, 2019

This script is a framework for investigating the number of
solutions to sparse systems.

*}


A = matrix{{0,1,0,1,0,0,2,0},{0,0,1,2,1,2,2,1},{0,0,0,0,1,1,1,2}}
numMonoms = numgens(source A)

R = QQ[x,y,z]

for i from 1 to 10 do (
    L = {};
    for j from 1 to 3 do(
    	f = 0;
    	for k from 0 to numMonoms-1 do (
    	    f = f + random(-50,50)*x^(A_(0,k))*y^(A_(1,k))*z^(A_(2,k));
    	    );
	L = append(L,f)
    );
    I = ideal(L);
    print(gens I);
    print(dim I, degree I);
)
