function [xq]=convert(y,b)
% [xq]=convert(y,b);
%
% Implementacja przetwornika AD
% WE:  y - sygnal wejsciowy 
%      b - liczba bitow
% WY:  xq - sygnal skwantowany  


ds=length(y);
xq=zeros(ds,1);

for i=1:ds   
   
 xsc=64*(y(i)+1);
 sc=2^b;
 d=128/sc;
 xq(i)=(fix(xsc/d)*d) + (0.5*d);
 xq(i)=(xq(i)/64)-1;
 
end;
