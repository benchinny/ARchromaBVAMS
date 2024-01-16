%%

filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';

if strcmp(getenv('username'),'bankslab')
   dataDirectory = [filePath 'ARC\'];
elseif strcmp(getenv("USER"),'benjaminchin')
   dataDirectory = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Analysis/'; 
elseif strcmp(getenv("USER"),'emily')
   dataDirectory = '/Users/emily/Library/CloudStorage/GoogleDrive-emilyacooper@gmail.com/Shared drives/ARChroma/Analysis/';
end
filenames = {
%              [dataDirectory 'S1006V7_AFC_RightACL0_2312211410.mat'] ...
%              [dataDirectory 'S1006V7_AFC_RightACL0_2312211413.mat'] ...
%              [dataDirectory 'S1006V7_AFC_RightACL0_2312211415.mat'] ...
%              [dataDirectory 'S1006V7_AFC_RightACL0_2312211421.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401101331.mat'] ... 
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401101401.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401101430.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401101623.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401111550.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401121659.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401121728.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401121749.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401121805.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401131237.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401141627.mat'] ...
%              [dataDirectory 'S1006V8_AFC_RightACL0_2401141644.mat'] ...
             [dataDirectory 'S1006V8_AFC_RightACL0_2401141706.mat'] ...
             [dataDirectory 'S1006V8_AFC_RightACL0_2401141721.mat'] ...               
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

unqFocDst = unique(focStmOptDstIncr);
scaleFac = 0.8;

for i = 1:length(unqFocDst)
    PC(i) = sum(rspAcu(focStmOptDstIncr==unqFocDst(i))==stimOrientation(focStmOptDstIncr==unqFocDst(i)))./sum(focStmOptDstIncr==unqFocDst(i)); 
end

figure;
plot(unqFocDst.*scaleFac,PC,'ko-','MarkerFaceColor','w');
axis square;
ylim([0 1]);
xlabel('Relative optical distance (D)');
ylabel('Proportion Correct');