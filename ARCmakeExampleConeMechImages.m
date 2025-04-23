%%

LMSweights = [0.5467    0.2533   -1.0000; ...
              0.4725    0.5775   -1.0000; ...
              0.7650    0.1350   -0.5000; ...
              1.1475    0.2025   -1.0000; ...
              0.2267    0.5733   -1.0000; ...
              0.3008    0.6492   -1.0000; ...
              1.1050    0.1950   -1.0000; ...
              1.1433    0.2567   -0.2500];

LMweights = [0.8250    0.1750         0; ...
             0.8500    0.1500         0; ...
             0.8500    0.1500         0; ...
             0.8500    0.1500         0; ...
             0.2500    0.7500         0; ...
             0.8250    0.1750         0; ...
             0.8500    0.1500         0; ...
             0.7500    0.2500         0];

LminusMweights = [0.3250   -0.1750         0; ...
                  0.3750   -0.1250         0; ...
                  0.4125   -0.0875         0; ...
                  0.8000   -0.2000         0; ...
                  0.7000   -0.3000         0; ...
                  0.4000   -0.1000         0; ...
                  0.6250   -0.3750         0; ...
                  0.4875   -0.0125         0];

%% GET WAVELENGTH-IN-FOCUS PREDICTIONS FROM EACH MODEL

subjNumAll = [1 3 5 10 16 17 18 20];
wvInFocusLMS8 = [];
wvInFocusLM8 = [];
wvInFocusLminusM8 = [];
wvInFocusLMS1 = [];
wvInFocusLM1 = [];
wvInFocusLminusM1 = [];
wvInFocusLMS6 = [];
wvInFocusLM6 = [];
wvInFocusLminusM6 = [];
peakCorr8LM = [];
peakCorr8LMS = [];
peakCorr1LM = [];
peakCorr1LMS = [];
peakCorr6LM = [];
peakCorr6LMS = [];

