close all;clear all;clc;
num1=2*conv([1 -1],[1 .5]);
den=conv(1-0.8*exp(j*pi/4),1-0.8*exp(-j*pi/4));
num2=conv([1 -1],[1 2]);
w=0:2*pi/1000:2*pi;
h1=freqz(num1,den,w);
h2=freqz(num2,den,w);
plot(w,abs(h1))
hold on
%plot(w,abs(h2),'r')
figure;
plot(w,angle(h1))
hold on
plot(w,angle(h2),'r')

sys1=tf(num1,den,1);
sys2=tf(num2,den,1);
figure;
iopzplot(sys1)
hold on
iopzplot(sys2,'r')