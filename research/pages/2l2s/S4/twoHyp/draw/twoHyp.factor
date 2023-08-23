#
#
#  This file factors the degree 4 ideals of twoHyp.out
#
#

interface(quiet=true):
Quadric := (a,b,c,d,e,f,g,h,x,y) ->
  linalg[matrix]([
   [ a , b , c , d ],
   [ b , e , f , g ],
   [ c , f , h , x ],
   [ d , g , x , y ]]):
coords:=linalg[vector]([1,X,Y,Z]):
linalg[innerprod](coords,Quadric(a,b,c,d,e,f,g,h,x,y),coords):

#############################################
#
#  The First degree 4 component

Ideal:=[4*x^2+4*x*y-y^2,h+2*x+y,f+g,e*y^2+4*g^2*x+4*g^2*y,e*x+g^2,d+g,
        c*y+2*g*x+g*y,2*c*x-2*g*x+g*y,2*c*g-e*y-2*g^2,c^2-2*g^2,b*y+g^2,
        4*b*x-e*y-4*g^2,2*b*g+c*e+e*g,2*b*c+c*e+2*e*g,4*b^2+4*b*e-e^2,a+2*b+e]:

#lprint([solve(Ideal[1]=0,y)]);
#[2*(1+2^(1/2))*x, 2*(1-2^(1/2))*x]
#
#  First component
#x:=1:
#y:=2*(1+2^(1/2))*x:
#h:=-2*(2+2^(1/2))*x:
#f:=-g:
#c:=-g*2^(1/2):
#e:=-g^2/x:
#d:=-g:
#b:=(1-2^(1/2))*g^2/2/x:
#a:=2^(1/2)*g^2/x:
#for eq in Ideal do
# lprint(simplify(eq));
#od;
#quit;

#Second factor

#Y:=2*(1-2^(1/2))*x:
#H:=-2*(2-2^(1/2))*x:
#F:=-g:
#C:=g*2^(1/2):
#E:=-g^2/x:
#Dd:=-g:
#B:=(1+2^(1/2))*g^2/2/x:
#A:=-2^(1/2)*g^2/x:
#for eq in Ideal do
# lprint(simplify(subs(f=F,d=Dd,e=E,c=C,h=H,y=Y,b=B,a=A,eq)));
#od;
#quit;

#############################################
#
#  The Second degree 4 component

Ideal:=[4*x^2+4*x*y-y^2,h+2*x+y,f+g,e*y^2+4*g^2*x+4*g^2*y,e*x+g^2,d-g,
        c*y-2*g*x-g*y,2*c*x+2*g*x-g*y,2*c*g+e*y+2*g^2,c^2-2*g^2,b*y-g^2,
        4*b*x+e*y+4*g^2,2*b*g+c*e-e*g,2*b*c-c*e+2*e*g,4*b^2-4*b*e-e^2,a-2*b+e]:

#lprint([solve(Ideal[1]=0,y)]);
#[2*(1+2^(1/2))*x, 2*(1-2^(1/2))*x]

x:=1:
y:=[solve(Ideal[1]=0,y)][1]:
h:=solve(Ideal[2]=0,h):
f:=solve(Ideal[3]=0,f):
e:=solve(Ideal[4]=0,e):
d:=solve(Ideal[6]=0,d):
c:=solve(Ideal[7]=0,c):
b:=solve(Ideal[11]=0,b):
a:=solve(Ideal[16]=0,a):

for eq in Ideal do
 lprint(simplify(eq));
od:
for ee in [a,b,c,d,e,f,g,h,x,y] do
lprint(ee);
od;


quit;
##############################################################
#  Second Factor
Y:=2*(1-2^(1/2))*x:
H:=-4*x+2*x*2^(1/2):
C:=-g*2^(1/2):
E:=-(2*b-2*2^(1/2)*b):
B:=-(-2*a-2^(1/2)*a)/4:
F:=-g:
Dd:=g:
#
#  The final consequence g^2*2^(1/2)+x*a
#
X:=solve(x*a+g^2*2^(1/2)=0,x):
#lprint(simplify(subs(b=B,x=X,a=1,E)));

for eq in Ideal do
 lprint(simplify(eq));
od:



#############################################
#
#  The Third degree 4 component

Ideal:=[4*x^2-4*x*y-y^2,h-2*x+y,f-g,e*y^2-4*g^2*x+4*g^2*y,e*x-g^2,d-g,
        c*y-2*g*x+g*y,2*c*x-2*g*x-g*y,2*c*g-e*y-2*g^2,c^2-2*g^2,b*y-g^2,
        4*b*x-e*y-4*g^2,2*b*g-c*e-e*g,2*b*c-c*e-2*e*g,4*b^2-4*b*e-e^2,a-2*b+e]:

