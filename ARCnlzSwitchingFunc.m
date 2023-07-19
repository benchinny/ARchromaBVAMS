function RMSE = ARCnlzSwitchingFunc(deltaA,deltaR,deltaB,deltaS,p)

wR=p(1);
wB=p(2);
wS=p(3);
bias=p(4);
rbThreshold=p(5);

wR = wR.*ones(size(deltaA));
wB = wB.*ones(size(deltaA));
wS = wS.*ones(size(deltaA));
bias = bias.*ones(size(deltaA));

wB(deltaR-deltaB>rbThreshold)=0;
wR(deltaR-deltaB<=rbThreshold)=0;

deltaApredicted = wR.*deltaR + wB.*deltaB + wS.*deltaS + bias;
RMSE = sqrt(mean((deltaApredicted-deltaA).^2));

end