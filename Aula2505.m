close all;clear all;clc;
w=-pi:2*pi/1000:pi;
hr=1+2*cos(w);
af=-w;

num=[1 1 1];
den=[1 0 0];
hh=freqz(num,den,w);
figure
hr2=(1+2*cos(w)).*exp(-j*w);
plot(w,hr)
hold on
plot(w,abs(hr2),'r')
hold on
plot(w,abs(hh),'g')
grid on

figure
grid on
plot(w,af)
hold on
plot(w,angle(hr2),'r')
grid on

