%% Version 201125
%clr
global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
cls  
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
c0=0.00384; %deg/pixels
%display =10 degrees
%FOV=5degrees


%BVAMS_gui; %run input gui
% ey='Right'; %eye Right Left Binocular
ey='Right'; %eye Right Left Binocular

ex='LCA'; %Experiment type TCA LCA CRM chromostereopsis
ACL=0; %ACL attached=1 otherwise=0
sn=10003; %subject number 10004MB
%subject number 10003AR
if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
zbr=1; %act ivate zebar/optotune 
rc00=[0 0; 0 0]; %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LCA params
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p0=zeros(8,2);
magn=1; %for LCA defocus task
%if set power_disp/optopower=0 randomize.
p0(1,:)=[9                    9];               %power_dispL_min      power_dispR_min
p0=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR
% p0(2,:)=[12.5                    12.5];               %initial power_dispL          power_dispR   
p0(3,:)=[19                  19];              %power_dispL_max      power_dispL_max                   
p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
p0(5,:)=[opL(magn)               opR(magn)];          %L_optopower(mag)     R_optopower(mag)
%making trombone go to a specific magnification OF 1 
% p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)
p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
p0(7,:)=-3; %rotation
p0(8,:)=4; %number of repetitions              
% LCAim='subpixel-e1403202931818.png';
 
% LCAim{1}='vrn10_RB_sd1.png';
% LCAim{2}='vrn10_RG_sd1.png';
% LCAim{3}='vrn10_GB_sd1.png';
LCAim{1}='vrn10_R_sd1.png';
LCAim{2}='vrn10_G_sd1.png';
LCAim{3}='vrn10_B_sd1.png';
% LCAim='vrn10_RG_sd1.png';
% LCAim='vrn10_GB_sd1.png';
% LCAim='vrn500ud_sd1.png';   
% LCAim='vrn100ud_sd1.png';

% LCAim='A.png';
% LCAim='dots.png';
% LCAim='Y.png';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TCA params
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ms=10;
% rd=540; % red diameter 
% kd=120; % black diameter
% bd=108; % blue diameter
% lineWidthPix = 4; %bar width
rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue

%rgb=[3 1]; %TCA [inner-small-circle background-outer-circle] colors 1red 2green 3blue
% rgb=[3 2]; %BLUE GREEN
xy0=40; %inital position of small circle
% xy0=0; %inital position of small circle

ppp = [5 0.2]; %resolution pixelsPerPress
n2=3; %number of repetitions
%TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
TCAfnm='c130_b145to540_w10_ms10_sd1_6';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ETM params
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%bxy=[-10.3 10.7; 10.5 -11]
d1=5; %trials to drop
% d1=0; %trials to drop
n0=4; % number of experiments/repetitions
n1=30;% number of trials
% n1=5;% number of trials
w0=12;% initial size of the optotype, stroke size= 2^w
%t0=0.7; %psignfit threshold
%sd=0; %blur kernel
%rgd=[ ]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
sz = [1080, 1920]; % size of screen
d0=2; %length of optotype presentation in secs
% Get the screen numbers
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[RB./RR LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
% cf=ones(3,2);
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
%  cf=ones(3,2);
% load('E_b2_m2_p10_o4_ms10.mat'); %LOAD BEFORE STARTING, E optotype base 2

%if exist('E10c')==0 | isempty(E10c)==1; load('E_b2_m2_p10_o4_ms10.mat'); end %E optotype base 2
%CHROMOSTREOPSIS parameters
p5(1)=0.5; %dly stimuli presntation times/delays: maltese, black, bars 
p5(2)=16; %s step size
p5(3)=17; % wh half width of blue&red bars
p5(4)=5; %wv gap half width between blue & red bars
p5(5)=260; %wl length of bar
p5(6)=43; %rd= round(p0(6).*rand(1)); %rd== round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
p5(7)=30; %ni number of trials
%% create green rectangle
p5(8)=250; %v 
p5(9)=250; %h 
p5(10)=10; % wr half vertical, horizontal, width of rectangle 
%% extract visual lines
p5(11)=50; % vl half of visual patch/line length

[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 

switch ex
    
    case 'LCA'
              p1=LCA8f(LCAim, p0, ey, window1, window2); 
         for k0=1:length(LCAim)
           p2(k0,:)=mean(p1(p1(:,6)==k0,:),1) 
        end
        if sv==1; save(['data\S' num2str(sn) '_' ey '_LCA_' tme], 'p1', 'LCAim'); end 
        if strcmp(ey,'Right') 
            p3=set_opt_RightEye(p2,magn); %gives optotune settings for Right eye only usign defocus adjustments from subject, i.e 2nd column in p0
            %Nadav:add line to save p3 for the subject-> Sub_OptSettings_RightEye_NoAcl_Date
            p4=p0(1,:);  %first column for left eye
        elseif strcmp(ey,'Left') 
            p4=set_opt_LeftEye(p2,magn);
            %Nadav:add line to save p4 for subject--> Sub_OptSettings_LeftEye_NoACL_Date
            %Nadav:load saved p3 for right eye from above
           
        end
        p5=[p4 p3];
        opt0(p5);
        
        %when defocus is adjusted for the subject, 
%         1 note down the best defocus value for the subject
%         2 load p3 for right eye and set p3(2,1)=   , and move trombone to
%         p0=[p0(:,1)  p3];
%         3 load p4 for left eye and set p4(2,1  , and move trombone to p0=[p4 p0(:,2)];
      
        
%        cf=[RB./RR LB./LR; 1 1; 1 1];
        clear E10c
       [bxy v0]=TCA6f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
        %bxy=TCA5f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);       
        if sv==1; save(['data\S' num2str(sn) '_TCA_' tme], 'bxy','rgb', 'v0'); end
        %z0=mean(bxy,1); z1=zeros(2, 2); z1(1,:)=z0(1:2); z1(2,:)=z0(3:4); %convert to ETM9f format
%         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
%         z1=[0 0 0 0;10 10 0 0;0 0 0 0];
%          z1=zeros(3,4);
        %rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
                z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
                z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]

    case 'ETM'
        
        if exist('E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat');  end %E optotype base 3 17secs to load

        
        cf=ones(3,2);
%         cf=[0 0; 1 1;0 0];
         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype 
          [y0 y1 w2]=ETM10f([n0 n1 w0 d0], z1, E10c, STK, window1, window2);  
         %[y0 y1 w2]= ETM9f([n0 n1 w0 d0], z1, E10c, STK, window1, window2); 
        [r0 r1]=psf(y0, y1, w2, d1, STK);
        c1=1./(c0.*60);
        m0=mean(r0)./c1; m1=mean(r1)./c1;
        disp(['TCA corrected mean visual acuity score 20/ ' n2s(m1)])
        disp(['TCA UNcorrected mean visual acuity score 20/ ' n2s(m0)])
        if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'r0', 'r1'); end         
