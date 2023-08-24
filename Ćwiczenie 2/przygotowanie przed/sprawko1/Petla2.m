%close all;
clear all;

y=audioread('mowa.wav');

% dl -dlugosc badanego sygnalu mowy 
dl=20000;
y1=y(1:dl);

% yq - sygnal idealny, 16 bitowy; 
[yq]=convert(y1,16);

% Skalowanie sygnalu mowy, w systemach rzeczywistych 
% sygnaly sterujace dominuja pod wzgledem amplitudy nad
% sygnalem mowy
yq=0.1*yq;

% wartosc poczatkowa przedzialu kwantyzacji - delta
delta(1)=0.001;

for i=2:dl+1
   
   % kwant_dyn4 - kwantowanie liniowe
   [xq(i-1),delta(i)]=kwant_4(yq(i-1),delta(i-1));
   
   if mod(i,1000)==0
     i
   end; 

 end; 

 e=yq-xq';
 c=e'*e;
 u=yq'*yq;
 nmse=c/u;
 sqnr=10*log10(1/nmse)
 
 %figure(1);
 %plot(delta);
 
 %figure(2);
 %plot(yq);
 %hold;
 %plot(xq,'r');
 %hold;
 
 
 %soundsc(yq);
 %pause;
 %soundsc(xq);
 
 
 
 
 
 
