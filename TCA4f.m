function xy4=TCA4f(fnm, xy0, rgb, ms, pp, window1, window2);

%function xy4=TCA2f(fname, rkc, pp, ey ,window1, window2);
%think about making fname a variable instead of a file to load; 

% function bxy=TCA2f(vd, lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);

% clear all
% close all
% clc
global ek uk wk dk zk lk ak rk sk snt sp kntr ifi cf sz rc00

% global ek uk dk lk rk snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi cf sz
%108 pix/degree
%display =10 degrees
%FOV=5degrees
%pp=[1 0.1]; 
p=pp(1); chk=0;
load(fnm);

xy=round(rand(1,2).*xy0.*2)-xy0;
i0=uint8(zeros(sz));
i1=uint8(255.*ones(size(m_bkg)));
im=m_bkg-circshift(m_crc{1,1}, xy); % background image;
ic= circshift(m_crc{1,1}-(i1-m_crs{1,1}), xy);% center image
%imshow(cat(3, im, i0, ic))
%b=cat(3, embd(im, i0), i0, embd(ic, i0));
b=uint8(zeros([sz 3]));
b(:, :, rgb(1))=embd(ic, i0);
b(:, :, rgb(2))=embd(im, i0);
b1=b; b2=b; xy=[xy; xy];



ext=false;
while ext == false; %find(KeyCode)~=ek

    cwin1(b1, b2, cf, rc00, window1, window2);
    
    [keyIsDown,secs, kc] = KbCheck;
    %[secs, kc, deltaSecs] = KbStrokeWait;
    if kc(KbName('RightArrow')); %kc(rk)
        xy(1,2)=xy(1,2)+p; chk=0;
    elseif kc(KbName('s')); % kc(sk)
        xy(2,2)=xy(2,2)+p; chk=0;
    elseif kc(KbName('LeftArrow')); %kc(lk);  
        xy(1,2)=xy(1,2)-p; chk=0;
    elseif kc(KbName('a')); %kc(ak);  
        xy(2,2)=xy(2,2)-p; chk=0;
    elseif kc(KbName('UpArrow')); %kc(uk)
        xy(1,1)=xy(1,1)+p; chk=0;
    elseif kc(KbName('w')); %kc(wk)
        xy(2,1)=xy(2,1)+p; chk=0;
    elseif kc(KbName('DownArrow'));%kc(dk);
        xy(1,1)=xy(1,1)-p; chk=0;
    elseif kc(KbName('z')); %kc(zk);
        xy(2,1)=xy(2,1)-p; chk=0
%     elseif  kc(sp) & chk == 0;
    elseif kc(KbName('space')) & chk == 0;
        pp=circshift(pp,[0 1]); p=pp(1); chk=1;
%     elseif kc(ek) | kc(kntr); %find(KeyCode)==ek
    elseif kc(KbName('ESCAPE')) | kc(KbName('Return')); %find(KeyCode)==ek
        ext=true;
    end
    
    xr=xy(1,1); yr=xy(1,2);
    xl=xy(2,1); yl=xy(2,2);
% decimal integer correct    
    [x1r x2r x3r]=d2i(xr, ms);
    [y1r y2r y3r]=d2i(yr, ms);
    
    [x1l x2l x3l]=d2i(xl, ms);
    [y1l y2l y3l]=d2i(yl, ms);
    

    %correct decimal for negative values
    %v0=[1 10 9 8 7 6 5 4 3 2]; 
    v0=[10:-1:1];
    
    x1r=x1r+1; if x3r<0; x1r=v0(x1r); end
    y1r=y1r+1; if y3r<0; y1r=v0(y1r); end
    
    x1l=x1l+1; if x3l<0; x1l=v0(x1l); end
    y1l=y1l+1; if y3l<0; y1l=v0(y1l); end

    xy(1,1)=x3r; xy(1,2)=y3r;
    xy(2,1)=x3l; xy(2,2)=y3l;

        
    disp([x3r y3r x3l y3l; x2r y2r x2l y2l; x1r y1r x1l y1l]);
    
    bcr=circshift(m_crc{x1r, y1r}, [x2r y2r]); 
    bcl=circshift(m_crc{x1l, y1l}, [x2l y2l]); 
    
    bsr=circshift(i1-m_crs{x1r, y1r}, [x2r y2r]); 
    bsl=circshift(i1-m_crs{x1l, y1l}, [x2l y2l]); 
    
    bgr= m_bkg-bcr;
    bgl= m_bkg-bcl;

    bcr=(bcr-bsr).*uint8(bcr~=0);
    bcl=(bcl-bsl).*uint8(bcl~=0);

    
    b1(:, :, rgb(1))=embd(bcr, i0); %right front circle
    b1(:, :, rgb(2))=embd(bgr, i0); %right background circle
    
    b2(:, :, rgb(1))=embd(bcl, i0); %left front circle
    b2(:, :, rgb(2))=embd(bgl, i0); %left background circle

