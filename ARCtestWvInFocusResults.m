%%

RMSEall = zeros([11 11 1]);
SvaluesAll = [0];
loadStr = {'0'};
folderPath = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneWeightsError/';
blockNums = 3:8;
rgbAll = [];

for i = 1:length(blockNums)
    AFCp = ARCloadFileBVAMS(20,blockNums(i));
    rgbAll = [rgbAll; AFCp.rgb100];
end

rgbAllGammaCorrected = [];
rgbAllGammaCorrected(:,1) = (rgbAll(:,1).^2.5)./0.2442;
rgbAllGammaCorrected(:,2) = (rgbAll(:,2).^2.7)./0.1037;
rgbAllGammaCorrected(:,3) = (rgbAll(:,3).^2.3)./1;
rgbAllGammaCorrected(rgbAllGammaCorrected>1) = 1;

for i = 1:length(loadStr)
    load([folderPath 'wvInFocusModelResults' num2str(loadStr{i}) '.mat']);
    RMSEall(:,:,i) = RMSE;
end

for i = 1:size(RMSEall,3)
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

predD = squeeze(defocus875predAll(:,:,10,4));
predD = predD(:);
actD = squeeze(defocus875all(:,:,10,4));
actD = actD(:);
figure; 
hold on;
for i = 1:length(predD)
    plot(predD(i),actD(i),'.','MarkerSize',12,'Color',rgbAllGammaCorrected(i,:)); 
end
axis square;
formatFigure('Predicted Defocus (D)','Actual Defocus (D)');

%%

clear;