#lprint([solve(Ideal[1]=0,y)]);
#[2*(-1+2^(1/2))*x, 2*(-1-2^(1/2))*x]

#########################################################
#
#         First solution
#
Y:=2*(-1+2^(1/2))*x:
H:=4*x-2*x*2^(1/2):
C:=g*2^(1/2):
E:=-(2*b-2*b*2^(1/2)):
B:=-(-2*a-2^(1/2)*a)/4:
F:=g:
Dd:=g:
#
#   These have the consequence -g^2*2^(1/2)+x*a
#
#X:=solve(-g^2*2^(1/2)+x*a=0,x):
#lprint(simplify(subs(b=B,x=X,a=1,E)));

for eq in Ideal do
# lprint(factor(primpart(subs(f=F,d=Dd,e=E,c=C,h=H,y=Y,b=B,eq))));
od:

#########################################################
#
#         Second solution
#
Y:=2*(-1-2^(1/2))*x:
H:=4*x+2*x*2^(1/2):
C:=-g*2^(1/2):
E:=-(2*b+2*b*2^(1/2)):
F:=g:
Dd:=g:
B:=-(-2*a+2^(1/2)*a)/4:
#
#  These leave only x*a+g^2*2^(1/2)
#
X:=solve(x*a+g^2*2^(1/2)=0,x):
lprint(simplify(subs(b=B,x=X,a=1,C)));

for eq in Ideal do
# lprint(factor(primpart(subs(f=F,d=Dd,e=E,c=C,h=H,y=Y,b=B,eq))));
od:

quit;



#############################################
#
#  The fourth degree 4 component

Ideal:=[4*x^2-4*x*y-y^2,h-2*x+y,f-g,e*y^2-4*g^2*x+4*g^2*y,e*x-g^2,d+g,
        c*y+2*g*x-g*y,2*c*x+2*g*x+g*y,2*c*g+e*y+2*g^2,c^2-2*g^2,b*y+g^2,
        4*b*x+e*y+4*g^2,2*b*g-c*e+e*g,2*b*c+c*e-2*e*g,4*b^2+4*b*e-e^2,a+2*b+e]:

#lprint([solve(Ideal[1]=0,y)]);
#[2*(-1+2^(1/2))*x, 2*(-1-2^(1/2))*x]:


#######################################
#
#   First Solution
Y:=2*(-1+2^(1/2))*x:
H:=4*x-2*x*2^(1/2):
C:=-g*2^(1/2):
E:=-(-2*b+2*2^(1/2)*b):
F:=g:
Dd:=-g:
B:=-(2*a+2^(1/2)*a)/4:
#
#   This leaves:  x*a-g^2*2^(1/2)
#
#  If we set a:=1, then we get
X:=g^2*2^(1/2):
a:=1:
lprint([a,B,C,Dd,simplify(subs(b=B,E)),F,g,simplify(subs(x=X,H))
        ,X,simplify(subs(x=X,Y))]);
Sols41:=[1, -1/2-1/4*2^(1/2), -g*2^(1/2), -g, 1/2*2^(1/2), g, g, 
          4*g^2*2^(1/2)-4*g^2, g^2*2^(1/2), 2*(-1+2^(1/2))*g^2*2^(1/2)]:

for eq in Ideal do
# lprint(factor(primpart(subs(f=F,d=Dd,c=C,e=E,h=H,y=Y,b=B,eq))));
od:


quit;


#########################################################
#
#         Second solution
Y:=2*(-1-2^(1/2))*x:
H:=4*x+2*x*2^(1/2):
F:=g:
Dd:=-g:
C:=g*2^(1/2):
E:=2*b+2*2^(1/2)*b:
B:=-(2*a-2^(1/2)*a)/4:
#
#  And we are left with g^2*2^(1/2)+x*a.  We set a=1.
#
X:=-g^2*2^(1/2):
a:=1:
lprint([a,B,C,Dd,simplify(subs(b=B,E)),F,g,simplify(subs(x=X,H))
        ,X,simplify(subs(x=X,Y))]);
Sols42:=[1, -1/2+1/4*2^(1/2), g*2^(1/2), -g, -1/2*2^(1/2), g, g, 
          -4*g^2*2^(1/2)-4*g^2, -g^2*2^(1/2), 2*(2^(1/2)+1)*g^2*2^(1/2)]:
for eq in Ideal do
 lprint(factor(primpart(subs(c=C,d=Dd,e=E,f=F,h=H,y=Y,b=B,eq))));
od:






