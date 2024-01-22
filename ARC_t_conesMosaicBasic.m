%% Introduction to the cone mosaic object.
%
% Description:
%    Create a rectangular cone mosaic object and compute cone
%    isomerizatoins across a set of small eye movements.
%
%    Visualize the results in coneMosaic window.
%
% See also
%   t_cones*

%% Initialize and clear
ieInit;

%% Build a simple scene

% Setting up display properties
d = displayCreate('OLED-Samsung');
d = displaySet(d, 'name', 'my display');
d = displaySet(d, 'dpi', 150);
d.dist = 2.04;

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

%% oi (retinal image) for computing

% Make optical image
oi = oiCreate;
oi = oiCompute(oi, s);

wavelengthInds = [6 21 36 51 66 81];

figure;
set(gcf,'Position',[193 192 1012 657]);
for i = 1:length(wavelengthInds)
    subplot(2,3,i);
    imagesc(ifftshift(ifft2(oi.optics.OTF.OTF(:,:,wavelengthInds(i))))); 
    colormap gray;
    set(gca,'XTick',[]);
    set(gca,'XTick',[]);
    set(gca,'FontSize',15);
    title([num2str(oi.spectrum.wave(wavelengthInds(i))) 'nm']);
end

%% crop retinal image for visualization

% Visualize image at each wavelength
oi = oiCrop(oi, [50 50 300 300]);

%% visualize retinal image

oiWindow(oi);
roi = [];
wList = [460 524 580 620];  % nm
gSpacing = 43;            % microns
for ww = 1:length(wList)
    thisWave = wList(ww); 
    oiPlot(oi, 'irradiance image wave grid', roi, thisWave, gSpacing);
end

%% Build a default cone mosaic and compute isomerizatoins

% Create the coneMosaic object
cMosaic = coneMosaic;

% Set size to show relevant portion of scene
cMosaic.setSizeToFOV(2 * sceneGet(s, 'fov'));

% You can see the field of view for this cone mosaic object, along with
% other parameters, within the coneMosaic object:
% cMosaic.fov;

%% Generate a sequence of 100 eye posistions.
% This function creates an eye movement object (see t_fixationalEM.m) and
% automatically generates a path for this given cone mosaic.
% cMosaic.emGenSequence(50);

%% Compute isomerizations for each eye position.

% key line for computing absorptions
absorptions = cMosaic.computeSingleFrame(oi, ...
        'fullLMS', true);

% variables for plotting
plotArea = 200;
nDbuffer = [(size(absorptions,1)-plotArea)/2 (size(absorptions,2)-plotArea)/2];

figure;
set(gcf,'Position',[193 192 1012 657]);

subplot(2,3,2);
imagesc(I);
set(gca,'XTick',[]);
set(gca,'YTick',[]);
axis square;
set(gca,'FontSize',15);
title('Original');

subplot(2,3,4);
imagesc(absorptions((nDbuffer(1)+1):(size(absorptions,1)-nDbuffer(1)),(nDbuffer(2)+1):(size(absorptions,2)-nDbuffer(2)),1));
axis square;
colormap gray;
set(gca,'XTick',[]);
set(gca,'YTick',[]);
set(gca,'FontSize',15);
title('L cones');

subplot(2,3,5);
imagesc(absorptions((nDbuffer(1)+1):(size(absorptions,1)-nDbuffer(1)),(nDbuffer(2)+1):(size(absorptions,2)-nDbuffer(2)),2));
axis square;
colormap gray;
set(gca,'XTick',[]);
set(gca,'YTick',[]);
set(gca,'FontSize',15);
title('M cones');

subplot(2,3,6);
imagesc(absorptions((nDbuffer(1)+1):(size(absorptions,1)-nDbuffer(1)),(nDbuffer(2)+1):(size(absorptions,2)-nDbuffer(2)),3));
axis square;
colormap gray;
set(gca,'XTick',[]);
set(gca,'YTick',[]);
set(gca,'FontSize',15);
title('S cones');

%% Bring up a window so that we can look at things.
%
% Using the pull down in the window, you can look at
% the mosaic, the isomerizations for one fixation, or
% the movie of fixations.
% cMosaic.window;

%% Plot things individually
% Instead of using the cone mosaic window, you can call the plot function
% directly. 

% cMosaic.plot('Cone mosaic');
% cMosaic.plot('meanabsorptions');

%% END