end

xy4=[x3r y3r; x3l y3l];







% % Responses for three pairings of colors: red vs blue, red vs green,
% % and green vs blue will be acquired. Six measurements, three for the left eye and three for the
% % right, will require approximately 10 minutes.
% function bxy=TCA2f(vd, lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);
% 
% global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi cf
% 
% 
% % % Clear the workspace and the screen
% % sca;
% % close all;
% % clearvars;
% 
% % rd=540; % red diameter 
% % kd=116; %black diameter
% % bd=108; % blue diameter
% % lineWidthPix = 4; %bar width
% % pixelsPerPress = 0.5;
% 
% 
% % Screen('Preference', 'SkipSyncTests', 1);
% % Screen('Preference','VisualDebugLevel', 0);
% % % Here we call some default settings for setting up Psychtoolbox
% % PsychDefaultSetup(2);
% 
% % % Get the screen numbers
% % screens = Screen('Screens');
% % 
% % % Draw to the external screen if avaliable
% % screenNumber = 0; %
% % max(screens);
% 
% % % Define black and white
% % white = WhiteIndex(screenNumber);
% % black = BlackIndex(screenNumber);
% % 
% % % Open an on screen window
% % [window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
% % 
% % % Get the size of the on screen window
% % [screenXpixels, screenYpixels] = Screen('WindowSize', window);
% % 
% % % Set up alpha-blending for smooth (anti-aliased) lines
% % Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
% 
% 
% % % Query the frame duration
% % ifi = Screen('GetFlipInterval', window);
% 
% % % The avaliable keys to press
% % escapeKey = KbName('ESCAPE');
% % upKey = KbName('UpArrow');
% % downKey = KbName('DownArrow');
% % leftKey = KbName('LeftArrow');
% % rightKey = KbName('RightArrow');
% 
% % % Get the centre coordinate of the window
% % [xCenter, yCenter] = RectCenter(windowRect);
% 
% % Make a base Rect of 200 by 250 pixels
% % baseRect = [0 0 rd rd];
% % rr = [0 0 rd rd];
% % kr = [0 0 kd kd];
% % br = [0 0 bd bd];
% 
% % % For Ovals we set a miximum diameter up to which it is perfect for
% % % maxDiameter = max(baseRect) * 1.01;
% % rm = max(rr);% * 1.01;
% % km = max(kr);% * 1.01;
% % bm = max(br);% * 1.01;
% % 
% % %mm=[rm; km; bm]'
% % mm=[rm; km]'
% 
% % Center the rectangle on the centre of the screen
% % centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);
% % rc = CenterRectOnPointd(rr, xCenter, yCenter);
% % kc = CenterRectOnPointd(kr, xCenter, yCenter);
% % bc = CenterRectOnPointd(br, xCenter, yCenter);
% % 
% % %cc=[rc; kc; bc]' 
% % cc=[rc; kc]'; % circle center
% % 
% % % Set the color of the rect to red
% % %rectColor = [1 0 0];
% % %rectColor = [1 0 0; 0 0 0; 0 0 1]';
% % rectColor = cf.*[1 0 0; 0 0 0]';
% 
% % Draw the rect to the screen
% %Screen('FillOval', window, rectColor, centeredRect, maxDiameter);
% % Screen('FillOval', window, rectColor, cc);
% 
% 
% % Now we set the coordinates (these are all relative to zero we will let
% % the drawing routine center the cross in the center of our monitor for us)
% xCoords = [-screenXpixels/2 screenXpixels/2 0 0];
% yCoords = [0 0 -screenYpixels screenYpixels];
% allCoords = [xCoords; yCoords];
% % 
% % % setting up cross over blue oval
% % xb = [-bd/2 bd/2 0 0];
% % yb = [0 0 -bd/2 bd/2];
% % ab = [xb; yb];
% 
% % Draw the fixation cross in white, set it to the center of our screen and
% % set good quality antialiasing
% % Screen('FillOval', window, rectColor, cc);
% % Screen('DrawLines', window, allCoords,...
% %     lineWidthPix, black, [xCenter yCenter], 2);
% 
% % Flip to the screen
% % Set the intial position of the square to be in the centre of the screen
% % squareX = xCenter;
% % squareY = yCenter;
% % Set the intial position of the square to be in random position
% %squareX = randi(screenXpixels);
% %squareY = randi(screenYpixels);
% 
% % squareX = round(screenXpixels*abs(randn)/6);
% % squareY = round(screenYpixels*abs(randn)/6);
% 
% squareX = screenXpixels/2 +round(vd(1).*rand./4);  
% squareY = screenYpixels/2 +round(vd(1).*rand./4);  
% 
% % squareX = screenXpixels/2;
% % squareY = screenYpixels/2;
% 
% % Set the amount we want our square to move on each button press
% 
% 
% % Sync us and get a time stamp
% % vbl0 = Screen('Flip', window1);
% % waitframes = 1;
% 
% % Maximum priority level
% topPriorityLevel = MaxPriority(window);
% Priority(topPriorityLevel);
% 
% % This is the cue which determines whether we exit the demo
% exitDemo = false;
% 
% while exitDemo == false
% 
%     % Check the keyboard to see if a button has been pressed
%     [keyIsDown,secs, keyCode] = KbCheck;
% 
%     % Depending on the button press, either move ths position of the square
%     % or exit the demo
%     if keyCode(ek)
%         exitDemo = true;
%     elseif keyCode(lk)
%         squareX = squareX - pixelsPerPress;
%     elseif keyCode(rk)
%         squareX = squareX + pixelsPerPress;
%     %elseif keyCode(upKey)
%     elseif keyCode(dk)
%         squareY = squareY - pixelsPerPress;
%     %elseif keyCode(downKey)
%     elseif keyCode(uk)
%         squareY = squareY + pixelsPerPress;
%     end
% 
%     % We set bounds to make sure our square doesn't go completely off of
%     % the screen
%     if squareX < 0
%         squareX = 0;
%     elseif squareX > screenXpixels
%         squareX = screenXpixels;
%     end
% 
%     if squareY < 0
%         squareY = 0;
%     elseif squareY > screenYpixels
%         squareY = screenYpixels;
%     end
% 
%     % Center the rectangle on the centre of the screen
% %     centeredRect = CenterRectOnPointd(br, squareX, squareY);
% %     bc = CenterRectOnPointd(br, squareX, squareY);
% %     cc=[rc; kc]'; 
% %     rectColor = cf.*[1 0 0; 0 0 0]';
% %     % Draw the rect to the screen
% %     Screen('FillOval', window, rectColor, cc);
% %     Screen('DrawLines', window, allCoords,...
% %     lineWidthPix, black, [xCenter yCenter], 2);
% %     Screen('FillOval', window, [0 0 1], bc);
% %     Screen('DrawLines', window, ab,...
% %     lineWidthPix, black, [squareX squareY], 2);
% % 
% %     % Flip to the screen
% %     vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
%     [wn, vbl1]=owin(ey, cf, [rd kd bd], lineWidthpix, allCoords, vbl0, window1, window2)
%     bxy=[squareX-xCenter squareY-yCenter]
%        
% end
% 
% % Wait for a key press
% %KbStrokeWait;
% 
% % Clear the screen
% %sca;

