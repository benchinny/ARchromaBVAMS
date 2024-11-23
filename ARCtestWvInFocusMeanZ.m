%%

subjNum = 10;
if subjNum==10
    subjName = 'S20-OD';
end
blockNumAll = 3:8;
trialNumAll = 1:36;
wLunq = 1;
wMunq = 1;
wSunq = 0;
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
            defocus875 = zeros([length(blockNumAll) length(trialNumAll)]);
            defocus875pred = zeros([length(blockNumAll) length(trialNumAll)]); 
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
            for l = 1:size(rgbUnq,1)
                indStiml = abs(rgbAll(:,1)-rgbUnq(l,1))<0.001 & ...
                abs(rgbAll(:,2)-rgbUnq(l,2))<0.001 & ...
                abs(rgbAll(:,3)-rgbUnq(l,3))<0.001;
                defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS10(wvInFocus(l),875);
            end
        end
    end
    % save([savePath 'wvInFocusModelResults' num2str(round(wSunq(Sindex)*10)) '.mat'],'defocus875all','defocus875predAll','wvInFocusAll','RMSE','wSunq'); 
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
