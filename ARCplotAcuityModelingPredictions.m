%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/acuityModeling/acuityModelingPredictionS20.mat');

scaleFac = 0.8;
dprime2regress = interp1(defocusForStim+modelPrediction875nmPurpleAt2pt5,dprimeMetric,2.5+unqFocDst.*scaleFac);

figure;
set(gcf,'Position',[342 460 1052 440]);
subplot(1,2,1);
hold on;
plot(defocusForStim+modelPrediction875nmPurpleAt2pt5,dprimeMetric,'-','Color',[0.56 0 1],'LineWidth',1);
% dprimeScale = max(dprime(:)./max(dprimeMetric));
dprimeScale = dprime'\dprime2regress;
errorbar(2.5+unqFocDst.*scaleFac,dprime.*dprimeScale,(dprime-dprimeCI(1,:)).*dprimeScale,(dprimeCI(2,:)-dprime).*dprimeScale,'o','Color',[0.56 0 1],'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
xlabel('Distance');
ylabel('D-prime metric');
set(gca,'FontSize',15);
title(['Mean defocus at 875nm = ' num2str(modelPrediction875nmPurpleAt2pt5,3) 'D']);
subplot(1,2,2);
plot(wvInFocusForStim,dprimeMetric,'k-','LineWidth',1);
xlabel('Wavelength in focus (nm)');
ylabel('D-prime metric');
set(gca,'FontSize',15);

%%

clear;
