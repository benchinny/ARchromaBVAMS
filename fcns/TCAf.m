% Responses for three pairings of colors: red vs blue, red vs green,
% and green vs blue will be acquired. Six measurements, three for the left eye and three for the
% right, will require approximately 10 minutes.
function bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);

global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi cf


% % Clear the workspace and the screen
% sca;
% close all;
% clearvars;

% rd=540; % red diameter 
% kd=116; %black diameter
% bd=108; % blue diameter
% lineWidthPix = 4; %bar width
% pixelsPerPress = 0.5;


% Screen('Preference', 'SkipSyncTests', 1);
% Screen('Preference','VisualDebugLevel', 0);
% % Here we call some default settings for setting up Psychtoolbox
% PsychDefaultSetup(2);

% % Get the screen numbers
% screens = Screen('Screens');
% 
% % Draw to the external screen if avaliable
% screenNumber = 0; %
% max(screens);

% % Define black and white
% white = WhiteIndex(screenNumber);
% black = BlackIndex(screenNumber);
% 
% % Open an on screen window
% [window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
% 
% % Get the size of the on screen window
% [screenXpixels, screenYpixels] = Screen('WindowSize', window);
% 
% % Set up alpha-blending for smooth (anti-aliased) lines
% Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');


% % Query the frame duration
% ifi = Screen('GetFlipInterval', window);

% % The avaliable keys to press
% escapeKey = KbName('ESCAPE');
% upKey = KbName('UpArrow');
% downKey = KbName('DownArrow');
% leftKey = KbName('LeftArrow');
% rightKey = KbName('RightArrow');

% % Get the centre coordinate of the window
% [xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect of 200 by 250 pixels
% baseRect = [0 0 rd rd];
rr = [0 0 rd rd];
kr = [0 0 kd kd];
br = [0 0 bd bd];

% For Ovals we set a miximum diameter up to which it is perfect for
% maxDiameter = max(baseRect) * 1.01;
rm = max(rr);% * 1.01;
km = max(kr);% * 1.01;
bm = max(br);% * 1.01;

%mm=[rm; km; bm]'
mm=[rm; km]'

% Center the rectangle on the centre of the screen
% centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);
rc = CenterRectOnPointd(rr, xCenter, yCenter);
kc = CenterRectOnPointd(kr, xCenter, yCenter);
bc = CenterRectOnPointd(br, xCenter, yCenter);

%cc=[rc; kc; bc]' 
cc=[rc; kc]'; 

% Set the color of the rect to red
%rectColor = [1 0 0];
%rectColor = [1 0 0; 0 0 0; 0 0 1]';
rectColor = cf.*[1 0 0; 0 0 0]';

% Draw the rect to the screen
%Screen('FillOval', window, rectColor, centeredRect, maxDiameter);
Screen('FillOval', window, rectColor, cc);


% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
xCoords = [-screenXpixels/2 screenXpixels/2 0 0];
yCoords = [0 0 -screenYpixels screenYpixels];
allCoords = [xCoords; yCoords];

% setting up cross over blue oval
xb = [-bd/2 bd/2 0 0];
yb = [0 0 -bd/2 bd/2];
ab = [xb; yb];

% Draw the fixation cross in white, set it to the center of our screen and
% set good quality antialiasing
Screen('DrawLines', window, allCoords,...
    lineWidthPix, black, [xCenter yCenter], 2);

% Flip to the screen
% Set the intial position of the square to be in the centre of the screen
% squareX = xCenter;
% squareY = yCenter;
% Set the intial position of the square to be in random position
%squareX = randi(screenXpixels);
%squareY = randi(screenYpixels);

% squareX = round(screenXpixels*abs(randn)/6);
% squareY = round(screenYpixels*abs(randn)/6);

squareX = screenXpixels/2 +round(rd.*rand./4);  
squareY = screenYpixels/2 +round(rd.*rand./4);  

% squareX = screenXpixels/2;
% squareY = screenYpixels/2;

% Set the amount we want our square to move on each button press


% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% This is the cue which determines whether we exit the demo
exitDemo = false;

while exitDemo == false

    % Check the keyboard to see if a button has been pressed
    [keyIsDown,secs, keyCode] = KbCheck;

    % Depending on the button press, either move ths position of the square
    % or exit the demo
    if keyCode(ek)
        exitDemo = true;
    elseif keyCode(lk)
        squareX = squareX - pixelsPerPress;
    elseif keyCode(rk)
        squareX = squareX + pixelsPerPress;
    %elseif keyCode(upKey)
    elseif keyCode(dk)
        squareY = squareY - pixelsPerPress;
    %elseif keyCode(downKey)
    elseif keyCode(uk)
        squareY = squareY + pixelsPerPress;
    end

    % We set bounds to make sure our square doesn't go completely off of
    % the screen
    if squareX < 0
        squareX = 0;
    elseif squareX > screenXpixels
        squareX = screenXpixels;
    end

    if squareY < 0
        squareY = 0;
    elseif squareY > screenYpixels
        squareY = screenYpixels;
    end

    % Center the rectangle on the centre of the screen
%     centeredRect = CenterRectOnPointd(br, squareX, squareY);
    bc = CenterRectOnPointd(br, squareX, squareY);
    cc=[rc; kc]'; 
    rectColor = cf.*[1 0 0; 0 0 0]';
    % Draw the rect to the screen
    Screen('FillOval', window, rectColor, cc);
    Screen('DrawLines', window, allCoords,...
    lineWidthPix, black, [xCenter yCenter], 2);
    Screen('FillOval', window, [0 0 1], bc);
    Screen('DrawLines', window, ab,...
    lineWidthPix, black, [squareX squareY], 2);

    % Flip to the screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    bxy=[squareX-xCenter squareY-yCenter]
       
end

% Wait for a key press
%KbStrokeWait;

% Clear the screen
%sca;

