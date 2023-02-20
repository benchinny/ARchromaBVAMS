%% Tumbling E
function [mm wf]=ETMf(w, ws, n, sc, sz, dly)

global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter window ifi

% 2D/1U done!
% average last N reversals

% % Setup the screen parameters for Psychtoolbox
% Screen('Preference', 'SkipSyncTests', 1);
% Screen('Preference','VisualDebugLevel', 0);
% PsychDefaultSetup(2);
% screens = Screen('Screens');
%scrn=0; %screen to display on
%w=5; % width of E line set for 540 pixels E width which corresponds to 5 visual degrees in the system
%ws=1; %width displacement steps  
%d=5*w; %initial displacement
%ds=10; % displacement steps
cnt=0;% initialization of 1U/2D
mm=[]% memory
%n=10;% memory length
%sc=0.5 % stop criterion
cc=1;  % initialization of current crieterion
%sz = [1080, 1920]; % size of screen

% % The avaliable keys to press
% ek = KbName('ESCAPE');
% uk = KbName('UpArrow');
% dk = KbName('DownArrow');
% lk = KbName('LeftArrow');
% rk = KbName('RightArrow');

% % Open the window(s) with a black background
% [window_1, windowRect_1] = PsychImaging('OpenWindow',scrn, [1 1 1]);
% Screen('BlendFunction', window_1, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

while cc>sc
    p=rand(1);
    %img=Et(p, d, w, sz);
    img=Eti(p, w, sz);
    %Screen('BlendFunction', window_1, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    % % Make a texture with the image we produced earlier and flip (place) onto
    % % display 1
    %tex_1 = Screen('MakeTexture', window_1, img);
    %img=uint8(abs(double(img)-255)); % convert img to black letter on white background
    tex_1 = Screen('MakeTexture', window, img);
    Screen('DrawTexture', window, tex_1);
    Screen('Flip', window);
    startTime=WaitSecs(0);
    %[secs, keyCode, deltaSecs] = KbStrokeWait([], dly);
    [secs, keyCode, deltaSecs] = KbStrokeWait([], startTime+dly);

    Screen('FillRect', window, white);
    Screen('Flip', window)
    
    [secs, keyCode, deltaSecs] = KbStrokeWait;
    
    if find(keyCode)==ek; break; %L80 R79 U82 D81
    elseif find(keyCode)==st %L80 R79 U82 D81
        cnt=cnt+1; % taking care of 2D/1U
        mm=[mm 1]; %memory
        if cnt==2
            %d=d-ds;
            w=w-ws; %d=5*w;
            cnt=0;
        end
    else
        %d=d+ds;
        w=w+ws; %d=5*w
        mm=[mm 0]; %memory
        cnt=0;
    end
    %calculate current criterion
    if length(mm)>=n
        cc=sum(mm(end-n+1:end))/n
    end
end
wf=w
% Clear the screen.
%sca;
