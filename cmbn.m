function [w22 y11 y00 STK]=cmbn(a0);
%210525cmbn combine ETM data

cls; w22=[]; y00=[]; y11=[]; STK=[];
for k0=1:length(a0)
    load(a0(k0));
    w22=[w22; w2]; y11=[y11; y1]; y00=[y00 y0]; STK=[STK; STK11];   
end


%w2=w22; y1=y11; y0=y00;