function wvInFocus = ARCwvInFocusCones(subjNum,trialNum,wLMS)

wave = 380:4:780;
wave = wave(16:101);
nFocus = length(wave);
foldernameCones = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/coneImages/';

fnameConeRspNoLCA = ['subj' num2str(subjNum) 'stimulus' num2str(trialNum) 'focusInd6noLCA'];
absorptionsOrig = load([foldernameCones fnameConeRspNoLCA]);
absorptionsOrig = absorptionsOrig.absorptions;
coneImgOrig = sum(absorptionsOrig,3);
peakCorr = [];

for i = 1:nFocus
    fnameConeRsp = ['subj' num2str(subjNum) 'stimulus' num2str(trialNum) 'focusInd' num2str(i)];
    load([foldernameCones fnameConeRsp]);
    absorptions(:,:,1) = absorptions(:,:,1).*wLMS(1);
    absorptions(:,:,2) = absorptions(:,:,2).*wLMS(2);
    absorptions(:,:,3) = absorptions(:,:,3).*wLMS(3);
    coneImg = sum(absorptions,3);
    peakCorr(i) = max(max(xcorr2(coneImg,coneImgOrig)));
end

[~,indPeakPeak] = max(peakCorr);
wvInFocus = wave(indPeakPeak);

end