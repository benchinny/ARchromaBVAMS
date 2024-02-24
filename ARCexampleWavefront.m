% Create wavefront structure with reasonable parameters.
pupilMM = 6;
zCoeffs = wvfLoadThibosVirtualEyes(pupilMM);
wave = [450:10:700]';
wvfP = wvfCreate('calc wavelengths', wave, ...
    'measured wavelength', 550, ...
    'zcoeffs', zCoeffs, 'measured pupil', pupilMM, ...
    'name', sprintf('human-%d', pupilMM));

% Set a little defocus, just to make the PSF a bit more interesting
wvfP = wvfSet(wvfP, 'zcoeff', 0.5, 'defocus');

% Convert to siData format and save.  201 is the number of default 
% samples in the wvfP object, and we need to match that here.
[siPSFData, wvfP] = wvf2SiPsf(wvfP,'showBar',true,'nPSFSamples',201);

%%

figure; 
for i = 1:length(wave)
   subplot(1,1,1);
   imagesc(siPSFData.psf(:,:,i)); 
   colormap gray; 
   axis square
   title(['wave = ' num2str(wave(i)) 'mm']);
   pause;
end

