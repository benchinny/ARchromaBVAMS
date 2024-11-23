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
            for l = 1:size(rgbUnq,1)
                wvInFocus(l,:) = ARCwvInFocusConesMeanZ(subjNum,l,[wL wM wS]);
                indStiml = abs(rgbAll(:,1)-rgbUnq(l,1))<0.001 & ...
                           abs(rgbAll(:,2)-rgbUnq(l,2))<0.001 & ...
                           abs(rgbAll(:,3)-rgbUnq(l,3))<0.001;
                defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS10(wvInFocus(l),875);
                display(['wL = ' num2str(wL) ' wM = ' num2str(wM) ' wS = ' num2str(wS) ' stim ' num2str(l)]);
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
