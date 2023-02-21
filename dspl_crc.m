%210610 dspl_crc display circle until it vanishes


%% Version 210510
%clr
global ek uk dk lk rk st snt  black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto ey
% edit JJVC_stro
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); addpath([pwd '\data\System TCA\Data Processing']);  addpath(genpath(fullfile('toolboxes')));
cls
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
c0=0.00384; %deg/pixels
%display =10 degrees
%FOV= 5 degrees

zbr=1; %activate zebar/optotune
rc00=[4 -7; 8 -6]; %210610 screen centering & FOV measurement =800pixels = 3degrees
%rc00=[0 0; 100 100]; % updated april 20 2021, use this
%Left794pixels Right792pixels FOV
%  [right_Y right_X; left_Y Left_X]

sz = [1080, 1920]; % size of screen
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[RB./RR LB./LR];
cf=ones(3,2);
%cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% background LATEST JAN 7
% try; 
%     
%     
% %     for k0=1:6; disp(opto(k0).control.focal_power); end
%     for k0=1:6; disp(opto(k0).control.getFocalPower); end
% 
% 
% catch ERROR;
%     for k0=1:3
%         cls_opt; pause(3);
%         
%     end
%     
%     OPNT;
% end
% %%run up to here to START/OPEN the system
KbName('UnifyKeyNames')

[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 1);
w0=390
chk=0;
while chk==0

        [rc00 [w0; w0]]
        img1=ct3(crc0(w0, sz)==0); 
    
        cwin1(img1, img1, cf, rc00, window1, window2);
    
        [secs, kc, deltaSecs] = KbStrokeWait;

        if kc(KbName('a'))
            w0=w0+1;

        elseif kc(KbName('z'))
            w0=w0-1;
            
        elseif kc(KbName('UpArrow'))
            rc00(:,1)=rc00(:,1)+1;

        elseif kc(KbName('DownArrow'))
            rc00(:,1)=rc00(:,1)-1;
            
        elseif kc(KbName('LeftArrow'))
            rc00(:,2)=rc00(:,2)-1;
        elseif kc(KbName('RightArrow'))
            rc00(:,2)=rc00(:,2)+1;
        elseif kc(KbName('ESCAPE'))
           chk=1; 
        end
end


sca


