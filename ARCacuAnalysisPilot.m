%%

% filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';
filePath = 'H:\Shared drives\CIVO_BVAMS\data\ARC\';

if strcmp(getenv('username'),'bankslab')
   dataDirectory = [filePath];
elseif strcmp(getenv("USER"),'benjaminchin')
   dataDirectory = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Analysis/'; 
elseif strcmp(getenv("USER"),'emily')
   dataDirectory = '/Users/emily/Library/CloudStorage/GoogleDrive-emilyacooper@gmail.com/Shared drives/ARChroma/Analysis/';
end
filenames = {
             % [dataDirectory 'S1006V7_AFC_RightACL0_2312211410.mat'] ...
             % [dataDirectory 'S1006V7_AFC_RightACL0_2312211413.mat'] ...
             % [dataDirectory 'S1006V7_AFC_RightACL0_2312211415.mat'] ...
             % [dataDirectory 'S1006V7_AFC_RightACL0_2312211421.mat'] ...
             % [dataDirectory 'S1006V8_AFC_RightACL0_2401101331.mat'] ... 
             % [dataDirectory 'S1006V8_AFC_RightACL0_2401101401.mat'] ...
             % [dataDirectory 'S1006V8_AFC_RightACL0_2401101430.mat'] ...
             % [dataDirectory 'S1006V8_AFC_RightACL0_2401101623.mat'] ...
             % [dataDirectory 'S1006V8_AFC_RightACL0_2401111550.mat'] ...

             % BEN HODGEPODGE OF RED CONDITIONS
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401121659.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401121728.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401121749.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401121805.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401131237.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401141627.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401141644.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401141706.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401141721.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401161033.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401161038.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401161057.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401161102.mat'] ...  
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401161120.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401161125.mat'] ...  

             % IONA RED
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191602.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191608.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191614.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191617.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191621.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191625.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191628.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191632.mat'] ...  
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191635.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401191639.mat'] ...  
             
             % IONA PURPLE
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241557.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241553.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241550.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241546.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241543.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241539.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241535.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241532.mat'] ...  
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241526.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401241521.mat'] ...  

%              % IONA BLUE
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251608.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251604.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251601.mat'] ...  
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251557.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251553.mat'] ...  
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251632.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251629.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251625.mat'] ...  
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251622.mat'] ...
             % [dataDirectory 'S1007V9_AFC_RightACL0_2401251618.mat'] ...   
             
                  % MUHAMMAD RED
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261620.mat'] ...  
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261617.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261613.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261608.mat'] ...  
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261604.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261559.mat'] ...   
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261636.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261633.mat'] ...  
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261630.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401261626.mat'] ...  

                  % IONA RED
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301648.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301652.mat'] ...  
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301655.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301658.mat'] ...    
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301702.mat'] ...    
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301709.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301713.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301716.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301719.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401301722.mat'] ...
                    
                  % MUHAMMAD BLUE
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011140.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011136.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011133.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011129.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011125.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011145.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011148.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011151.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011154.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2402011157.mat'] ...

                  % MUHAMMAD PURPLE
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291344.mat'] ...   
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291341.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291337.mat'] ...  
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291333.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291328.mat'] ...  
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291405.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291402.mat'] ...  
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291359.mat'] ...
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291355.mat'] ...    
                  % [dataDirectory 'S1007V9_AFC_RightACL0_2401291350.mat'] ...

                  % BEN PURPLE
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121426.mat'] ...   
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121430.mat'] ...
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121434.mat'] ...  
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121438.mat'] ...
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121442.mat'] ...  
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121447.mat'] ...
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121451.mat'] ...  
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121456.mat'] ...
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121501.mat'] ...    
                  % [dataDirectory 'S1007V15_AFC_RightACL0_2402121505.mat'] ...  

                  % JD PURPLE
                  [dataDirectory 'S1011V8_AFC_RightACL0_2408201000.mat'] ...
                  [dataDirectory 'S1011V8_AFC_RightACL0_2408201005.mat'] ... 
                  [dataDirectory 'S1011V8_AFC_RightACL0_2408201009.mat'] ... 
                  [dataDirectory 'S1011V8_AFC_RightACL0_2408201015.mat'] ... 
             };

rgb = [];
meanFocstmOptDst = [];
focStmOptDstIncr = [];
rspAcu = [];
stimOrientation = [];

for i = 1:length(filenames)
    load(filenames{i});
    rgb = [rgb; AFCp.rgb];
    meanFocstmOptDst = [meanFocstmOptDst; AFCp.meanFocstmOptDst];
    focStmOptDstIncr = [focStmOptDstIncr; AFCp.focStmOptDstIncr];
    rspAcu = [rspAcu; AFCp.rspAcu'];
    stimOrientation = [stimOrientation; AFCp.stimOrientation];
end

if size(unique(rgb,'rows'),1)>1
   error('ARCacuAnalysisPilot: code does not handle multiple colors yet!');
else
   rgbUnq = unique(rgb,'rows');
end

unqFocDst = unique(focStmOptDstIncr);
scaleFac = 0.8;
% meanFocInt = 5;

for i = 1:length(unqFocDst)
%    PC(i) = sum(rspAcu(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt)==stimOrientation(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt))./sum(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt); 
     PC(i) = sum(rspAcu(focStmOptDstIncr==unqFocDst(i))==stimOrientation(focStmOptDstIncr==unqFocDst(i)))./sum(focStmOptDstIncr==unqFocDst(i));
     PCci(:,i) = binoinv([0.16 0.84],sum(focStmOptDstIncr==unqFocDst(i)),PC(i))./sum(focStmOptDstIncr==unqFocDst(i));
end

figure;
% plot(unqFocDst.*scaleFac,PC,'o-','Color',rgbUnq,'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
errorbar(unqFocDst.*scaleFac,PC,PC-PCci(1,:),PCci(2,:)-PC,'o-','Color',rgbUnq,'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
axis square;
ylim([0.4 1]);
formatFigure('Relative optical distance (D)','Proportion Correct');
