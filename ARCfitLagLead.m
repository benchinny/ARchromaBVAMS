function [pFit,rms] = ARCfitLagLead(x,y,d)

% SET FMINCON OPTIONS
opts             = optimset('fmincon');
opts.Algorithm   = 'active-set';
opts.LargeScale  = 'off';
% opts.UseParallel = 'never';
opts.Display     = 'off';
opts.MaxIter     = 500;

p0 = rand([1 length(unique(d))]);
lb = -1.*ones([1 length(unique(d))]);
[pFit,rms] = fmincon(   @(p) ARCfitLagLeadFunc(x,y,d,p),p0,[],[],[],[],lb,[],[],opts);

end