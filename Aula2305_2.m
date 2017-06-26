close all;clear all;clc;
num=[-.9*exp(j*pi/4) 1];
den=[1 -.9*exp(j*pi/4)];
w=0:2*pi/1000:2*pi;
h=freqz(num,den,w);
plot(w,abs(h))
figure
plot(w,angle(h))