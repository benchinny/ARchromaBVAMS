function [wR, wS, bias, rbThreshold, mse] = ARCnlzSwitching(deltaA,deltaR,deltaB,deltaS)

% SET FMINCON OPTIONS
opts             = optimset('fmincon');
opts.Algorithm   = 'active-set';
opts.LargeScale  = 'off';
opts.UseParallel = 'never';
opts.Display     = 'iter';
opts.MaxIter     = 500;

ub = [1 2 1 0.01];
lb = [-1 -2 -1 -0.01];
p0 = [2.*(rand-0.5) 4.*(rand-0.5) 2.*(rand-0.5) 0];
[pFit,mse] = fmincon(   @(p) ARCnlzSwitchingFunc(deltaA,deltaR,deltaB,deltaS,p),p0,[],[],[],[],lb,ub,[],opts);

wR = pFit(1);
wS = pFit(2);
bias = pFit(3);
rbThreshold = pFit(4);

end