%% z1 & z2 are TCA values used (mean & std)

    case 'CRM'
        
         [r5 vu vb]=CRMf1(p5, window1, window2);
        if sv == 1; save(['data\S' num2str(sn) '_CRM_' ey '_ACL' n2s(ACL) tme], 'r5', 'vu', 'vb'); end      

end

sca

% %% Version 201124
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
% cls  
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% c0=0.00384; %deg/pixels
% %display =10 degrees
% %FOV=5degrees
% 
% 
% %BVAMS_gui; %run input gui
% % ey='Right'; %eye Right Left Binocular
% ey='Right'; %eye Right Left Binocular
% 
% ex='LCA'; %Experiment type TCA LCA CRM chromostereopsis
% ACL=0; %ACL attached=1 otherwise=0
% sn=10003; %subject number 10004MB
% %subject number 10003AR
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %act ivate zebar/optotune 
% rc00=[0 0; 0 0]; %
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % LCA params
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p0=zeros(8,2);
% %if set power_disp/optopower=0 randomize.
% p0(1,:)=[9                    9];               %power_dispL_min      power_dispR_min
% %p0=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR
% p0(2,:)=[0                    0];               %initial power_dispL          power_dispR   
% p0(3,:)=[19                  19];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% %p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)
% %making trombone go to a specific lowest magnification
% p0(5,:)=[opL(0.8)             opR(0.8)];               %L_optopower(mag)     R_optopower(mag)   
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation
% p0(8,:)=4; %number of repetitions              
% % LCAim='subpixel-e1403202931818.png';
%  
% % LCAim{1}='vrn10_RB_sd1.png';
% % LCAim{2}='vrn10_RG_sd1.png';
% % LCAim{3}='vrn10_GB_sd1.png';
% LCAim{1}='vrn10_R_sd1.png';
% LCAim{2}='vrn10_G_sd1.png';
% LCAim{3}='vrn10_B_sd1.png';
% % LCAim='vrn10_RG_sd1.png';
% % LCAim='vrn10_GB_sd1.png';
% % LCAim='vrn500ud_sd1.png';   
% % LCAim='vrn100ud_sd1.png';
% 
% % LCAim='A.png';
% % LCAim='dots.png';
% % LCAim='Y.png';
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% TCA params
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ms=10;
% % rd=540; % red diameter 
% % kd=120; % black diameter
% % bd=108; % blue diameter
% % lineWidthPix = 4; %bar width
% rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
% 
% %rgb=[3 1]; %TCA [inner-small-circle background-outer-circle] colors 1red 2green 3blue
% % rgb=[3 2]; %BLUE GREEN
% xy0=40; %inital position of small circle
% % xy0=0; %inital position of small circle
% 
% ppp = [5 0.2]; %resolution pixelsPerPress
% n2=3; %number of repetitions
% %TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
% TCAfnm='c130_b145to540_w10_ms10_sd1_6';
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% ETM params
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %bxy=[-10.3 10.7; 10.5 -11]
% d1=5; %trials to drop
% % d1=0; %trials to drop
% n0=4; % number of experiments/repetitions
% n1=30;% number of trials
% % n1=5;% number of trials
% w0=12;% initial size of the optotype, stroke size= 2^w
% %t0=0.7; %psignfit threshold
% %sd=0; %blur kernel
% %rgd=[ ]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
% sz = [1080, 1920]; % size of screen
% d0=2; %length of optotype presentation in secs
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
% % cf=ones(3,2);
% % cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% %  cf=ones(3,2);
% % load('E_b2_m2_p10_o4_ms10.mat'); %LOAD BEFORE STARTING, E optotype base 2
% 
% %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2_m2_p10_o4_ms10.mat'); end %E optotype base 2
% %CHROMOSTREOPSIS parameters
% p5(1)=0.5; %dly stimuli presntation times/delays: maltese, black, bars 
% p5(2)=16; %s step size
% p5(3)=17; % wh half width of blue&red bars
% p5(4)=5; %wv gap half width between blue & red bars
% p5(5)=260; %wl length of bar
% p5(6)=43; %rd= round(p0(6).*rand(1)); %rd== round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
% p5(7)=30; %ni number of trials
% %% create green rectangle
% p5(8)=250; %v 
% p5(9)=250; %h 
% p5(10)=10; % wr half vertical, horizontal, width of rectangle 
% %% extract visual lines
% p5(11)=50; % vl half of visual patch/line length
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% switch ex
%     
%     case 'LCA'
%               p1=LCA8f(LCAim, p0, ey, window1, window2); 
%          for k0=1:length(LCAim)
%            p2(k0,:)=mean(p1(p1(:,6)==k0,:),1) 
%         end
%         if sv==1; save(['data\S' num2str(sn) '_' ey '_LCA_' tme], 'p1', 'LCAim'); end                                
%     case 'TCA'
%       
%         
% %        cf=[RB./RR LB./LR; 1 1; 1 1];
%         clear E10c
%        [bxy v0]=TCA6f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%         %bxy=TCA5f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);       
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' tme], 'bxy','rgb', 'v0'); end
%         %z0=mean(bxy,1); z1=zeros(2, 2); z1(1,:)=z0(1:2); z1(2,:)=z0(3:4); %convert to ETM9f format
% %         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
% %         z1=[0 0 0 0;10 10 0 0;0 0 0 0];
% %          z1=zeros(3,4);
%         %rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
%                 z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
%                 z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
% 
%     case 'ETM'
%         
%         if exist('E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat');  end %E optotype base 3 17secs to load
% 
%         
%         cf=ones(3,2);
% %         cf=[0 0; 1 1;0 0];
%          %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype 
%           [y0 y1 w2]=ETM10f([n0 n1 w0 d0], z1, E10c, STK, window1, window2);  
%          %[y0 y1 w2]= ETM9f([n0 n1 w0 d0], z1, E10c, STK, window1, window2); 
%         [r0 r1]=psf(y0, y1, w2, d1, STK);
%         c1=1./(c0.*60);
%         m0=mean(r0)./c1; m1=mean(r1)./c1;
%         disp(['TCA corrected mean visual acuity score 20/ ' n2s(m1)])
%         disp(['TCA UNcorrected mean visual acuity score 20/ ' n2s(m0)])
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'r0', 'r1'); end         
% %% z1 & z2 are TCA values used (mean & std)
% 
%     case 'CRM'
%         
%          [r5 vu vb]=CRMf1(p5, window1, window2);
%         if sv == 1; save(['data\S' num2str(sn) '_CRM_' ey '_ACL' n2s(ACL) tme], 'r5', 'vu', 'vb'); end      
% 
% end
% 
% sca


