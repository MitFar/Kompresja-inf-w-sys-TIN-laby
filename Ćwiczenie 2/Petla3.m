%close all;
%clear all;

y=audioread('mowa.wav');
y1=y(1:20000);

% yq - sygnal idealny, 16 bitowy; 
[yq]=convert(y1,16);

% Skalowanie sygnalu mowy, w systemach rzeczywistych 
% sygnaly sterujace dominuja pod wzgledem amplitudy nad
% sygnalem mowy
yq=0.1*yq;


b=[5 6 7 8 9 10 11 12 13 14];
licz1=length(b);
u=zeros(1,licz1);
c=zeros(1,licz1);
mi=[1 2 5 10 25 50 100 150 200 250 300];
licz2=length(mi);
nmse=zeros(licz2,licz1);
sqnr=zeros(licz2,licz1);

for i=1:licz1
   b(i)
   
   for l=1:licz2
   % pcm - probkowanie nieliniowe, logarytmiczne
   [xcom,yq1,xq]=pcm(yq,b(i),mi(l));
   
   
   e=yq-xq;
   c(1,i)=e'*e;
   u(1,i)=yq'*yq;
   nmse(l,i)=c(1,i)/u(1,i);
   sqnr(l,i)=10*log10(1/nmse(l,i));
   
   end;
   
   if b(i)==8
       
       soundsc(xq);
       
   end;    
   
 end;   
 
 % drukowanie wykresu SQNR=f(liczba bitow)
 figure(2); 
 plot(mi,sqnr(:,1));
 hold;
 plot(mi,sqnr(:,1),'r.');
 
 for i=2:licz1
    plot(mi,sqnr(:,i));
    plot(mi,sqnr(:,i),'r.');
 end;
 
 zoom on;
 grid on;
 hold;
 