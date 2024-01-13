%%

filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';
filenames = {
%              [filePath 'S1006V7_AFC_RightACL0_2312211410.mat'] ...
%              [filePath 'S1006V7_AFC_RightACL0_2312211413.mat'] ...
%              [filePath 'S1006V7_AFC_RightACL0_2312211415.mat'] ...
%              [filePath 'S1006V7_AFC_RightACL0_2312211421.mat'] ...
%              [filePath 'S1006V8_AFC_RightACL0_2401101331.mat'] ... 
%              [filePath 'S1006V8_AFC_RightACL0_2401101401.mat'] ...
%              [filePath 'S1006V8_AFC_RightACL0_2401101430.mat'] ...
%              [filePath 'S1006V8_AFC_RightACL0_2401101623.mat'] ...
%              [filePath 'S1006V8_AFC_RightACL0_2401111550.mat'] ...
%              [filePath 'S1006V8_AFC_RightACL0_2401121659.mat'] ...
%              [filePath 'S1006V8_AFC_RightACL0_2401121728.mat'] ...
%              [filePath 'S1006V8_AFC_RightACL0_2401121749.mat'] ...
               [filePath 'S1006V8_AFC_RightACL0_2401121805.mat'] ...
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