% %% Version 201111
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
% cls 
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% c0=0.00384; %deg/pixels
% %display =10 degrees
% %FOV=5degrees
% 
% 
% %BVAMS_gui; %run input gui
% ey='Stereo'; %eye Right Left Binocular
% ex='TCA'; %Experiment type TCA LCA CRM chromostereopsis
% ACL=1; %ACL attached=1 otherwise=0
% sn=0; %subject number
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune 
% rc00=[0 0; 0 0]; %change screen offset
% 
% %% LCA params
% p0=zeros(8,2);
% %if set power_disp/optopower=0 randomize.
% p0(1,:)=[10                    10];               %power_dispL_min      power_dispR_min
% %p0=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR
% p0(2,:)=[0                    0];               %initial power_dispL          power_dispR   
% p0(3,:)=[17                  17];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% %p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)
% p0(5,:)=[0                    0];               %L_optopower(mag)     R_optopower(mag)     
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation
% p0(8,:)=1; %number of repetitions              
% 
% %  LCAim='vrn10_RB_sd1.png';
% % LCAim='vrn10_RG_sd1.png';
% %LCAim='vrn10_GB_sd1.png';
% % LCAim='vrn500ud_sd1.png';   
% % LCAim='vrn100ud_sd1.png';
% 
% % LCAim='A.png';
% LCAim='letter_a_PNG6.png';
% LCAim='Y.png';
% %% TCA params
% ms=10;
% % rd=540; % red diameter 
% % kd=120; % black diameter
% % bd=108; % blue diameter
% % lineWidthPix = 4; %bar width
% rgb=[3 1]; %TCA [inner-small-circle background-outer-circle] colors 1red 2green 3blue
% % rgb=[3 2]; %BLUE GREEN
% xy0=0; %inital position of small circle
% % xy0=0; %inital position of small circle
% 
% ppp = [5 0.2]; %resolution pixelsPerPress
% n2=1; %number of repetitions
% %TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
% TCAfnm='c130_b145to540_w10_ms10_sd1_6';
% 
% %% ETM params
% %bxy=[-10.3 10.7; 10.5 -11]
% d1=5; %trials to drop
% n0=4; % number of experiments/repetitions
% n1=30;% number of trials
% w0=12;% initial size of the optotype, stroke size= 2^w
% %sd=0; %blur kernel
% %rgd=[ ]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
% sz = [1080, 1920]; % size of screen
% d0=2; %length of optotype presentation in secs
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% % cf=[RB./RR LB./LR; 1 1; 1 1];
% %cf=ones(3,2);
% % cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
%  cf=ones(3,2);
% % load('E_b2_m2_p10_o4_ms10.mat'); %LOAD BEFORE STARTING, E optotype base 2
% 
% if exist('E10c')==0 | isempty(E10c)==1; load('E_b2_m2_p10_o4_ms10.mat'); end %E optotype base 2
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% switch ex
%     
%     case 'LCA'
%               p1=LCA7f(LCAim, p0, ey, window1, window2);                       
%         if sv==1; save(['data\S' num2str(sn) '_' ey '_LCA_' tme], 'p1', 'LCAim'); end                                
%     case 'TCA'
%         bxy=TCA5f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);       
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' tme], 'bxy','rgb'); end
%         z0=mean(bxy,1); z1=zeros(2, 2); z1(1,:)=z0(1:2); z1(2,:)=z0(3:4); %convert to ETM9f format
%         
%     case 'ETM'
%         cf=ones(3,2);
%          %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype 
%          [y0 y1 w2]=ETM9f([n0 n1 w0 d0], z1, E10c, STK, window1, window2); 
%         [r0 r1]=psf(y0, y1, w2, d1, STK);
%         c1=1./(c0.*60);
%         m0=mean(r0)./c1; m1=mean(r1)./c1;
%         disp(['TCA corrected mean visual acuity score 20/ ' n2s(m1)])
%         disp(['TCA UNcorrected mean visual acuity score 20/ ' n2s(m0)])
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'r0', 'r1'); end         
% end
% 
% sca


