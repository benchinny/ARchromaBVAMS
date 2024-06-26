%%

% filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';
filePath = 'H:\Shared drives\CIVO_BVAMS\data\ARC\';

subj = 2;

if strcmp(getenv('username'),'bankslab')
   dataDirectory = [filePath];
elseif strcmp(getenv("USER"),'benjaminchin')
   dataDirectory = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Analysis/'; 
elseif strcmp(getenv("USER"),'emily')
   dataDirectory = '/Users/emily/Library/CloudStorage/GoogleDrive-emilyacooper@gmail.com/Shared drives/ARChroma/Analysis/';
end
if subj==1
    filenames = {
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111219.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111222.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111226.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111230.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111234.mat'] ... 
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111237.mat'] ... 
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111250.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111253.mat'] ... 
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111257.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111305.mat'] ... 
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111309.mat'] ... 
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111315.mat'] ... 
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111319.mat'] ... 
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111325.mat'] ... 
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111329.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111336.mat'] ... 
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111340.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111346.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111351.mat'] ...
                 [dataDirectory 'S1007V15_AFC_RightACL0_2402111355.mat'] ...
                 };
elseif subj==2
    filenames = {
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101420.mat'] ...
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101425.mat'] ...
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101428.mat'] ...
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101432.mat'] ...
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101435.mat'] ... 
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101439.mat'] ... 
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101443.mat'] ...
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101446.mat'] ... 
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101449.mat'] ...
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101453.mat'] ... 
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101515.mat'] ... 
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101519.mat'] ... 
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101524.mat'] ... 
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101528.mat'] ... 
                 [dataDirectory 'S1002V7_AFC_RightACL0_2406101535.mat'] ...
                 };    
end

rgb = [];
meanFocstmOptDst = [];
focStmOptDstIncr = [];
rspAcu = [];
stimOrientation = [];
indAcuRB = [];

for i = 1:length(filenames)
    load(filenames{i});
    rgb = [rgb; AFCp.rgb];
    meanFocstmOptDst = [meanFocstmOptDst; AFCp.meanFocstmOptDst];
    focStmOptDstIncr = [focStmOptDstIncr; AFCp.focStmOptDstIncr];
    rspAcu = [rspAcu; AFCp.rspAcu'];
    stimOrientation = [stimOrientation; AFCp.stimOrientation];
    indAcuRB = [indAcuRB; AFCp.indAcuRBall(1:end-1)'];
end

if size(unique(rgb,'rows'),1)>1
   error('ARCacuAnalysisPilot: code does not handle multiple colors yet!');
else
   rgbUnq = unique(rgb,'rows');
   rgbUnq = [0 0 1];
end

unqFocDst = unique(focStmOptDstIncr);
scaleFac = 0.87;
% meanFocInt = 5;

rgbAcuCnd = 2;
for i = 1:length(unqFocDst)
    indAnalysis = focStmOptDstIncr==unqFocDst(i) & indAcuRB==rgbAcuCnd;
%    PC(i) = sum(rspAcu(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt)==stimOrientation(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt))./sum(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt); 
     PC(i) = sum(rspAcu(indAnalysis)==stimOrientation(indAnalysis))./sum(indAnalysis);
     PCci(:,i) = binoinv([0.16 0.84],sum(focStmOptDstIncr==unqFocDst(i)),PC(i))./sum(focStmOptDstIncr==unqFocDst(i));
end

figure;
hold on;
plot(unqFocDst.*scaleFac,PC,'o-','Color',rgbUnq,'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
errorbar(unqFocDst.*scaleFac,PC,PC-PCci(1,:),PCci(2,:)-PC,'o-','Color',rgbUnq,'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
axis square;
ylim([0.4 1]);
formatFigure('Relative optical distance (D)','Proportion Correct');