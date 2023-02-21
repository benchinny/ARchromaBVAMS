  %%210510 Based on JJVC_scrpt_bt
%clr
global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']);
cls 
 % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
c0=0.00384; %deg/pixels
%display =10 degrees
%FOV= 5 degrees

%BVAMS_gui; %run input gui
% ey='Right'; %eye Right Left Binocular
ey='Stereo'; %eye Right Left Binocular
% magn=0.8;
magn=1;
ex='CNT'; %Experiment type TCA LCA CRM chromostereopsis CSF CNT)
ACL=0; %ACL attached=1 otherwise=0
sn=10007; %subject  nu mber 10004MB
%subject number 10003AR
% -----------!!UPDATE FOR ETM!!!!-----------
% -----------!!UPDATE FOR ETM!!!!-
% !!!!!!!!!!!!!!LOAD NEW TCA FILES WHEN ACL is 1!!!!!!!!!!!!! 
% load('S10003_TCA_RightACL1_2104021427.mat'); z1R=z1;
% load('S10003_TCA_LeftACL1_2104021512.mat'); z1L=z1;


load('S10003_TCA_RightACL0_2103261502.mat'); z1R=z1;
load('S10003_TCA_LeftACL0_2103261614.mat'); z1L=z1;
% 
% load('S10003_TCA_RightACL0_2103261502.mat'); z1R=z1;
% load('S10003_TCA_LeftACL0_2103261614.mat'); z1L=z1;

% These files already have z1 values saved. Need to extract the correct part of z1 values from each of above 2 files, and create a new z1 matrix which can be used in a binocular task.
z1(:, 3:4)=z1R(:, 3:4);

%SYSTEM TCA!! %LOAD LCA files when ACL=0, depends on trombone powers!
load('S10003_LCA_RightACL0_2103261450.mat', 'a18'); a18R=a18; %RIGHT LCA 
load('S10003_LCA_LeftACL0_2103261603.mat', 'a18');  a18L=a18; %LEFT LCA



a18(:,2)=a18R(:,2);

findz0;
% -----------!!UPDATE FOR ETM!!!!-
%Tsystem TCA measurements sn=789
%sn=77 for test
%sn=122 chnaged tro mbone pwr to 12.2
%sn=131 chnaged trombone pwr to 13.1 using set_opt_MB_CSF
if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
zbr=1; %activate zebar/optotune
% rc00=[0 0; 0 0]; %
 rc00=[3 -8; 4 -7];
 
 
 
 
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LCA params
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p0=zeros(8,2);
% %if set power_disp/optopower=0 randomize.
% p0(1,:)=[9                    9];               %power_dispL_min      power_dispR_min
% %p0=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR
% p0(2,:)=[0             0];               %initial power_dispL          power_dispR
% p0(3,:)=[17                 17];              %power_dispL_max      power_dispL_max
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min
% %p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)
% %making trombone go to a specific lowest magnification
% p0(5,:)=[opL(magn)             opR(magn)];               %L_optopower(mag)     R_optopower(mag)
% p0(6,:)=[opL(1.3)             opR(1.3)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation
% p0(8,:)=4; %number of repetitions
% LCAim='subpixel-e1403202931818.png';

% LCAim{1}='bh1.png';
% LCAim{2}='bh1.png';
% LCAim{3}='bh1.png';
% LCAim{1}='vrn10_R_sd1.png';
% LCAim{2}='vrn10_G_sd1.png';
% LCAim{3}='vrn10_B_sd1.png';
% LCAim='vrn10_RG_sd1.png';
% LCAim='vrn10_GB_sd1.png';
% LCAim='vrn500ud_sd1.png';
% LCAim='vrn100ud_sd1.png';

% LCAim{1}='bh2.png';
% LCAim{3}='dots.png';
% LCAim{2}='big-white-circle.png';
%  LCAim{1}='text2.png';
%  LCAim{2}='text2.png';
%  LCAim{3}='text2.png';
% LCAim{1}='TCA_0_0.png';
% LCAim{2}='TCA_0_0.png';
% LCAim{3}='TCA_0_0.png';
%% present RGB squares
% LCAim{1}='SQRS_108.png';
% LCAim{2}='SQRS_54.png';
% LCAim{3}='SQRS_27.png';
% LCAim{4}='SQRS_12.png';
% LCAim{5}='SQRS_6.png';






%CHROMOSTREOPSIS parameters
p5(1)=0.5; %dly stimuli presntation times/delays: maltese, black, bars
p5(2)=16; %s step size
p5(3)=17; % wh half width of blue&red bars
p5(4)=5; %wv gap half width between blue & red bars
p5(5)=260; %wl length of bar
p5(6)=43; %rd= round(p0(6).*rand(1)); %rd== round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
p5(7)=40; %ni number of trials
%% create green rectangle
p5(8)=250; %v
p5(9)=250; %h
p5(10)=10; % wr half vertical, horizontal, width of rectangle
%% extract visual lines
p5(11)=50; % vl half of visual patch/line length
p5(12)=2; %color on topr and bottom 0=[R; B], 1=[B; R]; 2=rnd

%% CSF parameters

%a1=2; %color to shift 1RED-GREEN 2RED-BLUE
a0=40 ; %number of trials
a2=2*73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
a3=100; %gaussian  sigma
a4=1.6; %contrast step size
a5=10; %angle of image   tilt
%      a6=[-12 0 12];
% a6=-6:2:6; %[-6:2:6]; % s2=-6:2:6; %ffTCA shift of green plane f
a6=[-1 0 1]; %-6:2:6; %[-6:2:6]; % s2=-6:2:6; %ffTCA shift of green plane f



sz = [1080, 1920]; % size of screen
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[RB./RR LB./LR];
% cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1]
% cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% background LATEST JAN 7


