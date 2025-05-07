%% LOADING DATA

function ARCtestWvInFocusMeanZstrehlLMSeffectFitFinch(wS)

objFunc = 'RMS';
defocus875 = [];
optDistAll = [];
rgbAll = [];
rgbUnq = unique(rgbAll,'rows');

%% SEARCH INDIVIDUAL CONE WEIGHTS

wLM = 0.4:0.05:1.4;
wLprop = 0.25:(0.1/3):0.85;
coneWeightsFolder = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneWeightsErrorSpatFilter/colorMechPredictions/';
finchDataFolder = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Meetings/Meeting_April_23/';

finchData = readtable([finchDataFolder 'Finch_data.csv']);

RMSEall = zeros([length(wLM) length(wLprop)]);

for l = 1:length(wLM)
    for k = 1:length(wLprop)
        wL = wLM(l)*wLprop(k);
        wM = wLM(l)-wL;
        [~, defocus875mean, defocus875predTmp, rgbUnq, optDistUnq] = ARCtestWvInFocusMeanZspatFilterPlotHelper(subjNum,defocus875,rgbAll,optDistAll,[wL wM wS]);
        optDistTag = imresize(optDistUnq',size(defocus875mean),'nearest');
        [pFit,RMSE(k)] = ARCfitLagLead(defocus875predTmp(:),defocus875mean(:),optDistTag(:),true,objFunc);
        if k==1
            [pFitFlat,RMSEflat(k)] = ARCfitLagLead(optDistTag(:),defocus875mean(:),optDistTag(:),true,objFunc);
        end
        
        display(['Weights = [' num2str(wL) ' ' num2str(wM) ' ' num2str(wS)]);
    end
    RMSEall(l,:) = RMSE;
end

save([coneWeightsFolder 'S' num2str(subjNum) 'wvInFocusModelResultsFinch' num2str(round(-wS*10)) '.mat'],'RMSEall','wS','wLM','wLprop');

end
