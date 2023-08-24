function [pwy,deltan,nump]=kwant_4(xn1,delta)
% kwantyzer dynamiczny rownomierny - 4 bity
% wejscie:
% xn1 - probka sygnalu
% delta - wartosc przedzialu kwantyzacji w chwili n-1
% wyjscie:
% pwy - skwantowana wartosc na wyjsciu
% deltan - wartosc przedzialu kwantyzacji w chwili n 
% nump - numer poziomu kwantowania

M=[0.90 0.90 0.90 0.90 1.20 1.60 2.00 2.40];
pomoc=abs(xn1);

% okreslenie indeksu w tablicy M
num=floor(pomoc/delta);
num=num+1;

% zabezpieczenie przed przekroczeniem zakresu 
if num>8
  num=8;
end;

pomoc2=floor(xn1/delta);

% zabezpieczenie przed przekroczeniem zakresu min
if pomoc2<-8
  pomoc2=-8;
end;  
% zabezpieczenie przed przekroczeniem zakresu max
if pomoc2>7
  pomoc2=7;
end;

% ustalenie numeru poziomu kwantowania
nump=pomoc2+8;

% ustalenie poziomu kwantyzera
pwy=(pomoc2+0.5)*delta;

% aktualizacja wartosci dla przedzialu kwantyzacji
Mp=M(num);
deltan=delta*Mp;