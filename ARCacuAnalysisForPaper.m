%%

subjNum = 20;

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

indBad = cAll(:,4)==0 | cAll(:,4)<-10 | cAll(:,4)>2.5;
meanC = mean(cAll(~indBad,:),1); % TAKE MEAN OF COEFFICIENTS

defocusScaleFactor = 0.5774;

defocusOrig = meanC(4);
defocusOrigScaled = defocusOrig/defocusScaleFactor;

[unqFocDst,PC,PCci,dprime,dprimeCI,PCfit,dprimeFitAll,PCfitSupport] = ARCacuAnalysisSubjective(subjNum,0);
scaleFac = 0.8;

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Meetings/meeting_Sept25/allExp1DataRGB.mat');
indAcc = abs(optDistCndAll+2.5)<0.001 & abs(rgbLumNormCndAll(:,1)-1)<0.001 & ...
         abs(rgbLumNormCndAll(:,3)-1)<0.001 & abs(rgbLumNormCndAll(:,2)-0)<0.001 & ...
         subjNumTag==subjNum;
defocus875acc = mean(defocusAt875cellAll{indAcc});
diff875 = -defocus875acc-defocusOrigScaled;

%%

figure;
hold on;
% plot(unqFocDst.*scaleFac,PC,'o-','Color',rgbUnq,'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
plot(PCfitSupport,PCfit,'-','Color',[0.56 0 1],'LineWidth',1.5);
plot(PCfitSupport+diff875,PCfit,'--','Color',[0.56 0 1],'LineWidth',1.5);
errorbar(unqFocDst.*scaleFac,PC,PC-PCci(1,:),PCci(2,:)-PC,'o','Color',[0.56 0 1],'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
axis square;
ylim([0.4 1]);
xlim([-1.2 1.2]);
formatFigure('Relative optical distance (D)','Proportion Correct',['Subject ' num2str(subjNum) ', D_{acu} = ' num2str(defocusOrigScaled,3) ', D_{acc} = ' num2str(-defocus875acc,3)]);
legend('Acuity','Accommodation');

[~,indPeak] = max(PCfit);
acuPeak = PCfitSupport(indPeak)+diff875;

%%

peakAcuityAll = [-0.7102 -0.4229 0.1432 -0.3498 -0.1546 -0.6124 -0.8071 -0.2844];

figure;
bar(peakAcuityAll,'LineWidth',1,'FaceColor',[0.56 0 1]);
set(gca,'FontSize',15);
set(gca,'XTick',1:8);
set(gca,'XTickLabel',{'S1' 'S3' 'S5' 'S10' 'S16' 'S17' 'S18' 'S20'});
xlabel('Subject');
ylabel('Best acuity relative distance (D)');
ylim([-1 1]);

