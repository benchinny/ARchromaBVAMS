addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
%% BVAMS OPTICAL QUALITY
global ek uk dk lk rk sp n0m n1m n2m n0d n1d n2d st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf sz rc00
cls
cls_opt

  p00=[14.6008   14.6008
   12.5000   12.5000
    0.8000    0.8000
   -3.0000   -3.0000];

% colorarray=[ G, B, B ,G, G ,R, B, R, G, G, B, R, R, R, B, G, R, B];
colorarray=[ 'G', 'B', 'R'];

for trials=1:size(colorarray)
    
    if colorarray(trials)=='G'
    rgd=[1 3]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
    
    elseif colorarray(trials)=='B'
     rgd=[1 2]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
     
       elseif colorarray(trials)=='R'
    rgd=[2 3]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
    end
rc00=[0 0; 0 0];
drp=5; %number of trials to drop from the begining
n=10;% number of trials
w=5; %starting optotype size
sd=0; %Gaussian filter kernel size
% rgd=[1 3]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
sz = [1080, 1920]; % size of screen
dly=0.5; %length of optotype presentation in secs
ms=10;
bxy=[10 10; 0 0; -10 -10];
ey='Stereo';ex='LCA'

screens = Screen('Screens');
screenNumber = max(screens);
[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 


        cf=ones(3,2);
        %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype 
                %[p11 rv wv wn]=boa([n, w, dly, sd], p00, opto, port, name_map, rgd, bxy, ey, window1, window2);
                %[p11 rv wv wn]=boa([n, w, dly, sd], p00,rgd, bxy, ey, window1, window2);
                [p11 rv wv wn]=boai([n, w, dly, sd], p00,rgd, bxy, ey, window1, window2);
                ListenChar(0);
                 [rslt cnfd]=psft(wv, rv, drp);
         %disp(rslt); %[threshold,width,lambda,gamma,eta]
         % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
         yy=2.^(rslt(1)./2);
         disp(['YOUR ACUITY SCORE IS 20/' num2str(20.*yy./4.34)]);

sca
end