[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);

switch ex
       
    case 'CRM'
        
        [r5 r6 vu vb]=CRM1f(p5, window1, window2);
        %[r5 r6 vu vb]=CRMf1(p5, window1, window2);
        
        %r1=psfc(r5, vu, vb, d0) %psignfit for chromostereopsis
        
        if sv == 1; save(['data\S' num2str(sn) '_CRM_' ey '_ACL' n2s(ACL) '_' tme], 'r5', 'r6', 'vu', 'vb'); end
        
    case 'CSF'
        [a7 a8]=CSF4f(a0, a2, a3, a4, a5, a6, window1, window2);
        if sv==1; save(['data\S' num2str(sn) '_CSF_'  ey '_ACL' n2s(ACL) '_' tme], 'a7', 'a8', 'a6'); end
        %load first data set
        %a80=a8; a70=a7;
        %load 2nd data set
        %a8=[a80 a8]; a7=[a70 a7];
        %         a9=psfs(a7, a8, a6, 0);
        
    case 'CNT'
        clear p0 p1
        p0(1)=60; %0.5; %0.5; %stimuli presentation time
        p0(2) =20; %20; % number of repetitions, remeber the total repetitions are this multiplied by the length of the disparities vector
%        p1= [-4 -3 -2 -1 0 1 2 3 4];
%         p1= [-6 -4 -2 0 2 4 6];%marty
%                   p1= [-6 -4 -2 0 2 4 6];%Austin LCA0
p1=-200;
%              p1=[-2 0 2 4 6 8 10];%Austin's LCA1 4:10
%      0     p1=[-8 -4 -2 0 2 4 8]; %vector of disparities
%           p1=[-10 -8 -6 -4 -2 0 2]; %Nadav CNT3 00vector of disparities
%           p1=[-10 -6 -2 2 6 10]; %Nadav CNT4000
%         p1=[-16 8 16]; %vector of disparities0
% p1=0;
         %looking through the system positive is crossed and negative disparity is uncrossed       
       [y3 y2 y1 y0]=CNT1f(p0, p1, window1, window2);
        %y0 up/down responses
        %y1 disparities 
        %y2   invert responses
        %y3 up1 buttom0 blue/disparity
        %[rslt d0]=psfn(y1, y2);
        
        
        %buttom cases
        %y10=y1(y3==0); y20=y2(y3==0); [rslt d0]=psfn(y10, y20);
        %buttom cases
        %y11=y1(y3==1); y21=y2(y3==1); [rslt d0]=psfn(y11, y21);       
       
        if sv == 1; save(['data\S' num2str(sn) '_CNT_' ey '_ACL' n2s(ACL) '_' tme], 'y1', 'y2', 'y3', 'p0', 'p1'); end
        
         
        
    case 'ETM'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% ETM params
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %bxy=[-10.3 10.7; 10.5 -11]
%         cmb0 %combine Left&Right TCA and LCA for stereo

        d1=5; %trials to drop
        n0=4; % number of experiments/repetitions
        n1=40;% number of trials

        w0=6;% initial size of the optotype, stroke size= 2^w, marty 12
        sz = [1080, 1920]; % size of screen
        d0=0.5; %length of optotype presentation in secs, AR 0.5sec, MB 2 sec
            % Get the screen numbers
        screens = Screen('Screens');
        screenNumber = max(screens);
        load cal_val; %cf=[RB./RR LB./LR]; 
        %NOTE: NEED TO SELECT APPROPRAITE VALUE OF ACL for findz0 to work
        %correctly!
