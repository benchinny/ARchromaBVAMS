function RMSE = ARCtestWvInFocusMeanZspatFilterObjFunc(subjNum,w)

if subjNum==10
    subjName = 'S20-OD';
    blockNumAll = 3:8;
elseif subjNum==3
    subjName = 'S13-OD';
    blockNumAll = 12:17;
elseif subjNum==1
    subjName = 'S11-OD';
    blockNumAll = 11:16;
elseif subjNum==5
    subjName = 'S15-OD';
    blockNumAll = 3:8;
elseif subjNum==9
    subjName = 'S19-OD';
    blockNumAll = 2:7;
elseif subjNum==16
    subjName = 'S26-OD';
    blockNumAll = 2:7;
elseif subjNum==17
    subjName = 'S27-OD';
    blockNumAll = 2:7;
elseif subjNum==18
    subjName = 'S28-OD';
    blockNumAll = 2:7;
elseif subjNum==20
    subjName = 'S30-OD';
    blockNumAll = 2:7;
end

trialNumAll = 1:36;

defocus875 = [];
optDistAll = [];

for k = 1:length(blockNumAll)
    AFCp = ARCloadFileBVAMS(subjNum+10,blockNumAll(k));
    optDistAll = [optDistAll; AFCp.meanv00./1.2255];
    for l = 1:length(trialNumAll)
        % LOAD ZERNIKE TABLE AND TIMESTAMPS
        [ZernikeTable, ~, ~, TimeStamp] = ARCloadFileFIAT(subjName,blockNumAll(k),trialNumAll(l),0);

        NumCoeffs = width(ZernikeTable)-8; % determine how many coefficients are in the cvs file. 
        c=zeros(size(ZernikeTable,1),65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65. 
        PARAMS = struct;
        PARAMS.PupilSize=mean(table2array(ZernikeTable(:,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
        PARAMS.PupilFitSize=mean(table2array(ZernikeTable(:,5))); 
        PARAMS.PupilFieldSize=PARAMS.PupilSize*2; %automatically compute the field size
        c(:,3:NumCoeffs)=table2array(ZernikeTable(:,11:width(ZernikeTable)));
        indBad = c(:,4)==0;
        meanC = mean(c(~indBad,:),1); % TAKE MEAN OF COEFFICIENTS  
        defocusCorrectionFactor = (1e6/(4*sqrt(3)))*((PARAMS.PupilSize/2000)^2);
        defocus875(end+1,:) = meanC(4)./defocusCorrectionFactor;
    end
end

%%

rgbAll = [];
optDistAll = [];
for k = 1:length(blockNumAll)
    AFCp = ARCloadFileBVAMS(subjNum+10,blockNumAll(k));
    rgbAll = [rgbAll; AFCp.rgb100];
    optDistAll = [optDistAll; AFCp.meanv00./1.2255];
end
rgbUnq = unique(rgbAll,'rows');
defocus875predTmp = zeros([length(optDistAll) 1]);
wvInFocus = zeros([size(rgbUnq,1) 1]);
for l = 1:size(rgbUnq,1)
    wvInFocus(l,:) = ARCwvInFocusConesMeanZspatFilter(subjNum,l,w);
    % display(['wL = ' num2str(wL) ' wM = ' num2str(wM) ' wS = ' num2str(wS) ' stim ' num2str(l)]);
end 
wvInFocusAll = zeros([length(optDistAll) 1]);
for l = 1:size(rgbUnq,1)
    indStiml = abs(rgbAll(:,1)-rgbUnq(l,1))<0.001 & ...
    abs(rgbAll(:,2)-rgbUnq(l,2))<0.001 & ...
    abs(rgbAll(:,3)-rgbUnq(l,3))<0.001;
    if subjNum==10
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS10(wvInFocus(l),875);
    end
    if subjNum==1
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS1(wvInFocus(l),875);
    end
    if subjNum==3
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS3(wvInFocus(l),875);
    end
    if subjNum==5
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS5(wvInFocus(l),875);
    end                
    if subjNum==9
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS9(wvInFocus(l),875);
    end
    if subjNum==16
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS16(wvInFocus(l),875);
    end
    if subjNum==17
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS17(wvInFocus(l),875);
    end
    if subjNum==18
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS18(wvInFocus(l),875);
    end                
    if subjNum==20
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS20(wvInFocus(l),875);
    end
    wvInFocusAll(indStiml) = wvInFocus(l);
end

RMSE = sqrt(mean((defocus875predTmp(:)-defocus875(:)).^2));

end
