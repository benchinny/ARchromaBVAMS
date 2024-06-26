%% LOADING DATA

defocus875stack = [];
meanv00stack = [];
rgb1stack = [];
wvInFocusStack = [];

filenames = {'/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_1.mat' ...
             '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_2.mat' ...
             '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_3.mat'};

for i = 1:4
    load(['/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_' num2str(i) '.mat']);
    % DEFOCUS AT 875nm (RAW FIAT MEASUREMENT)
    defocus875stack = [defocus875stack; defocusBasic];
    % STIMULUS DISTANCE
    meanv00stack = [meanv00stack; meanv00all];
    % STIMULUS COLOR
    rgb1stack = [rgb1stack; rgb1all];
    % WAVELENGTH IN FOCUS
    wvInFocusStack = [wvInFocusStack; wvInFocus2all];
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
    plot(stimOptDist(i),defocus550(i),'o','Color',[redPlot 0 bluePlot],'MarkerSize',10,'MarkerFaceColor',[redPlot 0 bluePlot]);
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

subjNum = 2;

if subjNum==1
    subjName = 'BenChin-OS';
    blockNums = [2 3 4 5 6];
    trialNums = [[1:20]' [1:20]' [1:20]' [1:20]' [1:20]'];
    % blockNums = [2 3];
    % trialNums = [[1:20]' [1:20]']; 
elseif subjNum==2
    subjName = 'S2-OS';
    blockNums = [2 3 4 5 6];
    trialNums = [[1:20]' [1:20]' [1:20]' [1:20]' [1:20]'];
    % blockNums = [2 3];
    % trialNums = [[1:20]' [1:20]'];     
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
    for k = 1:20 % LOOP OVER TRIAL
        % LOADING DATA
        blockNumInd = l;
        blockNumTmp = blockNums(blockNumInd);
        trialNumTmp = trialNums(k,blockNumInd);
        
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
gammaFactorR = 2.4;
gammaFactorB = 2.2;
maxLumCdm2 = 0.40;

deltaR = scaleEquateRB.*rgb2all(:,1).^gammaFactorR - scaleEquateRB.*rgb1all(:,1).^gammaFactorR;
deltaB = rgb2all(:,3).^gammaFactorB - rgb1all(:,3).^gammaFactorB;
% COMPONENTS OF LINEAR REGRESSION
deltaS = v00all*0.87;
delta1 = ones(size(deltaR));
deltaR = deltaR.*maxLumCdm2;
deltaB = deltaB.*maxLumCdm2;
defocusChange = defocusBasic2./defocusCorrectionFactor - defocusBasic./defocusCorrectionFactor;
weightsRBS1 = [deltaR deltaB deltaS]\(defocusChange);

