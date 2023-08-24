function [B,V,Z,D] = k2d(A,w,Q)
% funkcja k2d realizuje zadanie kompresji przy pomocy 
% transformacji kosinusowej dla sygnalow dwuwymiarowych - 
% np. obrazow oraz kwantyzacje oparta o macierz Q
% WE:
%       A - obraz oryginalny
%       w - rozmiar bloku
%       Q - tablica kwantyzacji
% WY:   
%       B - obraz wejsciowy bo obciêciu
%       V - skompresowana postac obrazu
%       Z - ilosc zer w poszczegolnych blokach

% Dokonaj obciêcia obrazu

dx=length(A(:,1));
dy=length(A(1,:));

p=fix(dx/w);
r=fix(dy/w);

B=A(1:(p*w),1:(r*w));


   % Inicjacja tablic do dalszych obliczen

   pomoc=zeros(w,w);
   pomoc1=zeros(w,w);
   pomoc2=zeros(1,w);
   pomoc3=zeros(w,w);
   pomoc4=zeros(w,1);
   pomoc5=zeros(w,w);
   V=zeros(p*w,r*w);
   Z=zeros(p,r);
   D=0;
   
   for i=1:p
      for j=1:r
         % wez odpowiedni blok obrazu
         pomoc=B(((i-1)*w)+1:(i*w),((j-1)*w)+1:(j*w));
         
         % oblicz dwuwymiarowa transformate kosinusowa DCT 
         % bloku pomoc
         
         for n=1:w
            % wez n-ty wiersz tablicy pomoc i oblicz jego DCT
            pomoc2=dct(pomoc(n,:));
            % wynik zapamietaj w tablicy pomoc1
            pomoc1(n,:)=pomoc2;
         end;   
         
         for l=1:w
            % wez l-ta kolumne tablicy pomoc1 i oblicz jego DCT;
            pomoc4=dct(pomoc1(:,l));
            % wynik zapamietaj w tablicy pomoc5
            pomoc5(:,l)=pomoc4;
         end;   
         
         % nalozenie tablicy kwantyzacji
         pomoc3=fix(pomoc5(1:w,1:w)./Q);
         
         for k1=1:w
            for k2=1:w
               if (pomoc3(k1,k2)==0)  
                  Z(i,j)=Z(i,j)+1;
                  D=D+1;
               end;   
            end;
         end;   
         
         V(((i-1)*w)+1:(i*w),((j-1)*w)+1:(j*w))=pomoc3;
      end;
   end;   
   
    