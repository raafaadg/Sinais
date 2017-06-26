n = 0:100;
x = 0.7.^n;
stem(n,x)
N=50;
k=0:N-1;
xp=1./(1-0.7*exp(-j*2*pi*k/N));
xpn=ifft(xp);
xpnp = [xpn xpn];
kk = 0 : 99;
hold
stem(kk,xpnp,'r')