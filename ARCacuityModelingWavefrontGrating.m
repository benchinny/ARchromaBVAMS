%% Initialize and clear
ieInit;

%% Set up display struct and build Ben's stimulus

subjNum = 5;

% Setting up display properties
d = displayCreate('OLED-Samsung');
d = displaySet(d, 'name', 'my display');
d = displaySet(d,'ViewingDistance',1); % simulated screen distance
d = displaySet(d,'dpi',378); % simulated screen distance

bUseBVAMScal = 1; % if using BVAMS calibration data

if bUseBVAMScal
    drivePath = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/BVAMS_calibration_files/display calibration on August3/';
    load([drivePath 'Right_disp_Red.mat']);
    d.spd(:,1) = CurrentSpectrum.Spectral.emission_data;
    load([drivePath 'Right_disp_Green.mat']);
    d.spd(:,2) = CurrentSpectrum.Spectral.emission_data;
    load([drivePath 'Right_disp_Blue.mat']);
    d.spd(:,3) = CurrentSpectrum.Spectral.emission_data;
    [maxR,indMaxR] = max(d.spd(:,1));
    % d.spd(:,1) = zeros(size(d.spd(:,1)));
    % d.spd(indMaxR,1) = maxR;
end
d.gamma(:,1) = (d.gamma(:,1).^(1/2.2)).^2.5;
d.gamma(:,2) = (d.gamma(:,2).^(1/2.2)).^2.7;
d.gamma(:,3) = (d.gamma(:,3).^(1/2.2)).^2.3;
% d.spd = ones(size(d.spd)).*0.000200 + 0.03.*(repmat([1:length(d.wave)]',[1 3])./1000);
% d.spd(:,1) = [normpdf(380:4:780,624,10).*0.005]';
% d.spd(:,2) = [normpdf(380:4:780,532,10).*0.005]';
% d.spd(:,3) = [normpdf(380:4:780,488,10).*0.005]';

% Ben's stimulus
nDotsI = 260;
rVal = 0.56;
bVal = 1.00;
gVal = 0.00;

% GABOR
frqCpd = 15;
contrast = 1.0;
rgbAll = [rVal gVal bVal];
k0 = 1;
gammaR = 2.5;
gammaG = 2.7;
gammaB = 2.3;

acuStimOrig1 = ARC2Dgabor(smpPos(260,390),[],0,0,[frqCpd 3*frqCpd 5*frqCpd 7*frqCpd], ...
               [contrast contrast/3 contrast/5 contrast/7],15,90,0.2,0.2, ...
               [rgbAll(k0,1)^gammaR rgbAll(k0,2)^gammaG rgbAll(k0,3)^gammaB],1,1,0,0);

acuStimOrig1(:,:,1) = acuStimOrig1(:,:,1).^(1/gammaR);
acuStimOrig1(:,:,2) = acuStimOrig1(:,:,2).^(1/gammaG);
acuStimOrig1(:,:,3) = acuStimOrig1(:,:,3).^(1/gammaB);
I1 = acuStimOrig1;

acuStimOrig2 = ARC2Dgabor(smpPos(260,390),[],0,0,[frqCpd 3*frqCpd 5*frqCpd 7*frqCpd], ...
               [contrast contrast/3 contrast/5 contrast/7],-15,90,0.2,0.2, ...
               [rgbAll(k0,1)^gammaR rgbAll(k0,2)^gammaG rgbAll(k0,3)^gammaB],1,1,0,0);

acuStimOrig2(:,:,1) = acuStimOrig2(:,:,1).^(1/gammaR);
acuStimOrig2(:,:,2) = acuStimOrig2(:,:,2).^(1/gammaG);
acuStimOrig2(:,:,3) = acuStimOrig2(:,:,3).^(1/gammaB);
I2 = acuStimOrig2;

% Turn image into 'scene'
s1 = sceneFromFile(I1, 'rgb', [], d);  % The display is included here
s2 = sceneFromFile(I2, 'rgb', [], d);
% I think this copies the struct into an object
vcAddObject(s1); 
vcAddObject(s2); 
% s1.data.photons(130,130,:) = ones(size(s1.data.photons(130,130,:))).*4e14;

figure; 
set(gcf,'Position',[289 428 1056 420]);
subplot(1,3,1);
plot(d.wave,d.spd(:,1),'r','LineWidth',1.5); hold on;
plot(d.wave,d.spd(:,2),'g','LineWidth',1.5);
plot(d.wave,d.spd(:,3),'b','LineWidth',1.5);
axis square;
formatFigure('Wavelength (\lambda)','Radiance');
subplot(1,3,2);
imagesc(I1);
set(gca,'XTick',[]);
set(gca,'YTick',[]);
axis square;
set(gca,'FontSize',15);
title('Original');
subplot(1,3,3);
plot(s1.spectrum.wave,squeeze(s1.data.photons(130,130,:)),'-k','LineWidth',1);
formatFigure('Wavelength (\lambda)','Photons');
axis square;

%% Computing visual Strehl ratio

% COLOR MATCHING FUNCTIONS
S = [380 4 101]; % weird convention used by Brainard lab for defining wavelengths
load T_xyz1931; % load color matching functions
T_sensorXYZ = 683*SplineCmf(S_xyz1931,T_xyz1931,S); % interpolate and scale
wave = S(1):S(2):S(1)+S(2)*(S(3)-1); % define wavelength vector
% DEFOCUSES TO LOOK AT
Dall = -humanWaveDefocus(wave);

bPlotIndvWvf = false;

% PARAMETERS OF WAVEFRONT ANALYSIS
PARAMS.PupilSize = 7; %default values - will be replaced depending on choices below
PARAMS.PupilFieldSize =6; %default values - will be replaced depending on choices below
PARAMS.PupilFitSize = 7; %default values - will be replaced depending on choices below

wvfFiles = ARCacuAnalysisWvfSubj(subjNum);

dataFolder = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/csvFiles/SUBJ/';

cAll = [];

for i = 1:length(wvfFiles)
    ZernikeTable = readtable([dataFolder wvfFiles{i}]);
    NumCoeffs = width(ZernikeTable)-8; % determine how many coefficients are in the cvs file. 
    c=zeros(size(ZernikeTable,1),65); %this is the vector that contains the Zernike polynomial coefficients. We can work with up to 65. 
    PARAMS = struct;
    PARAMS.PupilSize=mean(table2array(ZernikeTable(:,5))); %default setting is the pupil size that the Zernike coeffs define, PARAMS(3)
    PARAMS.PupilFitSize=mean(table2array(ZernikeTable(:,5))); 
    PARAMS.PupilFieldSize=PARAMS.PupilSize*2; %automatically compute the field size
    c(:,3:NumCoeffs)=table2array(ZernikeTable(:,11:width(ZernikeTable)));
    cAll = [cAll; c];
    if bPlotIndvWvf
        indBadIndv = c(:,4)==0;
        meanCindv = mean(c(~indBadIndv,:),1);
        zCoeffsIndv = [0 meanCindv(1:end-1)];
        wvfPindv = wvfCreate('calc wavelengths', 875, ...
            'measured wavelength', 875, ...
            'zcoeffs', zCoeffsIndv, 'measured pupil', PARAMS.PupilSize, ...
            'name', sprintf('human-%d', PARAMS.PupilSize),'spatial samples',size(I1,2)); 
        wvfPindv.calcpupilMM = PARAMS.PupilSize;
        wvfPindv.refSizeOfFieldMM = 6;
        wvfPindv = wvfSet(wvfPindv, 'zcoeff', 0, 'defocus');
        
        % Convert to siData format as well as wavefront object
        [siPSFDataIndv, wvfPindv] = wvf2SiPsf(wvfPindv,'showBar',false,'nPSFSamples',size(I1,2),'umPerSample',1.1512); 
        oiIndv = wvf2oi(wvfPindv); % CONVERT TO OPTICS OBJECT       
        figure; 
        imagesc(fftshift(ifft2(squeeze(oiIndv.optics.OTF.OTF(:,:,1))))); 
        axis square; 
        colormap gray;
        pause;
        close;
    end
end

indBad = cAll(:,4)==0;
meanC = mean(cAll(~indBad,:),1); % TAKE MEAN OF COEFFICIENTS
% meanC = cAll(1,:);
% meanC = zeros([1 65]);
% meanC(3) = -0.2;
% meanC(4) = 0;

dprimeMetric = [];
defocusScaleFactor = 0.5774;

defocusOrig = meanC(4);
defocusOrigScaled = defocusOrig/defocusScaleFactor;
defocusForStim = 0.5+[1.3:0.1:3.2]-defocusOrigScaled;
wvInFocusForStim = humanWaveDefocusInvertARC(875,-defocusForStim,subjNum);

parfor i = 1:length(defocusForStim)
    zCoeffs = [0 meanC(1:end-1)];
    wvfP = wvfCreate('calc wavelengths', wave, ...
        'measured wavelength', 875, ...
        'zcoeffs', zCoeffs, 'measured pupil', PARAMS.PupilSize, ...
        'name', sprintf('human-%d', PARAMS.PupilSize),'spatial samples',size(I1,2));
    wvfP.calcpupilMM = PARAMS.PupilSize;
    wvfP.refSizeOfFieldMM = 6;
    wvfP = wvfSet(wvfP, 'zcoeff', -defocusForStim(i)*defocusScaleFactor, 'defocus');
    if subjNum==9
        wvfP = wvfSet(wvfP, 'customlca', @humanWaveDefocusS9);
    elseif subjNum==10
        wvfP = wvfSet(wvfP, 'customlca', @humanWaveDefocusS10);
    elseif subjNum==3
        wvfP = wvfSet(wvfP, 'customlca', @humanWaveDefocusS3);
    elseif subjNum==5
        wvfP = wvfSet(wvfP, 'customlca', @humanWaveDefocusS5);
    elseif subjNum==1
        wvfP = wvfSet(wvfP, 'customlca', @humanWaveDefocusS1);
    elseif subjNum==16
        wvfP = wvfSet(wvfP, 'customlca', @humanWaveDefocusS16);
    elseif subjNum==17
        wvfP = wvfSet(wvfP, 'customlca', @humanWaveDefocusS17); 
    elseif subjNum==18
        wvfP = wvfSet(wvfP, 'customlca', @humanWaveDefocusS18); 
    elseif subjNum==20
        wvfP = wvfSet(wvfP, 'customlca', @humanWaveDefocusS20);         
    end
    
    % Convert to siData format as well as wavefront object
    [siPSFData, wvfP] = wvf2SiPsfARC(wvfP,'showBar',false,'nPSFSamples',size(I1,2),'umPerSample',1.1512); % 1.1512
    oi = wvf2oi(wvfP); % CONVERT TO OPTICS OBJECT
    paddingXCpsf = round((size(siPSFData.psf,2)-size(s1.data.photons,2))/2);
    paddingYRpsf = round((size(siPSFData.psf,1)-size(s1.data.photons,1))/2); 
    indNotPadded = {(paddingYRpsf+1):(size(siPSFData.psf,1)-paddingYRpsf) ...
                    (paddingXCpsf+1):(size(siPSFData.psf,2)-paddingXCpsf)};    
    oi.optics.OTF = [];
    for j = 1:size(siPSFData.psf,3)
        oi.optics.OTF.OTF(:,:,j) = fft2(fftshift(squeeze(siPSFData.psf(indNotPadded{1},indNotPadded{2},j))));
    end
    oig1 = oiCompute(oi, s1); % compute optical image of stimulus
    oig2 = oiCompute(oi, s2); % compute optical image of stimulus

    photonsXW1 = RGB2XWFormat(oig1.data.photons); % FORMATTING
    energyXW1 = Quanta2Energy(wave,photonsXW1);
    lumImgXW1 = sum(bsxfun(@times,energyXW1,squeeze(T_sensorXYZ(2,:))),2);
    lumImgXY1 = reshape(lumImgXW1,[size(oig1.data.photons,1) size(oig1.data.photons,2)]);

    photonsXW2 = RGB2XWFormat(oig2.data.photons); % FORMATTING
    energyXW2 = Quanta2Energy(wave,photonsXW2);
    lumImgXW2 = sum(bsxfun(@times,energyXW2,squeeze(T_sensorXYZ(2,:))),2);
    lumImgXY2 = reshape(lumImgXW2,[size(oig2.data.photons,1) size(oig2.data.photons,2)]);

    dprimeMetric(i) = sqrt(sum((lumImgXW2-lumImgXW1).^2));

    figure; 
    set(gcf,'Position',[359 443 975 420]);
    subplot(1,2,1);
    imagesc(lumImgXY1); 
    axis square; 
    colormap gray;
    title(['Defocus = ' num2str(defocusForStim(i)) ', x-correlation = ' num2str(dprimeMetric(i))]);
    subplot(1,2,2);
    imagesc(fftshift(ifft2(squeeze(oig1.optics.OTF.OTF(:,:,61))))); 
    axis square; 
    colormap gray;
    display(['D-prime iteration ' num2str(i)]);
end
%%
figure;
set(gcf,'Position',[342 460 1052 440]);
subplot(1,2,1);
plot(defocusForStim+defocusOrigScaled,dprimeMetric,'k-','LineWidth',1);
xlabel('Distance');
ylabel('D-prime metric');
set(gca,'FontSize',15);
title(['Mean defocus at 875nm = ' num2str(defocusOrigScaled,3) 'D']);
subplot(1,2,2);
plot(wvInFocusForStim,dprimeMetric,'k-','LineWidth',1);
xlabel('Wavelength in focus (nm)');
ylabel('D-prime metric');
set(gca,'FontSize',15);

