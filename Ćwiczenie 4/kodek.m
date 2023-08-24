clear all;
close all;

% Paremetry wejsciowe

[y,Fp]=audioread('mw1.wav');

% dl - ilosc wektorow do kodowania
dl= 5000;

% k - ilosc probek w pojedynczym wektorze
k=2;

% p - calkowita liczba probek
p=k*dl;

% yin - sygnal oryginalny
yin=y(1:p,1);
%wavwrite(yin,8000,'yin.wav');

% y1 - zbior wektorow do kodowania  
y1=zeros(k,dl);


% zaladowanie danych do etapu kodowania
for i=1:dl
  y1(:,i)=y(1+((i-1)*k):1+(i*k)-1,1);
end;

clear y; 

% zaladuj slownik w postaci struktury drzewa do tablicy tr
load tr_2_256;
g=8;


% lp - wektor indeks�w wektor�w najblizszego sasiedztwa  
lp=zeros(1,dl);

snr=zeros(1,g);
nmse=zeros(1,g);

for r=1:g
   
   r
   l_wek(r)=2^r;
   
   % proces kodowania
   disp(' Proces kodowania - poczatek ');
   for i=1:dl
       lp(i)=koduj(y1(:,i),tr,r);
       if (mod(i,2000)==0)
          i
       end;
   end;  
    
   % proces dekodowania 
   disp(' Proces dekodowania - poczatek !');
   yd=zeros(k,p);
   yout=[];
   
   for i=1:dl
      yd(:,i)=tr(:,lp(i));
      yout=[yout; yd(:,i)];
      if (mod(i,2000)==0)
         i
      end;
   end;  
   
   figure(r);
   plot(yin);
   hold;
   plot(yout,'r');
   hold;
   
   % wyznaczyc NMSE i SQNR
   e=yin-yout;
   en=e'*e;
   ey=yin'*yin;
   nmse(r)=en/ey;
   snr(r)=10*log10(1/nmse(r));   
end;   

figure(g+1);
v=[1:1:g];
v=[1:1:g]*4;
plot(v,snr);
hold;
plot(v,snr,'r.');
hold;
hold;
plot(32,27.5,'r+');
hold;
