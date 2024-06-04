function [strtBVAMS, chng1BVAMS, chng2BVAMS, endBVAMS, strtFIAT, endFIAT] = ARCtimingAnalysisFIAT(subjNum)

if subjNum==1
    subjName = 'BenChin-OS';
    blockNums = [2 3 4 5 6];
    trialNums = [[1:20]' [1:20]' [1:20]' [1:20]' [1:20]'];
end

strtBVAMS = [];
chng1BVAMS = [];
chng2BVAMS = [];
endBVAMS = [];
strtFIAT = [];
endFIAT = [];

for i = 1:length(blockNums)
    AFCp = ARCloadFileBVAMS(subjNum,blockNums(i));
    for j = 1:size(AFCp.t3,1)
        tTmp = squeeze(AFCp.t3(j,4:6,:));
        tTmpSecs = tTmp(1,:)*3600 + tTmp(2,:)*60 + tTmp(3,:);
        strtBVAMS(end+1,:) = tTmpSecs(1);
        chng1BVAMS(end+1,:) = tTmpSecs(4);
        chng2BVAMS(end+1,:) = tTmpSecs(5);
        endBVAMS(end+1,:) = tTmpSecs(6);
        [~, ~, TimeStamp] = ARCloadFileFIAT(subjName,blockNums(i),j,1);
    end
end

end