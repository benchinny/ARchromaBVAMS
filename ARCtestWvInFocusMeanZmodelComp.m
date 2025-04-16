% %%
% 
% subjNumAll = [1 3 5 10 16 17 18 20];
% 
% aicDeltaPass2 = [];
% 
% for i = 1:length(subjNumAll)
%     aic = ARCtestWvInFocusMeanZdeltaPassPlotStack(subjNumAll(i),'Lum',2);
%     aicDeltaPass2(i) = aic;
% end
% 
% save('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicDeltaPass2.mat','aicDeltaPass2');
% 
% %%
% 
% subjNumAll = [1 3 5 10 16 17 18 20];
% 
% aicDeltaPass4 = [];
% 
% for i = 1:length(subjNumAll)
%     aic = ARCtestWvInFocusMeanZdeltaPassPlotStack(subjNumAll(i),'Lum',4);
%     aicDeltaPass4(i) = aic;
% end
% 
% save('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicDeltaPass4.mat','aicDeltaPass4');

% %%
% 
% subjNumAll = [1 3 5 10 16 17 18 20];
% 
% aicStrehlLMS = [];
% 
% for i = 1:length(subjNumAll)
%     aic = ARCtestWvInFocusMeanZstrehlLMSeffectPlotStack(subjNumAll(i),'LMS');
%     aicStrehlLMS(i) = aic;
% end
% 
% save('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicStrehlLMS.mat','aicStrehlLMS');
% 
% %%
% 
% subjNumAll = [1 3 5 10 16 17 18 20];
% 
% aicSpatFilterLMS = [];
% 
% for i = 1:length(subjNumAll)
%     aic = ARCtestWvInFocusMeanZspatFilterLMSeffectPlotStack(subjNumAll(i),'LMS');
%     aicSpatFilterLMS(i) = aic;
% end
% 
% save('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicSpatFilterLMS.mat','aicSpatFilterLMS');

% %%
% 
% subjNumAll = [1 3 5 10 16 17 18 20];
% 
% aicSpatFilterLM = [];
% 
% for i = 1:length(subjNumAll)
%     aic = ARCtestWvInFocusMeanZspatFilterLMSeffectPlotStack(subjNumAll(i),'LM');
%     aicSpatFilterLM(i) = aic;
% end
% 
% save('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicSpatFilterLM.mat','aicSpatFilterLM');
% 
% %%
% 
% subjNumAll = [1 3 5 10 16 17 18 20];
% 
% aicSpatFilterLminusM = [];
% 
% for i = 1:length(subjNumAll)
%     aic = ARCtestWvInFocusMeanZspatFilterLMSeffectPlotStack(subjNumAll(i),'LminusM');
%     aicSpatFilterLminusM(i) = aic;
% end
% 
% save('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicSpatFilterLminusM.mat','aicSpatFilterLminusM');

%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicDeltaPass2.mat')
load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicDeltaPass4.mat')
load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicSpatFilterLM.mat')
load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicSpatFilterLminusM.mat')
load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicSpatFilterLMS.mat')
load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/AICmodelComparisons/aicStrehlLMS.mat')

barWidth = 0.1;

figure;
set(gcf,'Position',[472 453 1054 420]);
hold on;
bar(1:9:64,aicSpatFilterLMS,barWidth,'FaceColor',[0 0 1]);
bar(2:9:65,aicSpatFilterLminusM,barWidth,'FaceColor',[1 0.5 0]);
bar(3:9:66,aicSpatFilterLM,barWidth,'FaceColor','w');
bar(4:9:67,aicStrehlLMS,barWidth);
bar(5:9:68,aicDeltaPass2,barWidth,'FaceColor',0.7.*[1 1 1]);
bar(6:9:69,aicDeltaPass4,barWidth,'FaceColor',0.4.*[1 1 1]);
plot(-1.*[1 1],[-100 50],'k-','LineWidth',1);
plot(8.*[1 1],[-100 50],'k-','LineWidth',1);
plot(17.*[1 1],[-100 50],'k-','LineWidth',1);
plot(26.*[1 1],[-100 50],'k-','LineWidth',1);
plot(35.*[1 1],[-100 50],'k-','LineWidth',1);
plot(44.*[1 1],[-100 50],'k-','LineWidth',1);
plot(53.*[1 1],[-100 50],'k-','LineWidth',1);
plot(62.*[1 1],[-100 50],'k-','LineWidth',1);
plot(71.*[1 1],[-100 50],'k-','LineWidth',1);
xlim([-2 72]);
set(gca,'XTick',3.5:9:66.5);
set(gca,'FontSize',15);
set(gca,'XTickLabel',{'S1' 'S2' 'S3' 'S4' 'S5' 'S6' 'S7' 'S8'})
ylabel('AIC');
legend('L+M-S','L-M','L+M','L+M-S Strehl','L+M 2cpd','L+M 4cpd','Location','NorthEastOutside');

