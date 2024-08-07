%%

subjNum = 1;
trialNumAll = 1:20;
wLMSall = [0.8 0.1 0.1; 0.1 0.8 0.1; 0.1 0.1 0.8];

for i = 1:size(wLMSall,1)
    wLMS = wLMSall(i,:);
    for j = 1:length(trialNumAll)
        trialNum = trialNumAll(j);
        wvInFocus(i,j) = ARCwvInFocusCones(subjNum,trialNum,wLMS);
        display(['Weight set ' num2str(i) ', trial number ' num2str(j)]);
    end
end

%%

figure; 
hold on;
histogram(wvInFocus(1,:),11,'FaceColor','r');
histogram(wvInFocus(2,:),11,'FaceColor','g');
histogram(wvInFocus(3,:),11,'FaceColor','b');
