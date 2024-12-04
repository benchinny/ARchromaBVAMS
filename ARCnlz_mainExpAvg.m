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

% %% SEPARATE TRIALS
% 
% rgbLumNormCndUnq = [0.2500         0    1.0000; ...
%                     0.5000         0    1.0000; ...
%                     1.0000         0    1.0000; ...
%                     1.0000         0    0.5000; ...
%                     1.0000         0    0.2500; ...
%                     0.2500    0.5000    1.0000; ...
%                     0.5000    0.5000    1.0000; ...
%                     1.0000    0.5000    1.0000; ...
%                     1.0000    0.5000    0.5000; ...
%                     1.0000    0.5000    0.2500; ...
%                     1.0000    1.0000    1.0000];
% 
% defocusAt550objDistCenteredCell = {};
% 
% for i = 1:size(rgbLumNormCndUnq,1)
%     % GET ALL CELL INDICES WITH UNIQUE COLOR
%     indRgbLumNormCnd = find(abs(rgbLumNormCndAll(:,1)-rgbLumNormCndUnq(i,1))<0.001 & ...
%                             abs(rgbLumNormCndAll(:,2)-rgbLumNormCndUnq(i,2))<0.001 & ...
%                             abs(rgbLumNormCndAll(:,3)-rgbLumNormCndUnq(i,3))<0.001);
%     defocusAt550objDistCentered = [];
%     for j = 1:length(indRgbLumNormCnd)
%         defocusAt550objDistCentered = [defocusAt550objDistCentered; defocusAt550cellAll{indRgbLumNormCnd(j)}-optDistCndAll(indRgbLumNormCnd(j))];
%     end
%     defocusAt550objDistCenteredCell{i} = defocusAt550objDistCentered;
% end
% 
% figure;
% set(gcf,'Position',[353 426 988 420]);
% subplot(1,2,1);
% hold on;
% for i = 1:5 % size(rgbLumNormCndUnq,1)
%     plot(i,mean(defocusAt550objDistCenteredCell{i}),'ko','MarkerFaceColor', ...
%         rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
% end
% for i = 1:5 %size(rgbLumNormCndUnq,1)
%     CIrgb = quantile(defocusAt550objDistCenteredCell{i},[0.16 0.84]);
%     errorbar(i,mean(defocusAt550objDistCenteredCell{i}), ...
%              mean(defocusAt550objDistCenteredCell{i})-CIrgb(1), ...
%              CIrgb(2)-mean(defocusAt550objDistCenteredCell{i}),'ko','MarkerFaceColor', ...
%             rgbLumNormCndUnq(i,:),'Color',rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
% end
% axis square;
% formatFigure('Color Condition','Relative defocus (D)');
% xlim([0.5 5.5]);
% subplot(1,2,2);
% hold on;
% for i = 1:5 % size(rgbLumNormCndUnq,1)
%     plot(i,mean(defocusAt550objDistCenteredCell{i+5}),'ko','MarkerFaceColor', ...
%         rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
% end
% for i = 1:5 %size(rgbLumNormCndUnq,1)
%     CIrgb = quantile(defocusAt550objDistCenteredCell{i+5},[0.16 0.84]);
%     errorbar(i,mean(defocusAt550objDistCenteredCell{i+5}), ...
%              mean(defocusAt550objDistCenteredCell{i+5})-CIrgb(1), ...
%              CIrgb(2)-mean(defocusAt550objDistCenteredCell{i+5}),'ko','MarkerFaceColor', ...
%             rgbLumNormCndUnq(i+5,:),'Color',rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
% end
% axis square;
% formatFigure('Color Condition','Relative defocus (D)');
% xlim([0.5 5.5]);

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

nBoots = 1000;

defocusAt550objDistCenteredCell = {};
wvInFocusSortedCell = {};

for i = 1:size(rgbLumNormCndUnq,1)
    % GET ALL CELL INDICES WITH UNIQUE COLOR
    indRgbLumNormCnd = find(abs(rgbLumNormCndAll(:,1)-rgbLumNormCndUnq(i,1))<0.001 & ...
                            abs(rgbLumNormCndAll(:,2)-rgbLumNormCndUnq(i,2))<0.001 & ...
                            abs(rgbLumNormCndAll(:,3)-rgbLumNormCndUnq(i,3))<0.001);
    defocusAt550objDistCentered = [];
    wvInFocusSorted = [];
    subjNumTagInd = subjNumTag(indRgbLumNormCnd);
    subjNumTagTmp = [];
    for j = 1:length(indRgbLumNormCnd)
        defocusAt550objDistCentered = [defocusAt550objDistCentered; defocusAt550cellAll{indRgbLumNormCnd(j)}-optDistCndAll(indRgbLumNormCnd(j))];
        wvInFocusSorted = [wvInFocusSorted; wvInFocusCellAll{indRgbLumNormCnd(j)}];
        subjNumTagTmp = [subjNumTagTmp; subjNumTagInd(j).*ones(size(defocusAt550cellAll{indRgbLumNormCnd(j)}))];
    end
    subjNumTagUnq = unique(subjNumTagTmp);
    defocusAt550objDistCenteredAvg = [];
    wvInFocusAvg = [];
    for j = 1:length(subjNumTagUnq)
        defocusAt550objDistCenteredAvg(j) = mean(defocusAt550objDistCentered(subjNumTagTmp==subjNumTagUnq(j)));
        wvInFocusAvg(j) = mean(wvInFocusSorted(subjNumTagTmp==subjNumTagUnq(j)));
    end
    defocusAt550objDistCenteredCell{i} = defocusAt550objDistCenteredAvg;
    wvInFocusSortedCell{i} = wvInFocusAvg;
    bootInds = randsample(length(wvInFocusAvg),length(wvInFocusAvg)*nBoots,'true');
    bootIndsMatrix = reshape(bootInds,[length(wvInFocusAvg) nBoots]);
    wvInFocusBoots = mean(wvInFocusAvg(bootIndsMatrix),1);
    defocusAt550objDistCenteredBoots = mean(defocusAt550objDistCenteredAvg(bootIndsMatrix),1);
    wvInFocusCI(:,i) = quantile(wvInFocusBoots,[0.025 0.975]);
    defocusAt550CI(:,i) = quantile(defocusAt550objDistCenteredBoots,[0.025 0.975]);
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
             mean(defocusAt550objDistCenteredCell{i})-defocusAt550CI(1,i), ...
             defocusAt550CI(2,i)-mean(defocusAt550objDistCenteredCell{i}),'ko','MarkerFaceColor', ...
            rgbLumNormCndUnq(i,:),'Color',rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
end
axis square;
formatFigure('Color Condition','Relative defocus (D)');
xlim([0.5 5.5]);
ylim([-0.55 0.2]);
subplot(1,2,2);
hold on;
for i = 1:5 % size(rgbLumNormCndUnq,1)
    plot(i,mean(defocusAt550objDistCenteredCell{i+5}),'ko','MarkerFaceColor', ...
        rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
end
for i = 1:5 %size(rgbLumNormCndUnq,1)
    errorbar(i,mean(defocusAt550objDistCenteredCell{i+5}), ...
             mean(defocusAt550objDistCenteredCell{i+5})-defocusAt550CI(1,i+5), ...
             defocusAt550CI(2,i+5)-mean(defocusAt550objDistCenteredCell{i+5}),'ko','MarkerFaceColor', ...
            rgbLumNormCndUnq(i+5,:),'Color',rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
end
axis square;
formatFigure('Color Condition','Relative defocus (D)');
xlim([0.5 5.5]);
ylim([-0.55 0.2]);

figure;
set(gcf,'Position',[353 426 988 420]);
subplot(1,2,1);
hold on;
for i = 1:5 % size(rgbLumNormCndUnq,1)
    plot(i,mean(wvInFocusSortedCell{i}),'ko','MarkerFaceColor', ...
        rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
end
for i = 1:5 %size(rgbLumNormCndUnq,1)
    CIrgb = quantile(wvInFocusSortedCell{i},[0.16 0.84]);
    errorbar(i,mean(wvInFocusSortedCell{i}), ...
             mean(wvInFocusSortedCell{i})-wvInFocusCI(1,i), ...
             wvInFocusCI(2,i)-mean(wvInFocusSortedCell{i}),'ko','MarkerFaceColor', ...
            rgbLumNormCndUnq(i,:),'Color',rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
end
axis square;
formatFigure('Color Condition','Wavelength (\lambda)');
xlim([0.5 5.5]);
ylim([460 620]);
subplot(1,2,2);
hold on;
for i = 1:5 % size(rgbLumNormCndUnq,1)
    plot(i,mean(wvInFocusSortedCell{i+5}),'ko','MarkerFaceColor', ...
        rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
end
for i = 1:5 %size(rgbLumNormCndUnq,1)
    CIrgb = quantile(wvInFocusSortedCell{i+5},[0.16 0.84]);
    errorbar(i,mean(wvInFocusSortedCell{i+5}), ...
             mean(wvInFocusSortedCell{i+5})-wvInFocusCI(1,i+5), ...
             wvInFocusCI(2,i+5)-mean(wvInFocusSortedCell{i+5}),'ko','MarkerFaceColor', ...
            rgbLumNormCndUnq(i+5,:),'Color',rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
end
% plot([0.5 5.5],mean(defocusAt550objDistCenteredCell{end}).*[1 1],'k--','LineWidth',1);
axis square;
formatFigure('Color Condition','Wavelength (\lambda)');
xlim([0.5 5.5]);
ylim([460 620]);


% %% ONE DATA POINT PER TRIAL (AVERAGE ACROSS SUBJECTS)
% 
% rgbLumNormCndUnq = [0.2500         0    1.0000; ...
%                     0.5000         0    1.0000; ...
%                     1.0000         0    1.0000; ...
%                     1.0000         0    0.5000; ...
%                     1.0000         0    0.2500; ...
%                     0.2500    0.5000    1.0000; ...
%                     0.5000    0.5000    1.0000; ...
%                     1.0000    0.5000    1.0000; ...
%                     1.0000    0.5000    0.5000; ...
%                     1.0000    0.5000    0.2500; ...
%                     1.0000    1.0000    1.0000];
% 
% defocusAt550objDistCenteredCell = {};
% wvInFocusSortedCell = {};
% 
% for i = 1:size(rgbLumNormCndUnq,1)
%     % GET ALL CELL INDICES WITH UNIQUE COLOR
%     indRgbLumNormCnd = find(abs(rgbLumNormCndAll(:,1)-rgbLumNormCndUnq(i,1))<0.001 & ...
%                             abs(rgbLumNormCndAll(:,2)-rgbLumNormCndUnq(i,2))<0.001 & ...
%                             abs(rgbLumNormCndAll(:,3)-rgbLumNormCndUnq(i,3))<0.001);
%     defocusAt550objDistCentered = [];
%     wvInFocusSorted = [];
%     trialTag = [];
%     subjNumUnq = unique(subjNumTag);
%     trialCounter = zeros(size(subjNumUnq));
%     for j = 1:length(indRgbLumNormCnd)
%         defocusAt550objDistCentered = [defocusAt550objDistCentered; defocusAt550cellAll{indRgbLumNormCnd(j)}-optDistCndAll(indRgbLumNormCnd(j))];
%         wvInFocusSorted = [wvInFocusSorted; wvInFocusCellAll{indRgbLumNormCnd(j)}];
%         trialTag = [trialTag; trialCounter(subjNumUnq==subjNumTag(indRgbLumNormCnd(j)))+ ...
%                     [1:length(defocusAt550cellAll{indRgbLumNormCnd(j)})]'];
%         trialCounter(subjNumUnq==subjNumTag(indRgbLumNormCnd(j))) = ...
%         trialCounter(subjNumUnq==subjNumTag(indRgbLumNormCnd(j)))+length(defocusAt550cellAll{indRgbLumNormCnd(j)});        
%     end
%     trialTagUnq = unique(trialTag);
%     for j = 1:length(trialTagUnq)
%         defocusAt550objDistCenteredMeanAcrossSubj(j) = mean(defocusAt550objDistCentered(trialTag==trialTagUnq(j)));
%         wvInFocusMeanAcrossSubj(j) = mean(wvInFocusSorted(trialTag==trialTagUnq(j)));
%     end
%     defocusAt550objDistCenteredCell{i} = defocusAt550objDistCenteredMeanAcrossSubj;
%     wvInFocusSortedCell{i} = wvInFocusMeanAcrossSubj;
% end
% 
% figure;
% set(gcf,'Position',[353 426 988 420]);
% subplot(1,2,1);
% hold on;
% for i = 1:5 % size(rgbLumNormCndUnq,1)
%     plot(i,mean(defocusAt550objDistCenteredCell{i}),'ko','MarkerFaceColor', ...
%         rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
% end
% for i = 1:5 %size(rgbLumNormCndUnq,1)
%     CIrgb = quantile(defocusAt550objDistCenteredCell{i},[0.16 0.84]);
%     errorbar(i,mean(defocusAt550objDistCenteredCell{i}), ...
%              std(defocusAt550objDistCenteredCell{i}), ...
%              'ko','MarkerFaceColor', ...
%             rgbLumNormCndUnq(i,:),'Color',rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
% end
% plot([0.5 5.5],mean(defocusAt550objDistCenteredCell{end}).*[1 1],'k--','LineWidth',1);
% axis square;
% formatFigure('Color Condition','Relative defocus (D)');
% xlim([0.5 5.5]);
% ylim([-0.6 0.4]);
% subplot(1,2,2);
% hold on;
% for i = 1:5 % size(rgbLumNormCndUnq,1)
%     plot(i,mean(defocusAt550objDistCenteredCell{i+5}),'ko','MarkerFaceColor', ...
%         rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
% end
% for i = 1:5 %size(rgbLumNormCndUnq,1)
%     CIrgb = quantile(defocusAt550objDistCenteredCell{i+5},[0.16 0.84]);
%     errorbar(i,mean(defocusAt550objDistCenteredCell{i+5}), ...
%              std(defocusAt550objDistCenteredCell{i+5}), ...
%              'ko','MarkerFaceColor', ...
%             rgbLumNormCndUnq(i+5,:),'Color',rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
% end
% plot([0.5 5.5],mean(defocusAt550objDistCenteredCell{end}).*[1 1],'k--','LineWidth',1);
% axis square;
% formatFigure('Color Condition','Relative defocus (D)');
% xlim([0.5 5.5]);
% ylim([-0.6 0.4]);
% 
% figure;
% set(gcf,'Position',[353 426 988 420]);
% subplot(1,2,1);
% hold on;
% for i = 1:5 % size(rgbLumNormCndUnq,1)
%     plot(i,mean(wvInFocusSortedCell{i}),'ko','MarkerFaceColor', ...
%         rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
% end
% for i = 1:5 %size(rgbLumNormCndUnq,1)
%     CIrgb = quantile(wvInFocusSortedCell{i},[0.16 0.84]);
%     errorbar(i,mean(wvInFocusSortedCell{i}), ...
%              std(wvInFocusSortedCell{i}), ...
%              'ko','MarkerFaceColor', ...
%             rgbLumNormCndUnq(i,:),'Color',rgbLumNormCndUnq(i,:),'MarkerSize',12,'LineWidth',1);
% end
% axis square;
% formatFigure('Color Condition','Wavelength (\lambda)');
% xlim([0.5 5.5]);
% ylim([460 620]);
% subplot(1,2,2);
% hold on;
% for i = 1:5 % size(rgbLumNormCndUnq,1)
%     plot(i,mean(wvInFocusSortedCell{i+5}),'ko','MarkerFaceColor', ...
%         rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
% end
% for i = 1:5 %size(rgbLumNormCndUnq,1)
%     CIrgb = quantile(wvInFocusSortedCell{i+5},[0.16 0.84]);
%     errorbar(i,mean(wvInFocusSortedCell{i+5}), ...
%              std(wvInFocusSortedCell{i+5}), ...
%              'ko','MarkerFaceColor', ...
%             rgbLumNormCndUnq(i+5,:),'Color',rgbLumNormCndUnq(i+5,:),'MarkerSize',12,'LineWidth',1);
% end
% % plot([0.5 5.5],mean(defocusAt550objDistCenteredCell{end}).*[1 1],'k--','LineWidth',1);
% axis square;
% formatFigure('Color Condition','Wavelength (\lambda)');
% xlim([0.5 5.5]);
% ylim([460 620]);
