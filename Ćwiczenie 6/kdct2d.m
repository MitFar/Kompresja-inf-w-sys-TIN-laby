function [B,V] = kdct2d(A,k,w)
% funkcja kdct2 realizuje zadanie kompresji przy pomocy 
% transformacji kosinusowej dla sygnalow dwuwymiarowych - 
% np. obrazow
% WE:
%       A - obraz oryginalny
%       k - liczba z zakresu od 1 do w;
%       w - rozmiar bloku
% WY:   
%       B - obraz wejsciowy bo obciêciu
%       V - skompresowana postac obrazu


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
   pomoc3=zeros(k,k);
   pomoc4=zeros(w,1);
   pomoc5=zeros(w,w);
   V=zeros(p*k,r*k);

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
         
         % obciecie bloku pomoc5 do bloku k*k
         pomoc3=pomoc5(1:k,1:k);
         V(((i-1)*k)+1:(i*k),((j-1)*k)+1:(j*k))=pomoc3;
      end;
   end;   
   
V=fix(V);    