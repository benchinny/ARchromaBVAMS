%% ACTUAL POWER ANALYSIS

addVarExplClr = [0.2147 0.1209 0.1658 0.1548 0.0443];

%% JUST CHECKING EXPRESSION FOR STD ERROR OF THE MEAN

for i = 1:10000
    smpAddVar = randsample(addVarExplClr,5,true);
    muSmpAddVar(i) = mean(smpAddVar);
end

xSupport = -0.15:0.001:0.15;
pMu = normpdf(xSupport,0,std(muSmpAddVar));

figure;
plot(xSupport,pMu,'k','LineWidth',1.5); hold on;
plot(mean(muSmpAddVar).*[1 1],ylim,'k--','LineWidth',1.5);
set(gca,'FontSize',15);
xlabel('Sample mean'); ylabel('Probability');

%% COMPARE TWO-PARAMETER VS ONE-PARAMETER COLOR MODELS

twoParamR2 = [0.946 0.863 0.939 0.943 0.528];

oneParamR2 = [0.941 0.854 0.938 0.943 0.505];

figure;
hold on;
bar([1 3 5 7 9],twoParamR2,0.4,'FaceColor','w');
bar([2 4 6 8 10],oneParamR2,0.4,'FaceColor','k');
set(gca,'FontSize',15);
xlabel('Subject'); ylabel('Correlation');
set(gca,'XTick',[1.5 3.5 5.5 7.5 9.5]);
set(gca,'XTickLabel',{'1' '2' '3' '4' '5'});
legend({'2-parameter' '1-parameter'});

%%

varColor = [0.1989 0.0924 0.1340 0.1253 0.0462];

varAccStim = [0.6708 0.6084 0.7140 0.7344 0.2107];

figure;
hold on;
bar([1 3 5 7 9],varAccStim,0.4,'FaceColor','w');
bar([2 4 6 8 10],varColor,0.4,'FaceColor','m');
set(gca,'FontSize',15);
xlabel('Subject'); ylabel('Variance explained');
set(gca,'XTick',[1.5 3.5 5.5 7.5 9.5]);
set(gca,'XTickLabel',{'1' '2' '3' '4' '5'});
legend({'Accommodative demand' 'Color'});

%%

varColor = [0.1989 0.0924 0.1340 0.1253 0.0462];

varAccStim = [0.6708 0.6084 0.7140 0.7344 0.2107];

figure;
hold on;
bar([1 3 5 7 9],varAccStim,0.4,'FaceColor','w');
bar([2 4 6 8 10],addVarExplClr,0.4,'FaceColor','m');
set(gca,'FontSize',15);
xlabel('Subject'); ylabel('Variance explained');
set(gca,'XTick',[1.5 3.5 5.5 7.5 9.5]);
set(gca,'XTickLabel',{'1' '2' '3' '4' '5'});
legend({'Accommodative demand' 'Color'});

%% COMPARE WEIGHTING MODEL AND SWITCHING MODEL

weightingModelRho = [0.946 0.863 0.939 0.943 0.528 0.971 0.853];
switchingModelRho = [];

