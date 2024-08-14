%%

subjNum = 11;

if subjNum==11 || subjNum==12
   blockNums = 2:7;
   trialNums = {1:33 1:33 1:33 1:33 1:33 1:33};
   subjName = ['S' num2str(subjNum) '-OD'];
end

meanC = [];
rgb1all = [];
meanv00all = [];
nIndBadTracker = [];

for i = 1:length(blockNums)
    blockNumTmp = blockNums(i);
    trialNumsTmp = trialNums{i};
    AFCp = ARCloadFileBVAMS(subjNum,blockNumTmp);
    for j = 1:length(trialNumsTmp)
        [ZernikeTable, ~, ~, ~] = ARCloadFileFIAT(subjName,blockNumTmp,trialNumsTmp(j),0);
        NumCoeffs = width(ZernikeTable)-8; % determine how many coefficients are in the cvs file. 
        c=zeros(size(ZernikeTable,1),65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65.
        indBadPupil = table2array(ZernikeTable(:,5))==0;
        PARAMS.PupilSize=mean(table2array(ZernikeTable(~indBadPupil,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
        PARAMS.PupilFitSize=mean(table2array(ZernikeTable(~indBadPupil,5))); 
        PARAMS.PupilFieldSize=PARAMS.PupilSize*2; %automatically compute the field size
        c(:,3:NumCoeffs)=table2array(ZernikeTable(:,11:width(ZernikeTable)));
        indBad = c(:,4)==0;
        nIndBadTracker(end+1) = sum(indBad);
        c(indBad,4) = mean(c(~indBad,4));
        meanC(end+1,:) = mean(c,1); % TAKE MEAN OF COEFFICIENTS        
    end
    rgb1all = [rgb1all; AFCp.rgb100];
    meanv00all = [meanv00all; AFCp.meanv00./1.2255];
end

%%

defocusCorrectionFactor = (1e6/(4*sqrt(3)))*((PARAMS.PupilSize/2000)^2);
defocusAt550 = humanWaveDefocus(875)-humanWaveDefocus(550)+meanC(:,4)./defocusCorrectionFactor;

figure; 
plot(meanv00all,defocusAt550,'ko');
set(gca,'FontSize',15);
xlim([1 4]);
axis square;
xlabel('Stimulus optical distance');
ylabel('Raw refractive power (D)');

%%

lumScaleRGB = [4.0888 9.6669 1];

gammaRGB = [2.5 2.7 2.3];

rgbLumNorm = [lumScaleRGB(1).*rgb1all(:,1).^gammaRGB(1) lumScaleRGB(2).*rgb1all(:,2).^gammaRGB(2) lumScaleRGB(3).*rgb1all(:,3).^gammaRGB(3)];

conditionsOrderedNorm = [0.25 0.00 1.00; ...
                         0.50 0.00 1.00; ...
                         1.00 0.00 1.00; ...
                         1.00 0.00 0.50; ...
                         1.00 0.00 0.25; ...
                         0.25 0.50 1.00; ...
                         0.50 0.50 1.00; ...
                         1.00 0.50 1.00; ...
                         1.00 0.50 0.50; ...
                         1.00 0.50 0.25];

figure;
hold on;
optDistToCheck = 3.5;
indDist = abs(meanv00all-optDistToCheck)<0.01;
for i = 1:size(conditionsOrderedNorm,1)
    ind = abs(rgbLumNorm(:,1)-conditionsOrderedNorm(i,1))<0.01 & ...
          abs(rgbLumNorm(:,2)-conditionsOrderedNorm(i,2))<0.01 & ...
          abs(rgbLumNorm(:,3)-conditionsOrderedNorm(i,3))<0.01 & ...
          abs(meanv00all-optDistToCheck)<0.01;
    plot(i.*ones([sum(ind) 1]),defocusAt550(ind),'o','Color',conditionsOrderedNorm(i,:),'MarkerFaceColor',conditionsOrderedNorm(i,:));
end
xlim([0 11]);
ylim(mean(defocusAt550(indDist))+[-0.6 0.6]);
plot(5.5.*[1 1],ylim,'k-');
set(gca,'FontSize',15);
xlabel('Condition');
ylabel('Defocus at 550nm');
