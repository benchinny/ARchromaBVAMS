%% Initialize and clear
ieInit;

%% Set up display struct and build Ben's stimulus

% Setting up display properties
d = displayCreate('OLED-Samsung');
d = displaySet(d, 'name', 'my display');
d = displaySet(d,'ViewingDistance',1); % simulated screen distance

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

% Ben's stimulus
nDotsI = 320;
im = AFCwordStimImproved('sea',nDotsI.*[1 1],'green');
imPatternTmp = squeeze(im(:,:,2));
imPatternTmp = circshift(imPatternTmp,-15,1);
I(:,:,3) = imresize(imPatternTmp,nDotsI.*[1 1],'nearest');
I(:,:,1) = 0.56.*imresize(imPatternTmp,nDotsI.*[1 1],'nearest');
I = I./255;

% Turn image into 'scene'
s = sceneFromFile(I, 'rgb', [], d);  % The display is included here
% I think this copies the struct into an object
vcAddObject(s); 

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
plot(s.spectrum.wave,squeeze(s.data.photons(160,160,:)),'-k','LineWidth',1);
formatFigure('Wavelength (\lambda)','Photons');
axis square;

%% Computing visual Strehl ratio

S = [380 4 101]; % weird convention used by Brainard lab for defining wavelengths
load T_xyz1931; % load color matching functions
T_sensorXYZ = 683*SplineCmf(S_xyz1931,T_xyz1931,S); % interpolate and scale
wave = S(1):S(2):S(1)+S(2)*(S(3)-1); % define wavelength vector

oi = oiCreateARC('human',wave,0); % create optics

% making 2D CSF function
[fx, fy] = meshgrid(oi.optics.OTF.fx,oi.optics.OTF.fy);
% scale so frequencies are in units of cyc/deg
fx = fx./3.37;
fy = fy./3.37;
df = sqrt(fx.^2 + fy.^2); % compute distance from origin
CSF2d = 0.04992*(1+5.9375*df).*exp(-0.114*df.^1.1);
% inverse Fourier transform of 2D CSF
N = ifftshift(ifft2(fftshift(CSF2d)));

Dall = -0.4:0.1:1.4; % defocus values to look at
peakPSF = [];

for i = 1:length(Dall)

    oi = oiCreateARC('human',wave,Dall(i)); % create optics
    
    polyPSF = [];
    
    for ind = 1:length(wave)
        polyPSF(:,:,ind) = ifftshift(ifft2(oi.optics.OTF.OTF(:,:,ind))).* ...
                          (s.data.photons(160,160,ind)./max(s.data.photons(:))).* ...
                          T_sensorXYZ(2,ind);
    end
    
    polyPSF = sum(polyPSF,3);
    peakPSF(i) = max(max(polyPSF));
    vsx(i) = sum(sum(N.*polyPSF));
end

figure; 
plot(humanWaveDefocusInvert(-Dall),vsx./max(vsx),'k-','LineWidth',1); hold on;
plot(humanWaveDefocusInvert(-Dall),peakPSF./max(peakPSF),'k--','LineWidth',1);
legend('Visual Strehl','Strehl');
axis square;
set(gca,'FontSize',15);
xlabel('Wavelength in focus');
ylabel('Ratio');
% ind = 21; % examine at particular wavelength index
% testWave = oi.optics.OTF.wave(ind);
% testOTF = fftshift(oi.optics.OTF.OTF(:,:,ind));
% testPSF = ifftshift(ifft2(oi.optics.OTF.OTF(:,:,ind)));

%% Turning original stimulus into luminance image

lumImgOrig = zeros(size(s.data.photons,1),size(s.data.photons,2));
for j = 1:length(wave)
    lumImgOrig = lumImgOrig+s.data.photons(:,:,j).*T_sensorXYZ(2,j);
end

%% Computing peak correlation for different wavelengths in focus

peakCorr = [];
Dall2 = fliplr(Dall);

figure;
for i = 1:length(Dall2)
    oi = oiCreateARC('human',wave,Dall2(i)); % create optics
    oi = oiCompute(oi, s); % compute optical image of stimulus
    lumImg = zeros(size(oi.data.photons,1),size(oi.data.photons,2));
    for j = 1:length(wave)
       lumImg = lumImg+oi.data.photons(:,:,j).*T_sensorXYZ(2,j);
    end
    lumImg = lumImg(41:360,41:360);
    peakCorr(i) = max(max(xcorr2(lumImgOrig,lumImg)));
    subplot(1,1,1);
    imagesc(lumImg); axis square; colormap gray;
    title(['wavelength in focus: ' num2str(round(humanWaveDefocusInvert(-Dall2(i)))) 'nm']);
    pause;
end

%% Plotting peak correlation with wavelength in focus

figure; 
plot(humanWaveDefocusInvert(-Dall2),peakCorr./max(peakCorr),'k-','LineWidth',1);
axis square;
set(gca,'FontSize',15);
xlabel('Wavelength in focus');
ylabel('Peak correlation');

%% MAKING 1D CSF EQUATION

f = oi.optics.OTF.fx(31:60)./3.37; % defining frequency space
CSF1d = 0.04992*(1+5.9375*f).*exp(-0.114*f.^1.1); % 1D CSF equation
