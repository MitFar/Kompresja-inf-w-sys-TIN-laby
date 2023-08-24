close all;
clear all;

y=audioread('mowa.wav');
y1=y(1:20000);

% yq - sygnal idealny, 16 bitowy; 
[yq]=convert(y1,16);

% Skalowanie sygnalu mowy, w systemach rzeczywistych 
% sygnaly sterujace dominuja pod wzgledem amplitudy nad
% sygnalem mowy
yq=0.1*yq;


b=[4 5 6 7 8  9 10 11 12 13 14 15 16];
a=length(b);
nmse=zeros(1,a);
sqnr=zeros(1,a);
u=zeros(1,a);
c=zeros(1,a);

for i=1:a
   % Wydruk liczby bitow w kazdej iteracji
   b(i)
  
   % convert - kwantowanie liniowe
   [xq]=convert(yq,b(i));
    
   %soundsc(xq);
   %pause;
   
   e=yq-xq;
   c(1,i)=e'*e;
   u(1,i)=yq'*yq;
   nmse(1,i)=c(1,i)/u(1,i);
   sqnr(1,i)=10*log10(1/nmse(1,i));
 end;   
 
 % drukowanie wykresu SQNR=f(liczba bitow)
 plot(b,sqnr);
 hold on;
 zoom on;
 grid on;
 plot(b,sqnr,'r.');
 hold;