function filenameCell = ARCacuAnalysisWvfSubj(subjNum)

if strcmp(getenv("USER"),'ben')
   dataFolder= '/home/ben/Documents/ARchroma/FIAT/csvFiles/SUBJ/';
elseif strcmp(getenv("USER"),'benchin')
   dataFolder = '/Users/benchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/csvFiles/SUBJ/';
else
   dataFolder = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/csvFiles/SUBJ/';
end

dirAll = dir(dataFolder);

filenamesAll = {dirAll.name};

if subjNum==9
    % filenameCell = { ...
    %                 'S19-OD-Block_9-Trial_99-4_240930_100151_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_99-4_240930_100812_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_99-4_240930_101500_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_89-4_240930_101427_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_89-4_240930_100740_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_89-4_240930_100119_proc.csv' ... 
    %                 'S19-OD-Block_9-Trial_79-4_240930_100048_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_79-4_240930_101355_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_69-4_240930_101324_proc.csv' ...     
    %                 'S19-OD-Block_9-Trial_69-4_240930_100016_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_69-4_240930_093304_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_69-4_240930_093935_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_69-4_240930_092547_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_79-4_240930_092620_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_79-4_240930_093336_proc.csv' ... 
    %                 'S19-OD-Block_9-Trial_89-4_240930_092652_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_89-4_240930_093408_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_89-4_240930_094043_proc.csv' ... 
    %                 'S19-OD-Block_9-Trial_19-4_240930_094322_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_19-4_240930_095735_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_19-4_240930_095045_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_29-4_240930_095808_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_29-4_240930_094354_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_29-4_240930_095116_proc.csv' ... 
    %                 'S19-OD-Block_9-Trial_44-4_241004_121716_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_44-4_241004_122518_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_44-4_241004_123149_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_54-4_241004_122553_proc.csv' ...
    %                 'S19-OD-Block_9-Trial_54-4_241004_123221_proc.csv' ...
    %             }; 
    subjName = 'S19-OD';
    blockNum = 9;
    trialNum = [99 89 79 69 19 29 44 54];
elseif subjNum==10
    subjName = 'S20-OD';
    blockNum = 10;
    trialNum = [1 17 33 49 65 81 97 108];
elseif subjNum==1
    subjName = 'S11-OD';
    blockNum = 18;
    trialNum = 1:13:183;
elseif subjNum==3
    subjName = 'S13-OD';
    blockNum = 19;
    trialNum = 1:13:105;
elseif subjNum==5
    subjName = 'S15-OD';
    blockNum = 19;
    trialNum = 1:13:105;    
end

filenameCell = {};

for i = 1:length(trialNum)
    filenameTmp = [subjName '-Block_' num2str(blockNum) '-Trial_' num2str(trialNum(i))];

    ind = find(contains(filenamesAll,filenameTmp) & ~contains(filenamesAll,'FullPupil'));
    for j = 1:length(ind)
        if contains(filenamesAll{ind(j)},'csv') && ~ismember(filenamesAll{ind(j)},filenameCell)
            filenameCell{end+1} = filenamesAll{ind(j)};
        end
    end
end

end