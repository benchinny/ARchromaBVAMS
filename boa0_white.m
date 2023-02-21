addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
%% BVAMS OPTICAL QUALITY
global ek uk dk lk rk sp n0m n1m n2m n0d n1d n2d st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf sz rc00
cls
cls_opt


%% generate background color and magnitude settings
%p00=[power_dispL power_dispR powerL powerR magL magR rot rgd];
cl=0; %background color 0white 1red 2green 3blue choose background color
tm= 1; % thrombone mag setting
opto_power=@(mag) -9.9976*mag+21.164;
tp=opto_power(1); %thrombone power setting
p00=zeros(length(cl).*length(tm), 8); 
p00(:,1:2)=14.608;
p00(:, 3:4)=opto_power(0.8);
p00(:,7)=0;

i0=1;
for k0=1:length(cl)
    for k1=1:length(tm)
    p00(i0, 8)=cl(k0);
    p00(i0, 5:6)=tm(k1);
    p00(i0, 3:4)=tp(k1);
    i0=i0+1;
    end 
end
%p00=[14.6008   14.6008 12.5000   12.5000 1     1 -3.0000   1];
 p00=[p00; p00;p00];
%shuffle the settings for randomization
p00=p00(randperm(size(p00,1)),:);



rc00=[0 0; 0 0];
drp=5; %number of trials to drop from the begining
n=30;% number of trials
w=5; %starting optotype size
sd=0; %Gaussian filter kernel size
%rgd=[ ]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
sz = [1080, 1920]; % size of screen
dly=0.5; %length of optotype presentation in secs
ms=10;
%bxy=[10 10; 0 0; -10 -10];
bxy=[0 0; 0 0; 0 0];

ey='Stereo';ex='LCA'

screens = Screen('Screens');
screenNumber = max(screens);
[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 


        cf=ones(3,2);
        %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype 
                %[p11 rv wv wn]=boa([n, w, dly, sd], p00, opto, port, name_map, rgd, bxy, ey, window1, window2);
                %[p11 rv wv wn]=boa([n, w, dly, sd], p00,rgd, bxy, ey, window1, window2);
                [p12 rvc wvc zzc wn]=boaii([n, w, dly, sd, drp], p00(1:3, :), bxy, ey, window1, window2);

                ListenChar(0);
                save(['data\AJR_ALL_' tme], 'p12', 'rvc', 'wvc', 'zzc');
%                  [rslt cnfd]=psft(wv, rv, drp);
%          %disp(rslt); %[threshold,width,lambda,gamma,eta]
%          % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
%          yy=2.^(rslt(1)./2);
%          disp(['YOUR ACUITY SCORE IS 20/' num2str(20.*yy./4.34)]);

sca


% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
% %% BVAMS OPTICAL QUALITY
% global ek uk dk lk rk sp n0m n1m n2m n0d n1d n2d st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf sz rc00
% cls
% cls_opt
% 
%   p00=[14.6008   14.6008
%    12.5000   12.5000
%     1     1
%    -3.0000   -3.0000];
% 
% 
% rc00=[0 0; 0 0];
% drp=5; %number of trials to drop from the begining
% n=30;% number of trials
% w=5; %starting optotype size
% sd=0; %Gaussian filter kernel size
% rgd=[ ]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
% sz = [1080, 1920]; % size of screen
% dly=0.5; %length of optotype presentation in secs
% ms=10;
% bxy=[10 10; 0 0; -10 -10];
% ey='Stereo';ex='LCA'
% 
% screens = Screen('Screens');
% screenNumber = max(screens);
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% 
%         cf=ones(3,2);
%         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype 
%                 %[p11 rv wv wn]=boa([n, w, dly, sd], p00, opto, port, name_map, rgd, bxy, ey, window1, window2);
%                 %[p11 rv wv wn]=boa([n, w, dly, sd], p00,rgd, bxy, ey, window1, window2);
%                 [p11 rv wv wn]=boai([n, w, dly, sd], p00,rgd, bxy, ey, window1, window2);
%                 ListenChar(0);
%                  [rslt cnfd]=psft(wv, rv, drp);
%          %disp(rslt); %[threshold,width,lambda,gamma,eta]
%          % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
%          yy=2.^(rslt(1)./2);
%          disp(['YOUR ACUITY SCORE IS 20/' num2str(20.*yy./4.34)]);
% 
% sca