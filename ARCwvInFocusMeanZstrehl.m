function wvInFocus = ARCwvInFocusMeanZstrehl(subjNum,rgb,wLMS)

wave = 380:4:780;
nFocus = length(wave);
foldernameCones = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneImages/';

% Setting up display properties
d = struct;

bUseBVAMScal = 1; % if using BVAMS calibration data

if strcmp(getenv('USER'),'benjaminchin')
    calPath = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/BVAMS_calibration_files/Ben_calibration_July_6_2024/';
     stimPath = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/stimuli/';
     savePath = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneImages/S';
end

if strcmp(getenv('USER'),'benchin')
    calPath = '/Users/benchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/BVAMS_calibration_files/Ben_calibration_July_6_2024/';
    stimPath = '/Users/benchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/stimuli/';
    savePath = '/Users/benchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneImages/S';
end

if bUseBVAMScal
    load([calPath 'redPrimaryJuly0624_initialPositionFocus3_100.mat']);
    d.spd(:,1) = energy;
    load([calPath 'greenPrimaryJuly0624_initialPositionFocus3_100.mat']);
    d.spd(:,2) = energy;
    load([calPath 'bluePrimaryJuly0624_initialPositionFocus3_100.mat']);
    d.spd(:,3) = energy;
end
d.gamma(:,1) = (d.gamma(:,1).^(1/2.2)).^2.5;
d.gamma(:,2) = (d.gamma(:,2).^(1/2.2)).^2.7;
d.gamma(:,3) = (d.gamma(:,3).^(1/2.2)).^2.3;

% COLOR MATCHING FUNCTIONS
S = [380 4 101]; % weird convention used by Brainard lab for defining wavelengths
load T_xyz1931; % load color matching functions
T_sensorXYZ = 683*SplineCmf(S_xyz1931,T_xyz1931,S); % interpolate and scale

% % Put the image center in (1, 1) and take the transform.
% imgFFT = fft2(fftshift(img));
% % Multiply the transformed otf and the image.
% % Then invert and put the image center in  the center of the matrix
% filteredIMG = abs(ifftshift(ifft2(otf .* imgFFT)));

peakCorr = [];

for i = 1:nFocus
    fnameConeRsp = ['subj' num2str(subjNum) 'stimulus' num2str(stimNum) 'focusInd' num2str(i)];
    load([foldernameCones 'S' num2str(subjNum) '/' fnameConeRsp]);
    absorptions(:,:,1) = absorptions(:,:,1).*wLMS(1);
    absorptions(:,:,2) = absorptions(:,:,2).*wLMS(2);
    absorptions(:,:,3) = absorptions(:,:,3).*wLMS(3);
    coneImg = sum(absorptions,3);

    coneImgFFT = fftshift(fft2(coneImg));
    coneImgFilteredFFT = coneImgFFT.*freqFilterARC;
    coneImgFiltered = real(ifft2(ifftshift(coneImgFilteredFFT)));

    peakCorr(i) = max(max(normxcorr2(coneImgFiltered,coneImgOrigFiltered)));
end

[~,indPeakPeak] = max(peakCorr);
wvInFocus = wave(indPeakPeak);

end