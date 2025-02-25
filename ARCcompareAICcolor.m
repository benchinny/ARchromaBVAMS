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