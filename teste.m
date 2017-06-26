clear all
close all
clc
syms x
Q1f(x)=3*cos(x)^2-2*x;
Q1d(x)=diff(Q1f);
vx=-2*pi:pi/1000:2*pi;
plot(vx,double(Q1f(vx)),vx,double(Q1d(vx)),'--')
clear vx x
keyboard
