%% LOADING OWENS (1980) RAW DATA

perfVsSFstr = 'Owens_1980_';
folderName = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/modelParams/';

dataOwens1980 = [];
for i = 1:4
    dataOwens1980table = readtable([folderName perfVsSFstr num2str(i)]);
    dataOwens1980array = table2array(dataOwens1980table);
    dataOwens1980unq = unique(dataOwens1980array,'rows');
    dataOwens1980unq(dataOwens1980unq>100) = 100;
    if i==4
        dataOwens1980unq = [dataOwens1980unq(1:4,:); mean(dataOwens1980unq(5:6,:)); dataOwens1980unq(7:8,:)];
    end
    dataOwens1980(:,:,i) = dataOwens1980unq;
end

%% REMAKE DIGITIZED OWENS (1980) PLOTS

figure;
set(gcf,'Position',[349 229 1112 725]);
for i = 1:4
    subplot(2,2,i);
    plot(dataOwens1980(:,1,i),dataOwens1980(:,2,i),'ko-','LineWidth',1,'MarkerSize',10,'MarkerFaceColor','w');
    axis square;
    set(gca,'FontSize',12);
    xlabel('Spatial frequency (cyc/deg)');
    ylabel('Performance');
    set(gca,'Xscale','log');
    xlim([0.4 40]);
    ylim([0 105]);
    set(gca,'XTick',[0.5 2 8 32]);
    set(gca,'YTick',[25 50 75 100]);
end

%%

dataOwens1980mean = mean(dataOwens1980,3);
dataOwensContFit = 0.01:0.1:32;

lgsORspline = 'lgs';

if strcmp(lgsORspline,'lgs')
    pFitAll = [];
    rmsAll = [];
    for i = 1:100
        [pFit,rms] = ARCfitLogGaussASF(dataOwens1980mean(:,1),dataOwens1980mean(:,2));
        pFitAll(i,:) = pFit;
        rmsAll(i,:) = rms;
    end
    [~,indBest] = min(rmsAll);
    pFitBest = pFitAll(indBest,:);
    a1 = pFitBest(1);
    m1 = pFitBest(2);
    s1 = pFitBest(3);
    yFit = a1.*exp(-0.5.*((dataOwensContFit - log(m1))./s1).^2);
end

if strcmp(lgsORspline,'spline')
    yFit = interp1(dataOwens1980mean(:,1),dataOwens1980mean(:,2),dataOwensContFit,'spline','extrap');
end

figure;
hold on;
plot(dataOwensContFit,yFit,'k-');
plot(dataOwens1980mean(:,1),dataOwens1980mean(:,2),'ko-','LineWidth',1,'MarkerSize',10,'MarkerFaceColor','w');
axis square;
set(gca,'FontSize',12);
xlabel('Spatial frequency (cyc/deg)');
ylabel('Performance');
set(gca,'Xscale','log');
xlim([0.4 40]);
ylim([0 105]);
set(gca,'XTick',[0.5 2 8 32]);
set(gca,'YTick',[25 50 75 100]);