% %% Version 200930
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
% cls 
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% c0=0.00384; %deg/pixels
% %display =10 degrees
% %FOV=5degrees
% 
% 
% %BVAMS_gui; %run input gui
% ey='Stereo'; %eye Right Left Binocular
% ex='LCA'; %Experiment type TCA LCA CRM chromostereopsis
% ACL=1; %ACL attached=1 otherwise=0
% sn=10004; %subject number
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune 
% rc00=[0 0; 0 0]; %change screen offset
% 
% %% LCA params
% %original parameters
% %      power_disp = 1000/75 +1/ +     power=12.5;
% %      mag = 0.8?  y jk\;/0.0  
% %      rot = 0.0;
% 
% 
% % p0(1)=1000/75 +1/.789;%power_disp
% % % p0(1)=14.700760;
% % p0(2)=12.5; % power
% % p0(3)=0.8; %mag
% % p0(4)=-3; %rot
% % p0(5)=0; % s
% 
% % p0(1,1)=1000/75 +1/.789; p0(1,2)= 1000/75 +1/.789; %powerdispL/R
% % p0(2,1)=0.826;           p0(2,2)= 0.8; %magL/R
% % p0(3,1)=-3;  %rotation
% % p0(4,1)=0
% 
% power_dispL=1000/75 +1/.789; power_dispR= 1000/75 +1/.789; %powerdispL/R
% magL=1;                  magR=1; %magL/R
% rot=-3;  %rotation
% 
% % [power_dispL power_dispR; magL magR= 0.8; rot rot]  %rotation
% 
% 
% %p0(4,1)=0
% 
% % power_dispL=p0(1,1); power_dispR=p0(1,2);
% % magR=p0(2,1);        magR=p0(2,2);
% % rot=p0(3,1);
% 
% 
% %LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
% % LCAim='texture1_nrm_br.png'; %te  ] s   ted   mart   y on day 1
% % 
% % a q= instrfiqnd();
% % fclose(a);31`
% % delete(a)
% % clear 0a
% 
% %  LCAim='lprd0'; %1 
% %  LCAim='lprd_blk1';%2
% %  LCAim='lprd_blk2'; %3
% %  LCAim='lprd_blk3' %4
% %  LCAim='lprd_blk5' %5
% %  LCAim='lprd_blk6' %6
% %  LCAim='lprd_blk7' %7
% %  LCAim='lprd_blk10' %8
% 
% %  LCAim='pst0' %9
% %  LCAim='pst1' %10
% %  LCAim='rce0' %11
% %  LCAim='rce1' %12
% %  LCAim='thrd0' %13
% %  LCAim='thrd1' %14
% 
% %  LCAim='texture0_inv_bgr.png'; %15 black background, with blue red texture on top, green-black maltese cross in between
% %  LCAim='texture0_inv_br.png';  %16 black background, with blue red texture on top, blue-red maltese cross
% %  LCAim='texture0_nrm_bgr.png'; %17 blue-red background, with black texture on top,green in middle
% %  LCAim='texture0_nrm_br.png';   %18 blue-red background, with black texture on top
% 
% % LCAim='texture1_inv_bgr';  %19 black background 
% %  LCAim='texture1_inv_br';  %20 black background
% % LCAim='texture1_nrm_bgr';  %21  blue-red background
% % LCAim='texture1_nrm_br';   %22 blue-red background
% % 
% % LCAim='texture2_inv_rgb'; %23 black background
% % LCAim='texture2_inv_rb';  %24 black background
% % LCAim='texture2_nrm_rgb';  %25 red-blue background
% % LCAim='texture2_nrm_rb';   %26 red-blue background
% % 
% % LCAim='texture3_inv_rgb'; %27 black background
% %  LCAim='texture3_inv_rb';  %28 black background %28
% %  LCAim='vrn_thick.png';
% %   LCAim='vrn500ud_sd1.png'; %use this normally
% 
%    LCAim='vrn10_RB_sd1.png';
% %  LCAim='vrn100ud_sd1.png';
% 
% %    LCAim='white.png';
% %    LCAim='big-white-circle.png';
% %    LCAim='vrn10_RGB_sd1.png';
% %   LCAim='black.0png';
% %   LCAim='E13.png'
% 
% % LCAim='texture3_nrm_rgb'; %29 red-blue background
% % LCAim='texture3_nrm_rb';  % 30 red-blue background
% % 
% % LCAim='strs_crc21_sd1';
% % LCAim='colored-dots-background-stock-illustration-2228056.jpg';
% % img=imread('G:\My Drive\exp_bvams\code_repo\imgs\colored-dots-background-stock-illustration-2228056','jpg');
% % imwrite(img,'G:\My Drive\exp_bvams\code_repo\imgs\dots.png');
% %  LCAim='dots.png';
% %% TCA params
% ms=10;
% % rd=540; % red diameter 
% % kd=120; % black diameter
% % bd=108; % blue diameter
% % lineWidthPix = 4; %bar width
% rgb=[3 1]; %TCA [inner-small-circle background-outer-circle] colors 1red 2green 3blue
% xy0=200; %inital position of small circle
% pixelsPerPress = [5 0.1];
% %TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
% TCAfnm='c130_b145to540_w10_ms10_sd1_6';
% 
% %% ETM params
% %bxy=[-10.3 10.7; 10.5 -11]
% d1=5; %trials to drop
% n0=4; % number of experiments/repetitions
% n1=30;% number of trials
% w0=12;% initial size of the optotype, stroke size= 2^w
% %sd=0; %blur kernel
% %rgd=[ ]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
% sz = [1080, 1920]; % size of screen
% d0=2; %length of optotype presentation in secs
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% % cf=[RB./RR LB./LR; 1 1; 1 1];
% %cf=ones(3,2);
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% % cf=ones(3,2);
% % load('E_b2_m2_p10_o4_ms10.mat'); %LOAD BEFORE STARTING, E optotype base 2
% 
% if exist('E10c')==0 | isempty(E10c)==1; load('E_b2_m2_p10_o4_ms10.mat'); end %E optotype base 2
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% switch ex
%     
%     case 'LCA'
% %             [mag, power, power_disp, wn]=LCA2f(LCAim, ey, window1, window2);%closes optotunes in the end
%              %[mag, power, power_disp, wn]=LCA3f(LCAim, ey, window1, window2);%keeps the last setting of optotunes
%              cls_opt
%              %[mag, power, power_disp, wn]=LCA4f(LCAim, p0, ey, window1, window2);%keeps the last setting of optotunes
%               [p1, opto, port, name_map, wn]=LCA6f(LCAim, [power_dispL power_dispR; magL magR; rot rot], ey, window1, window2)
%                power_dispL=p1(1,1); power_dispR=p1(1,2);
%                powerL=p1(2,1); powerR=p1(2,2);
% %                magL=p1(3,1); magR=p1(3,2);
% %                rot=p1(4,1);
%                rot=p1(3,1);
% 
%                p11=p1; p00=p11;
% %                p1=[power_dispL power_dispR; powerL powerR; rot rot];
% 
% %         LCA_val=6.5574./exp(0.237*power);
% %           LCA_valL=0.019*powerL^2-0.5379*powerL+4.1326;
%          LCA_valL=0.02.*powerL^2-0.6001.*powerL+4.8451;
%           
%          LCA_valR=0.0242*powerR^2-0.6966*powerR+5.3467;
% 
%         %if sv==1; save(['data\S' num2str(sn) '_LCA_' wn '_' tme], 'mag', 'power', 'power_disp' ,'LCA_val'); end
%           if sv==1; save(['data\S' num2str(sn) '_LCA_' wn '_' tme], 'powerL', 'power_dispL' ,'LCA_valL', 'powerR', 'power_dispR' ,'LCA_valR', 'rot'); end                         
% 
%         %y=6.5574.*exp(0.237.*mag)
%         %KbWait; %% wait for keystroke
%         
%     case 'TCA'
% %         switch ey
% %             case 'Right'
% %                 window=window1; cf=cf(1); wn='R';
% %             case 'Left'
% %                 window=window2; cf=cf(2); wn='L';
% %         end
% %         bxy=TCA1f(rd, kd, bd, lineWidthPix, pixelsPerPress, window);
%         %bxy=TCA2f(TCAfnm, [ms, rd, kd, lineWidthPix], pixelsPerPress, ey, window1, window2);
%         %[bxy wn]=TCA3f(TCAfnm, xy0, rgb, ms, pixelsPerPress, ey ,window1, window2);
%              bxy=TCA4f(TCAfnm, xy0, rgb, ms, pixelsPerPress, window1, window2);
% 
%         %bxy=TCA2f([rd, kd, bd], lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);
%         %bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);        
%         if sv==1; save(['data\S' num2str(sn) '_TCA' '_' tme], 'bxy'); end
%         %bxy=[0 0; bxy; bxy];
%         
%     case 'ETM'
%         cf=ones(3,2);
%          %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype 
%          [y0 y1 w2]=ETM9f([n0 n1 w0 d0], bxy, E10c, STK, window1, window2); 
%         [r0 r1]=psf(y0, y1, w2, d1, STK);
%         c1=1./(c0.*60);
%         m0=mean(r0)./c1; m1=mean(r1)./c1;
%         disp(['TCA corrected mean visual acuity score 20/ ' n2s(m1)])
%         disp(['TCA UNcorrected mean visual acuity score 20/ ' n2s(m0)])
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'r0', 'r1'); end         
% end
% 
% sca
% disp(rslt);


%% Version 200926
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
% cls 
% %108 pix/degree
% %display =10 de   qgrees
% %FOV=5degrees
% 
% 
% BVAMS_gui; %run input gui
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune 
% rc00=[0 0; 0 0]; %change screen offset
% 
% %% LCA params
% %original parameters
% %      power_disp = 1000/75 +1/.789;%setting for calibration with offset lens %distance=38.3+40.6=78.9cm as we insreased the distance of display further by putting 40.6 cm cage rods
% %      power=12.5;
% %      mag = 0.8;
% %      rot = 0.0;
% 
% p0(1)=1000/75 +1/.789;  %power_disp
% p0(2)=12.5; % power
% p0(3)=0.8; %mag
% p0(4)=0; %rot
% p0(5)=0; % set to 1 to close optotune at the end of LCA experiment, otherwise 0.
% 
% %LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
% % LCAim='texture1_nrm_br.png'; %te  ] s   ted   mart   y on day 1
% % 
% % a q= instrfind();
% % fclose(a);31`
% % delete(a)
% % clear a
% 
% %  LCAim='lprd0'; %1 
% %  LCAim='lprd_blk1';%2
% %  LCAim='lprd_blk2'; %3
% %  LCAim='lprd_blk3' %4
% %  LCAim='lprd_blk5' %5
% %  LCAim='lprd_blk6' %6
% %  LCAim='lprd_blk7' %7
% %  LCAim='lprd_blk10' %8
% 
% %  LCAim='pst0' %9
% %  LCAim='pst1' %10
% %  LCAim='rce0' %11
% %  LCAim='rce1' %12
% %  LCAim='thrd0' %13
% %  LCAim='thrd1' %14
% 
% %  LCAim='texture0_inv_bgr.png'; %15 black background, with blue red texture on top, green-black maltese cross in between
% %  LCAim='texture0_inv_br.png';  %16 black background, with blue red texture on top, blue-red maltese cross
% %  LCAim='texture0_nrm_bgr.png'; %17 blue-red background, with black texture on top,green in middle
% %  LCAim='texture0_nrm_br.png';   %18 blue-red background, with black texture on top
% 
% % LCAim='texture1_inv_bgr';  %19 black background 
% %  LCAim='texture1_inv_br';  %20 black background
% % LCAim='texture1_nrm_bgr';  %21  blue-red background
% % LCAim='texture1_nrm_br';   %22 blue-red background
% % 
% % LCAim='texture2_inv_rgb'; %23 black background
% % LCAim='texture2_inv_rb';  %24 black background
% % LCAim='texture2_nrm_rgb';  %25 red-blue background
% % LCAim='texture2_nrm_rb';   %26 red-blue background
% % 
% % LCAim='texture3_inv_rgb'; %27 black background
% %  LCAim='texture3_inv_rb';  %28 black background %28
% %  LCAim='vrn_thick1.png';
% %                            LCAim='vrn500ud_sd1.png'; %use this normally
%                            LCAim='black.png';
% %   LCAim='E13.png';
% % LCAim='texture3_nrm_rgb'; %29 red-blue background
% % LCAim='texture3_nrm_rb';  % 30 red-blue background
% % 
% % LCAim='strs_crc21_sd1';
% % LCAim='colored-dots-background-stock-illustration-2228056.jpg';
% 
% %% TCA params
% ms=10;
% % rd=540; % red diameter 
% % kd=120; % black diameter
% % bd=108; % blue diameter
% % lineWidthPix = 4; %bar width
% rgb=[3 1]; %TCA [front background] colors 1red 2green 3blue
% xy0=200; %inital position of small circle
% pixelsPerPress = [5 0.1];
% TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
% 
% %% ETM params
% drp=5;
% n=60;% number of trials
% sz = [1080, 1920]; % size of screen
% dly=2; %length of optotype presentation in secs
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% % cf=[RB./RR LB./LR; 1 1; 1 1];
% %cf=ones(3,2);
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% % load('E_b2_m2_p10_o4_ms10.mat'); %LOAD BEFORE STARTING, E optotype base 2
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% switch ex
%     
%     case 'LCA'
% %             [mag, power, power_disp, wn]=LCA2f(LCAim, ey, window1, window2);%closes optotunes in the end
%              %[mag, power, power_disp, wn]=LCA3f(LCAim, ey, window1, window2);%keeps the last setting of optotunes
%              [mag, power, power_disp, wn]=LCA4f(LCAim, p0, ey, window1, window2);%keeps the last setting of optotunes
% 
% %         LCA_val=6.5574./exp(0.237*power);
%           LCA_val=0.019*power^2-0.5379*power+4.1326;
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' wn '_' tme], 'mag', 'power', 'power_disp' ,'LCA_val'); end                         
%         %y=6.5574.*exp(0.237.*mag)
%         %KbWait; %% wait for keystroke
%         
%     case 'TCA'
% %         switch ey
% %             case 'Right'
% %                 window=window1; cf=cf(1); wn='R';
% %             case 'Left'
% %                 window=window2; cf=cf(2); wn='L';
% %         end
% %         bxy=TCA1f(rd, kd, bd, lineWidthPix, pixelsPerPress, window);
%         %bxy=TCA2f(TCAfnm, [ms, rd, kd, lineWidthPix], pixelsPerPress, ey, window1, window2);
%         bxy=TCA3f(TCAfnm, xy0, rgb, ms, pixelsPerPress, ey ,window1, window2);
%         %bxy=TCA2f([rd, kd, bd], lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);
%         %bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);        
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' wn '_' tme], 'bxy'); end
%         
%     case 'Tumbling E'
%         cf=ones(3,2);
%         [rv wv wn]=ETM6f(n, bxy, dly, ey, window1, window2);
%          [rslt cnfd]=psft(wv, rv, drp);
%          disp(rslt);
%         %[rv wv wn]=ETM4f(n, -bxy, dly, ey, window1, window2);
%         %[rv wv wn]=ETM3f(w, b, n, sz, dly, L, ey, window1, window2);
%       %[rv wv wn]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2)
%         %[mm wf]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2);
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' wn '_' tme], 'rv', 'wv'); end        
% end
% 
% sca
% % disp(rslt);


