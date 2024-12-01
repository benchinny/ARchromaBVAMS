%%

clear;

%% LOADING DATA FROM SUBJECTS AND CONCATENATING

subjNumAll = [1 3 5 9 10 16 17 18 20];

wvInFocusCellAll = {};
defocusAt550cellAll = {};
optDistCndAll = [];
rgbLumNormCndAll = [];

for i = 1:length(subjNumAll)
    [wvInFocusCell, defocusAt550cell, optDistCnd, rgbLumNormCnd] = ARCnlz_mainExpSortColor(subjNumAll(i)+10);
    wvInFocusCellAll = [wvInFocusCellAll wvInFocusCell];
    defocusAt550cellAll = [defocusAt550cellAll defocusAt550cell];
    optDistCndAll = [optDistCndAll; optDistCnd];
    rgbLumNormCndAll = [rgbLumNormCndAll; rgbLumNormCnd];
end

%%

save('/Users/benjaminchin/Documents/allExp1DataRGB.mat','wvInFocusCellAll','defocusAt550cellAll','optDistCndAll','rgbLumNormCndAll');

%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Meetings/meeting_Sept25/allExp1DataRGB.mat');

%%

rgbLumNormCndUnq = unique(rgbLumNormCndAll,'rows');
defocusAt550objDistCenteredCell = {};

for i = 1:size(rgbLumNormCndUnq,1)
    % GET ALL CELL INDICES WITH UNIQUE COLOR
    indRgbLumNormCnd = find(abs(rgbLumNormCndAll(:,1)-rgbLumNormCndUnq(i,1))<0.001 & ...
                            abs(rgbLumNormCndAll(:,2)-rgbLumNormCndUnq(i,2))<0.001 & ...
                            abs(rgbLumNormCndAll(:,3)-rgbLumNormCndUnq(i,3))<0.001);
    defocusAt550objDistCentered = [];
    for j = 1:length(indRgbLumNormCnd)
        defocusAt550objDistCentered = [defocusAt550objDistCentered; defocusAt550cellAll{indRgbLumNormCnd(j)}-optDistCndAll(indRgbLumNormCnd(j))];
    end
    defocusAt550objDistCenteredCell{i} = defocusAt550objDistCentered;
end
