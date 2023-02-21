 %% 210409 measure white vs green vs purple luminance

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
% b=[5 25   35   55   105  155  205  255];%background luminance for RGB right and left
%b=[ 255 205 155 105 55 35 30 25];   
%c=2  ; %1R 2G B3
%w=50; % width of line

%      cf=ones(3,2); %white
% b=[0.3982 0.3982 0.3982; 0.6153 0.3982 1; 0 0.5 0]; %gamma corrected/purple background
%b=[0.3982 0.3982 0.3982; 0.6153 0.3982 1; 0 0.65 0]; %gamma corrected/purple background
%b=[0.6153 0.3982 1; 0 0.55 0; ; 0 0.57 0; 0 0.6 0]; %gamma corrected/purple background
%b=[0.6153 0.3982 1; 0 0.59 0; ; 0.57 0.57 0.57]; %gamma corrected/purple background
%b=[0.6153 0.3982 1; 0 0.58 0; 0.55 0.55 0.55]; %gamma corrected/purple background
%b=[0.6153 0.3982 1; 0 0.585 0; 0.53 0.53 0.53; 0.52 0.52 0.52; 0.51 0.51 0.51]; %gamma corrected/purple background
%b=[0.6153 0.3982 1; 0 0.584 0; 0.525 0.525 0.525]; %gamma corrected/purple background
%b=[0.6153 0.3982 1; 0 0.583 0; 0 0.582 0]; %gamma corrected/purple background
%b=[0.6153 0.3982 1; 0 0.5825 0]; %gamma corrected/purple background
%b=[0.6153 0.3982 1; 0 0.583 0; 0.525 0.525 0.525]; %gamma corrected/purple background final values for LEFT display
% b=[0.6153 0.3982 1; 0 0 0]; %gamma corrected/purple background final values
%b=[0.6153 0.3982 1; 0 0.583 0; 0.525 0.525 0.525]; %gamma corrected/purple
%b=[0.6153 0.3982 1; 0 0.61 0; 0.535 0.535 0.535]; %gamma corrected/purple 
%b=[0.6153 0.3982 1; 0 0.605 0; 0.54 0.54 0.54]; %gamma corrected/purple
b=[0.6153 0.3982 1; 0 0.605 0; 0.538 0.538 0.538]; %gamma corrected/purple background final values for RIGHT display

%         cf=[0 0; 1 1;0 0]; %green background
00
KbName('UnifyKeyNames')
ey='Right';ex='LCA'

% [RR RG RB] =1.4010    4.1090    0.4064
% 
% [LR LG LB]= 1.3480    3.9330    0.3604

screens = Screen('Screens');
screenNumber = max(screens);
%load cal_val; %cf=[1 1]; 
%cf=[RB./RR LB./LR];
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1 ];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
cf=ones(3,2);
[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
%ext=false;     chk=0;
    sz0=[screenYpixels,  screenXpixels];
    sz2=round(sz0./2)
    %i0=ones(sz0);
    i1=ones(sz0); i2=zeros([sz0 3]);
 ext=0;
 while ext == 0; %find(KeyCode)~=ek
%for k0=1:length(b);
     for k0=1:3; i2(:,:,k0)=i1.*b(1, k0); end
     %img=uint8(cat(3, b(1,2).*i0, b(2,2).*i0, b(3,2).*i0));

    %img=imread(b,'png'); %% image to sh
    disp(b(k0));
        tex_1 = Screen('MakeTexture', window1, uint8(255.*i2)); Screen('DrawTexture', window1, tex_1);
        tex_2 = Screen('MakeTexture', window2, uint8(255.*i2)); Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window1);
        Screen('Flip', window2);
    
    %KbWait([], 2 ); %% wait for keystroke
    [secs, kc, deltaSecs] = KbStrokeWait;
    if kc(KbName('ESCAPE')); ext=1; end
    
    
    b=circshift(b, [-1 0]);
    
end

sca



%  %% 210409 collect values for gamma correction
% 
% % clear all
% close all
% clc
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% %108 pix/degree
% %0.0093 visual degrees/pixel
% %0.5556 arcmin/pixel
% %3.333 arcsec/pixel
% %display =10 degrees
% %FOV=5degrees
% % b=[5 25   35   55   105  155  205  255];%background luminance for RGB right and left
% b=[ 255 205 155 105 55 35 30 25];   
% c=2  ; %1R 2G B3
% %w=50; % width of line
% 
% 
% 
% 
% ey='Right';ex='LCA'
% 
% % [RR RG RB] =1.4010    4.1090    0.4064
% % 
% % [LR LG LB]= 1.3480    3.9330    0.3604
% 
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1]; 
% %cf=[RB./RR LB./LR];
% % cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1 ];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=ones(3,2);
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% %ext=false;     chk=0;
%     sz0=[screenYpixels,  screenXpixels];
%     sz2=round(sz0./2)
%     %i0=ones(sz0);
%     i0=zeros([sz0 3]); i1=ones(sz0);
% % while ext == false; %find(KeyCode)~=ek
% for k0=1:length(b);
%      i2=i0;
%      i2(:,:,c)=i1.*b(k0);
%      %img=uint8(cat(3, b(1,2).*i0, b(2,2).*i0, b(3,2).*i0));
% 
%     %img=imread(b,'png'); %% image to sh
%     disp(b(k0));
%         tex_1 = Screen('MakeTexture', window1, uint8(i2)); Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, uint8(i2 )); Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window1);
%         Screen('Flip', window2);
%     
%     KbWait([], 2 ); %% wait for keystroke
%     
% end
% 
% sca