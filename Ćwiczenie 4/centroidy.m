clear all;
close all;

% zaladuj slownik w postaci struktury drzewa do tablicy tr
load tr_2_256;
g=8;

% inicjalizacja biezacego wskaznika poziomu w drzewie 
  indeks=1;

  for r=1:g
    
    r  
      
    % l - ilosc wektorow decyzyjnych w drzewie na r-tym poziomie
    l=2^r;

    figure(r);
    
    for k=1:l
        
        plot(tr(1,indeks+k-1),tr(2,indeks+k-1),'r+');
        
        if k==1
            
            axis([-1 1 -1 1]);
            hold;
            
        end;
        
    end;
    
    % przesuniecie wskaznika na poczatek nastepnego poziomu w drzewie
    indeks=indeks+l;
    
    hold;
    
    pause
    
end; 


