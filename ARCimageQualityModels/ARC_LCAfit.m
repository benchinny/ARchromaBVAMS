function [q1,q2,q3,err] = ARC_LCAfit(wave,D)

% SET FMINCON OPTIONS
opts             = optimset('fmincon');
opts.Algorithm   = 'active-set';
opts.LargeScale  = 'off';
% opts.UseParallel = 'never';
opts.Display     = 'off';
% opts.MaxIter     = 500;

p0 = [1.73 0.63 0.21];
pLB = [0 0 0];
pUB = [2 2 2];

[pFit,err] = fmincon(   @(p) humanWaveDefocusObjFunc(wave,D,p),p0,[],[],[],[],pLB,pUB,[],opts);

q1 = pFit(1);
q2 = pFit(2);
q3 = pFit(3);

end