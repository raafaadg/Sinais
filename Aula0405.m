%% Ex1
% close all;
% clear;clc;
% t=0:0.01:20;
% xa=exp(-t/2);
% plot(t,xa)
% hold on;
% T1=0.5;
% T2=1;
% N1=0:40;
% N2=0:20;
% xd1=exp(-N1*T1/2);
% xd2=exp(-N2*T2/2);
% stem(N1*T1,xd1,'r')
% hold on
% stem(N2*T2,xd2,'g')
% hold on
%% Ex2 
close all;
clear;clc;
t=0:0.01:20;
xa=exp(-t/5);
plot(t,xa)
hold on;
T=2;
N=0:10;
xd=exp(-N*T/5);
stem(N*T,xd,'r')
hold on;

w=-pi:2*pi/1000:pi;
xw=xd(1)*xd(2)*exp(-j*w)+xd(3)*exp(-j*2*w)+xd(4)*exp(-j*3*w)+xd(5)*exp(-j*4*w)+...
    xd(6)*exp(-j*5*w)+xd(7)*exp(-j*6*w)+xd(8)*exp(-j*7*w)+xd(9)*exp(-j*8*w)+...
    xd(10)*exp(-j*9*w)+xd(10)*exp(-j*10*w);
plot(w,xw,'y')
hold on;

xdd=xd(1:2:end)
N2=0:5;
T2=4;
stem(N2*T2,xdd,'g')
xwd=xdd(1)*xdd(2)*exp(-j*w)+xdd(3)*exp(-j*2*w)+xdd(4)*exp(-j*3*w)+...
    xdd(5)*exp(-j*4*w)+xdd(6)*exp(-j*5*w);
plot(w,xwd)
hold on