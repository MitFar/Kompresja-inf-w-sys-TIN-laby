function [B,V,Qp] = kom2d(A,k)
% funkcja kom2d realizuje kompresje algebraiczna dla 
% sygnalow dwuwymiarowych - obrazow
% WE:
%       A - obraz oryginalny
%       k - liczba z zakresu od 1 do 64;
% WY:   
%       B - obraz wejsciowy A bo obciêciu
%       V - skompresowana postac obrazu
%       Qp - macierz wektorow wlasnych dla dekodera


% Dokonaj obciêcia obrazu

dx=length(A(:,1));
dy=length(A(1,:));

p=fix(dx/8);
r=fix(dy/8);

B=A(1:(p*8),1:(r*8));

% Oblicz macierz korelacji obrazu

   % Inicjacja tablic do dalszych obliczen

   Ru=zeros(64,64);
   U=zeros(64,64);
   S=zeros(64,64);
   F=zeros(64,64);
   pomoc=zeros(8,8);
   pomoc1=zeros(1,64);
   V=zeros(k,p*r);
   v=zeros(64,1);
   Vr=zeros(64,(p*r));
   
   for i=1:p
      for j=1:r
         % wez odpowiedni blok obrazu
         pomoc=B(((i-1)*8)+1:(i*8),((j-1)*8)+1:(j*8));
         % rozwin blok pomoc w wektor v o dlugosci 64
         k1=1;
         for n=1:8
            for m=1:8
               if k1
                v(((n-1)*8)+m,1)=pomoc(n,m);  
               else
                v(((n-1)*8)+m,1)=pomoc(n,9-m);  
               end;   
            end;
            k1=~k1;
         end;   
         % zapamietaj do procesu kompresji wektor v
         Vr(:,((i-1)*r)+j)=v;
         % uaktualnienie estymatora macierzy korelacji
         Ru=Ru+(v*v');
      end;
   end;   
   
   % Dokonaj dekompozycji wlasnej (Karhunena - Loeve)
   
   [U,S,F]=svd(Ru);
   
   % Wlasciwa kompresja
   
   Qp=U(:,1:k);
   pomoc2=p*r;
   for i=1:pomoc2
      V(:,i)=Qp'*Vr(:,i);
   end;   
   