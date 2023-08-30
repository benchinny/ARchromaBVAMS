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

% weightingModelRho = [0.946 0.863 0.939 0.943 0.528 0.971 0.853];
% switchingModelRho = [0.901 0.799 0.905 0.925 0.51  0.943 0.835];
% 
% 
% figure;
% hold on;
% bar([1 3 5 7 9 11 13],weightingModelRho.^2,0.4,'FaceColor','w');
% bar([2 4 6 8 10 12 14],switchingModelRho.^2,0.4,'FaceColor','k');
% set(gca,'FontSize',15);
% xlabel('Subject'); ylabel('Variance Explained');
% set(gca,'XTick',[1.5 3.5 5.5 7.5 9.5 11.5 13.5]);
% set(gca,'XTickLabel',{'1' '2' '3' '4' '5' '6' '7'});
% legend({'Weighting' 'Switching'});

sn = [17 11 16 19 21 23 24 25];
rhoSwitchAll = [];
rhoFullAll = [];
rhoNoColorAll = [];
weightsRBSall = [];
rhoColorAll = [];
rhoColorSwitchAll = [];

for i = 1:length(sn)
    [d, wS, rbThreshold, rhoSwitch, rhoColorSwitch] = ARCnlz_linearSwitching(sn(i),false);
    rhoSwitchAll(i) = rhoSwitch;
    rhoColorSwitchAll(i) = rhoColorSwitch;
    display(['Done with subject ' num2str(i)]);
end

for i = 1:length(sn)
    [weightsRBS1_x, weightsRBS1_y, rhoFull, rhoNoColor, rhoColor] = ARCnlz_linearModelnobias(sn(i),false);
    rhoFullAll(i) = rhoFull;
    rhoNoColorAll(i) = rhoNoColor;
    weightsRBSall(i,:) = weightsRBS1_x;
    rhoColorAll(i) = rhoColor;
    display(['Done with subject ' num2str(i)]);
end

%% PLOT WEIGHTS

figure;
set(gcf,'Position',[262 314 1239 594]);
for i = 1:size(weightsRBSall,1)
    subplot(2,4,i);
    hold on;
    bar(1,weightsRBSall(i,1),'FaceColor','r');
    bar(2,weightsRBSall(i,2),'FaceColor','b');
    bar(3,weightsRBSall(i,3),'FaceColor','k');
    set(gca,'XTick',[1 2 3]);
    set(gca,'XTickLabel',{'w_R' 'w_B' 'w_S'});
    title('Weights');
    set(gca,'FontSize',20);
    ylim(1.*[-1.1 1.1]);
    axis square;
end

%% PLOT VARIANCE EXPLAINED COMPARISONS

figure;
hold on;
bar([1 4 7 10 13 16 19 22],rhoFullAll.^2,0.3,'FaceColor','w');
bar([2 5 8 11 14 17 20 23],rhoSwitchAll.^2,0.3,'FaceColor',[0.5 0.5 0.5]);
bar([3 6 9 12 15 18 21 24],rhoNoColorAll.^2,0.3,'FaceColor','k');
set(gca,'FontSize',15);
xlabel('Subject'); ylabel('Variance Explained');
set(gca,'XTick',[1.5 4.5 7.5 10.5 13.5 16.5 19.5 22.5]);
set(gca,'XTickLabel',{'1' '2' '3' '4' '5' '6' '7' '8'});
legend({'Weighting' 'Switching' 'No color'});

%% PLOT VARIANCE EXPLAINED BY COLOR COMPARISONS

figure;
hold on;
bar([1 3 5 7 9 11],rhoColorAll.^2,0.4,'FaceColor','m');
bar([2 4 6 8 10 12],rhoColorSwitchAll.^2,0.4,'FaceColor',[0.5 0 0.5]);
set(gca,'FontSize',15);
xlabel('Subject'); ylabel('Variance Explained');
set(gca,'XTick',[1.5 3.5 5.5 7.5 9.5 11.5]);
set(gca,'XTickLabel',{'1' '2' '3' '4' '5' '6'});
legend({'Weighting' 'Switching'});

%% COMPARE WEIGHTS

redWeights = [0.7076 0.1043 0.3660 0.4499 0.2045 0.4052 0.2148];
blueWeights = [-0.2690 -0.4902 -0.2788 -0.3552 -0.0726 -0.2039 -0.1898];

