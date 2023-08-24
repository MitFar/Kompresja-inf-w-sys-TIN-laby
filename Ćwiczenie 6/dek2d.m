function [D] = dek2d(V,r,p,w,Q)
% funkcja dek2d realizuje zadanie dekompresji 
% przy zastosowaniu transformacji kosinusowej dla 
% sygnalow dwuwymiarowych - obrazow oraz operacje 
% dekwantyzacji oparta o macierz Q 
% WE:
%       V - skompresowania postac obrazu
%       r - ilosc blokow w wierszu obrazu
%       p - ilosc blokow w kolumnie obrazu
%       w - rozmiar bloku 
%       Q - tablica kwantyzacji
% WY:   
%       D - obraz po dekompresji


   % Inicjacja tablic do obliczen

   pomoc=zeros(w,w);
   pomoc1=zeros(w,w);
   pomoc2=zeros(1,w);
   pomoc4=zeros(w,1);
   pomoc5=zeros(w,w);
   D=zeros((w*p),(w*r));
   
   % proces dekompresji
   
   for i=1:p
      for j=1:r
         % wez odpowiedni blok do dekompresji        
         pomoc=zeros(w,w);
         pomoc=V(((i-1)*w)+1:(i*w),((j-1)*w)+1:(j*w));
         
         % operacja odwrotna do kwantyzacji - dekwantyzacja
         pomoc=pomoc.*Q;          
         
         % oblicz odwrotna transformate kosinusowa IDCT dla 
         % bloku pomoc
         for n=1:w
            % wez n-ty wiersz tablicy pomoc i oblicz jego IDCT
            pomoc2=idct(pomoc(n,:));
            % wynik zapamietaj w tablicy pomoc1
            pomoc1(n,:)=pomoc2;
         end;   
         
         for l=1:w
            % wez l-ta kolumne tablicy pomoc1 i oblicz jego IDCT;
            pomoc4=idct(pomoc1(:,l));
            % wynik zapamietaj w tablicy pomoc5
            pomoc5(:,l)=pomoc4;
         end; 
                  
         % zapamietaj odtworzony fragment w tablicy D
         D(((i-1)*w)+1:(i*w),((j-1)*w)+1:(j*w))=pomoc5; 
      end;
   end;   
   