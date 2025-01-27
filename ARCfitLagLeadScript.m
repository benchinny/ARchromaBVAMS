%%

subjNumAll = [1 3 5 10 16 17 18 20];
bSpatFilter = true;

SvaluesAll = [0 0 -1];
loadStr = {'0' '0' '-10'};    

if bSpatFilter
    coneWeightsFolder = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneWeightsErrorSpatFilter/';
else
    coneWeightsFolder = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneWeightsError/';
end

for i = 1:length(subjNumAll)
    subjNum = subjNumAll(i);
    if subjNum==10
        RMSEall = zeros([2 2 2]);
        blockNums = 3:8;
        ind2examine = 1:3;     
        coordinates2examine = [1 1; 1 2; 1 1];
    elseif subjNum==3
        RMSEall = zeros([2 2 2]);
        blockNums = 12:17;
        ind2examine = 1:3;    
        coordinates2examine = [1 1; 1 2; 1 1];
    elseif subjNum==1
        RMSEall = zeros([2 2 2]);
        ind2examine = 1:3;
        blockNums = 11:16;
        coordinates2examine = [1 1; 1 2; 1 1];
    elseif subjNum==5
        RMSEall = zeros([2 2 2]);
        ind2examine = 1:3;
        blockNums = 3:8;
        coordinates2examine = [1 1; 1 2; 1 1];
    elseif subjNum==9
        RMSEall = zeros([2 2 2]);
        ind2examine = 1:3;
        blockNums = 2:7;
        coordinates2examine = [1 1; 1 2; 1 1];
    elseif subjNum==16
        RMSEall = zeros([2 2 2]);
        ind2examine = 1:3;
        blockNums = 2:7;
        coordinates2examine = [1 1; 1 2; 1 1];
    elseif subjNum==17
        RMSEall = zeros([2 2 2]);
        ind2examine = 1:3;
        blockNums = 2:7;
        coordinates2examine = [1 1; 1 2; 1 1];
    elseif subjNum==18
        RMSEall = zeros([2 2 2]);
        ind2examine = 1:3;
        blockNums = 2:7;
        coordinates2examine = [1 1; 1 2; 1 1];
    elseif subjNum==20    
        RMSEall = zeros([2 2 2]);
        ind2examine = 1:3;
        blockNums = 2:7;
        coordinates2examine = [1 1; 1 2; 1 1];
    end
    rgbAll = [];
    optDistStim = [];
    
    for j = 1:length(blockNums)
        AFCp = ARCloadFileBVAMS(subjNum+10,blockNums(j));
        rgbAll = [rgbAll; AFCp.rgb100];
        optDistStim = [optDistStim; AFCp.meanv00./1.2255];
    end
    
    rgbLumNorm = [];
    rgbLumNorm(:,1) = (rgbAll(:,1).^2.5)./0.2442;
    rgbLumNorm(:,2) = (rgbAll(:,2).^2.7)./0.1037;
    rgbLumNorm(:,3) = (rgbAll(:,3).^2.3)./1;
    rgbLumNorm(rgbLumNorm>1) = 1;

    for j = ind2examine
        load([coneWeightsFolder 'S' num2str(subjNum) 'wvInFocusModelResults' num2str(loadStr{j}) '.mat']);
        RMSEall(:,:,j) = RMSE(:,:,end);
    end

    for j = ind2examine
        RMSEtmp = squeeze(RMSEall(:,:,j)); 
        load([coneWeightsFolder 'S' num2str(subjNum) 'wvInFocusModelResults' num2str(loadStr{j}) '.mat']);
        predD = squeeze(defocus875predAll(:,coordinates2examine(j,1),coordinates2examine(j,2),end))';
        predD = predD(:);
        actD = squeeze(defocus875all(:,coordinates2examine(j,1),coordinates2examine(j,2),end))';
        actD = actD(:); 
        predDall(:,j) = predD;
        actDall(:,j) = actD;        
    end
end