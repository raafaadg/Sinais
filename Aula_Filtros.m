clear;clc;
close all
%% Declaracao Sinal
scope=importdata('scope.csv');
t=scope(:,1);
y=scope(:,2);
t=t-t(1);
figure
plot(t,y)
L=length(y);
Fs=10000;
NFFT = 2^nextpow2(L);
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
figure
plot(f,2*abs(Y(1:NFFT/2+1)))

%% Filtro 

op=7; %Hz
os=10;%Hz
wp=(op/1000)*2*pi;
ws=(os/1000)*2*pi;
Rp=1;
As=50;
wc=(wp+ws)/2;
bt=ws-wp;
N=round((6.6*pi)/bt);
alfa=(N-1)/2;
n=0:N-1;
hdn=(sin(wc*(n-alfa)))./(pi*(n-alfa));
jan=hamming(N);
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