%% Version 200908
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
% cls 
% %108 pix/degree
% %display =10 de   qgrees
% %FOV=5degrees
% 
% 
% BVAMS_gui; %run input gui
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune 
% rc00=[0 0; 0 0]; %change screen offset       
% %LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
% % LCAim='texture1_nrm_br.png'; %te  ] s   ted   mart   y on day 1
% % 
% % a q= instrfind();
% % fclose(a);31`
% % delete(a)
% % clear a
% 
% %  LCAim='lprd0'; %1 
% %  LCAim='lprd_blk1';%2
% %  LCAim='lprd_blk2'; %3
% %  LCAim='lprd_blk3' %4
% %  LCAim='lprd_blk5' %5
% %  LCAim='lprd_blk6' %6
% %  LCAim='lprd_blk7' %7
% %  LCAim='lprd_blk10' %8
% 
% %  LCAim='pst0' %9
% %  LCAim='pst1' %10
% %  LCAim='rce0' %11
% %  LCAim='rce1' %12
% %  LCAim='thrd0' %13
% %  LCAim='thrd1' %14
% 
% %  LCAim='texture0_inv_bgr.png'; %15 black background, with blue red texture on top, green-black maltese cross in between
% %  LCAim='texture0_inv_br.png';  %16 black background, with blue red texture on top, blue-red maltese cross
% %  LCAim='texture0_nrm_bgr.png'; %17 blue-red background, with black texture on top,green in middle
% %  LCAim='texture0_nrm_br.png';   %18 blue-red background, with black texture on top
% 
% % LCAim='texture1_inv_bgr';  %19 black background 
% %  LCAim='texture1_inv_br';  %20 black background
% % LCAim='texture1_nrm_bgr';  %21  blue-red background
% % LCAim='texture1_nrm_br';   %22 blue-red background
% % 
% % LCAim='texture2_inv_rgb'; %23 black background
% % LCAim='texture2_inv_rb';  %24 black background
% % LCAim='texture2_nrm_rgb';  %25 red-blue background
% % LCAim='texture2_nrm_rb';   %26 red-blue background
% % 
% % LCAim='texture3_inv_rgb'; %27 black background
% %  LCAim='texture3_inv_rb';  %28 black background %28
% %  LCAim='vrn_thick1.png';
% %                            LCAim='vrn500ud_sd1.png'; %use this normally
%                            LCAim='black.png';
% %   LCAim='E13.png';
% % LCAim='texture3_nrm_rgb'; %29 red-blue background
% % LCAim='texture3_nrm_rb';  % 30 red-blue background
% % 
% % LCAim='strs_crc21_sd1';
% % LCAim='colored-dots-background-stock-illustration-2228056.jpg';
% 
% %% TCA params
% ms=10;
% % rd=540; % red diameter 
% % kd=120; % black diameter
% % bd=108; % blue diameter
% % lineWidthPix = 4; %bar width
% rgb=[3 1]; %TCA [front background] colors 1red 2green 3blue
% xy0=200;
% pixelsPerPress = [5 0.1];
% TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
% 
% %% ETM params
% drp=5;
% n=60;% number of trials
% sz = [1080, 1920]; % size of screen
% dly=2; %length of optotype presentation in secs
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% % cf=[RB./RR LB./LR; 1 1; 1 1];
% %cf=ones(3,2);
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% % load('E_b2_m2_p10_o4_ms10.mat'); %LOAD BEFORE STARTING, E optotype base 2
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% switch ex
%     
%     case 'LCA'
% %             [mag, power, power_disp, wn]=LCA2f(LCAim, ey, window1, window2);%closes optotunes in the end
%              [mag, power, power_disp, wn]=LCA3f(LCAim, ey, window1, window2);%keeps the last setting of optotunes
% %         LCA_val=6.5574./exp(0.237*power);
%           LCA_val=0.019*power^2-0.5379*power+4.1326;
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' wn '_' tme], 'mag', 'power', 'power_disp' ,'LCA_val'); end                         
%         %y=6.5574.*exp(0.237.*mag)
%         %KbWait; %% wait for keystroke
%         
%     case 'TCA'
% %         switch ey
% %             case 'Right'
% %                 window=window1; cf=cf(1); wn='R';
% %             case 'Left'
% %                 window=window2; cf=cf(2); wn='L';
% %         end
% %         bxy=TCA1f(rd, kd, bd, lineWidthPix, pixelsPerPress, window);
%         %bxy=TCA2f(TCAfnm, [ms, rd, kd, lineWidthPix], pixelsPerPress, ey, window1, window2);
%         bxy=TCA3f(TCAfnm, xy0, rgb, ms, pixelsPerPress, ey ,window1, window2);
%         %bxy=TCA2f([rd, kd, bd], lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);
%         %bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);        
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' wn '_' tme], 'bxy'); end
%         
%     case 'Tumbling E'
%         cf=ones(3,2);
%         [rv wv wn]=ETM6f(n, bxy, dly, ey, window1, window2);
%          [rslt cnfd]=psft(wv, rv, drp);
%          disp(rslt);
%         %[rv wv wn]=ETM4f(n, -bxy, dly, ey, window1, window2);
%         %[rv wv wn]=ETM3f(w, b, n, sz, dly, L, ey, window1, window2);
%       %[rv wv wn]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2)
%         %[mm wf]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2);
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' wn '_' tme], 'rv', 'wv'); end        
% end
% 
% sca
% % disp(rslt);





% %% Version 200824
% %clear all
% close all
% clc
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% %108 pix/degree
% %display =10 degrees
% %FOV=5degrees
% 
% 
% BVAMS_gui; %run input gui
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune 
%     
% %LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
% % LCAim='texture1_nrm_br.png'; %te  ] s   ted   mart   y on day 1
% % 
% % a q= instrfind();
% % fclose(a);31`
% % delete(a)
% % clear a
% 
% %  LCAim='lprd0'; %1 
% %  LCAim='lprd_blk1';%2
% %  LCAim='lprd_blk2'; %3
% %  LCAim='lprd_blk3' %4
% %  LCAim='lprd_blk5' %5
% %  LCAim='lprd_blk6' %6
% %  LCAim='lprd_blk7' %7
% %  LCAim='lprd_blk10' %8
% 
% %  LCAim='pst0' %9
% %  LCAim='pst1' %10
% %  LCAim='rce0' %11
% %  LCAim='rce1' %12
% %  LCAim='thrd0' %13
% %  LCAim='thrd1' %14
% 
% %  LCAim='texture0_inv_bgr.png'; %15 black background, with blue red texture on top, green-black maltese cross in between
% %  LCAim='texture0_inv_br.png';  %16 black background, with blue red texture on top, blue-red maltese cross
% %  LCAim='texture0_nrm_bgr.png'; %17 blue-red background, with black texture on top,green in middle
% %  LCAim='texture0_nrm_br.png';   %18 blue-red background, with black texture on top
% 
% % LCAim='texture1_inv_bgr';  %19 black background 
% %  LCAim='texture1_inv_br';  %20 black background
% % LCAim='texture1_nrm_bgr';  %21  blue-red background
% % LCAim='texture1_nrm_br';   %22 blue-red background
% % 
% % LCAim='texture2_inv_rgb'; %23 black background
% % LCAim='texture2_inv_rb';  %24 black background
% % LCAim='texture2_nrm_rgb';  %25 red-blue background
% % LCAim='texture2_nrm_rb';   %26 red-blue background
% % 
% % LCAim='texture3_inv_rgb'; %27 black background
% %  LCAim='texture3_inv_rb';  %28 black background %28
% %  LCAim='vrn_thick1.png';
% %  LCAim='vrn500ud_sd1.png';
%   LCAim='E13.png';
% % LCAim='texture3_nrm_rgb'; %29 red-blue background
% % LCAim='texture3_nrm_rb';  % 30 red-blue background
% % 
% % LCAim='strs_crc21_sd1';
% 
% 
% %% TCA params
% ms=10;
% rd=540; % red diameter 
% kd=120; % black diameter
% bd=108; % blue diameter
% lineWidthPix = 4; %bar width
% pixelsPerPress = [5 0.1];
% TCAfnm='r108_c4_10.mat';
% 
% %% ETM params
% n=60;% number of trials
% sz = [1080, 1920]; % size of screen
% dly=2; %length of optotype presentation in secs
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% % cf=[RB./RR LB./LR; 1 1; 1 1];
% cf=ones(3,2);
% %if isempty(Ec)==1; load('E_b2_m16top15.mat'); end %E optotype base 2
% %load('E_b2_m10_p15_ms10.mat');
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% switch ex
%     
%     case 'LCA'
% %             [mag, power, power_disp, wn]=LCA2f(LCAim, ey, window1, window2);%closes optotunes in the end
%              [mag, power, power_disp, wn]=LCA3f(LCAim, ey, window1, window2);%keeps the last setting of optotunes
%         LCA_val=6.5574./exp(0.237*power);
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' wn '_' tme], 'mag', 'power', 'power_disp' ,'LCA_val'); end                         
%         %y=6.5574.*exp(0.237.*mag)
%         %KbWait; %% wait for keystroke
%         
%     case 'TCA'
% %         switch ey
% %             case 'Right'
% %                 window=window1; cf=cf(1); wn='R';
% %             case 'Left'
% %                 window=window2; cf=cf(2); wn='L';
% %         end
% %         bxy=TCA1f(rd, kd, bd, lineWidthPix, pixelsPerPress, window);
%         bxy=TCA2f(TCAfnm, [ms, rd, kd, lineWidthPix], pixelsPerPress, ey, window1, window2);
% 
%         %bxy=TCA2f([rd, kd, bd], lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);
%         %bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);        
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' wn '_' tme], 'bxy'); end
%         
%     case 'Tumbling E'
%        
%          [rv wv wn]=ETM5f(n, bxy, dly, ey, window1, window2);
%         %[rv wv wn]=ETM4f(n, -bxy, dly, ey, window1, window2);
%         %[rv wv wn]=ETM3f(w, b, n, sz, dly, L, ey, window1, window2);
%       %[rv wv wn]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2)
%         %[mm wf]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2);
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' wn '_' tme], 'rv', 'wv'); end        
% end
% 
% sca



