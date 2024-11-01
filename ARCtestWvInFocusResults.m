%%

RMSEall = zeros([11 11 7]);
SvaluesAll = [-0.6 -0.4 -0.2 0 0.2 0.4 0.6];

for i = 1:3
    load(['/Users/benjaminchin/Documents/ARchromaScraps/wvInFocusModelResults' num2str(i) '.mat']);
    if i==1
        RMSEall(:,:,3) = RMSE(:,:,1);
        RMSEall(:,:,4) = RMSE(:,:,2);
    end
    if i==2
        RMSEall(:,:,1) = RMSE(:,:,1);
        RMSEall(:,:,2) = RMSE(:,:,2);
        RMSEall(:,:,5) = RMSE(:,:,3);
        RMSEall(:,:,6) = RMSE(:,:,4);
    end    
    if i==3
        RMSEall(:,:,7) = RMSE(:,:,1);
    end
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
end

%%

clear;

%%

fileNum = 2;
Svalues = {[-0.2 0] [-0.6 -0.4 0.2 0.4] [0.6]};
SvaluesTmp = Svalues{fileNum};

load(['/Users/benjaminchin/Documents/ARchromaScraps/wvInFocusModelResults' num2str(fileNum) '.mat']);


for i = 1:size(RMSE,3)

    RMSEtmp = squeeze(RMSE(:,:,i)); 

    figure; 
    imagesc(RMSEtmp);
    xlabel('M weight');
    ylabel('L weight');
    axis square;
    set(gca,'FontSize',12);
    set(gca,'XTick',1:11);
    set(gca,'XTickLabel',{'-1' '-0.8' '-0.6' '-0.4' '-0.2' '0' '0.2' '0.4' '0.6' '0.8' '1'});
    set(gca,'YTickLabel',{'-1' '-0.8' '-0.6' '-0.4' '-0.2' '0' '0.2' '0.4' '0.6' '0.8' '1'});
    title(['S weight = ' num2str(SvaluesTmp(i))]);
end

%%

clear;
