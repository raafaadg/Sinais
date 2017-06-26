clear all
close all
clc

a=[1 1];
b1=conv(a,a);
b2=conv(a,a);
numlp=0.001836*conv(b1,b2);
denlp=conv([1 -1.4996 .8482],[1 -1.5548 .6493]);
w=0:pi/1000:pi;
H=freqz(numlp,denlp,w);
hmag=20*log10(abs(H)/max(abs(H)));
figure(1)
plot(w/pi,hmag)
axis([0 1 -100 0]);

numhp=.02426*conv(b1,b2);
denhp=conv([1 .5661 .7657],[1 1.0416 .4019]);
H2=freqz(numhp,denhp,w);
hmag2=20*log10(abs(H2)/max(abs(H2)));

figure(2)
plot(w/pi,hmag2)