%          input(['\n WAS ACL VALUE UPDATED CORRECTLY?? Currently it is: ' n2s2(ACL)]);
%         findz0; %based on trombone location calculate z0 (system tca)

        if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load

% 'E_b2s5_p2_p14_o4_ms10_210320.mat' acuities: 6 to  32: namely 6.0803    6.9844    8.0230    9.2160   10.5864   12.1606   13.9688 16.0460   18.4320   21.1728   24.3212   27.9377   32.0920
% 'E_b2s2_p1_p11_o4_ms10_210319.mat' acuities:6 to 417
% E_b2s10_p1_p13_o4_ms10_201207.mat buggy
% 'E_b2s6_p2_p14_o4_ms10_210318.mat' 'E_b2s10_p1_p13_o4_ms10_210316.mat'

%         cf=ones(3,2); %white
        cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected/purple background
%         cf=[0 0; 1 1;0 0]; %green background
        %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
        [y0 y1 w2]=ETM11f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
        c0=0.00384; %deg/pixels
        c1=1./(c0.*60);
        w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
        w4=20.*w3./c1; 20.*STK./c1;
        
        %% first step to analyze
%                 c0=0.00384; %deg/pixels
%                 c1=1./(c0.*60);
%                 w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%                 w4=20.*w3./c1; 20.*STK./c1
        %% end of first step
                %strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
