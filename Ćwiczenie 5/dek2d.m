function [D] = dek2d(V,Qp,r,p)
% funkcja dek2d realizuje dekompresji algebraicznej dla 
% sygnalow dwuwymiarowych - np. obrazow
% WE:
%       V - skompresowania postac obrazu
%       Qp - macierz wektorow wlasnych
%       r - ilosc blokow w wierszu obrazu
%       p - ilosc blokow w kolumnie obrazu
% WY:   
%       D - obraz po dekompresji


   % Inicjacja tablic do obliczen

   pomoc=zeros(8,8);
   D=zeros((8*p),(8*r));
   
   % proces dekompresji
   
   for n=1:p
      for m=1:r
         % Oblicz wektor v po dekompresji
         v=Qp*V(:,((n-1)*r)+m);
         % utworzenie z wektora v bloku pomoc o wymiarze 8*8
         k=1;
         for s=1:8
            for t=1:8
               if k
                  pomoc(s,t)=v(((s-1)*8)+t,1);
               else
                  pomoc(s,9-t)=v(((s-1)*8)+t,1);
               end;   
            end;
            k=~k;
         end;  
        pomoc=fix(pomoc);
        D(((n-1)*8)+1:(n*8),((m-1)*8)+1:(m*8))=pomoc; 
      end;
   end;   
   
    