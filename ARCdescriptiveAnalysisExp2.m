%% LOADING DATA FOR ORIGINAL ANALYSIS

subjNum = 2;

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

for l = 1:5 % LOOP OVER BLOCK
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
        indBad = c(:,4)==0;
        c(indBad,4) = mean(c(~indBad,4));
        meanC = mean(c,1); % TAKE MEAN OF COEFFICIENTS
        
        c2=zeros(30,65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65. 
        PARAMS2.PupilSize=mean(table2array(ZernikeTable(FrameEnd,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
        PARAMS2.PupilFitSize=mean(table2array(ZernikeTable(FrameEnd,5))); 
        PARAMS2.PupilFieldSize=PARAMS2.PupilSize*2; %automatically compute the field size
        c2(:,3:NumCoeffs)=table2array(ZernikeTable(FrameEnd,11:width(ZernikeTable)));
        indBad = c2(:,4)==0;
        c2(indBad,4) = mean(c2(~indBad,4));        
        meanC2 = mean(c2,1); % TAKE MEAN OF COEFFICIENTS   

        % figure;
        % subplot(1,1,1);
        % plot(c2(:,4));
        % title(['Block ' num2str(blockNumTmp) ', Trial ' num2str(trialNumTmp)]);
        % ylim([0 2]);
        % pause;
        % close;

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

% ORIGINAL ANALYSIS

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
deltaR = deltaR(1:100);
deltaB = deltaB(1:100);
deltaS = deltaS(1:100);
defocusChange = defocusChange(1:100);
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
