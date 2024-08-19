%%

% filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';
filePath = 'H:\Shared drives\CIVO_BVAMS\data\ARC\';

subj = 1;

if strcmp(getenv('username'),'bankslab')
   dataDirectory = [filePath];
elseif strcmp(getenv("USER"),'benjaminchin')
   dataDirectory = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Analysis/'; 
elseif strcmp(getenv("USER"),'emily')
   dataDirectory = '/Users/emily/Library/CloudStorage/GoogleDrive-emilyacooper@gmail.com/Shared drives/ARChroma/Analysis/';
end
if subj==1
    filenames = {
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408161637.mat'] ...
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408191326.mat'] ...
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408191333.mat'] ...
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408191345.mat'] ...
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408191352.mat'] ...
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408191359.mat'] ...
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408191417.mat'] ...
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408191424.mat'] ...
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408191432.mat'] ...
                 [dataDirectory 'S1001V12_AFC_RightACL0_2408191439.mat'] ...
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

%%

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
    indAcuRB = [indAcuRB; AFCp.indAcuRGBall(1:end-1)];
end

if size(unique(rgb,'rows'),1)>1
   error('ARCacuAnalysisPilot: code does not handle multiple colors yet!');
else
   rgbUnq = unique(rgb,'rows');
   rgbUnq = [0 0 1];
end

unqFocDst = unique(focStmOptDstIncr);
scaleFac = 0.816;
% meanFocInt = 5;

rgbAcuCnd = 1;
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