% %% Version 200817
% %clear all
% close all
% clc
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% %108 pix/degree
% %display =10 degrees
% %FOV=5degrees
% 
% 
% BVAMS_gui; %run input gui
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune 
%     
% %LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
% % LCAim='texture1_nrm_br.png'; %tested marty on day 1
% % 
% % a = instrfind();
% % fclose(a);
% % delete(a)
% % clear a
% 
% %  LCAim='lprd0'; %1 
% %  LCAim='lprd_blk1';%2
% %  LCAim='lprd_blk2'; %3
% %  LCAim='lprd_blk3' %4
% %  LCAim='lprd_blk5' %5
% %  LCAim='lprd_blk6' %6
%  LCAim='lprd_blk7' %7
% %  LCAim='lprd_blk10' %8
% 
% %  LCAim='pst0' %9
% %  LCAim='pst1' %10
% %  LCAim='rce0' %11
% %  LCAim='rce1' %12
% %  LCAim='thrd0' %13
% %  LCAim='thrd1' %14
% 
% %  LCAim='texture0_inv_bgr.png'; %15 black background, with blue red texture on top, green-black maltese cross in between
% %  LCAim='texture0_inv_br.png';  %16 black background, with blue red texture on top, blue-red maltese cross
% %  LCAim='texture0_nrm_bgr.png'; %17 blue-red background, with black texture on top,green in middle
% %  LCAim='texture0_nrm_br.png';   %18 blue-red background, with black texture on top
% 
% % LCAim='texture1_inv_bgr';  %19 black background 
% % LCAim='texture1_inv_br';  %20 black background
% % LCAim='texture1_nrm_bgr';  %21  blue-red background
% % LCAim='texture1_nrm_br';   %22 blue-red background
% % 
% % LCAim='texture2_inv_rgb'; %23 black background
% % LCAim='texture2_inv_rb';  %24 black background
% % LCAim='texture2_nrm_rgb';  %25 red-blue background
% % LCAim='texture2_nrm_rb';   %26 red-blue background
% % 
% % LCAim='texture3_inv_rgb'; %27 black background
% %  LCAim='texture3_inv_rb';  %28 black background %28
% % LCAim='texture3_nrm_rgb'; %29 red-blue background
% % LCAim='texture3_nrm_rb';  % 30 red-blue background
% % 
% 
% 
% %% TCA params
% rd=540; % red diameter 
% kd=120; % black diameter
% bd=108; % blue diameter
% lineWidthPix = 4; %bar width
% pixelsPerPress = [2 0.05];
% 
% %% ETM params
% n=60;% number of trials
% sz = [1080, 1920]; % size of screen
% dly=0.5; %length of optotype presentation in secs
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; cf=[RB./RR LB./LR];
% if isempty(Ec)==1; load('E_b2_m16top15.mat'); end %E optotype base 2
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% switch ex
%     
%     case 'LCA'
% %             [mag, power, power_disp, wn]=LCA2f(LCAim, ey, window1, window2);%closes optotunes in the end
%              [mag, power, power_disp, wn]=LCA3f(LCAim, ey, window1, window2);%keeps the last setting of optotunes
%         LCA_val=6.5574./exp(0.237*power);
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' wn '_' tme], 'mag', 'power', 'LCA_val'); end                         
%         %y=6.5574.*exp(0.237.*mag)
%         %KbWait; %% wait for keystroke
%         
%     case 'TCA'
%         switch ey
%             case 'Right'
%                 window=window1; cf=cf(1); wn='R';
%             case 'Left'
%                 window=window2; cf=cf(2); wn='L';
%         end
%         bxy=TCA1f(rd, kd, bd, lineWidthPix, pixelsPerPress, window);
%         %bxy=TCA2f([rd, kd, bd], lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);
%         %bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);        
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' wn '_' tme], 'bxy'); end
%         
%     case 'Tumbling E'
%         [rv wv wn]=ETM4f(n, -bxy, dly, ey, window1, window2);
%         %[rv wv wn]=ETM3f(w, b, n, sz, dly, L, ey, window1, window2);
%         %[rv wv wn]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2)
%         %[mm wf]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2);
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' wn '_' tme], 'rv', 'wv'); end        
% end
% 
% sca


