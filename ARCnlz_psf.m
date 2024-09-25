function ARCnlz_psf

if strcmp(getenv('username'),'bankslab')
   foldername = 'H:\Shared drives\CIVO_BVAMS\data\ARC\';
elseif strcmp(getenv("USER"),'benchin')
   foldername = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/ARC/';
elseif strcmp(getenv("USER"),'benjaminchin')
   foldername = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/ARC/';
end

subjNum = 13;
fitType = 'weibull';

if subjNum==18
    filenames = {
                 'S1018V1_AFC_RightACL0_2409061234.mat' ...
                 'S1018V1_AFC_RightACL0_2409061236.mat' ...
                 'S1018V1_AFC_RightACL0_2409061237.mat' ...
                 'S1018V1_AFC_RightACL0_2409061240.mat' ...
                 'S1018V1_AFC_RightACL0_2409061243.mat' ...
                 'S1018V1_AFC_RightACL0_2409061247.mat' ...
                 'S1018V8_AFC_RightACL0_2409110958.mat' ...
                 'S1018V8_AFC_RightACL0_2409111004.mat' ...
                 'S1018V8_AFC_RightACL0_2409110958.mat' ...
                 'S1018V8_AFC_RightACL0_2409111007.mat' ...
                 'S1018V8_AFC_RightACL0_2409111016.mat' ...
                 'S1018V8_AFC_RightACL0_2409111019.mat' ...
                 'S1018V8_AFC_RightACL0_2409111022.mat' ...
                 'S1018V8_AFC_RightACL0_2409111024.mat' ...
                 };
elseif subjNum==20
    filenames = {
                 % 'S1020V1_AFC_RightACL0_2409091341.mat' ...
                 'S1020V1_AFC_RightACL0_2409091343.mat' ...
                 'S1020V1_AFC_RightACL0_2409091344.mat' ...
                 'S1020V1_AFC_RightACL0_2409091347.mat' ...
                 'S1020V1_AFC_RightACL0_2409091352.mat' ...
                 'S1020V1_AFC_RightACL0_2409091357.mat' ...
                 'S1020V1_AFC_RightACL0_2409091400.mat' ...
                 'S1020V1_AFC_RightACL0_2409091404.mat' ...
                 'S1020V1_AFC_RightACL0_2409091407.mat' ...
                 'S1020V1_AFC_RightACL0_2409091410.mat' ...
                 'S1020V1_AFC_RightACL0_2409091414.mat' ...
                 'S1020V1_AFC_RightACL0_2409091416.mat' ...
                 'S1020V1_AFC_RightACL0_2409091420.mat' ...
                 'S1020V9_AFC_RightACL0_2409111540.mat' ...
                 'S1020V9_AFC_RightACL0_2409111542.mat' ...
                 'S1020V9_AFC_RightACL0_2409111544.mat' ...
                 };    
elseif subjNum==11
    filenames = {
                 'S1011V17_AFC_RightACL0_2409100948.mat' ...
                 'S1011V17_AFC_RightACL0_2409100949.mat' ...
                 'S1011V17_AFC_RightACL0_2409100955.mat' ...
                 'S1011V17_AFC_RightACL0_2409101002.mat' ...
                 'S1011V17_AFC_RightACL0_2409101007.mat' ...
                 'S1011V17_AFC_RightACL0_2409101014.mat' ...
                 'S1011V17_AFC_RightACL0_2409101019.mat' ...
                 };        
elseif subjNum==13
    filenames = {
                 'S1013V18_AFC_RightACL0_2409171533.mat' ...
                 'S1013V18_AFC_RightACL0_2409171535.mat' ...
                 'S1013V18_AFC_RightACL0_2409171543.mat' ...
                 'S1013V18_AFC_RightACL0_2409171547.mat' ...
                 'S1013V18_AFC_RightACL0_2409171559.mat' ...
                 'S1013V18_AFC_RightACL0_2409171604.mat' ...
                 'S1013V18_AFC_RightACL0_2409171610.mat' ...
                 };         
elseif subjNum==15
    filenames = {
                 'S1015V9_AFC_RightACL0_2409181657.mat' ...
                 'S1015V9_AFC_RightACL0_2409181652.mat' ...
                 'S1015V9_AFC_RightACL0_2409181650.mat' ...
                 'S1015V9_AFC_RightACL0_2409181648.mat' ...
                 'S1015V9_AFC_RightACL0_2409181646.mat' ...
                 'S1015V9_AFC_RightACL0_2409181639.mat' ...
                 'S1015V9_AFC_RightACL0_2409181633.mat' ...
                 'S1015V9_AFC_RightACL0_2409181622.mat' ...
                 };             
elseif subjNum==26
    filenames = {
                 'S1026V1_AFC_RightACL0_2409161339.mat' ...
                 'S1026V1_AFC_RightACL0_2409161341.mat' ...
                 'S1026V1_AFC_RightACL0_2409161343.mat' ...
                 'S1026V1_AFC_RightACL0_2409161347.mat' ...
                 'S1026V1_AFC_RightACL0_2409161350.mat' ...
                 'S1026V1_AFC_RightACL0_2409161353.mat' ...
                 'S1026V1_AFC_RightACL0_2409161359.mat' ...
                 'S1026V1_AFC_RightACL0_2409161403.mat' ...
                 'S1026V1_AFC_RightACL0_2409161408.mat' ...
                 };             
