%% LOADING DATA

defocus875stack = [];
meanv00stack = [];
rgb1stack = [];
wvInFocusStack = [];

filenames = {'/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_1.mat' ...
             '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_2.mat' ...
             '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_3.mat'};

for i = 1:5
    load(['/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_' num2str(i) 'nogreen.mat']);
    % DEFOCUS AT 875nm (RAW FIAT MEASUREMENT)
    defocus875stack = [defocus875stack; defocusBasic];
    % STIMULUS DISTANCE
    meanv00stack = [meanv00stack; meanv00all];
    % STIMULUS COLOR
    rgb1stack = [rgb1stack; rgb1all];
    if exist('wvInFocus2all','var')
        wvInFocusStack = [wvInFocusStack; wvInFocus2all];
    else
        % WAVELENGTH IN FOCUS
        wvInFocusStack = [wvInFocusStack; wvInFocus1all];
    end
end

%% STIMULUS DISTANCE VS ESTIMATED DEFOCUS AT 550nm

% CORRECTION FACTOR THAT IS ALSO IN AUSTIN'S CODE
defocusCorrectionFactor = 0.57735;

% CORRECTING FOR BVAMS RE-CALIBRATION (TOOK DATA BEFORE RE-CALIBRATION)
stimOptDist = meanv00stack*0.87-0.46;

% ESTIMATING DEFOCUS AT 550
defocus550 = defocus875stack/defocusCorrectionFactor -(humanWaveDefocus(550)-humanWaveDefocus(875));

figure; 
plot([0 4],[0 4],'k--'); hold on;
colorRB = [];
colorRGB = [];
lumScaleR = 1/(0.555^2.4);
lumScaleG = 1/(0.418^2.6);
for i = 1:length(stimOptDist)
    redGam = rgb1stack(i,1).^2.4;
    blueGam = rgb1stack(i,3).^2.2;
    greenGam = rgb1stack(i,2).^2.6;
    redPlot = lumScaleR*redGam/(lumScaleR*redGam+blueGam);
    bluePlot = blueGam/(lumScaleR*redGam+blueGam);
    redStore = lumScaleR*redGam/(lumScaleR*redGam+lumScaleG*greenGam+blueGam);
    greenStore = lumScaleG*greenGam/(lumScaleR*redGam+lumScaleG*greenGam+blueGam);
    blueStore = blueGam/(lumScaleR*redGam+lumScaleG*greenGam+blueGam);
    colorRB(i,:) = [redPlot 0 bluePlot];
    colorRGB(i,:) = [redStore greenStore blueStore];
    plot(stimOptDist(i),defocus550(i),'o','Color',rgb1stack(i,:),'MarkerSize',10,'MarkerFaceColor',rgb1stack(i,:));
end
axis square;
set(gca,'FontSize',15);
xlabel('Stimulus distance (D)')
ylabel('Defocus at 550nm (D)');
title(['Correlation = ' num2str(corr(stimOptDist,defocus550))]);
xlim([0 4]);
ylim([0 4]);

%%  

stimOptDistUnq = unique(stimOptDist);

indSanityCheck = 1;

indOptDist = abs(stimOptDist-stimOptDistUnq(indSanityCheck))<0.001;

defocusSanityCheck = defocus550(indOptDist)-mean(defocus550(indOptDist));   

%% PREDICTIONS VS DEFOCUS AT 875nm

% PREDICTION IS BASICALLY WORKS THIS WAY: TAKE STIMULUS OPTICAL DISTANCE,
% THEN ADD THE DEFOCUS DISCREPANCY BETWEEN THE WAVELENGTH YIELDING BEST
% FOCUS AND 875nm 
colorBasedPrediction = stimOptDist+(humanWaveDefocus(wvInFocusStack)-humanWaveDefocus(875));

