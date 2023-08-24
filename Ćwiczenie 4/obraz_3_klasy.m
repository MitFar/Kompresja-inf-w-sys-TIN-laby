% Skrypt obraz.m ilustruje dzialanie algorytmu centroidow dla dwoch klas

clear all;
close all;

% wczytanie sygnalu mowy z pliku typu wave
[y,Fp]=wavread('mw1.wav');

y1=y(8000:2:10000)';
y1(2,:)=y(8001:2:10001)';

% szum o rozkladzie gaussowskim
%y1=randn(2,3000);

% szum o rozkladzie rownomiernym
%y1=rand(2,3000);
%y1=(2*y1)-1;

clear y;

[r,p]=size(y1);

% r - ilosc skladowych wektora
% p - ilosc wektorow treningowych

% dn - zadany prog dokladnosci - warunek stopu
dn=0.01;


% c0 - tablica indeksow wektorow nalezacych do klasy c0
% c1 - tablica indeksow wektorow nalezacych do klasy c1
% c2 - tablica indeksow wektorow nalezacych do klasy c2


c0=[];
c1=[];
c2=[];

sw=0;

for i=1:p
    
  if sw==0
      
    c0=[c0 i];
    
  else
      
     if sw==1
        
        c1=[c1 i];
      
     else
        
        if sw==2
           c2=[c2 i];
        end;
      
     end;
    
  end;
  sw=sw+1;
  
  if sw>3
     sw=0;
  end;   
      
end;  

p0=length(c0);
p1=length(c1);
p2=length(c2);

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

sum=[0;0];
for i=1:p2
  sum=sum+y1(:,c2(i));
end;  
r2=sum/p2;


% wyznaczenie wartosci kryterium

% dl0 - wartosc kryterium w poprzedniej iteracji
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

% sumowanie po elementach klasy c2
for i=1:p2
  eloc=r1-y1(:,c2(i));
  dl1=dl1+(eloc'*eloc);
end;  

% e - wartosc pocz�tkowa bledu
e=abs(dl1-dl0);

% vk - wartosc kryterium globalna dla poczatkowego podzialu
vk(1)=e;

% wzgledny blad kwantyzacji - wartosc poczatkowa
if dl1>0
  es(1)=e/dl1;
else
  es(1)=0;
end;  

% wydruk - warunki poczatkowe
figure(1);
  
  % Klasa c0 - kolor czerwony
  plot(r0(1),r0(2),'r+');
  hold;
  for  i=1:p0
    plot(y1(1,c0(i)),y1(2,c0(i)),'r.');
  end;  
  
  % Klasa c1 - kolor zielony
  for  i=1:p1
    plot(y1(1,c1(i)),y1(2,c1(i)),'g.');
  end; 
  
  
  % Klasa c2 - kolor niebieski
   for  i=1:p2
    plot(y1(1,c2(i)),y1(2,c2(i)),'.');
  end; 
  
  
  plot(r0(1),r0(2),'r+');
  plot(r1(1),r1(2),'g+');
  plot(r2(1),r2(2),'+');
  
  title('Wektory treningowe - podzial wstepny na plaszczyznie XOY')
  xlabel('Wspolrzedna X');
  ylabel('Wspolrzedna Y');
  
  hold;
  
  k=1; 
  pause;
  
  
while es(k)>dn
   
  k  
  % nowa klasyfikacja
  c0=[];
  c1=[];
  c2=[];
  
  for i=1:p
    
    % oblicz odleglosc i-tego wektora  od srodka r0
    eloc=r0-y1(:,i);
    en0=(eloc'*eloc);
    
    % oblicz odleglosc i-tego wektora  od srodka r1
    eloc=r1-y1(:,i);
    en1=(eloc'*eloc);
    
     % oblicz odleglosc i-tego wektora  od srodka r2
    eloc=r2-y1(:,i);
    en2=(eloc'*eloc);
    
    
    if en0<=en1
        
       if en0<=en2
          c0=[c0 i];
       else
          c2=[c2 i];   
       end;    
          
    else
       
      if en1<=en2  
         c1=[c1 i];
      else
         c2=[c2 i];     
      end;    
      
    end;
    
  end;
% wyznacz nowe wartosci srodkow centroidu - r0, r1 i r2 end;
  
  p0=length(c0);
  p1=length(c1);
  p2=length(c2);
  
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
  
  sum=[0;0];
  for i=1:p2
     sum=sum+y1(:,c2(i));
  end;  
  r2=sum/p2;

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
  
  % sumowanie po elementach klasy c2
  for i=1:p2
     eloc=r2-y1(:,c2(i));
     dl1=dl1+(eloc'*eloc);
  end;  
  
  vk(k+1)=dl1;
  e=abs(dl1-dl0);
  
  if dl1>0
    es(k+1)=e/dl1;
  else
    es(k+1)=0;
  end;  
  
  figure(k+1);
  
  % Klasa c0 - kolor czerwony
  plot(r0(1),r0(2),'k+');
  hold;
  for  i=1:p0
    plot(y1(1,c0(i)),y1(2,c0(i)),'r.');
  end;  
  
  % Klasa c1 - kolor zielony
  
  for  i=1:p1
    plot(y1(1,c1(i)),y1(2,c1(i)),'g.');
  end; 
  
  % Klasa c2 - kolor niebieski
  
  for  i=1:p2
    plot(y1(1,c2(i)),y1(2,c2(i)),'.');
  end; 
  
  plot(r0(1),r0(2),'k+');
  plot(r1(1),r1(2),'k+');
  plot(r2(1),r2(2),'k+');
  
  title('Wektory treningowe - na plaszczyznie XOY')
  xlabel('Wspolrzedna X');
  ylabel('Wspolrzedna Y');
  
  hold;
  
  k=k+1;
  pause;
  
end; 

figure(k+1);
  plot(vk);
  hold;
  plot(vk,'r.');
  xlabel('k - numer iteracji');
  title('Wartosc kryterium globalnego');
  hold;
  
  
  figure(k+2);
  plot(es);
  hold;
  plot(es,'r.');
  xlabel('k - numer iteracji');
  title('Wzgledne zmiany kryterium globalnego');
  hold;


