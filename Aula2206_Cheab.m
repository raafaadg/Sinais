% function []=Cheab1(cheab)
clc;
close all

Wp=.6*pi;
Ws=.4586*pi;
Rp=1;
As=15;
T=.1;
Wplp=.2*pi;
Wslp=.3*pi;
Op=(2/T)*tan(Wplp/2);
Os=(2/T)*tan(Wslp/2);
E=sqrt(10^(Rp/10)-1);
A=10^(As/20);

for i=1:1
    cheab=i;
switch cheab
    case 1  %Cheab 1
        Oc=Op;
        Or=Os/Op;
        G=sqrt((A^2-1)/E^2);
        N=ceil((log10(G+sqrt(G^2-1)))/(log10(Or+sqrt(Or^2-1))));
        [Z,P,K]=cheb1ap(N,Rp);
        denn=real(poly(P));
        numn=real(poly(Z));
        den=real(poly(P*Oc));
        num=real(poly(Z*Oc));
        K=K*den(end)/denn(end);
        num=K*numn;
        w=0:pi/1000:pi;
        [numd,dend]=bilinear(num,den,1/T);
        alfa=-(cos((Wplp+Wp)/2))/(cos((Wplp-Wp)/2));
        Nz=-[alfa 1];
        Dz=[1 alfa];
        [numpa,denpa]=mapeamento(numd,dend,Nz,Dz);
        H=freqz(numpa,denpa,w);
        Hmag=20*log10(abs(H)/max(abs(H)));
    case 2  %Cheab 2
        Oc=Os;
        Or=Os/Op;
        G=sqrt((A^2-1)/E^2);
        N=ceil((log10(G+sqrt(G^2-1)))/(log10(Or+sqrt(Or^2-1))));
        [Z,P,K]=cheb2ap(N,As);
        denn=real(poly(P));
        numn=real(poly(Z));
        den=real(poly(P*Oc));
        num=real(poly(Z*Oc));
        K=K*((den(end)/denn(end))*(numn(end)/num(end)));
        num=num*K;
        w=0:pi/1000:pi;
    case 3  %Ellip
        Oc=Op;
        k=Op/Os;
        k1=E/sqrt(A^2-1);
        G=sqrt((A^2-1)/E^2);
        N=ceil((ellipke(k)*ellipke(sqrt(1-k1^2)))/(ellipke(k1)*ellipke(1-k^2)));
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
% H=freqs(num,den,w);
% Hmag=20*log10(abs(H)/max(abs(H)));
% Hfase=angle(H);
% % subplot(3,2,2*i-1)
% plot(w/pi,Hmag);
% subplot(3,2,2*i)
% plot(w/pi,Hfase)
end

figure
plot(w/pi,Hmag)
        

% end