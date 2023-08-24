function [xcom,yq,xq]=pcm(y,b,mi)
% [xcom,yq,xq]=pcm(y,b,mi);
%
% Symulacja systemu - kompresja z prawem mi
% WE:  y - sygnal wejsciowy 
%      b - liczba bitow
%      mi - wartosc wspolczynnika mi
% WY:  xcom - sygnal na wyjsciu kompresora mi;
%      yq - sygnal skwantowany - przetwornik b bitow;
%      xq - sygnal po dekompresji;  

ds=length(y);
xcom=zeros(ds,1);
xq=xcom;
yq=xq;

for i=1:ds   
  % przejscie probki x(i) przez kompresor mi 
  xcom(i)=log(1+(mi*abs(y(i))))*sign(y(i))/log(1+mi);
  
  % przejscie probki xcom(i)
  xsc=64*(xcom(i)+1);
  sc=2^b;
  d=128/sc;
  yq(i)=fix(xsc/d)*d + 0.5*d;
  yq(i)=(yq(i)/64)-1;
   
  % przejscie probki yq(i) 
  xq(i)=sign(yq(i))*(((1+mi)^(abs(yq(i))))-1)/mi;
 
end;