%% COMPARE WITH AND WITHOUT BIAS TERM

sn = [17 11 16 19 21 23 24 25];
rhoFullAllnobias = [];
rhoFullBias = [];

for i = 1:length(sn)
    [weightsRBS1_xNoBias, weightsRBS1_yNoBias, rhoFull, rhoNoColor, rhoColor] = ARCnlz_linearModelnobias(sn(i),false);
    rhoFullAllnobias(i) = rhoFull;
    display(['Done with subject ' num2str(i)]);
end

for i = 1:length(sn)
    [weightsRBS1_x, weightsRBS1_y, rhoFull, rhoNoColor, rhoColor] = ARCnlz_linearModel(sn(i),false);
    rhoFullAllBias(i) = rhoFull;
    display(['Done with subject ' num2str(i)]);
end

%% PLOT VARIANCE EXPLAINED WITH AND WITHOUT BIAS TERM

figure;
hold on;
bar([1 3 5 7 9 11 13 15],rhoFullAllBias.^2,0.4,'FaceColor','k');
bar([2 4 6 8 10 12 14 16],rhoFullAllnobias.^2,0.4,'FaceColor','w');
set(gca,'FontSize',15);
xlabel('Subject'); ylabel('Variance Explained');
set(gca,'XTick',[1.5 3.5 5.5 7.5 9.5 11.5 13.5 15.5]);
set(gca,'XTickLabel',{'1' '2' '3' '4' '5' '6' '7' '8'});
legend({'With bias' 'No bias'});

%% COMPARE PARAMETERS FROM ALL TRIALS VS RANDOM ONLY TRIALS

sn = [17 11 16 19 21 23 24 25 26];
rhoFullAll = [];
rhoNoColorAll = [];
weightsRBSall = [];
rhoColorAll = [];

for i = 1:length(sn)
    [weightsRBS1_x, weightsRBS1_y, rhoFull, rhoNoColor, rhoColor] = ARCnlz_linearModelnobias(sn(i),false);
    rhoFullAll(i) = rhoFull;
    rhoNoColorAll(i) = rhoNoColor;
    weightsRBSall(i,:) = weightsRBS1_x;
    rhoColorAll(i) = rhoColor;
    display(['Done with subject ' num2str(i)]);
end

save('/Users/benchin/Documents/ARchroma/cache/paramsRandom','rhoFullAll','weightsRBSall');

%% COMPARE PARAMETERS FROM ALL TRIALS VS RANDOM ONLY TRIALS

load('/Users/benchin/Documents/ARchroma/cache/paramsAll.mat');
rhoFullAllAll = rhoFullAll;
weightsRBSallAll = weightsRBSall;
load('/Users/benchin/Documents/ARchroma/cache/paramsRandom.mat');
rhoFullAllRandom = rhoFullAll;
weightsRBSallRandom = weightsRBSall;

figure;
set(gcf,'Position',[318 247 1135 708]);
subplot(2,2,1);
set(gca,'FontSize',15);
hold on;
plot(rhoFullAllAll,rhoFullAllRandom,'ko','MarkerSize',10);
plot([0 1],[0 1],'k--');
xlabel('All trials'); ylabel('Random trials only'); title('Correlation');
axis square;
subplot(2,2,2);
set(gca,'FontSize',15);
hold on;
plot(weightsRBSallAll(:,3),weightsRBSallRandom(:,3),'ko','MarkerSize',10);
plot([0 1],[0 1],'k--');
xlabel('All trials'); ylabel('Random trials only'); title('Gain');
axis square;
subplot(2,2,3);
set(gca,'FontSize',15);
hold on;
plot([0 1],[0 1],'k--');
plot(weightsRBSallAll(:,1),weightsRBSallRandom(:,1),'ro','MarkerSize',10,'MarkerFaceColor','w');
xlabel('All trials'); ylabel('Random trials only'); title('Red weight');
axis square;
subplot(2,2,4);
set(gca,'FontSize',15);
hold on;
plot([-1 0],[-1 0],'k--');
plot(weightsRBSallAll(:,2),weightsRBSallRandom(:,2),'bo','MarkerSize',10,'MarkerFaceColor','w');
xlabel('All trials'); ylabel('Random trials only'); title('Blue weight');
axis square;
