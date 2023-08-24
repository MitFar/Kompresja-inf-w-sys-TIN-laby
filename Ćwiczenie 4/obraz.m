% Skrypt obraz.m ilustruje dzialanie algorytmu centroidow dla dwoch klas

clear all;
close all;

% wczytanie sygnalu mowy z pliku typu wave
[y,Fp]=audioread('mw1.wav');

y1=y(8000:2:10000)';
y1(2,:)=y(8001:2:10001)';

clear y;

[r,p]=size(y1);

% r - ilosc skladowych wektora
% p - ilosc wektorow treningowych

% dn - zadany prog dokladnosci - warunek stopu
dn=0.01;


% c0 - tablica indeksow wektorow nalezacych do klasy c0
% c1 - tablica indeksow wektorow nalezacych do klasy c1
c0=[];
c1=[];
sw=1;
for i=1:p
  if sw==1
    c0=[c0 i];
  else
    c1=[c1 i];
  end;
  sw=~sw;
end;  

p0=length(c0);
p1=length(c1);

% r0, r1 - wartosci poczatkowe srodka centroidow

sum=[0;0];
for i=1:p0
  sum=sum+y1(:,c0(i));
end;  
r0=sum/p0;

sum=[0;0];
for i=1:p1
  sum=sum+y1(:,c1(i));
end;  
r1=sum/p1;

% wyznaczenie wartosci kryterium

% dl0 - wartosc kryterium w porzedniej iteracji
dl0=0;

% dl1 - wartosc kryterium w biezacej iteracji
dl1=0;

% sumowanie po elementach klasy c0
for i=1:p0
  eloc=r0-y1(:,c0(i));
  dl1=dl1+(eloc'*eloc);
end;  

% sumowanie po elementach klasy c1
for i=1:p1
  eloc=r1-y1(:,c1(i));
  dl1=dl1+(eloc'*eloc);
end;  

% e - blad kryterium
e=abs(dl1-dl0);

% sredni blad kwantyzacji
if dl1>0
  es=e/dl1;
else
  es=0;
end;  

% wydruk - warunki poczatkowe
figure(1);
  
  % Klasa c0 - kolor czerwony
  plot(r0(1),r0(2),'b+');
  hold;
  for  i=1:p0
    plot(y1(1,c0(i)),y1(2,c0(i)),'r.');
  end;  
  
  % Klasa c1 - kolor zielony
  for  i=1:p1
    plot(y1(1,c1(i)),y1(2,c1(i)),'g.');
  end;   
  
  plot(r0(1),r0(2),'b+');
  plot(r1(1),r1(2),'k+');
  hold;
  
  k=0  
pause;  
  
while es>dn
  % nowa klasyfikacja
  c0=[];
  c1=[];
  
  
  for i=1:p
    
    % oblicz odleglosc i-tego wektora  od srodka r0
    eloc=r0-y1(:,i);
    en0=(eloc'*eloc);
    
    % oblicz odleglosc i-tego wektora  od srodka r1
    eloc=r1-y1(:,i);
    en1=(eloc'*eloc);
    
    if en0<=en1
      c0=[c0 i];
    else
      c1=[c1 i];
    end;
    
  end;
  
  p0=length(c0);
  p1=length(c1);

  % wyznacz nowe wartosci srodkow centroidu - r0, r1
  sum=[0;0];
  for i=1:p0
     sum=sum+y1(:,c0(i));
  end;  
  r0=sum/p0;

  sum=[0;0];
  for i=1:p1
     sum=sum+y1(:,c1(i));
  end;  
  r1=sum/p1;

  % dl1 - wartosc kryterium w biezacej iteracji
  dl0=dl1;
  dl1=0;

  % sumowanie po elementach klasy c0
  for i=1:p0
    eloc=r0-y1(:,c0(i));
    dl1=dl1+(eloc'*eloc);
  end;  

  % sumowanie po elementach klasy c1
  for i=1:p1
     eloc=r1-y1(:,c1(i));
     dl1=dl1+(eloc'*eloc);
  end;  
  
  e=abs(dl1-dl0);
  
  if dl1>0
    es=e/dl1;
  else
    es=0;
  end;  
  
  figure(1);
  
  % Klasa c0 - kolor czerwony
  plot(r0(1),r0(2),'b+');
  hold;
  for  i=1:p0
    plot(y1(1,c0(i)),y1(2,c0(i)),'r.');
  end;  
  % Klasa c1 - kolor zielony
  
  for  i=1:p1
    plot(y1(1,c1(i)),y1(2,c1(i)),'g.');
  end;   
  plot(r0(1),r0(2),'b+');
  plot(r1(1),r1(2),'k+');
  hold;
  
  k=k+1
  pause;
end;  