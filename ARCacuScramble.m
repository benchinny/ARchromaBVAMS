%%

rgb = [0.555 0 1];
meanFocstmOptDst = [2]*1.149;
focStmOptDstIncr = -1.2:0.3:1.2;
trlPerLvl = 4;

rgbAll = [];
meanFocstmOptDstAll = [];
focStmOptDstIncrAll = [];
indAcuRBall = [];
indScramble = [];
maskBrightness = 0;
maskSize = [100 100];
gammaR = 2.4;
gammaG = 2.6;
gammaB = 2.2;
frqCpdRB = 15;
rgbAcuRB = [0.555 0 0; 0 0 1];

% CAREFUL ATTEMPT TO BLOCK CONDITIONS SO EACH OPTICAL DISTANCE INCREMENT IS
% PRESENTED ONCE PER BLOCK
for i = 1:size(rgb,1)
   for j = 1:length(meanFocstmOptDst)
       for m = 1:size(rgbAcuRB,1)
           for k = 1:length(focStmOptDstIncr)           
               rgbAll(end+1,:) = rgb(i,:);
               meanFocstmOptDstAll(end+1,:) = meanFocstmOptDst(j);
               focStmOptDstIncrAll(end+1,:) = focStmOptDstIncr(k);
               indAcuRBall(end+1,:) = m;
           end
       end
       for l = 1:trlPerLvl
          indScramble = [indScramble; randperm(length(focStmOptDstIncr)*size(rgbAcuRB,1))'];
       end
   end
end

% RANDOMIZING TRIALS
indScramble = indScramble+imresize(length(focStmOptDstIncr).*size(rgbAcuRB,1).*[0:(trlPerLvl*size(rgb,1)*length(meanFocstmOptDst)-1)]',size(indScramble),'nearest');
rgbAll = repmat(rgbAll,[trlPerLvl 1]);
meanFocstmOptDstAll = repmat(meanFocstmOptDstAll,[trlPerLvl 1]);
focStmOptDstIncrAll = repmat(focStmOptDstIncrAll,[trlPerLvl 1]);
indAcuRBall = repmat(indAcuRBall,[trlPerLvl 1]);
stimSizePixAll = 10.*ones(size(focStmOptDstIncrAll));
offsetXall = 5.*ones(size(focStmOptDstIncrAll));
offsetYall = 10.*ones(size(focStmOptDstIncrAll));
sizeTotal = 100;
stimCtr = 50;
rgbAll = rgbAll(indScramble,:);
meanFocstmOptDstAll = meanFocstmOptDstAll(indScramble);
focStmOptDstIncrAll = focStmOptDstIncrAll(indScramble);
stimSizePixAll = stimSizePixAll(indScramble);
indAcuRBall = indAcuRBall(indScramble);

% ADD DUMMY TRIAL RIGHT AT THE END (PECULIAR TO WAY CODE IS WRITTEN)
rgbAll(end+1,:) = [0 0 0];
focStmOptDstIncrAll(end+1,:) = 0;
meanFocstmOptDstAll(end+1,:) = 3;
stimSizePixAll(end+1,:) = 10;
indAcuRBall(end+1,:) = 1;
