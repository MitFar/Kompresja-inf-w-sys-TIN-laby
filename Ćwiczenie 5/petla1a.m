close all;
clear all;

% zaladowanie obrazu dwuwymiarowego
load trees;
load mandrill;

% tablica wartosci wspolczynnikow k
k=[1 2 3 4 5 10 15 20 25 30 35 40 45 60 64]; 
licz1=length(k);

for i=1:licz1
   k(i)
   % algorytm kompresji
   [B,V,Qp]=kom2d(I,k(i));
   dx=length(B(:,1));   
   dy=length(B(1,:));
   p=dx/8;
   r=dy/8;
   
   % algorytm dekompresji
   [D]=dek2d(V,Qp,r,p);
   E=B-D;
   Ms(i)=trace(E*E');
   En(i)=trace(B*B');
   Nmse(i)=Ms(i)/En(i);   
   Snr(i)=10*log10(1/Nmse(i));
end;

figure(1);
plot(k,Snr);
hold;
plot(k,Snr,'r.');
load snr_1.mat;
plot (k,Snr, 'g');
plot (k,Snr,'k.');
save snr_1 Snr;


