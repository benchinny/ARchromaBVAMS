%% LOADING DATA

defocus875stack = [];
meanv00stack = [];
rgb1stack = [];
wvInFocusStack = [];

filenames = {'/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_1.mat' ...
             '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/imageQualityAnalysis/ARCmodelOutput2_2.mat'};

for i = 1:2
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
plot(stimOptDist,defocus550,'ko','MarkerSize',10,'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',15);
xlabel('Stimulus distance (D)')
ylabel('Defocus at 550nm (D)');
title(['Correlation = ' num2str(corr(stimOptDist,defocus550))]);
xlim([0 4]);
ylim([0 4]);

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
