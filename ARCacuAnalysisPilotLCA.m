%%

filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';

if strcmp(getenv('username'),'bankslab')
   dataDirectory = [filePath];
elseif strcmp(getenv("USER"),'benjaminchin')
   dataDirectory = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Analysis/'; 
elseif strcmp(getenv("USER"),'emily')
   dataDirectory = '/Users/emily/Library/CloudStorage/GoogleDrive-emilyacooper@gmail.com/Shared drives/ARChroma/Analysis/';
end
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
end

unqFocDst = unique(focStmOptDstIncr);
scaleFac = 0.8;
% meanFocInt = 5;

acuColors = [0.56 0 0; 0 0 1];
colorInd = 2;
for i = 1:length(unqFocDst)
    indCnd = focStmOptDstIncr==unqFocDst(i) & indAcuRB == colorInd;
%    PC(i) = sum(rspAcu(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt)==stimOrientation(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt))./sum(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt); 
     PC(i) = sum(rspAcu(indCnd)==stimOrientation(indCnd))./sum(indCnd);
     PCci(:,i) = binoinv([0.16 0.84],sum(indCnd),PC(i))./sum(indCnd);
end

figure;
% plot(unqFocDst.*scaleFac,PC,'o-','Color',rgbUnq,'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
errorbar(unqFocDst.*scaleFac,PC,PC-PCci(1,:),PCci(2,:)-PC,'o-','Color',acuColors(colorInd,:),'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
axis square;
ylim([0.4 1]);
formatFigure('Relative optical distance (D)','Proportion Correct');
