function [wR, wB, wS, bias, rbThreshold, mse] = ARCnlzSwitching(deltaA,deltaR,deltaB,deltaS)

% SET FMINCON OPTIONS
opts             = optimset('fmincon');
opts.Algorithm   = 'active-set';
opts.LargeScale  = 'off';
opts.UseParallel = 'never';
opts.Display     = 'iter';
opts.MaxIter     = 500;

ub = [5 5 5 2 0.5];
lb = [-5 -5 -5 -2 -0.5];
p0 = [5.*(rand-0.5) 5.*(rand-0.5) 4.*(rand-0.5) 2.*(rand-0.5) 1.*(rand-0.5)];
[pFit,mse] = fmincon(   @(p) ARCnlzSwitchingFunc(deltaA,deltaR,deltaB,deltaS,p),p0,[],[],[],[],lb,ub,[],opts);

wR = pFit(1);
wB = pFit(2);
wS = pFit(3);
bias = pFit(4);
rbThreshold = pFit(5);

end