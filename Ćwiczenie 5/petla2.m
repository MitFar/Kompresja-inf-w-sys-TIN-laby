close all;
clear all;

% zaladowanie obrazu dwuwymiarowego
load trees;
%load mandrill;

% tablica wartosci wspolczynnikow k
k=[1 2 3 4 5 10 15 20 25 30 35 40 45 60 64]; 
licz1=length(k);
 
 for i=1:licz1
    
   k(i) 
   % Algorytm kompresji algebraicznej
   [B,V,Qp]=kom2d(I,k(i));

   dx=length(B(:,1));   
   dy=length(B(1,:));
   p=dx/8;
   r=dy/8;
   
   % Algorytm dekompresji
   [D]=dek2d(V,Qp,r,p);
   figure(i);
   colormap(gray(255));
   image(D);
   
end;