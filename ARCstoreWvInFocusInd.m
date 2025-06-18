%% STORE WAVELENGTH-IN-FOCUS DATA

subjNumAll = [1 3 5 10 16 17 18 20];

wvMeanAllSubj = [];
wvPredAllSubj = [];

for i = 1:length(subjNumAll)
   [aic, pFit, wvMeanAll, wvPredAll] = ARCtestWvInFocusMeanZspatFilterLMSeffectPlotWave(subjNumAll(i),'LMS');
   wvMeanAllSubj(:,:,i) = wvMeanAll;
   wvPredAllSubj(:,:,i) = wvPredAll;
end

%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/PresavedFigureData/wvInFocusIndData.mat');

%%

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

markerPlotSpeed = 'sod';

figure;
set(gcf,'Position',[214 90 1228 906]);
for k = 1:8
    subplot(4,4,(k-1)*2+1);
    hold on;
    for i = 1:3
        hold on;
        plot(1:5,wvPredAllSubj(1:5,i,k),'k-');
        for j = 1:5
            plot(j,wvMeanAllSubj(j,i,k),['k' markerPlotSpeed(i)],'MarkerFaceColor',conditionsOrderedNorm(j,:), ...
                 'MarkerSize',10);
        end
    end
    text(0.25,670,['S' num2str(k)],'FontSize',18);
    set(gca,'FontSize',15);
    set(gca,'XTick',1:5);
    set(gca,'XTickLabel',{'0.25' '0.50' '1.00' '2.00' '4.00'});
    xlabel('Red-blue ratio');
    if k==1
       ylabel('Wavelength in focus (nm)');
       title('No green');
    end
    if k==2
       title('No green');
    end
    xlim([0 6]);
    ylim([400 700]);

    subplot(4,4,(k-1)*2+2);
    for i = 1:3
        hold on;   
        plot(1:5,wvPredAllSubj(6:10,i,k),'k-');
        for j = 6:11
            if j<11
                plot(j-5,wvMeanAllSubj(j,i,k),['k' markerPlotSpeed(i)],'MarkerFaceColor',conditionsOrderedNorm(j,:), ...
                     'MarkerSize',10);
            end
        end       
    end
    text(0.25,670,['S' num2str(k)],'FontSize',18);
    set(gca,'FontSize',15);
    set(gca,'XTick',1:5);
    set(gca,'XTickLabel',{'0.25' '0.50' '1.00' '2.00' '4.00'});
    xlabel('Red-blue ratio');
    if k==1 || k==2
        title('Some green');
    end
    xlim([0 6]);
    ylim([400 700]);
end
