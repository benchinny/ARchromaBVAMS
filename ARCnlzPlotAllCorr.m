%% COMPARE WEIGHTING MODEL AND SWITCHING MODEL

sn = [18 23 24 26 27 28 29 30 32 33];

rhoSwitchAll = [];
rhoFullAll = [];
rhoNoColorAll = [];
weightsRBSall = [];
rhoColorAll = [];
rhoColorSwitchAll = [];
dAll = [];
aicSwitchAll = [];
aicLinAll = [];
aicNoColorAll = [];
weightsRBSciAll = [];

% for i = 1:length(sn)
%     [d, wS, rbThreshold, rhoSwitch, rhoColorSwitch, aicSwitch] = ARCnlz_linearSwitching(sn(i),false);
%     rhoSwitchAll(i) = rhoSwitch;
%     rhoColorSwitchAll(i) = rhoColorSwitch;
%     dAll(i) = d;
%     aicSwitchAll(i) = aicSwitch;
%     display(['Done with subject ' num2str(i)]);
% end

for i = 1:length(sn)
    [weightsRBS1_x, weightsRBS1_y, rhoFull, rhoNoColor, rhoColor, aicLin, aicNoColor, weightsRBSci, trialMeans, meanChange, deltaR, deltaB, deltaS] = ARCnlz_linearModelnobias(sn(i),false,1000,0);
    rhoFullAll(i) = rhoFull;
    rhoNoColorAll(i) = rhoNoColor;
    weightsRBSall(i,:) = weightsRBS1_x;
    rhoColorAll(i) = rhoColor;
    aicLinAll(i) = aicLin;
    aicNoColorAll(i) = aicNoColor;
    weightsRBSciAll(:,:,i) = weightsRBSci;
    meanChangeAll(:,i) = meanChange;
    deltaRall(:,i) = deltaR;
    deltaBall(:,i) = deltaB;
    deltaSall(:,i) = deltaS;
    display(['Done with subject ' num2str(i)]);
end

%%

maxLumCdm2 = 0.40;
RBratioAll = [];
figure;
set(gcf,'Position',[119 203 1437 718]);
for i = 1:length(sn)
    subplot(2,5,i);
%    plot([deltaR deltaB deltaS]*weightsRBS1_x,meanChangeXvec,'ko','LineWidth',1);
    deltaR = deltaRall(:,i);
    deltaB = deltaBall(:,i);
    deltaS = deltaSall(:,i);
    meanChange = meanChangeAll(:,i);
    weightsRBS1_x = weightsRBSall(i,:);
    predictionTmp = [deltaR deltaB deltaS]*weightsRBS1_x';
    hold on;
    for j = 1:length(predictionTmp)
        deltaRtmp = (1/maxLumCdm2)*deltaR(j);
        deltaBtmp = (1/maxLumCdm2)*deltaB(j);
        RBratio = 0.3.*(deltaRtmp-deltaBtmp+2);
        if RBratio<0
            RBratio = 0;
        end
        if RBratio>1
            RBratio = 1;
        end
        RBratioAll(j)=RBratio;
        plot(predictionTmp(j),meanChange(j),'o','LineWidth',1,'Color',[RBratio 0 1-RBratio],'MarkerFaceColor',[RBratio 0 1-RBratio]);
        % plot(predictionTmp(j),meanChangeXvec(j),'o','LineWidth',1,'Color','k','MarkerFaceColor','w');
    end    
    plot([-2 2],[-2 2],'k--');
    xlim([-2 2]);
    ylim([-2 2]);
    set(gca,'FontSize',15);
    xlabel('Prediction \DeltaA');
    ylabel('Measured \DeltaA');
    title(['Correlation = ' num2str(rhoFullAll(i),3)]);
    axis square;
end

%%

maxLumCdm2 = 0.40;
RBratioAll = [];
figure;
set(gcf,'Position',[119 203 1437 718]);
for i = 1:length(sn)
    subplot(2,5,i);
%    plot([deltaR deltaB deltaS]*weightsRBS1_x,meanChangeXvec,'ko','LineWidth',1);
    deltaR = deltaRall(:,i);
    deltaB = deltaBall(:,i);
    deltaS = deltaSall(:,i);
    meanChange = meanChangeAll(:,i);
    weightsRBS1_x = weightsRBSall(i,:);
    predictionTmp = [deltaS]*weightsRBS1_x(3)';
    hold on;
    for j = 1:length(predictionTmp)
        deltaRtmp = (1/maxLumCdm2)*deltaR(j);
        deltaBtmp = (1/maxLumCdm2)*deltaB(j);
        RBratio = 0.3.*(deltaRtmp-deltaBtmp+2);
        if RBratio<0
            RBratio = 0;
        end
        if RBratio>1
            RBratio = 1;
        end
        RBratioAll(j)=RBratio;
        plot(predictionTmp(j),meanChange(j),'o','LineWidth',1,'Color',[RBratio 0 1-RBratio],'MarkerFaceColor',[RBratio 0 1-RBratio]);
        % plot(predictionTmp(j),meanChangeXvec(j),'o','LineWidth',1,'Color','k','MarkerFaceColor','w');
    end    
    plot([-2 2],[-2 2],'k--');
    xlim([-2 2]);
    ylim([-2 2]);
    set(gca,'FontSize',15);
    xlabel('Prediction \DeltaA');
    ylabel('Measured \DeltaA');
    title(['Correlation = ' num2str(rhoNoColorAll(i),3)]);
    axis square;
end
