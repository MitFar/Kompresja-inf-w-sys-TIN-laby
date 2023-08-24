close all;
clear all;

%load trees; 
load mandrill;
% rozmiar bloku do kompresji
l=8;

% Tablica kwantyzacji - luminancja
Q=[16 11 10 16 24 40 51 61; 
   12 12 14 19 26 58 60 55;
   14 13 16 24 40 57 69 56;
   14 17 22 29 51 87 80 62;
   18 22 37 56 68 109 103 77;
   24 35 55 64 81 104 113 92;
   49 64 78 87 103 121 120 101;
   72 92 95 98 112 100 103 99];


   % algorytm kompresji
   [B,V,Z,g]=k2d(I,l,Q);
   % Z - macierz opisujaca ilosc zer w analizowanych blokach
   % g - calkowita liczba zer w skompresowanej postaci obrazu
   g
   
   dx=length(B(:,1));   
   dy=length(B(1,:));
   
   % tot - calkowita liczba pikseli
   tot=dx*dy;
   tot
   
   p=dx/l;
   r=dy/l;
   
   % algorytm dekompresji
   [D]=dek2d(V,r,p,l,Q);
   
   % wyznaczanie bledow subiektywnych
   E=B-D;
   Ms=trace(E*E');
   En=trace(B*B');
   Nmse=Ms/En;
   Snr=10*log10(1/Nmse)
   
   % obraz oryginalny;
   figure(1);
   colormap(gray(255));
   image(B);
   
   % obraz po dekompresji
   figure(2);
   colormap(gray(255));
   image(D);