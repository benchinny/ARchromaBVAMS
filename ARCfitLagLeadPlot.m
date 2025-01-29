%%

clear all;

%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneWeightsError/rmsMeanAllSubjComb.mat');

%%

subjNumAll = [1 3 5 10 16 17 18 20];

figure;
set(gcf,'Position',[123 316 1476 621]);
for i = 1:size(rmsMeanAllSubjComb,1)
    subplot(2,4,i);
    hold on;
    bar(1,rmsMeanAllSubjComb(i,1),'FaceColor','w','LineWidth',1);
    bar(2,rmsMeanAllSubjComb(i,2),'FaceColor',[0 1 0],'LineWidth',1);
    bar(3,rmsMeanAllSubjComb(i,3),'FaceColor',[0 0 1],'LineWidth',1);
    bar(4,rmsMeanAllSubjComb(i,4),'FaceColor',0.5.*[1 1 1],'LineWidth',1);
    bar(5,rmsMeanAllSubjComb(i,5),'FaceColor',[0 0.5 0],'LineWidth',1);
    bar(6,rmsMeanAllSubjComb(i,6),'FaceColor',[0 0 0.5],'LineWidth',1);   
    bar(7,rmsMeanAllSubjComb(i,7),'FaceColor',[0 0 0],'LineWidth',1);   
    set(gca,'FontSize',10);
    set(gca,'XTick',[1 2 3 7]);
    set(gca,'XTickLabel',{'L+M' 'L-M' 'L+M-S' 'Bal'});
    xlabel('Model');
    ylabel('RMS');
    title(['Subject ' num2str(subjNumAll(i))]);
end