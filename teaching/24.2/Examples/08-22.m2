restart

S = QQ[t]
R = QQ[x,y]
psi = map(S,R,matrix{{t,t^2}})
ker psi

psi = map(S,R,matrix{{t^2,t^3}})
ker psi

S = QQ[s,t]
R = QQ[w,x,y,z]
psi = map(S,R,matrix{{1,s,t,s*t}})
ker psi

S = QQ[x,y,z,w]
R = QQ[m_(1,1)..m_(2,2)]
describe R
psi = map(S,R,matrix{{x*z, x*w, y*z, y*w}})
ker psi

restart
S = QQ[x_1..x_3, y_1..y_4]
R = QQ[m_(1,1)..m_(3,4)]
psi = map(S,R,matrix{{x_1*y_1,x_1*y_2,x_1*y_3,x_1*y_4, x_2*y_1,x_2*y_2,x_2*y_3,x_2*y_4, x_3*y_1,x_3*y_2,x_3*y_3,x_3*y_4}})
ker psi
