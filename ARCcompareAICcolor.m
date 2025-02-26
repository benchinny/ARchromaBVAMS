%% AIC VALUES FOR ALL SUBJECTS AND MODELS

subjNumAll = [1 3 5 10 16 17 18 20];

aicLMS = [];
aicLM = [];
aicLum = [];

for i = 1:length(subjNumAll)
    aicLMS(i) = ARCtestWvInFocusMeanZspatFilterLMSeffectPlot(subjNumAll(i),'LMS');
    aicLM(i) = ARCtestWvInFocusMeanZspatFilterLMSeffectPlot(subjNumAll(i),'LM');
    aicLum(i) = ARCtestWvInFocusMeanZspatFilterLMSeffectPlot(subjNumAll(i),'Lum');
end

%%

load('/Users/benjaminchin/Documents/ARchromaScraps/aicColorModels.mat');

%%

figure;
hold on;
for i = 1:length(aicLMS)
    bar(1:4:29,aicLMS,0.22,'FaceColor','b','LineWidth',1);
    bar(2:4:30,aicLM,0.22,'FaceColor','w','LineWidth',1);
end
set(gca,'FontSize',15);
ylabel('AIC');
set(gca,'XTick',2:4:30);
set(gca,'XTickLabel',{'S1' 'S3' 'S5' 'S10' 'S16' 'S17' 'S18' 'S20'});
legend('(L+M)-S','L+M');