%% version 200810 %%%%%%%%
% close all
% clc
% 
% global ek uk dk lk rk st sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']);
% %108 pix/degree
% %display =10 degrees
% %FOV=5degrees
% 
% 
% BVAMS_gui; %run input gui
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune 
%     
%     
% L='E';
% Esz=22; %% size of E
% %LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
% LCAim='lprd1.png';
% % 'texture1_nrm_br.png'
% %% TCA params
% rd=540; % red diameter 
% kd=116; % black diameter
% bd=108; % blue diameter
% lineWidthPix = 4; %bar width
% pixelsPerPress = [0.5 5];
% 
% %% ETM params
% L='E';
% w=10; % width of E line set for 540 pixels E width which corresponds to 5 visual degrees in the system
% ws=1; %width displacement steps  
% n=10;% memory length
% sc=0.5 % stop criterion
% sz = [1080, 1920]; % size of screen
% dly=1;
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val
% [window1, window2]=strt_psych(screenNumber-1, screenNumber);
% switch ey
%     case 'Right';
%         window=window1;
%         wn='R'; cf=RB./RR;
%     case 'Left';
%         window=window2;
%         wn='L'; cf=LB./LR;
%     case 'Random';
%         if rand<0.5; window=window1; wn='R'; cf=RB./RR;
%         else; window=window2; wn='L'; cf=LB./LR;
%         end
% end
% 
% switch ex
%     
%     case 'LCA'
%         
%         [mag, power]=LCAf(Esz, LCAim, window, L);
%         LCA_val=6.5574./exp(0.237*power);
%         if sv==1; save(['S' num2str(sn) '_LCA_' wn '_' tme], 'mag', 'power', 'LCA_val'); end
%         %y=6.5574.*exp(0.237.*mag)
%         %KbWait; %% wait for keystroke
%         
%     case 'TCA'
%         
%         bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);
%         
%         if sv==1; save(['S' num2str(sn) '_TCA_' wn '_' tme], 'bxy'); end
%         
%     case 'Tumbling E'
%         
%         [mm wf]=ETMf(w, ws, n, sc, sz, dly, window1, window2, L);
%         if sv == 1; save(['S' num2str(sn) '_ETM_' tme], 'mm', 'wf'); end        
% end
% 
% sca



