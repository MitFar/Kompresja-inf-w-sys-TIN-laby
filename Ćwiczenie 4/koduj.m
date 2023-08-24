function lp=koduj(y1,tr,r);

indeks=1;
pe=r-1;

for i=1:pe
    e1=y1-tr(:,indeks);
    e2=y1-tr(:,indeks+1); 
    er1=e1'*e1;
    er2=e2'*e2;
    
    if er2>er1 
      indeks=(2*indeks)+1;  
    else
      indeks=(2*(indeks+1))+1;
    end;   
end;

e1=y1-tr(:,indeks);  
e2=y1-tr(:,indeks+1); 
er1=e1'*e1;
er2=e2'*e2;

if er2<er1 
      indeks=indeks+1;
end;
    

lp=indeks;


