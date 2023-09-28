loadPackage("RandomIdeals")
R=QQ[w..z]
m=ideal(x,y,z,w)
l={4,4}
tq = randomElementsFromIdeal(l,m)
j = gb tq
gens j