for i = 1:size(LMSweights,1)
    [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
     ARCwvInFocusConesMeanZsandbox(subjNumAll(i),8,LMSweights(i,:),[]);
    wvInFocusLMS8(i,:) = wvInFocus;
    peakCorr8LMS(i,:) = peakCorr;
    [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
     ARCwvInFocusConesMeanZsandbox(subjNumAll(i),8,LMweights(i,:),[]);
    wvInFocusLM8(i,:) = [wvInFocus wvInFocus2];
    peakCorr8LM(i,:) = peakCorr;
    [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
     ARCwvInFocusConesMeanZsandbox(subjNumAll(i),8,LminusMweights(i,:),[]);
    wvInFocusLminusM8(i,:) = wvInFocus; 

    [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
     ARCwvInFocusConesMeanZsandbox(subjNumAll(i),1,LMSweights(i,:),[]);
    wvInFocusLMS1(i,:) = wvInFocus;
    peakCorr1LMS(i,:) = peakCorr;
    [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
     ARCwvInFocusConesMeanZsandbox(subjNumAll(i),1,LMweights(i,:),[]);
    wvInFocusLM1(i,:) = [wvInFocus wvInFocus2];
    peakCorr1LM(i,:) = peakCorr;
    [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
     ARCwvInFocusConesMeanZsandbox(subjNumAll(i),1,LminusMweights(i,:),[]);
    wvInFocusLminusM1(i,:) = wvInFocus;

    [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
     ARCwvInFocusConesMeanZsandbox(subjNumAll(i),6,LMSweights(i,:),[]);
    wvInFocusLMS6(i,:) = wvInFocus;
    peakCorr6LMS(i,:) = peakCorr;
    [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
     ARCwvInFocusConesMeanZsandbox(subjNumAll(i),6,LMweights(i,:),[]);
    wvInFocusLM6(i,:) = [wvInFocus wvInFocus2];
    peakCorr6LM(i,:) = peakCorr;
    [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
     ARCwvInFocusConesMeanZsandbox(subjNumAll(i),6,LminusMweights(i,:),[]);
    wvInFocusLminusM6(i,:) = wvInFocus;    

    disp(['Subj ' num2str(i) ' done']);
end

%% MAKE EXAMPLE CONE IMAGES FOR SUBJECT 2 AT INFORMATIVE WAVELENGTHS

wave = 380:4:780;
wv2vis = [608 584 540 480];
stimInd = [1 8 6];
coneImgFilteredEgLMS = [];
coneImgFilteredEgLM = [];

for i = 1:length(stimInd)
    for j = 1:length(wv2vis)
        [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
         ARCwvInFocusConesMeanZsandbox(3,stimInd(i),LMSweights(2,:),find(wave==wv2vis(j)));
         coneImgFilteredEgLMS(:,:,i,j) = coneImgFilteredEg;

        [wvInFocus, coneImgFilteredEg, coneImgOrigFilteredEg, wvInFocus2, wave, peakCorr] = ...
         ARCwvInFocusConesMeanZsandbox(3,stimInd(i),LMweights(2,:),find(wave==wv2vis(j))); 
        coneImgFilteredEgLM(:,:,i,j) = coneImgFilteredEg;
    end
end

%% PLOT DIFFERENT CONE IMAGES FOR BUILDING MODEL INTUITIONS

redblue = make_red_blue_colormap(1);
axisLims = [min([coneImgFilteredEgLM(:); coneImgFilteredEgLMS(:)]) ...
            max([coneImgFilteredEgLM(:); coneImgFilteredEgLMS(:)])];
stimCell = {'More blue' 'Equal' 'More red'};

figure;
set(gcf,'Position',[16 103 558 868]);
for i = 1:length(wv2vis)
    subplot(4,2,(i-1)*2+1);
    imagesc(squeeze(coneImgFilteredEgLMS(:,:,1,i))); 
    axis square; 
    colormap(redblue); 
    xlim([50 120]); 
    ylim([55 125]); 
    colorbar; 
    clim(axisLims(2).*[-1 1])
    title(['\lambda_{focus} = ' num2str(wv2vis(i)) ', ' stimCell{1}]);
    subplot(4,2,(i-1)*2+2);
    imagesc(squeeze(coneImgFilteredEgLM(:,:,1,i))); 
    axis square; 
    colormap(redblue); 
    xlim([50 120]); 
    ylim([55 125]); 
    colorbar; 
    clim(axisLims(2).*[-1 1])    
end

figure;
set(gcf,'Position',[551 99 558 868]);
for i = 1:length(wv2vis)
    subplot(4,2,(i-1)*2+1);
    imagesc(squeeze(coneImgFilteredEgLMS(:,:,2,i))); 
    axis square; 
    colormap(redblue); 
    xlim([50 120]); 
    ylim([55 125]); 
    colorbar; 
    clim(axisLims(2).*[-1 1])
    title(['\lambda_{focus} = ' num2str(wv2vis(i)) ', ' stimCell{2}]);
    subplot(4,2,(i-1)*2+2);
    imagesc(squeeze(coneImgFilteredEgLM(:,:,2,i))); 
    axis square; 
    colormap(redblue); 
    xlim([50 120]); 
    ylim([55 125]); 
    colorbar; 
    clim(axisLims(2).*[-1 1])    
end

figure;
set(gcf,'Position',[1073 96 558 868]);
for i = 1:length(wv2vis)
    subplot(4,2,(i-1)*2+1);
    imagesc(squeeze(coneImgFilteredEgLMS(:,:,3,i))); 
    axis square; 
    colormap(redblue); 
    xlim([50 120]); 
    ylim([55 125]); 
    colorbar; 
    clim(axisLims(2).*[-1 1])
    title(['\lambda_{focus} = ' num2str(wv2vis(i)) ', ' stimCell{3}]);
    subplot(4,2,(i-1)*2+2);
    imagesc(squeeze(coneImgFilteredEgLM(:,:,3,i))); 
    axis square; 
    colormap(redblue); 
    xlim([50 120]); 
    ylim([55 125]); 
    colorbar; 
    clim(axisLims(2).*[-1 1])    
end

%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/helperFiles/wvInFocusAllModel.mat','wvInFocusAllTable','peakCorr8LMS','peakCorr8LM','peakCorr1LMS','peakCorr1LM','peakCorr6LMS','peakCorr6LM');

figure;
hold on;
for i = 1:8
    wvInFocusBlue = wvInFocusAllTable.("L+M-S1");
    wvInFocusPurple = wvInFocusAllTable.("L+M-S8");
    wvInFocusRed = wvInFocusAllTable.("L+M-S6");
    plot([wvInFocusBlue(i) wvInFocusPurple(i) wvInFocusRed(i)],'LineWidth',1);
end
plot(mean([wvInFocusBlue wvInFocusPurple wvInFocusRed]),'k-','LineWidth',2);
plot([0.5 3.5],[620 620],'r--','LineWidth',1);
plot([0.5 3.5],[460 460],'b--','LineWidth',1);
set(gca,'FontSize',15);
ylim([430 650]);
xlim([0.75 3.25]);
set(gca,'XTick',[1 2 3]);
set(gca,'XTickLabel',{'Bluest' 'Purple' 'Reddest'});
ylabel('Wavelength in focus (nm)');
legend({'S1' 'S2' 'S3' 'S4' 'S5' 'S6' 'S7' 'S8' 'Average'},'Location','SouthEast');
title('No green model predictions');

%%

load('/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/helperFiles/wvInFocusAllModel.mat','wvInFocusAllTable','peakCorr8LMS','peakCorr8LM','peakCorr1LMS','peakCorr1LM','peakCorr6LMS','peakCorr6LM');
wave = 380:4:780;

figure;
set(gcf,'Position',[263 365 1287 574]);
for i = 1:8
   subplot(2,4,i);
   plot(wave,peakCorr1LMS(i,:),'b-','LineWidth',1); 
   hold on; 
   plot(wave,peakCorr1LM(i,:),'k-','LineWidth',1)
   if i==1
       xlabel('Wavelength in focus (nm)');
       ylabel('Normalized cross-correlation');
   end   
   set(gca,'FontSize',15);
   axis square;
   title('Bluest');
end

figure;
set(gcf,'Position',[263 365 1287 574]);
for i = 1:8
   subplot(2,4,i);
   plot(wave,peakCorr6LMS(i,:),'b-','LineWidth',1); 
   hold on; 
   plot(wave,peakCorr6LM(i,:),'k-','LineWidth',1)
   if i==1
       xlabel('Wavelength in focus (nm)');
       ylabel('Normalized cross-correlation');
   end
   set(gca,'FontSize',15);
   axis square;   
   title('Reddest');
end

figure;
set(gcf,'Position',[263 365 1287 574]);
for i = 1:8
   subplot(2,4,i);
   plot(wave,peakCorr8LMS(i,:),'b-','LineWidth',1); 
   hold on; 
   plot(wave,peakCorr8LM(i,:),'k-','LineWidth',1)
   if i==1
       xlabel('Wavelength in focus (nm)');
       ylabel('Normalized cross-correlation');
   end
   set(gca,'FontSize',15);
   axis square; 
   title('Purple');
end

