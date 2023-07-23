%%

% script for checking luminances of BVAMS oleds based on calibration files
% / gamma function exponents that Ben dug up

S = [380 4 101]; % correct for PR650
% LOAD COLOR MATCHING FUNCTIONS
load T_xyz1931
% INTERPOLATE TO PUT THEM ON SAME X-SUPPORT AS PR650
T_sensorXYZ = 683*SplineCmf(S_xyz1931,T_xyz1931,S);

colorsCal = {'Red' 'Green' 'Blue' 'white'};
Meas1xyY = [];
for i = 1:length(colorsCal)
    load(['calibration/Right_disp_' colorsCal{i} '.mat']);
    spectra(:,i) = CurrentSpectrum.Spectral.emission_data';
    Meas1XYZ = T_sensorXYZ*spectra(:,i); % Luminance is going to be #2
    Meas1xyY(:,i) = XYZToxyY(Meas1XYZ); % Luminance is going to be #3
end

% GAMMA VALUES 
% LEFT SCREEN
% n1=[2.473 2.501 2.431]; %ones(1,3).*2.33;
% RIGHT SCREEN
% n1=[2.458 2.611 2.482]; %ones(1,3).*2.33;
