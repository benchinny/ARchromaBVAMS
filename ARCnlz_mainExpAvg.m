%%

clear;

%% LOADING DATA FROM SUBJECTS AND CONCATENATING

subjNumAll = [1 3 5 9 10 16 17 18 20];

wvInFocusCellAll = {};
defocusAt550cellAll = {};
optDistCndAll = [];
rgbLumNormCndAll = [];
subjNumTag = [];

for i = 1:length(subjNumAll)
    [wvInFocusCell, defocusAt550cell, optDistCnd, rgbLumNormCnd] = ARCnlz_mainExpSortColor(subjNumAll(i)+10);
    wvInFocusCellAll = [wvInFocusCellAll wvInFocusCell];
    defocusAt550cellAll = [defocusAt550cellAll defocusAt550cell];
    optDistCndAll = [optDistCndAll; optDistCnd];
    rgbLumNormCndAll = [rgbLumNormCndAll; rgbLumNormCnd];
    subjNumTag = [subjNumTag; subjNumAll(i).*ones([size(optDistCnd,1) 1])];
end

%%

save('/Users/benjaminchin/Documents/allExp1DataRGB.mat','wvInFocusCellAll','defocusAt550cellAll','optDistCndAll','rgbLumNormCndAll','subjNumTag');

%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Meetings/meeting_Sept25/allExp1DataRGB.mat');

%% SEPARATE TRIALS

rgbLumNormCndUnq = [0.2500         0    1.0000; ...
                    0.5000         0    1.0000; ...
                    1.0000         0    1.0000; ...
                    1.0000         0    0.5000; ...
                    1.0000         0    0.2500; ...
                    0.2500    0.5000    1.0000; ...
                    0.5000    0.5000    1.0000; ...
                    1.0000    0.5000    1.0000; ...
                    1.0000    0.5000    0.5000; ...
                    1.0000    0.5000    0.2500; ...
                    1.0000    1.0000    1.0000];

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

figure;
set(gcf,'Position',[353 426 988 420]);
subplot(1,2,1);
hold on;
for i = 1:5 % size(rgbLumNormCndUnq,1)
    plot(i,mean(defocusAt550objDistCenteredCell{i}),'ko','MarkerFaceColor', ...
        rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
end
for i = 1:5 %size(rgbLumNormCndUnq,1)
    CIrgb = quantile(defocusAt550objDistCenteredCell{i},[0.16 0.84]);
    errorbar(i,mean(defocusAt550objDistCenteredCell{i}), ...
             mean(defocusAt550objDistCenteredCell{i})-CIrgb(1), ...
             CIrgb(2)-mean(defocusAt550objDistCenteredCell{i}),'ko','MarkerFaceColor', ...
            rgbLumNormCndUnq(i,:),'Color',rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
end
axis square;
formatFigure('Color Condition','Relative defocus (D)');
xlim([0.5 5.5]);
subplot(1,2,2);
hold on;
for i = 1:5 % size(rgbLumNormCndUnq,1)
    plot(i,mean(defocusAt550objDistCenteredCell{i+5}),'ko','MarkerFaceColor', ...
        rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
end
for i = 1:5 %size(rgbLumNormCndUnq,1)
    CIrgb = quantile(defocusAt550objDistCenteredCell{i+5},[0.16 0.84]);
    errorbar(i,mean(defocusAt550objDistCenteredCell{i+5}), ...
             mean(defocusAt550objDistCenteredCell{i+5})-CIrgb(1), ...
             CIrgb(2)-mean(defocusAt550objDistCenteredCell{i+5}),'ko','MarkerFaceColor', ...
            rgbLumNormCndUnq(i+5,:),'Color',rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
end
axis square;
formatFigure('Color Condition','Relative defocus (D)');
xlim([0.5 5.5]);

%% ONE DATA POINT PER SUBJECT

rgbLumNormCndUnq = [0.2500         0    1.0000; ...
                    0.5000         0    1.0000; ...
                    1.0000         0    1.0000; ...
                    1.0000         0    0.5000; ...
                    1.0000         0    0.2500; ...
                    0.2500    0.5000    1.0000; ...
                    0.5000    0.5000    1.0000; ...
                    1.0000    0.5000    1.0000; ...
                    1.0000    0.5000    0.5000; ...
                    1.0000    0.5000    0.2500; ...
                    1.0000    1.0000    1.0000];

defocusAt550objDistCenteredCell = {};

for i = 1:size(rgbLumNormCndUnq,1)
    % GET ALL CELL INDICES WITH UNIQUE COLOR
    indRgbLumNormCnd = find(abs(rgbLumNormCndAll(:,1)-rgbLumNormCndUnq(i,1))<0.001 & ...
                            abs(rgbLumNormCndAll(:,2)-rgbLumNormCndUnq(i,2))<0.001 & ...
                            abs(rgbLumNormCndAll(:,3)-rgbLumNormCndUnq(i,3))<0.001);
    defocusAt550objDistCentered = [];
    subjNumTagInd = subjNumTag(indRgbLumNormCnd);
    subjNumTagTmp = [];
    for j = 1:length(indRgbLumNormCnd)
        defocusAt550objDistCentered = [defocusAt550objDistCentered; defocusAt550cellAll{indRgbLumNormCnd(j)}-optDistCndAll(indRgbLumNormCnd(j))];
        subjNumTagTmp = [subjNumTagTmp; subjNumTagInd(j).*ones(size(defocusAt550cellAll{indRgbLumNormCnd(j)}))];
    end
    subjNumTagUnq = unique(subjNumTagTmp);
    defocusAt550objDistCenteredAvg = [];
    for j = 1:length(subjNumTagUnq)
        defocusAt550objDistCenteredAvg(j) = mean(defocusAt550objDistCentered(subjNumTagTmp==subjNumTagUnq(j)));
    end
    defocusAt550objDistCenteredCell{i} = defocusAt550objDistCenteredAvg;
end

figure;
set(gcf,'Position',[353 426 988 420]);
subplot(1,2,1);
hold on;
for i = 1:5 % size(rgbLumNormCndUnq,1)
    plot(i,mean(defocusAt550objDistCenteredCell{i}),'ko','MarkerFaceColor', ...
        rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
end
for i = 1:5 %size(rgbLumNormCndUnq,1)
    errorbar(i,mean(defocusAt550objDistCenteredCell{i}), ...
             std(defocusAt550objDistCenteredCell{i}),'ko','MarkerFaceColor', ...
            rgbLumNormCndUnq(i,:),'Color',rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
end
axis square;
formatFigure('Color Condition','Relative defocus (D)');
xlim([0.5 5.5]);
ylim([-0.6 0.4]);
subplot(1,2,2);
hold on;
for i = 1:5 % size(rgbLumNormCndUnq,1)
    plot(i,mean(defocusAt550objDistCenteredCell{i+5}),'ko','MarkerFaceColor', ...
        rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
end
for i = 1:5 %size(rgbLumNormCndUnq,1)
    errorbar(i,mean(defocusAt550objDistCenteredCell{i+5}), ...
             std(defocusAt550objDistCenteredCell{i+5}),'ko','MarkerFaceColor', ...
            rgbLumNormCndUnq(i+5,:),'Color',rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
end
axis square;
formatFigure('Color Condition','Relative defocus (D)');
xlim([0.5 5.5]);
ylim([-0.6 0.4]);
