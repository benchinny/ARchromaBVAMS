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

%% Build a simple scene and oi (retinal image) for computing

% First the scene
% s = sceneCreate('rings rays');
% s = sceneSet(s, 'fov', 1);
im2 = AFCwordStimImproved('sea',[320 320],'green');
im2(im2>0) = 255;
% im2 = flipud(im2); 
imPatternTmp = squeeze(im2(:,:,2));
imPatternTmp = circshift(imPatternTmp,-15,1);
imPattern(:,:,3) = imresize(imPatternTmp,100.*[1 1],'nearest');
imPattern(:,:,1) = 0.56.*imresize(imPatternTmp,100.*[1 1],'nearest');
imPattern = imPattern./255;

d = displayCreate('OLED-Samsung');
d = displaySet(d, 'name', 'my display');
d = displaySet(d, 'dpi', 150);
I = imPattern;
scene = sceneFromFile(I, 'rgb', [], d);  % The display is included here
vcAddObject(scene);
s = scene; clear scene;

% Then the oi
oi = oiCreate;
oi = oiCompute(oi, s);

%% Build a default cone mosaic and compute isomerizatoins

% Create the coneMosaic object
cMosaic = coneMosaic;

% Set size to show about half the scene. Speeds things up.
cMosaic.setSizeToFOV(5 * sceneGet(s, 'fov'));

% You can see the field of view for this cone mosaic object, along with
% other parameters, within the coneMosaic object:
% cMosaic.fov;

%% Generate a sequence of 100 eye posistions.
% This function creates an eye movement object (see t_fixationalEM.m) and
% automatically generates a path for this given cone mosaic.
cMosaic.emGenSequence(100);

%% Compute isomerizations for each eye position.
cMosaic.compute(oi);

%% Bring up a window so that we can look at things.
%
% Using the pull down in the window, you can look at
% the mosaic, the isomerizations for one fixation, or
% the movie of fixations.
cMosaic.window;

%% Plot things individually
% Instead of using the cone mosaic window, you can call the plot function
% directly. 

% cMosaic.plot('Cone mosaic');
% cMosaic.plot('meanabsorptions');

%% END
