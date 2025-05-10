%%

subjNum = [1 3 5 10 16 17 18 20];
wvMeanAll = [];
wvPredAll = [];

for i = 1:length(subjNum)
    [aic, pFit, wvMean, wvPred] = ARCtestWvInFocusMeanZspatFilterLMSeffectPlotWave(subjNum(i),'LMS');
    wvMeanAll(:,:,i) = wvMean;
    wvPredAll(:,:,i) = wvPred;
end 

%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Meetings/Meeting_April_23/wvMeanAndPred.mat');

figure;
set(gca,'Position',[255 499 1028 420]);
subplot(1,2,1);
hold on;
for i = 1:size(wvMeanAll,2)
    wvMeanTmp = squeeze(wvMeanAll(:,i,:));
    wvPredTmp = squeeze(wvPredAll(:,i,:));
    plot(mean(wvPredTmp(1:5,:),2),'k-');
    plot(mean(wvMeanTmp(1:5,:),2),'ko','MarkerSize',10,'MarkerFaceColor','w');
end
axis square;
subplot(1,2,2);
hold on;
for i = 1:size(wvMeanAll,2)
    wvMeanTmp = squeeze(wvMeanAll(:,i,:));
    wvPredTmp = squeeze(wvPredAll(:,i,:));
    plot(mean(wvPredTmp(6:10,:),2),'k-');
    plot(mean(wvMeanTmp(6:10,:),2),'ko','MarkerSize',10,'MarkerFaceColor','w');
end
axis square;

