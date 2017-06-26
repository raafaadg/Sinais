clear all
clc
k=0:5;
p = .5*exp(j*(pi/6)*(2*k+4));

p1=[1 -p(1)];
p2=[1 -p(2)];
p3=[1 -p(3)];
den=real(conv(p1,conv(p2,p3)))
roots(den)

