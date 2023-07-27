%%

% script for checking luminances of BVAMS oleds based on calibration files
% / gamma function exponents that Ben dug up

S = [380 4 101]; % correct for PR650
% LOAD COLOR MATCHING FUNCTIONS
load T_xyz1931
% INTERPOLATE TO PUT THEM ON SAME X-SUPPORT AS PR650
T_sensorXYZ = 683*SplineCmf(S_xyz1931,T_xyz1931,S);

% colorsCal = {'Red' 'Green' 'Blue' 'white'};
% colorsCal = {'calBlue055.mat' 'calBlue060.mat' 'calBlue070.mat' 'calBlue080.mat' 'calBlue090.mat' 'calBlue100.mat'};
% colorsCal = {'calRed055.mat' 'calRed060.mat' 'calRed070.mat' 'calRed080.mat' 'calRed090.mat' 'calRed100.mat'};
% colorsCal = {'calRed050_closest.mat' 'calRed060_closest.mat' 'calRed070_closest.mat' 'calRed080_closest.mat' 'calRed090_closest.mat' 'calRed100_closest.mat'};
% colorsCal = {'calBlue050_closest.mat' 'calBlue060_closest.mat' 'calBlue070_closest.mat' 'calBlue080_closest.mat' 'calBlue090_closest.mat' 'calBlue100_closest.mat'};
colorsCal = {'calGreen050_closest.mat' 'calGreen060_closest.mat' 'calGreen070_closest.mat' 'calGreen080_closest.mat' 'calGreen090_closest.mat' 'calGreen100_closest.mat'};

Meas1xyY = [];
for i = 1:length(colorsCal)
%    load(['/home/ben/Documents/ARchroma/Right_disp_' colorsCal{i} '.mat']);
    load(['/home/ben/Documents/ARchroma/' colorsCal{i}]);
    spectra(:,i) = nativeEnergy;
%    spectra(:,i) = CurrentSpectrum.Spectral.emission_data;
    Meas1XYZ = T_sensorXYZ*spectra(:,i); % Luminance is going to be #2
    Meas1xyY(:,i) = XYZToxyY(Meas1XYZ); % Luminance is going to be #3
end

% GAMMA VALUES 
% LEFT SCREEN
% n1=[2.473 2.501 2.431]; %ones(1,3).*2.33;
% RIGHT SCREEN
% n1=[2.458 2.611 2.482]; %ones(1,3).*2.33;

%%

load /home/ben/Documents/ARchroma/calBlue100_closest.mat
figure; plot(nativeSpectralAxis,nativeEnergy,'-b')
load /home/ben/Documents/ARchroma/calRed100_closest.mat
hold on; plot(nativeSpectralAxis,nativeEnergy,'-r')
load /home/ben/Documents/ARchroma/calGreen100_closest.mat
plot(nativeSpectralAxis,nativeEnergy,'-g');