%% Tumbling E
function [rv wv wn]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2)

global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi

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
p0=rand(n,1);
rv=zeros(1,n); %response/reply vector
wv=zeros(1,n); %optotype size vector


for ni=1:n;
    p=p0(ni);
    %img=Et(p, d, w, sz);
    img=Eti(p, w, sz, L);
    %Screen('BlendFunction', window_1, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    % % Make a texture with the image we produced earlier and flip (place) onto
    % % display 1
    %tex_1 = Screen('MakeTexture', window_1, img);
    %img=uint8(abs(double(img)-255)); % convert img to black letter on white background
%     tex_1 = Screen('MakeTexture', window1, img);
%     tex_2 = Screen('MakeTexture', window2, img);
% 
%     Screen('DrawTexture', window1, tex_1);
%     Screen('DrawTexture', window2, tex_2);
% 
%     Screen('Flip', window1);     Screen('Flip', window2);

   wn=cwin(img, ey, [1 1], window1, window2)

    startTime=WaitSecs(0);
    %[secs, keyCode, deltaSecs] = KbStrokeWait([], dly);
    [secs, keyCode, deltaSecs] = KbStrokeWait([], startTime+dly);

    Screen('FillRect', window1, white);
    Screen('FillRect', window2, white);

    Screen('Flip', window1);     Screen('Flip', window2);

    [secs, keyCode, deltaSecs] = KbStrokeWait;
    
    if find(keyCode)==ek; break; %L80 R79 U82 D81
    elseif find(keyCode)==st %L80 R79 U82 D81
        cnt=cnt+1; % taking care of 2D/1U
        %mm=[mm 1]; %memory
        snd(1000, 0.2)
        rv(ni)=1; wv(ni)=w;
        if cnt==2
            %d=d-ds;
            w=w-ws; %d=5*w;
            cnt=0;
        end
    else
        %d=d+ds;
        snd(250, 0.2)
        wv(ni)=w;
        w=w+ws; %d=5*w
        %mm=[mm 0]; %memory
        cnt=0;
    end
    %calculate current criterion
%     if length(mm)>=n
%         cc=sum(mm(end-n+1:end))/n
%     end
end
%wf=w
% Clear the screen.
%sca;
