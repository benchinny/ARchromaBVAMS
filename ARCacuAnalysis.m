%%

rgb = [];
meanFocstmOptDst = [];
focStmOptDstIncr = [];
rspAcu = [];
stimOrientation = [];
filePath = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Analysis/';
subj = 'IM';
if strcmp(subj,'IM')
    filenames = {[filePath 'S1005V16_AFC_RightACL0_2311141650.mat'] ...
                 [filePath 'S1005V15_AFC_RightACL0_2311141641.mat'] ...
                 [filePath 'S1005V14_AFC_RightACL0_2311141628.mat'] ...
                 [filePath 'S1005V13_AFC_RightACL0_2311141616.mat'] ...
                 [filePath 'S1005V12_AFC_RightACL0_2311141604.mat']};
end
if strcmp(subj,'BC')
    filenames = {[filePath 'S1003V18_AFC_RightACL0_2311141111.mat'] ...
                 [filePath 'S1003V18_AFC_RightACL0_2311141123.mat'] ...
                 [filePath 'S1003V18_AFC_RightACL0_2311141137.mat'] ...
                 [filePath 'S1003V18_AFC_RightACL0_2311141428.mat']};
end

for i = 1:length(filenames)
    load(filenames{i});
    if i==3 && strcmp(subj,'IM')
        rgb = [rgb; AFCp.rgb(1:131,:)];
        meanFocstmOptDst = [meanFocstmOptDst; AFCp.meanFocstmOptDst(1:131)];
        focStmOptDstIncr = [focStmOptDstIncr; AFCp.focStmOptDstIncr(1:131)];
        rspAcu = [rspAcu; AFCp.rspAcu(1:131)'];
        stimOrientation = [stimOrientation; AFCp.stimOrientation(1:131)];
    else
        rgb = [rgb; AFCp.rgb];
        meanFocstmOptDst = [meanFocstmOptDst; AFCp.meanFocstmOptDst];
        focStmOptDstIncr = [focStmOptDstIncr; AFCp.focStmOptDstIncr];
        rspAcu = [rspAcu; AFCp.rspAcu'];
        stimOrientation = [stimOrientation; AFCp.stimOrientation];
    end
end

ind = rgb(:,1)==0 & rgb(:,3)>0;


