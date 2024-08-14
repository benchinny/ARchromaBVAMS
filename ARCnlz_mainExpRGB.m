%%

subjNum = 11;

if subjNum==11 || subjNum==12
   blockNums = 2:7;
   trialNums = {1:33 1:33 1:33 1:33 1:33 1:33};
   subjName = ['S' num2str(subjNum) '-OD'];
end

for i = 1:length(blockNums)
    blockNumTmp = blockNums(i);
    trialNumsTmp = trialNums{i};
    AFCp = ARCloadFileBVAMS(subjNum,blockNumTmp);
    for j = 1:length(trialNumsTmp)
        [trialData, defocus, strehl, TimeStamp] = ARCloadFileFIAT(subjName,blockNumTmp,trialNumsTmp(j),0);
    end
end