function VDIGA2()
%VDIGA2 Summary of this function goes here
%   Detailed explanation goes here

clc
clear all 
close all

eps = 1e-2;
w0 = 40;
fN = 250;

r = 1 + eps;
dt = 1/(2*fN);
w=2*pi*w0*dt;


a(1) = r^(-2);              % a0
a(2) = -2*cos(w)*r^(-2);    % a1
a(3) = r^(-2);              % a2
b(2) = -2*cos(w)*r^(-1);    % b1
b(3) = r^(-2);              % b2

v(1)= 10;
v(2)= 100;
T=1;
t = 0:dt:T;
n=length(t);

x=chirp(t,v(1),T,v(2)).*tukeywin(n,.05)';
%x=sin(2*pi*(v(1)+(v(2)-v(1))/(2*T).*t).*t).*tukeywin(n,.05)';

Fig1=figure(1);
set(Fig1,'position',[0,0,2000, 400]);
set(Fig1,'PaperPositionMode','Auto') 
plot(t,x)
xlabel('Zeit [s]','Fontsize',16)
ylabel('S(t)','Fontsize',16)
title('Eingangssignal Upsweep (\nu_1=10Hz, \nu_2=100 Hz)','Fontsize',18)
set(gca,'FontSize',14)
print -dpng Signal2.png



Fig2=figure(2);
set(Fig2,'position',[0,0,2000, 400]);
set(Fig2,'PaperPositionMode','Auto') 
plot(t*2*fN,abs(fft(x)))
axis([0 250 0 50])
xlabel('Frequenz [Hz]','Fontsize',16)
ylabel('A(\omega)','Fontsize',16)
title('FT des Eingangssignal bis \omega_N','Fontsize',18)
set(gca,'FontSize',14)
print -dpng Signal_fft2.png

y = zeros(1,n);

for k = 3 : n-2
    y(k) = a(1) * x(k) + a(2) * x(k-1) + a(3) * x(k-2) -  b(2) * y(k-1) - b(3) * y(k-2);
end;

Fig3=figure(3);
set(Fig3,'position',[0,0,2000, 400]);
set(Fig3,'PaperPositionMode','Auto') 
plot(t,y)
xlabel('Zeit [s]','Fontsize',16)
ylabel('S(t)','Fontsize',16)
title('Ausgangssignal Upsweep (\nu_1=10Hz, \nu_2=100 Hz) mit Notch (\omega_0=40Hz)','Fontsize',18)
set(gca,'FontSize',14)
print -dpng Signal_filter2.png

Fig4=figure(4);
set(Fig4,'position',[0,0,2000, 400]);
set(Fig4,'PaperPositionMode','Auto') 
plot(t*2*fN,abs(fft(y)))
axis([0 250 0 50])
xlabel('Frequenz [Hz]','Fontsize',16)
ylabel('A(\omega)','Fontsize',16)
title('FT des Ausgangssignal bis \omega_N','Fontsize',18)
set(gca,'FontSize',14)
print -dpng Signal_filter_fft2.png

Fig5=figure(5);
set(Fig5,'position',[0,0,2000, 400]);
set(Fig5,'PaperPositionMode','Auto') 
plot(t*2*fN,1+(abs(fft(y))-abs(fft(x)))/(25))
axis([0 250 0 1])
xlabel('Frequenz [Hz]','Fontsize',16)
ylabel('|f^{quer}|','Fontsize',16)
title('Uebertragungsfunktion des Filters bis \omega_N','Fontsize',18)
set(gca,'FontSize',14)
print -dpng Signal_filter_uebertrag2.png

end


