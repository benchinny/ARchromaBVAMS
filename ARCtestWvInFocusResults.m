%%

clear;

%%

subjNum = 20;
RMSEall = zeros([11 11 6]);
SvaluesAll = [-0.6 -0.4 -0.2 0.0 0.2 0.4];
loadStr = {'-6' '-4' '-2' '0' '2' '4'};
folderPath = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneWeightsError/';
blockNums = 3:8;
rgbAll = [];
ind2examine = 4;
optDistStim = [];

for i = 1:length(blockNums)
    AFCp = ARCloadFileBVAMS(20,blockNums(i));
    rgbAll = [rgbAll; AFCp.rgb100];
    optDistStim = [optDistStim; AFCp.meanv00./1.2255];
end

rgbLumNorm = [];
rgbLumNorm(:,1) = (rgbAll(:,1).^2.5)./0.2442;
rgbLumNorm(:,2) = (rgbAll(:,2).^2.7)./0.1037;
rgbLumNorm(:,3) = (rgbAll(:,3).^2.3)./1;
rgbLumNorm(rgbLumNorm>1) = 1;

for i = ind2examine
    load([folderPath 'wvInFocusModelResults' num2str(loadStr{i}) '.mat']);
    RMSEall(:,:,i) = RMSE(:,:,end);
end

for i = ind2examine
    RMSEtmp = squeeze(RMSEall(:,:,i)); 

    figure; 
    imagesc(RMSEtmp);
    xlabel('M weight');
    ylabel('L weight');
    axis square;
    set(gca,'FontSize',12);
    set(gca,'XTick',1:11);
    set(gca,'XTickLabel',{'-1' '-0.8' '-0.6' '-0.4' '-0.2' '0' '0.2' '0.4' '0.6' '0.8' '1'});
    set(gca,'YTickLabel',{'-1' '-0.8' '-0.6' '-0.4' '-0.2' '0' '0.2' '0.4' '0.6' '0.8' '1'});
    title(['S weight = ' num2str(SvaluesAll(i))]);   
    min(RMSEtmp(:))
end

predD = squeeze(defocus875predAll(:,:,11,11,end))';
predD = predD(:);
actD = squeeze(defocus875all(:,:,11,11,end))';
actD = actD(:);
figure; 
hold on;
for i = 1:length(predD)
    plot(predD(i),actD(i),'.','MarkerSize',12,'Color',rgbLumNorm(i,:)); 
end
plot([0 3.5],[0 3.5],'k--','LineWidth',1);
xlim([0 3.5]);
ylim([0 3.5]);
axis square;
formatFigure('Predicted Defocus (D)','Actual Defocus (D)');

%% PLOTTING ALL TRIAL MEANS PER CONDITION AND DISTANCE

conditionsOrderedNorm = [0.25 0.00 1.00; ...
                         0.50 0.00 1.00; ...
                         1.00 0.00 1.00; ...
                         1.00 0.00 0.50; ...
                         1.00 0.00 0.25; ...
                         0.25 0.50 1.00; ...
                         0.50 0.50 1.00; ...
                         1.00 0.50 1.00; ...
                         1.00 0.50 0.50; ...
                         1.00 0.50 0.25; ...
                         1.00 1.00 1.00];

figPositions = [14 493 560 420; ...
                544 496 560 420; ...
                1079 498 560 420; ...
                ];
optDistToCheckAll = [1.5 2.5 3.5];

for j = 1:length(optDistToCheckAll)
    figure;
    set(gcf,'Position',figPositions(j,:));
    hold on;
    optDistToCheck = optDistToCheckAll(j);
    indDist = abs(optDistStim-optDistToCheck)<0.01;
    for i = 1:size(conditionsOrderedNorm,1)
        ind = abs(rgbLumNorm(:,1)-conditionsOrderedNorm(i,1))<0.01 & ...
              abs(rgbLumNorm(:,2)-conditionsOrderedNorm(i,2))<0.01 & ...
              abs(rgbLumNorm(:,3)-conditionsOrderedNorm(i,3))<0.01 & ...
              abs(optDistStim-optDistToCheck)<0.01;
        if i<size(conditionsOrderedNorm,1)
            plot(i.*ones([sum(ind) 1]),actD(ind),'o','Color',conditionsOrderedNorm(i,:),'MarkerFaceColor',conditionsOrderedNorm(i,:));
        else
            plot(i.*ones([sum(ind) 1]),actD(ind),'o','Color','k','MarkerFaceColor','k');
        end
        defocusAt875mean(i) = mean(actD(ind));
    end
    plot(defocusAt875mean(1:5),'k-');
    plot(6:10,defocusAt875mean(6:10),'k-');
    plot([0 11],defocusAt875mean(11).*[1 1],'k--','LineWidth',1);
    xlim([0 11]);
    % ylim(mean(actD(indDist))+[-0.6 0.6]);
    title(['Subject ' num2str(subjNum-10) ', Optical Distances = ' num2str(optDistToCheck)]);
    plot(5.5.*[1 1],ylim,'k-');
    set(gca,'FontSize',15);
    xlabel('Condition');
    ylabel('Defocus at 875nm');
