clear;clc;
close all
addpath('./Sinais para filtrar');
%% Declaracao Sinal
scope=importdata('scope.csv');
t=scope(:,1);
y=scope(:,2);
t=t-t(1);
figure
plot(t,y)
L=length(y);
Fs=10000;
op=7; %Hz
os=10;%Hz
wp=(op/1000)*2*pi;
ws=(os/1000)*2*pi;
Rp=1;
As=50;
NFFT = 2^nextpow2(L);
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
figure
plot(f,2*abs(Y(1:NFFT/2+1)))

%% Filtro FIR


wc=(wp+ws)/2;
bt=ws-wp;
M=round((6.6*pi)/bt);
alfa=(M-1)/2;
n=0:M-1;
hdn=(sin(wc*(n-alfa)))./(pi*(n-alfa));
jan=hamming(M);
h=hdn.*jan';
w=0:pi/1000:pi;
H=freqz(h,1,w);
Hmag=20*log10(abs(H)/max(abs(H)));
Hfase=angle(H);
figure
plot(w/pi,Hmag)
axis([0 1 -100 0])
[yf]=filter(h,1,y);
figure
plot(t,y,t,yf,'r')
yf1=conv(h,y);
figure
plot(t,y,t,yf1(1:2000),'g');
Hg=grpdelay(h,1,w);
figure
stem(n,hdn)
figure
stem(n,h)
figure
plot(w/pi,Hg)

%% Filtro IRR

Wp=.6*pi;
Ws=.4586*pi;
Wplp=.006*pi;
Wslp=.01*pi;

T=.1;

Op=(2/T)*tan(Wplp/2);
Os=(2/T)*tan(Wslp/2);
E=sqrt(10^(Rp/10)-1);
A=10^(As/20);

for i=1:1
    cheab=1;
switch cheab
    case 1  %Cheab 1
        Oc=Op;
        Or=Os/Op;
        G=sqrt((A^2-1)/E^2);
        M=round((log10(G+sqrt(G^2-1)))/(log10(Or+sqrt(Or^2-1))));
        [Z,P,K]=cheb1ap(M,Rp);
        denn=real(poly(P));
        numn=real(poly(Z));
        den=real(poly(P*Oc));
        K=K*den(end)/denn(end);
        num=K*numn;
        w=0:pi/1000:pi;
        [numd,dend]=bilinear(num,den,1/T);
        alfa=-(cos((Wplp+wp)/2))/(cos((Wplp-wp)/2));
        Nz=-[alfa 1];
        Dz=[1 alfa];
        [numpa,denpa]=mapeamento(numd,dend,Nz,Dz);
        H=freqz(numpa,denpa,w);
        Hmag=20*log10(abs(H)/max(abs(H)));
        [haa,xx,tt]=impulse(numpa,denpa);
        [yf]=filter(haa,1,y);
        figure
        plot(t,y,t,yf,'r')    
        figure
        plot(w/pi,Hmag)
        figure
        plot(w/pi,angle(H))
    case 2  %Cheab 2
        Oc=Os;
        Or=Os/Op;
        G=sqrt((A^2-1)/E^2);
        M=ceil((log10(G+sqrt(G^2-1)))/(log10(Or+sqrt(Or^2-1))));
        NN=ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(Op/Os)));
        [Z,P,K]=cheb2ap(M,As);
        denn=real(poly(P));
        numn=real(poly(Z));
        den=real(poly(P*Oc));
        num=real(poly(Z*Oc));
        K=K*((den(end)/denn(end))*(numn(end)/num(end)));
        num=num*K;
        w=0:pi/1000:pi;
        [numd,dend]=bilinear(num,den,1/T);
        alfa=-(cos((Wplp+wp)/2))/(cos((Wplp-wp)/2));
        Nz=-[alfa 1];
        Dz=[1 alfa];
        [numpa,denpa]=mapeamento(numd,dend,Nz,Dz);
        H=freqz(numpa,denpa,w);
        Hmag=20*log10(abs(H)/max(abs(H)));
        h=impulse(tf(numpa,denpa));
        [yf]=filter(h,1,y);
        figure
        plot(t,y,t,yf,'r')
    case 3  %Ellip
        Oc=Op;
        k=Op/Os;
        k1=E/sqrt(A^2-1);
        G=sqrt((A^2-1)/E^2);
        M=ceil((ellipke(k)*ellipke(sqrt(1-k1^2)))/(ellipke(k1)*ellipke(1-k^2)));
        [Z,P,K]=ellipap(M,Rp,As);
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
figure
plot(w/pi,angle(H))


