function rms = ARCfitLagLeadFunc(x,y,d,p)

dUnq = unique(d);
if length(dUnq)~=length(p)
    error('ARCfitLagLeadFunc: fewer lag/lead parameters than unique stimulus distances!');
end

for i = 1:length(dUnq)
    ind = abs(d-dUnq(i))<0.0001;
    y(ind) = y(ind)+p(i);
end

rms = sqrt(mean((y-x).^2));

end