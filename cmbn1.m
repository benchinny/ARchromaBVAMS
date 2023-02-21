function [w22 y11 y00 STK t1 acl clr]=cmbn1(a0);
%211117cmbn1 combine ETM data with different optotype sets

cls; w22=[]; y00=[]; y11=[]; STK=[]; t1=[]; acl=[]; clr=[];
for k0=1:length(a0)
    load(a0(k0)); a1=char(a0(k0)); 
    t0=ones(1, length(y0)).*str2num(a1(end-9:end)); 
    acl=[acl ones(1, length(y0)).*str2num(a1(end-15))]; %tca=[tca ]
    c0=a1(end-20); if c0=='g'; c1=0; y0=zeros(size(y0)); elseif c0=='w'; c1=1; elseif c0=='p'; c1=2; else; c1=-1; end; 
    w22=[w22; STK11(w2)]; y11=[y11; y1]; y00=[y00 y0]; STK=[STK; STK11]; t1=[t1 t0]; clr=[clr ones(1, length(y0)).*c1];
  clear STK11 w2 y1 y0
end


%w2=w22; y1=y11; y0=y00;