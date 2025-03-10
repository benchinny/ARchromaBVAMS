%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/acuityModeling/acuityModelingPredictionS20.mat');

scaleFac = 0.8;
dprime2regress = interp1(defocusForStim+modelPrediction875nmPurpleAt2pt5,dprimeMetric,2.5+unqFocDst.*scaleFac);

% dprimeScale = max(dprime(:)./max(dprimeMetric));
dprimeScale = dprime2regress\dprime';

figure;
set(gcf,'Position',[342 460 1052 440]);
subplot(1,2,1);
hold on;
plot(defocusForStim+modelPrediction875nmPurpleAt2pt5,dprimeMetric.*dprimeScale,'-','Color',[0.56 0 1],'LineWidth',1);
errorbar(2.5+unqFocDst.*scaleFac,dprime,(dprime-dprimeCI(1,:)),(dprimeCI(2,:)-dprime),'o','Color',[0.56 0 1],'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
xlabel('Distance');
ylabel('D-prime metric');
set(gca,'FontSize',15);
axis square;
title(['Mean defocus at 875nm = ' num2str(modelPrediction875nmPurpleAt2pt5,3) 'D']);
subplot(1,2,2);
plot(wvInFocusForStim,dprimeMetric,'k-','LineWidth',1);
xlabel('Wavelength in focus (nm)');
ylabel('D-prime metric');
set(gca,'FontSize',15);
axis square;

stimDistanceSmp = 1.2:0.01:3.8;
dprimeMetricSmooth = interp1(defocusForStim+modelPrediction875nmPurpleAt2pt5,dprimeMetric,stimDistanceSmp,'spline');
[~,indPeak] = max(dprimeMetricSmooth);
peakLocModelPrediction = stimDistanceSmp(indPeak);

%%

peakLocModelPredictionAll = [1.79 1.87 2.19 2.04 1.98 2.17 2.22 1.89];
peakLocActualAll = [1.8635 1.9435 2.6335 2.1235 2.6435 1.9035 1.8935 2.3235];

figure;
hold on;
plot(peakLocModelPredictionAll,peakLocActualAll,'ko','MarkerFaceColor',[0.56 0 1],'MarkerSize',15)
axis square;
set(gca,'FontSize',15);
xlim([1.5 2.8]);
ylim([1.5 2.8]);
plot([1.5 2.8],[1.5 2.8],'k--','LineWidth',1);
xlabel(['Predicted Peak Location (D)']);
ylabel(['Actual Peak Location (D)']);

%%

clear;
