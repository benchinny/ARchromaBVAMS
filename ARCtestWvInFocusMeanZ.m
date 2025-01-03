%%

subjNum = 20;
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

if subjNum==20
    % RMSEall = zeros([11 11 11]);
    % SvaluesAll = [-1 -0.8 -0.6 -0.4 -0.2 0.0 0.2 0.4 0.6 0.8 1];
    % loadStr = {'-10' '-8' '-6' '-4' '-2' '0' '2' '4' '6' '8' '10'};
    % blockNums = 3:8;
    % ind2examine = 1:11;

    % RMSEall = zeros([11 11 1]);
    % SvaluesAll = [-0.8];
    % loadStr = {'-8'};
    % blockNums = 3:8;
    % ind2examine = 1;    
    
    RMSEall = zeros([11 11 3]);
    blockNums = 3:8;
    ind2examine = 1:3;     
elseif subjNum==13
    RMSEall = zeros([11 11 3]);
    blockNums = 12:17;
    ind2examine = 1:3; 
elseif subjNum==11
    RMSEall = zeros([11 11 3]);
    ind2examine = 1:3;
    blockNums = 11:16;
elseif subjNum==15
    RMSEall = zeros([11 11 3]);
    ind2examine = 1:3;
    blockNums = 3:8;
elseif subjNum==19
    RMSEall = zeros([11 11 3]);
    ind2examine = 1:3;
    blockNums = 2:7;
elseif subjNum==26
    RMSEall = zeros([11 11 3]);
    ind2examine = 1:3;
    blockNums = 2:7;
elseif subjNum==27
    RMSEall = zeros([11 11 3]);
    ind2examine = 1:3;
    blockNums = 2:7;
elseif subjNum==28
    RMSEall = zeros([11 11 3]);
    ind2examine = 1:3;
    blockNums = 2:7;
elseif subjNum==30    
    RMSEall = zeros([11 11 3]);
    ind2examine = 1:3;
    blockNums = 2:7;
end
trialNumAll = 1:36;
wLunq = [1 -1];
wMunq = [1 -1];
wSunq = [0 -1];
RMSE = [];
defocus875all = [];
defocus875predAll = [];
wvInFocusAll = [];
savePath = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneWeightsError/';

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

for Sindex = 1:length(wSunq)
    for i = 1:length(wLunq)
        for j = 1:length(wMunq)
            wL = wLunq(i);
            wM = wMunq(j);
            wS = wSunq(Sindex);
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
            parfor l = 1:size(rgbUnq,1)
                wvInFocus(l,:) = ARCwvInFocusConesMeanZ(subjNum,l,[wL wM wS]);
                display(['wL = ' num2str(wL) ' wM = ' num2str(wM) ' wS = ' num2str(wS) ' stim ' num2str(l)]);
            end 
            wvInFocusTmp = zeros([length(optDistAll) 1]);
            for l = 1:size(rgbUnq,1)
                indStiml = abs(rgbAll(:,1)-rgbUnq(l,1))<0.001 & ...
                abs(rgbAll(:,2)-rgbUnq(l,2))<0.001 & ...
                abs(rgbAll(:,3)-rgbUnq(l,3))<0.001;
                defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS10(wvInFocus(l),875);
                wvInFocusTmp(indStiml) = wvInFocus(l);
            end
            RMSE(i,j,Sindex) = sqrt(mean((defocus875predTmp(:)-defocus875(:)).^2));
            defocus875predAll(:,i,j,Sindex) = defocus875predTmp;
            defocus875all(:,i,j,Sindex) = defocus875;
            wvInFocusAll(:,i,j,Sindex) = wvInFocusTmp;
        end
    end
    save([savePath 'S' num2str(subjNum) 'wvInFocusModelResults' num2str(round(wSunq(Sindex)*10)) '.mat'],'defocus875all','defocus875predAll','wvInFocusAll','RMSE','wSunq'); 
end

% RMSE(i,j,Sindex) = sqrt(mean((defocus875pred(:)-defocus875(:)).^2));
% defocus875predAll(:,:,i,j,Sindex) = defocus875pred;
% defocus875all(:,:,i,j,Sindex) = defocus875;
% wvInFocusAll(:,:,i,j,Sindex) = wvInFocus;

% %%
% 
% figure; 
% hold on;
% histogram(wvInFocus(1,:),11,'FaceColor','r');
% histogram(wvInFocus(2,:),11,'FaceColor','g');
% histogram(wvInFocus(3,:),11,'FaceColor','b');
