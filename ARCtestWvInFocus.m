%%

subjNum = 10;
blockNumAll = 3:8;
trialNumAll = 1:36;
wLunq = 0:0.1:1;
wMunq = 0:0.1:1;

for i = 1:length(wLunq)
    for j = 1:length(wMunq)
        wL = wLunq(i);
        wM = wMunq(j);
        wS = 1-wL-wM;
        for k = 1:length(blockNumAll)
            for l = 1:length(trialNumAll)
                wvInFocus(k,l) = ARCwvInFocusCones(subjNum,blockNumAll(k),trialNumAll(l),[wL wM wS]);
                display(['wLind = ' num2str(wLunq(i)) ', wMind = ' num2str(wMunq(j)) ', block number ' num2str(blockNumAll(k)) ', trial number ' num2str(trialNumAll(l))]);  
                % LOAD ZERNIKE TABLE AND TIMESTAMPS
                [ZernikeTable, ~, ~, TimeStamp] = ARCloadFileFIAT(subjName,blockNumTmp,trialNumTmp,0);
        
                NumCoeffs = width(ZernikeTable)-8; % determine how many coefficients are in the cvs file. 
                c=zeros(size(ZernikeTable,1),65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65. 
                PARAMS = struct;
                PARAMS.PupilSize=mean(table2array(ZernikeTable(:,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
                PARAMS.PupilFitSize=mean(table2array(ZernikeTable(:,5))); 
                PARAMS.PupilFieldSize=PARAMS.PupilSize*2; %automatically compute the field size
                c(:,3:NumCoeffs)=table2array(ZernikeTable(:,11:width(ZernikeTable)));
                indBad = c(:,4)==0;
                meanC = mean(c(~indBad,:),1); % TAKE MEAN OF COEFFICIENTS                
            end
        end
    end
end

%%

figure; 
hold on;
histogram(wvInFocus(1,:),11,'FaceColor','r');
histogram(wvInFocus(2,:),11,'FaceColor','g');
histogram(wvInFocus(3,:),11,'FaceColor','b');