%                 strc(y0, w4, [mna(20.*STK./c1) mxa(w4)]); %step 2: show staircase
% 
%                   d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
%                   [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
%                 y0=[0 0 0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
%         
        if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'z0', 'z1', 'ETMfnm0'); end
        %% z1 & z2 are TCA values used (mean & std)
        
end

sca





% %%210510 Based on JJVC_scrpt_bt
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']);
% cls 
%  % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% c0=0.00384; %deg/pixels
% %display =10 degrees
% %FOV= 5 degrees
% 
% %BVAMS_gui; %run input gui
% % ey='Right'; %eye Right Left Binocular
% ey='Stereo'; %eye Right Left Binocular
% % magn=0.8;
% magn=1;
% ex='CNT'; %Experiment type TCA LCA CRM chromostereopsis CSF CNT)
% ACL=1; %ACL attached=1 otherwise=0
% sn=10003; %subject  nu mber 10004MB
% %subject number 10003AR
% % -----------!!UPDATE FOR ETM!!!!-----------
% % -----------!!UPDATE FOR ETM!!!!-
% % !!!!!!!!!!!!!!LOAD NEW TCA FILES WHEN ACL is 1!!!!!!!!!!!!! 
% % load('S10003_TCA_RightACL1_2104021427.mat'); z1R=z1;
% % load('S10003_TCA_LeftACL1_2104021512.mat'); z1L=z1;
% 
% 
% load('S10003_TCA_RightACL0_2103261502.mat'); z1R=z1;
% load('S10003_TCA_LeftACL0_2103261614.mat'); z1L=z1
% % 
% % load('S10003_TCA_RightACL0_2103261502.mat'); z1R=z1;
% % load('S10003_TCA_LeftACL0_2103261614.mat'); z1L=z1;
% 
% % These files already have z1 values saved. Need to extract the correct part of z1 values from each of above 2 files, and create a new z1 matrix which can be used in a binocular task.
% z1(:, 3:4)=z1R(:, 3:4);
% 
% %SYSTEM TCA!! %LOAD LCA files when ACL=0, depends on trombone powers!
% load('S10003_LCA_RightACL0_2103261450.mat', 'a18'); a18R=a18; %RIGHT LCA 
% load('S10003_LCA_LeftACL0_2103261603.mat', 'a18');  a18L=a18; %LEFT LCA
% 
% 
% 
% a18(:,2)=a18R(:,2);
% 
% findz0;
% % -----------!!UPDATE FOR ETM!!!!-
% %Tsystem TCA measurements sn=789
% %sn=77 for test
% %sn=122 chnaged tro mbone pwr to 12.2
% %sn=131 chnaged trombone pwr to 13.1 using set_opt_MB_CSF
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune
% % rc00=[0 0; 0 0]; %
%  rc00=[3 -8; 4 -7];
%  
%  
%  
%  
%  
%  
%  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % LCA params
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % p0=zeros(8,2);
% % %if set power_disp/optopower=0 randomize.
% % p0(1,:)=[9                    9];               %power_dispL_min      power_dispR_min
% % %p0=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR
% % p0(2,:)=[0             0];               %initial power_dispL          power_dispR
% % p0(3,:)=[17                 17];              %power_dispL_max      power_dispL_max
% % p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min
% % %p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)
% % %making trombone go to a specific lowest magnification
% % p0(5,:)=[opL(magn)             opR(magn)];               %L_optopower(mag)     R_optopower(mag)
% % p0(6,:)=[opL(1.3)             opR(1.3)];        %L_optopower(mag)_max R_optopower(mag)_max
% % p0(7,:)=-3; %rotation
% % p0(8,:)=4; %number of repetitions
% % LCAim='subpixel-e1403202931818.png';
% 
% % LCAim{1}='bh1.png';
% % LCAim{2}='bh1.png';
% % LCAim{3}='bh1.png';
% % LCAim{1}='vrn10_R_sd1.png';
% % LCAim{2}='vrn10_G_sd1.png';
% % LCAim{3}='vrn10_B_sd1.png';
% % LCAim='vrn10_RG_sd1.png';
% % LCAim='vrn10_GB_sd1.png';
% % LCAim='vrn500ud_sd1.png';
% % LCAim='vrn100ud_sd1.png';
% 
% % LCAim{1}='bh2.png';
% % LCAim{3}='dots.png';
% % LCAim{2}='big-white-circle.png';
% %  LCAim{1}='text2.png';
% %  LCAim{2}='text2.png';
% %  LCAim{3}='text2.png';
% % LCAim{1}='TCA_0_0.png';
% % LCAim{2}='TCA_0_0.png';
% % LCAim{3}='TCA_0_0.png';
% %% present RGB squares
% % LCAim{1}='SQRS_108.png';
% % LCAim{2}='SQRS_54.png';
% % LCAim{3}='SQRS_27.png';
% % LCAim{4}='SQRS_12.png';
% % LCAim{5}='SQRS_6.png';
% 
% 
% 
% 
% 
% 
% %CHROMOSTREOPSIS parameters
% p5(1)=0.5; %dly stimuli presntation times/delays: maltese, black, bars
% p5(2)=16; %s step size
% p5(3)=17; % wh half width of blue&red bars
% p5(4)=5; %wv gap half width between blue & red bars
% p5(5)=260; %wl length of bar
% p5(6)=43; %rd= round(p0(6).*rand(1)); %rd== round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
% p5(7)=40; %ni number of trials
% %% create green rectangle
% p5(8)=250; %v
% p5(9)=250; %h
% p5(10)=10; % wr half vertical, horizontal, width of rectangle
% %% extract visual lines
% p5(11)=50; % vl half of visual patch/line length
% p5(12)=2; %color on topr and bottom 0=[R; B], 1=[B; R]; 2=rnd
% 
% %% CSF parameters
% 
% a1=2; %color to shift 1RED-GREEN 2RED-BLUE
% a0=40 ; %number of trials
% a2=2*73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
% a3=100; %gaussian  sigma
% a4=1.6; %contrast step size
% a5=10; %angle of image   tilt
% %      a6=[-12 0 12];
% a6=-6:2:6; %[-6:2:6]; % s2=-6:2:6; %ffTCA shift of green plane f
% sz = [1080, 1920]; % size of screen
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% % cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
% % cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1]
% % cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% % background LATEST JAN 7
% 
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% 
% switch ex
%        
%     case 'CRM'
%         
%         [r5 r6 vu vb]=CRM1f(p5, window1, window2);
%         %[r5 r6 vu vb]=CRMf1(p5, window1, window2);
%         
%         %r1=psfc(r5, vu, vb, d0) %psignfit for chromostereopsis
%         
%         if sv == 1; save(['data\S' num2str(sn) '_CRM_' ey '_ACL' n2s(ACL) '_' tme], 'r5', 'r6', 'vu', 'vb'); end
%         
%     case 'CSF'
%         [a7 a8]=CSF3f(a0, a1, a2, a3, a4, a5, a6, window1, window2);
%         if sv==1; save(['data\S' num2str(sn) '_CSF_'  ey '_ACL' n2s(ACL) '_' tme], 'a7', 'a8', 'a6'); end
%         %load first data set
%         %a80=a8; a70=a7;
%         %load 2nd data set
%         %a8=[a80 a8]; a7=[a70 a7];
%         %         a9=psfs(a7, a8, a6, 0);
%         
%     case 'CNT'
%         clear p0 p1
%         p0(1)=0.5; %0.5; %stimuli presentation time
%         p0(2) =20; %20; % number of repetitions, remeber the total repetitions are this multiplied by the length of the disparities vector
% %        p1= [-4 -3 -2 -1 0 1 2 3 4];
% %         p1= [-6 -4 -2 0 2 4 6];
%            p1=[-2 0 2 4 6 8 10];
% %         p1=[-8 -4 -2 0 2 4 8]; %vector of disparities
% %         p1=[-16 8 16]; %vector of disparities
% % p1=0;
%         [y3 y2 y1 y0]=CNT1f(p0, p1, window1, window2);
%         %y0 up/down responses
%         %y1 disparities 
%         %y2   invert responses
%         %y3 up1 buttom0 blue/disparity
%         %[rslt d0]=psfn(y1, y2);
%         
%         
%         %buttom cases
%         %y10=y1(y3==0); y20=y2(y3==0); [rslt d0]=psfn(y10, y20);
%         %buttom cases
%         %y11=y1(y3==1); y21=y2(y3==1); [rslt d0]=psfn(y11, y21);       
%        
%         if sv == 1; save(['data\S' num2str(sn) '_CNT_' ey '_ACL' n2s(ACL) '_' tme], 'y1', 'y2', 'y3'); end
%         
%          
%         
%     case 'ETM'
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %% ETM params
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %bxy=[-10.3 10.7; 10.5 -11]
% %         cmb0 %combine Left&Right TCA and LCA for stereo
% 
%         d1=5; %trials to drop
%         n0=4; % number of experiments/repetitions
%         n1=40;% number of trials
% 
%         w0=6;% initial size of the optotype, stroke size= 2^w, marty 12
%         sz = [1080, 1920]; % size of screen
%         d0=0.5; %length of optotype presentation in secs, AR 0.5sec, MB 2 sec
%             % Get the screen numbers
%         screens = Screen('Screens');
%         screenNumber = max(screens);
%         load cal_val; %cf=[RB./RR LB./LR]; 
%         %NOTE: NEED TO SELECT APPROPRAITE VALUE OF ACL for findz0 to work
%         %correctly!
% %          input(['\n WAS ACL VALUE UPDATED CORRECTLY?? Currently it is: ' n2s2(ACL)]);
% %         findz0; %based on trombone location calculate z0 (system tca)
% 
%         if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load
% 
% % 'E_b2s5_p2_p14_o4_ms10_210320.mat' acuities: 6 to  32: namely 6.0803    6.9844    8.0230    9.2160   10.5864   12.1606   13.9688 16.0460   18.4320   21.1728   24.3212   27.9377   32.0920
% % 'E_b2s2_p1_p11_o4_ms10_210319.mat' acuities:6 to 417
% % E_b2s10_p1_p13_o4_ms10_201207.mat buggy
% % 'E_b2s6_p2_p14_o4_ms10_210318.mat' 'E_b2s10_p1_p13_o4_ms10_210316.mat'
% 
% %         cf=ones(3,2); %white
%         cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected/purple background
% %         cf=[0 0; 1 1;0 0]; %green background
%         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
%         [y0 y1 w2]=ETM11f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
%         c0=0.00384; %deg/pixels
%         c1=1./(c0.*60);
%         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         w4=20.*w3./c1; 20.*STK./c1;
%         
%         %% first step to analyze
% %                 c0=0.00384; %deg/pixels
% %                 c1=1./(c0.*60);
% %                 w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
% %                 w4=20.*w3./c1; 20.*STK./c1
%         %% end of first step
%                 %strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
% %                 strc(y0, w4, [mna(20.*STK./c1) mxa(w4)]); %step 2: show staircase
% % 
% %                   d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
% %                   [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
% %                 y0=[0 0 0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
% %         
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'z0', 'z1', 'ETMfnm0'); end
%         %% z1 & z2 are TCA values used (mean & std)
%         
% end
% 
% sca
% 
% 
