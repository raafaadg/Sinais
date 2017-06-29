% function []=Cheab1(cheab)
clear;clc;
close all

wp=.2*pi;
ws=.3*pi;
Rp=1;
As=16;
E=sqrt(10^(Rp/10)-1);
A=10^(As/20);
for i=1:3
    cheab=i;
switch cheab
    case 1
        
        Oc=wp;
        Or=ws/wp;
        G=sqrt((A^2-1)/E^2);
        N=ceil((log10(G+sqrt(G^2-1)))/(log10(Or+sqrt(Or^2-1))));
        [Z,P,K]=cheb1ap(N,Rp);
        [num2,den2]=u_chb1ap(N,Rp,Oc)
        denn=real(poly(P));
        numn=real(poly(Z));
        den=real(poly(P*Oc))
        K=K*den(end)/denn(end);
        num=K*numn;
        w=0:pi/1000:pi;
    case 2
        Oc=ws;
        Or=ws/wp;
        G=sqrt((A^2-1)/E^2);
        N=ceil((log10(G+sqrt(G^2-1)))/(log10(Or+sqrt(Or^2-1))));
        [Z,P,K]=cheb2ap(N,As);
%         [num2,den2]=u_chb2ap(N,As,Oc);
        denn=real(poly(P));
        numn=real(poly(Z));
        den=real(poly(P*Oc));
        num=real(poly(Z*Oc));
        K=K*((den(end)/denn(end))*(numn(end)/num(end)));
        num=num*K;
        w=0:pi/1000:pi;

    case 3
        Oc=wp;
        k=wp/ws;
        k1=E/sqrt(A^2-1);
        G=sqrt((A^2-1)/E^2);
        N=ceil((ellipke(k)*ellipke (sqrt(1-k1^2)))/(ellipke(k1)*ellipke(1-k^2)));
        [Z,P,K]=ellipap(N,Rp,As);
        denn=real(poly(P));
        numn=real(poly(Z));
        den=real(poly(P*Oc));
        num=real(poly(Z*Oc));
        K=K*((den(end)/denn(end))*(numn(end)/num(end)));
        num=num*K;
        w=0:pi/1000:pi;
end
w=0:pi/1000:pi;
H=freqs(num,den,w);
Hmag=20*log10(abs(H)/max(abs(H)));
Hfase=angle(H);
subplot(3,2,2*i-1)
plot(w/pi,Hmag);
subplot(3,2,2*i)
plot(w/pi,Hfase)
end
        

% end