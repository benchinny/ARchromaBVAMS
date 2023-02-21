%% adjust luminance on 2 screens

% clear all
close all
clc

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
%108 pix/degree
%0.0093 visual degrees/pixel
%0.5556 arcmin/pixel
%3.333 arcsec/pixel
%display =10 degrees
%FOV=5degrees
b=[150 0; 150 0 ;0 0]; %background luminance for RGB right and left
w=50; % width of line




ey='Right';ex='LCA'

% [RR RG RB] =1.4010    4.1090    0.4064
% 
% [LR LG LB]= 1.3480    3.9330    0.3604

screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[1 1]; 
%cf=[RB./RR LB./LR];
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1 ];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
cf=ones(3,2);
[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
ext=false;     chk=0;
    sz0=[screenYpixels,  screenXpixels];
    sz2=round(sz0./2)
    i0=ones(sz0);
while ext == false; %find(KeyCode)~=ek

     img1=uint8(cat(3, b(1,1).*i0, b(2,1).*i0, b(3,1).*i0));
     img2=uint8(cat(3, b(1,2).*i0, b(2,2).*i0, b(3,2).*i0));

    %img=imread(b,'png'); %% image to show
    disp(b);
        tex_1 = Screen('MakeTexture', window1, img1); Screen('DrawTexture', window1, tex_1);
        tex_2 = Screen('MakeTexture', window2, img2); Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window1);
        Screen('Flip', window2);
    
    %[keyIsDown,secs, kc] = KbCheck;
    [secs, kc, deltaSecs] = KbStrokeWait;
    if kc(ek); %find(KeyCode)==ek
        ext=true;
    elseif kc(uk);
        b(:,1)=b(:,1)+w;
    elseif kc(dk);
        b(:,1)=b(:,1)-w;
    elseif kc(rk);
        b(:,2)=b(:,2)+w;
    elseif kc(lk);
        b(:,2)=b(:,2)-w;        
    end
    %KbWait; %% wait for keystroke
end

sca