% %% version 200810
% close all
% clc
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% %108 pix/degree
% %display =10 degrees
% %FOV=5degrees
% 
% 
% BVAMS_gui; %run input gui
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zaber/optotune 
%     
%     
% L='E';
% Esz=22; %% size of E
% %LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
% % LCAim='texture1_nrm_br.png'; %tested marty on day 1
% % 
% % a = instrfind();
% % fclose(a);
% % delete(a)
% % clear a
% 
% %1 LCAim='lprd0'; 
% %2 LCAim='lprd_blk1';
% %  LCAim='lprd_blk2'; %3
% %  LCAim='lprd_blk3'
% 
% % LCAim='texture0_inv_bgr.png'; %black background, with blue red texture on top, green-black maltese crossq in between
% %  LCAim='texture0_inv_br.png';  %black background, with blue red texture on top, blue-red maltese cross
% %7  LCAim='texture0_nrm_bgr.png';%blue-red background, with black texture on top,green in middle
% % 8 LCAim='texture0_nrm_br.png';   %blue-red background, with black texture on top
% 
% %9 LCAim='texture1_inv_bgr';  %black background 
% %10  LCAim='texture1_inv_br';  %black background
% %11 LCAim='texture1_nrm_bgr';  %blue-red background
% %12 LCAim='texture1_nrm_br';   %blue-red background
% % 
% %13 LCAim='texture2_inv_rgb'; %black background
% %14 LCAim='texture2_inv_rb';  %black background
% %15 LCAim='texture2_nrm_rgb';  %red-blue background
% %  LCAim='texture2_nrm_rb';   %red-blue background %16 
% % 
% %17 LCAim='texture3_inv_rgb'; %black background
%  LCAim='texture3_inv_rb';  %black background
% %19 LCAim='texture3_nrm_rgb'; %red-blue background
% %20 LCAim='texture3_nrm_rb';  %red-blue background
% % 
% 
% 
% %% TCA params
% rd=540; % red diameter 
% kd=120; % black diameter
% bd=108; % blue diameter
% lineWidthPix = 4; %bar width
% pixelsPerPress = [2 0.05];
% 
% %% ETM params
% L='E';
% w=10; % width of E line set for 540 pixels E width which corresponds to 5 visual degrees in the system
% ws=1; %width displacement steps  
% n=60;% number of trials/showings
% sc=0.5 % stop criterion
% sz = [1080, 1920]; % size of screen
% dly=0.5;
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; cf=[RB./RR LB./LR];
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% switch ex
%     
%     case 'LCA'
% %             [mag, power, power_disp, wn]=LCA2f(LCAim, ey, window1, window2);%closes optotunes in the end
%              [mag, power, power_disp, wn]=LCA3f(LCAim, ey, window1, window2);%keeps the last setting of optotunes
% 
%         LCA_val=6.5574./exp(0.237*power);
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' wn '_' tme], 'mag', 'power', 'power_disp', 'LCA_val'); end                         
%         %y=6.5574.*exp(0.237.*mag)
%         %KbWait; %% wait for keystroke
%         
%     case 'TCA'
%         switch ey
%             case 'Right'
%                 window=window1; cf=cf(1); wn='R';
%             case 'Left'
%                 window=window2; cf=cf(2); wn='L';
%         end
%         bxy=TCA1f(rd, kd, bd, lineWidthPix, pixelsPerPress, window);
%         %bxy=TCA2f([rd, kd, bd], lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);
%         %bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);        
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' wn '_' tme], 'bxy'); end
%         
%     case 'Tumbling E'
%      [rv wv wn]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2)
%         %[mm wf]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2);
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' wn '_' tme], 'rv', 'wv'); end        
% end
% 
% sca