end

for i = 1:length(filenames)
    load([foldername filenames{i}]);
    lengthRsp = length(AFCp.rspAcu);
    AFCp.t3 = AFCp.t3(1:lengthRsp,:,:);
    AFCp.rgb = AFCp.rgb(1:lengthRsp,:);
    AFCp.meanFocstmOptDst = AFCp.meanFocstmOptDst(1:lengthRsp);
    AFCp.contrast = AFCp.contrast(1:lengthRsp);
    AFCp.rspAcu = AFCp.rspAcu';
    AFCp.stimOrientation = AFCp.stimOrientation(1:lengthRsp);
    if i==1
        AFCpAll = AFCp;
    else
        AFCpAll = structmerge(AFCpAll,AFCp);
    end
end

rgbUnq = [0.569 0.000 0.000; ...
          0.000 0.432 0.000; ...
          0.000 0.000 1.000; ...
          0.569 0.000 1.000];

if strcmp(fitType,'gauss')
    figure;
    set(gcf,'Position',[414 281 1013 660]);
    for i = 1:size(rgbUnq,1)
        ind = abs(AFCpAll.rgb(:,1)-rgbUnq(i,1))<0.001 & ...
              abs(AFCpAll.rgb(:,2)-rgbUnq(i,2))<0.001 & ...
              abs(AFCpAll.rgb(:,3)-rgbUnq(i,3))<0.001;
        [mFit,sFit,bFit,Tfit,PCdta,PCfit,negLL] = psyfitgengauss(zeros(size(AFCpAll.contrast(ind))),AFCpAll.contrast(ind),AFCpAll.rspAcu(ind)==AFCpAll.stimOrientation(ind),0,[],[],1.48,2,0);
        if subjNum==13
           contrastIncr = 0.1:0.01:1;
        else
           contrastIncr = 0.2:0.01:1;
        end
        [PCplt,~]=psyfitgengaussfunc(zeros(size(contrastIncr)),contrastIncr,mFit,sFit,bFit,1.48,2,0);
        subplot(2,2,i);
        hold on;
        plot([1 1].*(mFit+Tfit),[min(contrastIncr) 1].*0.85,'k--','LineWidth',1);
        plot([min(contrastIncr) 1].*(mFit+Tfit),[1 1].*0.85,'k--','LineWidth',1);
        plot(contrastIncr,PCplt,'-','Color',rgbUnq(i,:),'LineWidth',1);
        plot(unique(AFCpAll.contrast(ind)),PCdta,'o','Color',rgbUnq(i,:),'LineWidth',1,'MarkerSize',10,'MarkerFaceColor','w');
        axis square;
        xlabel('Contrast');
        ylabel('Proportion correct');
        title(['Subj ' num2str(subjNum-10) ', Threshold = ' num2str(mFit+Tfit,2)]);
        set(gca,'FontSize',15);
        xlim([min(contrastIncr) 1]);
        ylim([0.3 1]);
    end
end

if strcmp(fitType,'weibull')
    figure;
    set(gcf,'Position',[414 281 1013 660]);
    for i = 1:size(rgbUnq,1)
        ind = abs(AFCpAll.rgb(:,1)-rgbUnq(i,1))<0.001 & ...
              abs(AFCpAll.rgb(:,2)-rgbUnq(i,2))<0.001 & ...
              abs(AFCpAll.rgb(:,3)-rgbUnq(i,3))<0.001;
        [mFit,sFit,bFit,Tfit,PCdta,PCfit,negLL] = psyfitWeibull(zeros(size(AFCpAll.contrast(ind))),AFCpAll.contrast(ind),AFCpAll.rspAcu(ind)==AFCpAll.stimOrientation(ind),[],[],[],1.48,2,0);
        if subjNum==13
           contrastIncr = 0.1:0.01:1;
        else
           contrastIncr = 0.2:0.01:1;
        end
        [PCplt,~]=psyfitWeibullfunc(zeros(size(contrastIncr)),contrastIncr,mFit,sFit,bFit,1.48,2,0);
        subplot(2,2,i);
        hold on;
        plot([1 1].*(mFit+Tfit),[min(contrastIncr) 1].*0.85,'k--','LineWidth',1);
        plot([min(contrastIncr) 1].*(mFit+Tfit),[1 1].*0.85,'k--','LineWidth',1);
        plot(contrastIncr,PCplt,'-','Color',rgbUnq(i,:),'LineWidth',1);
        plot(unique(AFCpAll.contrast(ind)),PCdta,'o','Color',rgbUnq(i,:),'LineWidth',1,'MarkerSize',10,'MarkerFaceColor','w');
        axis square;
        xlabel('Contrast');
        ylabel('Proportion correct');
        title(['Subj ' num2str(subjNum-10) ', Threshold = ' num2str(mFit+Tfit,2)]);
        set(gca,'FontSize',15);
        xlim([min(contrastIncr) 1]);
        ylim([0.3 1]);
    end
end

end