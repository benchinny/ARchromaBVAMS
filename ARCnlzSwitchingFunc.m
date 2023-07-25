function RMSE = ARCnlzSwitchingFunc(deltaA,deltaR,deltaB,deltaS,p)

wR=p(1);
wS=p(2);
bias=p(3);
rbThreshold=p(4);

wR = wR.*ones(size(deltaA));
wB = -wR.*ones(size(deltaA));
wS = wS.*ones(size(deltaA));
bias = bias.*ones(size(deltaA));

wB(deltaR-deltaB>rbThreshold)=0;
wR(deltaR-deltaB<=rbThreshold)=0;

deltaApredicted = wR + wB + wS.*deltaS + bias;
RMSE = sqrt(mean((deltaApredicted-deltaA).^2));

end