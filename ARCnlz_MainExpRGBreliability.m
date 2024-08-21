%% LOOKING AT RELIABILITY OF WAVEFRONT MEASUREMENTS

subjNum = 11;

if subjNum==11 || subjNum==12
   blockNums = 2:7;
   trialNums = {1:33 1:33 1:33 1:33 1:33 1:33};
   subjName = ['S' num2str(subjNum) '-OD'];
elseif subjNum==13
   blockNums = 3:8;
   trialNums = {1:33 1:33 1:33 1:33 1:33 1:33};
   subjName = ['S' num2str(subjNum) '-OD'];   
end

meanC = [];
rgb1all = [];
meanv00all = [];
nIndBadTracker = [];
c4all = {};

for i = 1:length(blockNums)
    blockNumTmp = blockNums(i);
    trialNumsTmp = trialNums{i};
    AFCp = ARCloadFileBVAMS(subjNum,blockNumTmp);
    for j = 1:length(trialNumsTmp)
        [ZernikeTable, ~, ~, ~] = ARCloadFileFIAT(subjName,blockNumTmp,trialNumsTmp(j),0);
        NumCoeffs = width(ZernikeTable)-8; % determine how many coefficients are in the cvs file. 
        c=zeros(size(ZernikeTable,1),65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65.
        indBadPupil = table2array(ZernikeTable(:,5))==0;
        PARAMS.PupilSize=mean(table2array(ZernikeTable(~indBadPupil,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
        PARAMS.PupilFitSize=mean(table2array(ZernikeTable(~indBadPupil,5))); 
        PARAMS.PupilFieldSize=PARAMS.PupilSize*2; %automatically compute the field size
        c(:,3:NumCoeffs)=table2array(ZernikeTable(:,11:width(ZernikeTable)));
        indBad = c(:,4)==0;
        nIndBadTracker(end+1) = sum(indBad);
        c(indBad,4) = mean(c(~indBad,4));
        meanC(end+1,:) = mean(c,1); % TAKE MEAN OF COEFFICIENTS    
        c4all{end+1} = c(:,4);
    end
    rgb1all = [rgb1all; AFCp.rgb100];
    meanv00all = [meanv00all; AFCp.meanv00./1.2255];
end

