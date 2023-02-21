function [m0 m1 i2]=mrtg(p0, i0, n0)
% calculate mortgage payments
m0=(p0.*i0.*(1+i0).^n0)./((1+i0).^n0-1) % 1627.2
m1=n0*m0; %loan+interest total
i2= m1-p0  % total interest
%(i0/12)*p0
p1=m1; i1=[]; p2=[];
for k0=1:n0
    p1=[p1 p1(end)-m0]; %loan+interest remaining
    i1=p0(end).*i0; %interest payment
    p2=[p2 m0-i1(end)]; %loan payment
    p0=[p0 p0(end)-p2(end)]; %remaining loan
    %i1=(m0-p0(end).*i0)    
end
