function [pFit,rms] = ARCfitLagLead(x,y,d)

% SET FMINCON OPTIONS
opts             = optimset('fmincon');
opts.Algorithm   = 'active-set';
opts.LargeScale  = 'off';
% opts.UseParallel = 'never';
opts.Display     = 'off';
% opts.MaxIter     = 500;

p0 = rand([1 3]);
lb = [0.01 0.01 0.01];
[pFit,rms] = fmincon(   @(p) ARCfitLagLeadFunc(x,y,d,p),p0,[],[],[],[],lb,[],[],opts);

end