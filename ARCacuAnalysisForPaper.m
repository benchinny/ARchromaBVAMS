%%

subjNum = 1;

% PARAMETERS OF WAVEFRONT ANALYSIS
PARAMS.PupilSize = 7; %default values - will be replaced depending on choices below
PARAMS.PupilFieldSize =6; %default values - will be replaced depending on choices below
PARAMS.PupilFitSize = 7; %default values - will be replaced depending on choices below

wvfFiles = ARCacuAnalysisWvfSubj(subjNum);

dataFolder = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/csvFiles/SUBJ/';

cAll = [];

for i = 1:length(wvfFiles)
    ZernikeTable = readtable([dataFolder wvfFiles{i}]);
    NumCoeffs = width(ZernikeTable)-8; % determine how many coefficients are in the cvs file. 
    c=zeros(size(ZernikeTable,1),65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65. 
    PARAMS = struct;
    PARAMS.PupilSize=mean(table2array(ZernikeTable(:,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
    PARAMS.PupilFitSize=mean(table2array(ZernikeTable(:,5))); 
    PARAMS.PupilFieldSize=PARAMS.PupilSize*2; %automatically compute the field size
    c(:,3:NumCoeffs)=table2array(ZernikeTable(:,11:width(ZernikeTable)));
    cAll = [cAll; c];
end

indBad = cAll(:,4)==0 | cAll(:,4)<-10;
meanC = mean(cAll(~indBad,:),1); % TAKE MEAN OF COEFFICIENTS

defocusScaleFactor = 0.5774;

defocusOrig = meanC(4);
defocusOrigScaled = defocusOrig/defocusScaleFactor;

[unqFocDst,PC,PCci,dprime,PCfit,dprimeFitAll,PCfitSupport] = ARCacuAnalysisSubjective(subjNum);
scaleFac = 0.8;

figure;
hold on;
% plot(unqFocDst.*scaleFac,PC,'o-','Color',rgbUnq,'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
plot(PCfitSupport,PCfit,'-','Color',[0.56 0 1],'LineWidth',1.5);
errorbar(unqFocDst.*scaleFac,PC,PC-PCci(1,:),PCci(2,:)-PC,'o','Color',[0.56 0 1],'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
axis square;
ylim([0.4 1]);
formatFigure('Relative optical distance (D)','Proportion Correct',['Subject ' num2str(subjNum) ', D_{acu} = ' num2str(defocusOrigScaled,3)]);