figure; 
plot([0 4],[0 4],'k--'); hold on;
plot(colorBasedPrediction,defocus875stack./defocusCorrectionFactor,'ko','MarkerSize',10,'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Image Quality Prediction (D)')
ylabel('Defocus at 875nm (D)');
title(['Correlation = ' num2str(corr(colorBasedPrediction,defocus875stack./defocusCorrectionFactor))]);
xlim([0 4]);
ylim([0 4]);

%%

subjNum = 1;

if subjNum==1
    subjName = 'BenChin-OS';
    blockNums = [2 3 4 5 6];
    trialNums = {[1:20]' [1:20]' [1:20]' [1:20]' [ 1:20]'};
    % blockNums = [2 3];
    % trialNums = [[1:20]' [1:20]']; 
    limVals = [-2 2];
elseif subjNum==2
    subjName = 'S2-OS';
    blockNums = [2 3 4 5 6];
    trialNums = {[1:20]' [1:20]' [1:20]' [1:20]' [1:20]'};
    % blockNums = [2 3];
    % trialNums = [[1:20]' [1:20]'];     
    limVals = [-2 2];
end

wvInFocus1all = [];
meanv00all = [];
v00all = [];
rgb1all = [];
rgb2all = [];
defocusBasic = [];
defocusBasic2 = [];
defocus875stack = [];
% STIMULUS DISTANCE
meanv00stack = [];
% STIMULUS COLOR
rgb1stack = [];
% CORRECTION FACTOR THAT IS ALSO IN AUSTIN'S CODE
defocusCorrectionFactor = 0.57735;

for l = 1:length(blockNums) % LOOP OVER BLOCK
    trialsTmp = trialNums{l};
    for k = 1:length(trialsTmp) % LOOP OVER TRIAL
        % LOADING DATA
        blockNumInd = l;
        blockNumTmp = blockNums(blockNumInd);
        trialNumTmp = trialsTmp(k);
        
        AFCp = ARCloadFileBVAMS(subjNum,blockNumTmp); % LOAD BVAMS DATA
        % LOAD ZERNIKE TABLE AND TIMESTAMPS
        [ZernikeTable, ~, ~, TimeStamp] = ARCloadFileFIAT(subjName,blockNumTmp,trialNumTmp,0);
        % GET THE TIMESTAMP CORRESPONDING TO THE HALFWAY POINT
        t = seconds(TimeStamp)-min(seconds(TimeStamp));
        tHalfway = max(t)/2;
        tDiffFromHalfway = abs(t-tHalfway);
        [~,indMinT] = min(tDiffFromHalfway);
        FrameStart = (indMinT-29):indMinT; % analyze 30 frames
        FrameEnd = (length(t)-29):length(t);

        NumCoeffs = width(ZernikeTable)-8; % determine how many coefficients are in the cvs file. 
        c=zeros(30,65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65. 
        PARAMS.PupilSize=mean(table2array(ZernikeTable(FrameStart,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
        PARAMS.PupilFitSize=mean(table2array(ZernikeTable(FrameStart,5))); 
        PARAMS.PupilFieldSize=PARAMS.PupilSize*2; %automatically compute the field size
        c(:,3:NumCoeffs)=table2array(ZernikeTable(FrameStart,11:width(ZernikeTable)));
        meanC = mean(c,1); % TAKE MEAN OF COEFFICIENTS
        
        c2=zeros(30,65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65. 
        PARAMS2.PupilSize=mean(table2array(ZernikeTable(FrameEnd,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
        PARAMS2.PupilFitSize=mean(table2array(ZernikeTable(FrameEnd,5))); 
        PARAMS2.PupilFieldSize=PARAMS2.PupilSize*2; %automatically compute the field size
        c2(:,3:NumCoeffs)=table2array(ZernikeTable(FrameEnd,11:width(ZernikeTable)));
        meanC2 = mean(c2,1); % TAKE MEAN OF COEFFICIENTS   

        % STORE COLORS FOR FIRST AND SECOND STIMULI
        rgb00 = [];
        rgb00(1,:) = AFCp.rgb100(trialNumTmp,:);
        rgb00(2,:) = AFCp.rgb200(trialNumTmp,:);
        defocusBasic(end+1,:) = meanC(4);
        defocusBasic2(end+1,:) = meanC2(4);
        rgb1all(end+1,:) = AFCp.rgb100(trialNumTmp,:);
        rgb2all(end+1,:) = AFCp.rgb200(trialNumTmp,:);
        meanv00all(end+1,:) = AFCp.meanv00(trialNumTmp);
        v00all(end+1,:) = AFCp.v00(trialNumTmp);

        defocus875stack(end+1,:) = meanC(4);
        meanv00stack(end+1,:) = AFCp.meanv00(trialNumTmp);
        rgb1stack(end+1,:) = AFCp.rgb100(trialNumTmp,:);
    end
end

%%

scaleEquateRB = 4.1086;
scaleEquateRG = 9.6592;
gammaFactorR = 2.4;
gammaFactorG = 2.6;
gammaFactorB = 2.2;
maxLumCdm2 = 0.40;

deltaR = scaleEquateRB.*rgb2all(:,1).^gammaFactorR - scaleEquateRB.*rgb1all(:,1).^gammaFactorR;
deltaG = scaleEquateRG.*rgb2all(:,2).^gammaFactorG - scaleEquateRG.*rgb1all(:,2).^gammaFactorG;
deltaB = rgb2all(:,3).^gammaFactorB - rgb1all(:,3).^gammaFactorB;
% COMPONENTS OF LINEAR REGRESSION
deltaS = v00all*0.87;
delta1 = ones(size(deltaR));
deltaR = deltaR.*maxLumCdm2;
deltaB = deltaB.*maxLumCdm2;
deltaG = deltaG.*maxLumCdm2;
defocusChange = defocusBasic2./defocusCorrectionFactor - defocusBasic./defocusCorrectionFactor;
weightsRBS1 = [deltaR deltaB deltaS]\(defocusChange);

% COMPUTING CORRELATIONS BETWEEN DIFFERENT MODEL PREDICTIONS AND DATA
rhoFull = corr([deltaR deltaB deltaS]*weightsRBS1,defocusChange);
rhoNoColor = corr([deltaS]*weightsRBS1(3),defocusChange);
rhoColor = corr([deltaR deltaB]*weightsRBS1(1:2),defocusChange);

nParams = 4;
nParamsNoColor = 2;

% COMPUTING COMPONENETS FOR AIC
trialMeans = [deltaR deltaB deltaS]*weightsRBS1;
errorIndividual = defocusChange - trialMeans;
for i = 1:100
   [stdTmp(i),LLtmp(i)] = ARCfitStdGauss(errorIndividual);
end
[~,bestInd] = min(LLtmp);
estResidualStd = stdTmp(bestInd);
LL = sum(log(normpdf(defocusChange,trialMeans,estResidualStd)));
aic = 2*nParams-2*LL;

% COMPUTING COMPONENTS FOR AIC FOR NO-COLOR MODEL
trialMeansNoColor = [deltaS]*weightsRBS1(3);
errorIndividualNoColor = defocusChange - trialMeansNoColor;
for i = 1:100
   [stdTmp(i),LLtmp(i)] = ARCfitStdGauss(errorIndividualNoColor);
end
[~,bestInd] = min(LLtmp);
estResidualStdNoColor = stdTmp(bestInd);
LLnoColor = sum(log(normpdf(defocusChange,trialMeansNoColor,estResidualStdNoColor)));
aicNoColor = 2*nParamsNoColor-2*LLnoColor;

figure;
set(gcf,'Position',[189 395 1280 420]);
subplot(1,2,1);
%    plot([deltaR deltaB deltaS]*weightsRBS1_x,defocusChange,'ko','LineWidth',1);
predictionTmp = [deltaR deltaB deltaS]*weightsRBS1;
hold on;
for i = 1:length(predictionTmp)
    deltaRtmp = (1/maxLumCdm2)*deltaR(i);
    deltaBtmp = (1/maxLumCdm2)*deltaB(i);
    RBratio = 0.25.*(deltaRtmp-deltaBtmp+2);
    RBratio
    plot(predictionTmp(i),defocusChange(i),'o','LineWidth',1,'Color',[RBratio 0 1-RBratio],'MarkerFaceColor',[RBratio 0 1-RBratio]);
    % plot(predictionTmp(i),defocusChange(i),'o','LineWidth',1,'Color','k','MarkerFaceColor','w');
end    
plot(limVals,limVals,'k--');
xlim(limVals);
ylim(limVals);
set(gca,'FontSize',15);
xlabel('Prediction \DeltaA');
ylabel('Measured \DeltaA');
title(['Correlation = ' num2str(rhoFull,3)]);
axis square;

subplot(1,2,2);
hold on;
bar(1,weightsRBS1(1),'FaceColor','r');
bar(2,weightsRBS1(2),'FaceColor','b');
bar(3,weightsRBS1(3),'FaceColor','k');
set(gca,'XTick',[1 2 3]);
set(gca,'XTickLabel',{'Red' 'Blue' 'D_{opt}'});
title('Weights');
set(gca,'FontSize',20);
ylim(max(weightsRBS1).*[-1.2 1.2]);
axis square;

figure;
set(gcf,'Position',[189 395 1280 420]);
subplot(1,2,1);
% plot([deltaS]*weightsS1_x,defocusChange,'ko','LineWidth',1);
predictionTmp = [deltaS]*weightsRBS1(3);
hold on;
for i = 1:length(predictionTmp)
    deltaRtmp = (1/maxLumCdm2)*deltaR(i);
    deltaBtmp = (1/maxLumCdm2)*deltaB(i);
    RBratio = 0.25.*(deltaRtmp-deltaBtmp+2);
    RBratio
    plot(predictionTmp(i),defocusChange(i),'o','LineWidth',1,'Color',[RBratio 0 1-RBratio],'MarkerFaceColor',[RBratio 0 1-RBratio]);
    % plot(predictionTmp(i),defocusChange(i),'o','LineWidth',1,'Color','k','MarkerFaceColor','w');
end
plot(limVals,limVals,'k--');
xlim(limVals);
ylim(limVals);
set(gca,'FontSize',15);
xlabel('Prediction \DeltaA');
ylabel('Measured \DeltaA');
title(['Correlation = ' num2str(rhoNoColor,3)]);
axis square;

subplot(1,2,2);
hold on;
bar(1,weightsRBS1(3),'FaceColor','k');
set(gca,'XTick',[1 2]);
set(gca,'XTickLabel',{'D_{opt}'});
title('Weights');
set(gca,'FontSize',20);
ylim(max(weightsRBS1(3)).*[-1.2 1.2]);
axis square;

%% LINEAR MODEL WITHOUT COLOR

% MEASURED ACCOMMODATIVE STATE AT 875nm
A = defocus875stack./defocusCorrectionFactor;
% STIMULUS OPTICAL DISTANCE--ASSOCIATE IT WITH IR? WHY? NOT SURE. 
S = meanv00stack.*0.87-0.46;

regWeights = [S ones(size(S))]\A;

predictionNoColor = [S ones(size(S))]*regWeights;

figure;
hold on;
for i = 1:length(A)
    plot(predictionNoColor(i),A(i),'o','MarkerFaceColor',rgb1stack(i,:),'Color',rgb1stack(i,:));
end
axis square;
set(gca,'FontSize',15);
xlabel('Prediction');
ylabel('Actual');

%% LINEAR MODEL WITH COLOR

% MEASURED ACCOMMODATIVE STATE AT 875nm
A = defocus875stack./defocusCorrectionFactor;
% STIMULUS OPTICAL DISTANCE--ASSOCIATE IT WITH IR? WHY? NOT SURE. 
S = meanv00stack.*0.87-0.46;
% LUMINANCES
lumR1 = 0.4.*(rgb1stack(:,1).^(2.4)).*scaleEquateRB;
lumG1 = 0.4.*(rgb1stack(:,2).^(2.6)).*scaleEquateRG;
lumB1 = 0.4.*(rgb1stack(:,3).^(2.2)).*1;
% 'OPTICAL DISTANCES' FOR EACH COLOR--DUNNO WHAT IT MEANS
d_r = humanWaveDefocus(875)-humanWaveDefocus(620);
d_g = humanWaveDefocus(875)-humanWaveDefocus(532);
d_b = humanWaveDefocus(875)-humanWaveDefocus(460);

regWeights = [S ones(size(S)) lumR1*d_r lumG1*d_g lumB1*d_b]\A;
predictionColor = [S ones(size(S)) lumR1*d_r lumG1*d_g lumB1*d_b]*regWeights;

figure;
hold on;
for i = 1:length(A)
    plot(predictionColor(i),A(i),'o','MarkerFaceColor',rgb1stack(i,:),'Color',rgb1stack(i,:));
end
axis square;
set(gca,'FontSize',15);
xlabel('Prediction');
ylabel('Actual');

figure;
hold on;
bar(1,regWeights(1),'FaceColor','k');
bar(2,regWeights(2),'FaceColor',[0.7 0.7 0.7]);
bar(3,regWeights(3),'FaceColor','r');
bar(4,regWeights(4),'FaceColor','g');
bar(5,regWeights(5),'FaceColor','b');
set(gca,'XTick',[]);
set(gca,'FontSize',15)

%% LOAD TRIALS FROM 'FIXED' CONDITIONS

subjNum = 1;

if subjNum==1
    subjName = 'BenChin-OD';
    blockNums = [8];
    trialNums = {[1:30]'};
    % blockNums = [2 3];
    % trialNums = [[1:20]' [1:20]']; 
    limVals = [-2 2];
elseif subjNum==2
    subjName = 'S2-OS';
    blockNums = [2 3 4 5 6];
    trialNums = {[1:20]' [1:20]' [1:20]' [1:20]' [1:20]'};
    % blockNums = [2 3];
    % trialNums = [[1:20]' [1:20]'];     
    limVals = [-2 2];
end

wvInFocus1all = [];
meanv00all = [];
v00all = [];
rgb1all = [];
rgb2all = [];
defocusBasic = [];
defocusBasic2 = [];
defocus875stack = [];
defocus875stack2 = [];
% STIMULUS DISTANCE
meanv00stack = [];
meanv01stack = [];
% STIMULUS COLOR
rgb1stack = [];
rgb2stack = [];
% CORRECTION FACTOR THAT IS ALSO IN AUSTIN'S CODE
defocusCorrectionFactor = 0.57735;

for l = 1:length(blockNums) % LOOP OVER BLOCK
    trialsTmp = trialNums{l};
    for k = 1:length(trialsTmp) % LOOP OVER TRIAL
        % LOADING DATA
        blockNumInd = l;
        blockNumTmp = blockNums(blockNumInd);
        trialNumTmp = trialsTmp(k);
        
        AFCp = ARCloadFileBVAMS(subjNum,blockNumTmp); % LOAD BVAMS DATA
        % LOAD ZERNIKE TABLE AND TIMESTAMPS
        [ZernikeTable, ~, ~, TimeStamp] = ARCloadFileFIAT(subjName,blockNumTmp,trialNumTmp,0);
        % GET THE TIMESTAMP CORRESPONDING TO THE HALFWAY POINT
        t = seconds(TimeStamp)-min(seconds(TimeStamp));
        tHalfway = max(t)/2;
        tDiffFromHalfway = abs(t-tHalfway);
        [~,indMinT] = min(tDiffFromHalfway);
        FrameStart = (indMinT-29):indMinT; % analyze 30 frames
        FrameEnd = (length(t)-29):length(t);

        NumCoeffs = width(ZernikeTable)-8; % determine how many coefficients are in the cvs file. 
        c=zeros(30,65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65. 
        PARAMS.PupilSize=mean(table2array(ZernikeTable(FrameStart,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
        PARAMS.PupilFitSize=mean(table2array(ZernikeTable(FrameStart,5))); 
        PARAMS.PupilFieldSize=PARAMS.PupilSize*2; %automatically compute the field size
        c(:,3:NumCoeffs)=table2array(ZernikeTable(FrameStart,11:width(ZernikeTable)));
        meanC = mean(c,1); % TAKE MEAN OF COEFFICIENTS
        
        c2=zeros(30,65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65. 
        PARAMS2.PupilSize=mean(table2array(ZernikeTable(FrameEnd,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
        PARAMS2.PupilFitSize=mean(table2array(ZernikeTable(FrameEnd,5))); 
        PARAMS2.PupilFieldSize=PARAMS2.PupilSize*2; %automatically compute the field size
        c2(:,3:NumCoeffs)=table2array(ZernikeTable(FrameEnd,11:width(ZernikeTable)));
        meanC2 = mean(c2,1); % TAKE MEAN OF COEFFICIENTS   

        % STORE COLORS FOR FIRST AND SECOND STIMULI
        rgb00 = [];
        rgb00(1,:) = AFCp.rgb100(trialNumTmp,:);
        rgb00(2,:) = AFCp.rgb200(trialNumTmp,:);
        defocusBasic(end+1,:) = meanC(4);
        defocusBasic2(end+1,:) = meanC2(4);
        rgb1all(end+1,:) = AFCp.rgb100(trialNumTmp,:);
        rgb2all(end+1,:) = AFCp.rgb200(trialNumTmp,:);
        meanv00all(end+1,:) = AFCp.meanv00(trialNumTmp);
        v00all(end+1,:) = AFCp.v00(trialNumTmp);

        defocus875stack(end+1,:) = meanC(4);
        defocus875stack2(end+1,:) = meanC2(4);
        meanv00stack(end+1,:) = AFCp.meanv00(trialNumTmp);
        rgb1stack(end+1,:) = AFCp.rgb100(trialNumTmp,:);
        rgb2stack(end+1,:) = AFCp.rgb200(trialNumTmp,:);
        meanv01stack(end+1,:) = AFCp.meanv00(trialNumTmp)+AFCp.v00(trialNumTmp);
    end
end

%%

rgb1unq = unique(rgb1stack,'rows');

figure;
hold on;
for i = 1:size(rgb1unq,1)
    ind = abs(rgb1stack(:,1)-rgb1unq(i,1))<0.001 & ...
          abs(rgb1stack(:,2)-rgb1unq(i,2))<0.001 & ...
          abs(rgb1stack(:,3)-rgb1unq(i,3))<0.001;

    plot(i.*ones([sum(ind) 1]),defocus875stack(ind)./defocusCorrectionFactor,'o','Color',rgb1unq(i,:),'MarkerFaceColor',rgb1unq(i,:));
end
ylim([0 3]);
set(gca,'XTick',1:3);
set(gca,'XTickLabel','');
xlim([0.5 3.5]);
set(gca,'FontSize',15);
ylabel('Accommodative response at 875nm (D)');

%%

rgb2unq = unique([rgb2stack meanv01stack],'rows');

figure;
hold on;
for i = 1:size(rgb2unq,1)
    ind = abs(rgb2stack(:,1)-rgb2unq(i,1))<0.001 & ...
          abs(rgb2stack(:,2)-rgb2unq(i,2))<0.001 & ...
          abs(rgb2stack(:,3)-rgb2unq(i,3))<0.001 & ...
          abs(meanv01stack-rgb2unq(i,4))<0.001;

    plot(i.*ones([sum(ind) 1]),defocus875stack2(ind)./defocusCorrectionFactor,'o','Color',rgb2unq(i,1:3),'MarkerFaceColor',rgb2unq(i,1:3));
end
ylim([0 3]);
set(gca,'XTick',1:3);
set(gca,'XTickLabel','');
xlim([0.5 6.5]);
set(gca,'FontSize',15);
ylabel('Accommodative response at 875nm (D)');
