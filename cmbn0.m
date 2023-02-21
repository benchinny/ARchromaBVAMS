function [w22 y11 y00 STK]=cmbn0(a0);
%210624cmbn0 combine ETM data with different optotype sets

cls; w22=[]; y00=[]; y11=[]; STK=[];
for k0=1:length(a0)
    load(a0(k0));
    w22=[w22; STK11(w2)]; y11=[y11; y1]; y00=[y00 y0]; STK=[STK; STK11]; 
  clear STK11 w2 y1 y0
end


%w2=w22; y1=y11; y0=y00;