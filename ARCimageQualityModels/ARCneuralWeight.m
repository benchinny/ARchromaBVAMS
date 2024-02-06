%% MAKING EXAMPLE OPTICS

S = [380 4 101]; % weird convention used by Brainard lab for defining wavelengths
load T_xyz1931; % load color matching functions
T_sensorXYZ = 683*SplineCmf(S_xyz1931,T_xyz1931,S); % interpolate and scale
wave = S(1):S(2):S(1)+S(2)*(S(3)-1); % define wavelength vector

oi.optics = opticsCreateARC('human',[],[],wave,[],[],0); % create optics

ind = 21; % examine at particular wavelength index
testWave = oi.optics.OTF.wave(ind);
testOTF = fftshift(oi.optics.OTF.OTF(:,:,ind));
testPSF = ifftshift(ifft2(oi.optics.OTF.OTF(:,:,ind)));

%% MAKING 1D CSF EQUATION

f = oi.optics.OTF.fx(31:60)./3.37; % defining frequency space
CSF1d = 0.04992*(1+5.9375*f).*exp(-0.114*f.^1.1); % 1D CSF equation

%% NEURAL WEIGHTING FUNCTION (IN SPATIAL DOMAIN)

% making 2D CSF function
[fx, fy] = meshgrid(oi.optics.OTF.fx,oi.optics.OTF.fy);
% scale so frequencies are in units of cyc/deg
fx = fx./3.37;
fy = fy./3.37;
df = sqrt(fx.^2 + fy.^2); % compute distance from origin
CSF2d = 0.04992*(1+5.9375*df).*exp(-0.114*df.^1.1);
% inverse Fourier transform of 2D CSF
N = ifftshift(ifft2(fftshift(CSF2d)));
