close all;
clear all;

load trees; 
load mandrill;
% tablica wartosci parametru k
k=[1 2 3 4 5 6 7 8];
licz1=length(k);

% rozmiar bloku do kompresji
l=8;

for i=1:licz1
   k(i)
   
   % algorytm kompresji
   [B,V]=kdct2d(I,k(i),l);
   dx=length(B(:,1));   
   dy=length(B(1,:));
   p=dx/l;
   r=dy/l;
   
   % algorytm dekompresji
   [D]=dekdct2d(V,r,p,k(i),l);
   
   % wyznaczanie bledow subiektywnych
   E=B-D;
   Ms(i)=trace(E*E');
   En(i)=trace(B*B');
   Nmse(i)=Ms(i)/En(i);
   Snr(i)=10*log10(1/Nmse(i));
end;

figure(1);
plot(k.*k,Snr);
hold;
plot(k.*k,Snr,'r.');
load snr_1.mat;
plot (k.*k,Snr, 'g');
plot (k.*k,Snr,'k.');
save snr_1 Snr;
