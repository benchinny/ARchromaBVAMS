%%

subjNumAll = [1 3 5 10 16 17 18 20];
stimNumAll = [1 3 5];
stimNumReal = [1 8 6];
imgQualQueryAll = [];
wvInFocusRawAll = [];
imgQualAll = [];

for i = 1:length(stimNumAll)
    for j = 1:length(subjNumAll)
        [waveInFocus3raw, waveInFocus3, wLMS] = ...
        ARCtestWvInFocusMeanZspatFilterLMSlagLeadEffect(subjNumAll(j),'LMS',stimNumAll(i));
        [imgQualQuery, peakCorr] = ARCwvInFocusConesMeanZspatFilterImgQual(subjNumAll(j),stimNumReal(i),wLMS,[waveInFocus3raw waveInFocus3]);
        imgQualQueryAll(i,j,:) = imgQualQuery;
        wvInFocusRawAll(i,j,:) = [waveInFocus3raw waveInFocus3];
        imgQualAll(i,j,:) = peakCorr;
    end
end

%%

stimString = {'More blue' 'Purple' 'More red'};
wave = 380:4:780;

for j = 1:length(stimNumAll)
    figure;
    set(gcf,'Position',[311 330 1236 594]);
    for i = 1:length(subjNumAll)
        subplot(2,4,i);
        hold on;
        plot(wave,squeeze(imgQualAll(j,i,:)),'k-','LineWidth',1);
        plot(squeeze(wvInFocusRawAll(j,i,2:4)),squeeze(imgQualQueryAll(j,i,2:4)),'kx-','LineWidth',1,'MarkerSize',10);
        plot(squeeze(wvInFocusRawAll(j,i,1)),squeeze(imgQualQueryAll(j,i,1)),'ko','LineWidth',1,'MarkerFaceColor','w','MarkerSize',10);
        axis square;
        ylim([0 1]);
        xlim([400 700]);
        set(gca,'FontSize',15);
        ylabel('Peak cross-correlation');
        xlabel('Wavelength in focus');
        if i==1
            title(stimString{j});
        end
    end
end

%%

defocusAtRef = -[0:0.1:4];
penalty = defocusAtRef.^2;
stimDist = 3.5;
wvInFocusPossible = 400:700;
wvRef = 550;

figure;
plot(defocusAtRef,penalty,'k-','LineWidth',1)
axis square;
set(gca,'FontSize',18);
xlabel('Defocus at 550nm');
ylabel('Penalty');

figure; 
plot(wvInFocusPossible,(humanWaveDefocusARC(wvInFocusPossible,wvRef,1)-stimDist).^2,'k-','LineWidth',1);
axis square;
set(gca,'FontSize',18);
xlabel('Wavelength-in-focus (nm)');
ylabel('Penalty (unitless?)');
