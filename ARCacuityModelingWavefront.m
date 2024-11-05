%% Initialize and clear
ieInit;

%% Set up display struct and build Ben's stimulus

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
rVal = 1.00;
bVal = 0.00;

% GABOR
frqCpd = 15;
contrast = 1.0;
rgbAll = [rVal 0 bVal];
k0 = 1;
gammaR = 2.5;
gammaG = 2.7;
gammaB = 2.3;

acuStimOrig1 = ARC2Dgabor(smpPos(260,260),[],0,0,[frqCpd 3*frqCpd 5*frqCpd 7*frqCpd], ...
               [contrast contrast/3 contrast/5 contrast/7],-15,90,0.2,0.2, ...
               [rgbAll(k0,1)^gammaR rgbAll(k0,2)^gammaG rgbAll(k0,3)^gammaB],1,1,0,0);

acuStimOrig1(:,:,1) = acuStimOrig1(:,:,1).^(1/gammaR);
acuStimOrig1(:,:,2) = acuStimOrig1(:,:,2).^(1/gammaG);
acuStimOrig1(:,:,3) = acuStimOrig1(:,:,3).^(1/gammaB);
I = acuStimOrig1;

% Turn image into 'scene'
s = sceneFromFile(I, 'rgb', [], d);  % The display is included here
% I think this copies the struct into an object
vcAddObject(s); 
% s.data.photons(130,130,:) = ones(size(s.data.photons(130,130,:))).*4e14;

figure; 
set(gcf,'Position',[289 428 1056 420]);
subplot(1,3,1);
plot(d.wave,d.spd(:,1),'r','LineWidth',1.5); hold on;
plot(d.wave,d.spd(:,2),'g','LineWidth',1.5);
plot(d.wave,d.spd(:,3),'b','LineWidth',1.5);
axis square;
formatFigure('Wavelength (\lambda)','Radiance');
subplot(1,3,2);
imagesc(I);
set(gca,'XTick',[]);
set(gca,'YTick',[]);
axis square;
set(gca,'FontSize',15);
title('Original');
subplot(1,3,3);
plot(s.spectrum.wave,squeeze(s.data.photons(130,130,:)),'-k','LineWidth',1);
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

% PARAMETERS OF WAVEFRONT ANALYSIS
PARAMS.PixelDimension = 512;% size of pupil aperture field in pixels (this defines the resolution of the calculation)
PARAMS.PupilSize = 7; %default values - will be replaced depending on choices below
PARAMS.PupilFieldSize =42; %default values - will be replaced depending on choices below
PARAMS.PupilFitSize = 7; %default values - will be replaced depending on choices below
PARAMS.ImagingWavelength = 0.55;% imaging wavelength in microns
PARAMS.WavefrontResolution = 53;% increase to enhance the display of the wavefront (doesn't affect calculation)

wvfFiles = { ...
            'S19-OD-Block_9-Trial_99-4_240930_100151_proc.csv' ...
            'S19-OD-Block_9-Trial_99-4_240930_100812_proc.csv' ...
            'S19-OD-Block_9-Trial_99-4_240930_101500_proc.csv' ...
            'S19-OD-Block_9-Trial_89-4_240930_101427_proc.csv' ...
            'S19-OD-Block_9-Trial_89-4_240930_100740_proc.csv' ...
            'S19-OD-Block_9-Trial_89-4_240930_100119_proc.csv' ... 
            'S19-OD-Block_9-Trial_79-4_240930_100048_proc.csv' ...
            'S19-OD-Block_9-Trial_79-4_240930_101355_proc.csv' ...
            'S19-OD-Block_9-Trial_69-4_240930_101324_proc.csv' ...     
            'S19-OD-Block_9-Trial_69-4_240930_100016_proc.csv' ...
            'S19-OD-Block_9-Trial_69-4_240930_093304_proc.csv' ...
            'S19-OD-Block_9-Trial_69-4_240930_093935_proc.csv' ...
            'S19-OD-Block_9-Trial_69-4_240930_092547_proc.csv' ...
            'S19-OD-Block_9-Trial_79-4_240930_092620_proc.csv' ...
            'S19-OD-Block_9-Trial_79-4_240930_093336_proc.csv' ... 
            'S19-OD-Block_9-Trial_89-4_240930_092652_proc.csv' ...
            'S19-OD-Block_9-Trial_89-4_240930_093408_proc.csv' ...
            'S19-OD-Block_9-Trial_89-4_240930_094043_proc.csv' ... 
            'S19-OD-Block_9-Trial_19-4_240930_094322_proc.csv' ...
            'S19-OD-Block_9-Trial_19-4_240930_095735_proc.csv' ...
            'S19-OD-Block_9-Trial_19-4_240930_095045_proc.csv' ...
            'S19-OD-Block_9-Trial_29-4_240930_095808_proc.csv' ...
            'S19-OD-Block_9-Trial_29-4_240930_094354_proc.csv' ...
            'S19-OD-Block_9-Trial_29-4_240930_095116_proc.csv' ... 
            'S19-OD-Block_9-Trial_44-4_241004_121716_proc.csv' ...
            'S19-OD-Block_9-Trial_44-4_241004_122518_proc.csv' ...
            'S19-OD-Block_9-Trial_44-4_241004_123149_proc.csv' ...
            'S19-OD-Block_9-Trial_54-4_241004_122553_proc.csv' ...
            'S19-OD-Block_9-Trial_54-4_241004_123221_proc.csv' ...
            };

dataFolder = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/csvFiles/';

for i = 1:length(wvfFiles)
    ZernikeTable = readtable([dataFolder wvfFiles{i}]);
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

Dall2 = -humanWaveDefocus(wave(1:101));

zCoeffs = [0 meanC(1:end-1)];
wvfP = wvfCreate('calc wavelengths', wave, ...
    'measured wavelength', humanWaveDefocusInvert(-Dall2(i)), ...
    'zcoeffs', zCoeffs, 'measured pupil', PARAMS.PupilSize, ...
    'name', sprintf('human-%d', PARAMS.PupilSize),'spatial samples',size(im,2));
wvfP.calcpupilMM = PARAMS.PupilSize;
wvfP.refSizeOfFieldMM = 42;
wvfP = wvfSet(wvfP, 'zcoeff', 0, 'defocus');