end

%% PLOTTING ALL TRIAL MEANS PER CONDITION AND DISTANCE

conditionsOrderedNorm = [0.25 0.00 1.00; ...
                         0.50 0.00 1.00; ...
                         1.00 0.00 1.00; ...
                         1.00 0.00 0.50; ...
                         1.00 0.00 0.25; ...
                         0.25 0.50 1.00; ...
                         0.50 0.50 1.00; ...
                         1.00 0.50 1.00; ...
                         1.00 0.50 0.50; ...
                         1.00 0.50 0.25; ...
                         1.00 1.00 1.00];

figPositions = [14 493 560 420; ...
                544 496 560 420; ...
                1079 498 560 420; ...
                ];
optDistToCheckAll = [1.5 2.5 3.5];

for j = 1:length(optDistToCheckAll)
    figure;
    set(gcf,'Position',figPositions(j,:));
    hold on;
    optDistToCheck = optDistToCheckAll(j);
    indDist = abs(optDistStim-optDistToCheck)<0.01;
    for i = 1:size(conditionsOrderedNorm,1)
        ind = abs(rgbLumNorm(:,1)-conditionsOrderedNorm(i,1))<0.01 & ...
              abs(rgbLumNorm(:,2)-conditionsOrderedNorm(i,2))<0.01 & ...
              abs(rgbLumNorm(:,3)-conditionsOrderedNorm(i,3))<0.01 & ...
              abs(optDistStim-optDistToCheck)<0.01;
        if i<size(conditionsOrderedNorm,1)
            plot(i.*ones([sum(ind) 1]),actD(ind),'o','Color',conditionsOrderedNorm(i,:),'MarkerFaceColor',conditionsOrderedNorm(i,:));
        else
            plot(i.*ones([sum(ind) 1]),actD(ind),'o','Color','k','MarkerFaceColor','k');
        end
        defocusAt875mean(i) = mean(actD(ind));
    end
    plot(defocusAt875mean(1:5),'k-');
    plot(6:10,defocusAt875mean(6:10),'k-');
    plot([0 11],defocusAt875mean(11).*[1 1],'k--','LineWidth',1);
    xlim([0 11]);
    % ylim(mean(actD(indDist))+[-0.6 0.6]);
    title(['Subject ' num2str(subjNum-10) ', Optical Distances = ' num2str(optDistToCheck)]);
    plot(5.5.*[1 1],ylim,'k-');
    set(gca,'FontSize',15);
    xlabel('Condition');
    ylabel('Defocus at 875nm');
end

%% PLOTTING ALL TRIAL MEANS PER CONDITION AND DISTANCE

conditionsOrderedNorm = [0.25 0.00 1.00; ...
                         0.50 0.00 1.00; ...
                         1.00 0.00 1.00; ...
                         1.00 0.00 0.50; ...
                         1.00 0.00 0.25; ...
                         0.25 0.50 1.00; ...
                         0.50 0.50 1.00; ...
                         1.00 0.50 1.00; ...
                         1.00 0.50 0.50; ...
                         1.00 0.50 0.25; ...
                         1.00 1.00 1.00];

figPositions = [15 78 560 420; ...
                553 81 560 420; ...
                1079 85 560 420; ...
                ];
optDistToCheckAll = [1.5 2.5 3.5];

for j = 1:length(optDistToCheckAll)
    figure;
    set(gcf,'Position',figPositions(j,:));
    hold on;
    optDistToCheck = optDistToCheckAll(j);
    indDist = abs(optDistStim-optDistToCheck)<0.01;
    for i = 1:size(conditionsOrderedNorm,1)
        ind = abs(rgbLumNorm(:,1)-conditionsOrderedNorm(i,1))<0.01 & ...
              abs(rgbLumNorm(:,2)-conditionsOrderedNorm(i,2))<0.01 & ...
              abs(rgbLumNorm(:,3)-conditionsOrderedNorm(i,3))<0.01 & ...
              abs(optDistStim-optDistToCheck)<0.01;
        if i<size(conditionsOrderedNorm,1)
            plot(i.*ones([sum(ind) 1]),predD(ind),'o','Color',conditionsOrderedNorm(i,:),'MarkerFaceColor',conditionsOrderedNorm(i,:));
        else
            plot(i.*ones([sum(ind) 1]),predD(ind),'o','Color','k','MarkerFaceColor','k');
        end
        defocusAt875mean(i) = mean(predD(ind));
    end
    plot(defocusAt875mean(1:5),'k-');
    plot(6:10,defocusAt875mean(6:10),'k-');
    plot([0 11],defocusAt875mean(11).*[1 1],'k--','LineWidth',1);
    xlim([0 11]);
    % ylim(mean(actD(indDist))+[-0.6 0.6]);
    title(['Subject ' num2str(subjNum-10) ', Optical Distances = ' num2str(optDistToCheck)]);
    plot(5.5.*[1 1],ylim,'k-');
    set(gca,'FontSize',15);
    xlabel('Condition');
    ylabel('Defocus at 875nm');
end
