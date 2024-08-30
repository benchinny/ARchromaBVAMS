%%

[ZernikeTable, ~, ~, ~, trialTagIndex] = ARCloadFileFIATallInstances('S12-OD',17,0);
NumCoeffs = width(ZernikeTable)-8; % determine how many coefficients are in the cvs file. 
c=zeros(size(ZernikeTable,1),65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65.
indBadPupil = table2array(ZernikeTable(:,5))==0;
PARAMS.PupilSize=mean(table2array(ZernikeTable(~indBadPupil,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
PARAMS.PupilFitSize=mean(table2array(ZernikeTable(~indBadPupil,5))); 
PARAMS.PupilFieldSize=PARAMS.PupilSize*2; %automatically compute the field size
c(:,3:NumCoeffs)=table2array(ZernikeTable(:,11:width(ZernikeTable)));

indBad = c(:,4)==0;
cGood = c(~indBad,4);
defocusCorrectionFactor = (1e6/(4*sqrt(3)))*((PARAMS.PupilSize/2000)^2);
defocusAt550 = humanWaveDefocus(875)-humanWaveDefocus(550)+cGood./defocusCorrectionFactor;
trialTagIndexGood = trialTagIndex(~indBad);

%%

for i = 1:length(unique(trialTagIndexGood))
    trialInd = trialTagIndexGood==i;
    defocusAt550mean(i) = mean(defocusAt550(trialInd));
end
