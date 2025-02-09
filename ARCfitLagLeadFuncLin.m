function rms = ARCfitLagLeadFuncLin(x,y,d,p)

dUnq = unique(d);
pLagLead = dUnq.*p(1)+p(2);

if length(dUnq)~=length(pLagLead)
    error('ARCfitLagLeadFunc: fewer lag/lead parameters than unique stimulus distances!');
end

for i = 1:length(dUnq)
    ind = abs(d-dUnq(i))<0.0001;
    y(ind) = y(ind)+pLagLead(i);
end

rms = sqrt(mean((y-x).^2));

end