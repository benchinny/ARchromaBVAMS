global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz rc00
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
cls

% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
c0=0.00384; %deg/pixels
%display =10 degrees
%FOV=5degrees

%BVAMS_gui; %run input gui

ey='Stereo'; %eye Right Left Binocular
ex='ETM'; %LCA TCA ETM %Experiment type CRM chromostereopsis
ACL=0; %1 or 0
sn=10007; %subject number
if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
zbr=0; %activate zebar/optotune 
rc00=[0 0; 0 0];

%% LCA params
p0=zeros(8,2);
%if set power_disp/optopower=0 randomize.
p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
p0(2,:)=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR   
p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)     
p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
p0(7,:)=-3; %rotation
p0(8,:)=10; %number of repetitions              

LCAim{1}='vrn10_RB_sd1.png';
LCAim{2}='vrn10_RG_sd1.png';
LCAim{3}='vrn10_GB_sd1.png';
%imwrite(i3, 'imgs\vrn10_B_sd1.png')


% LCAim{1}='SQRS_108.png';
% LCAim{2}='SQRS_54.png';
% LCAim{3}='SQRS_27.png';
% LCAim{4}='SQRS_12.png';
% LCAim{5}='SQRS_6.png';



% % %% TCA params
%  ms=10;
% % rd=540; % red diameter 
% % kd=120; % black diameter
% % bd=108; % blue diameter
% % lineWidthPix = 4; %bar width
% rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
% xy0=10;%200; %initial position of small circle
% ppp = [5 0.2]; %resolution pixelsPerPress
% n2=5; %number of repetitions
% %TCAfnm='c108_b120to540_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
% %TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat';
% TCAfnm='c130_b145to540_w10_ms10_sd1_6';

%% ETM params
%bxy=[-10.3 10.7; 10.5 -11]
d1=5; %number of trials to drop from the begining
n0=3; %number of experiments/repetitions
n1=12;% number of trials
w0=12; %starting optotype size
t0=0.7; %psignfit threshold
%sd=0; %Gaussian filter kernel size
%rgd=[]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
sz = [1080, 1920]; % size of screen
d0=1; %length of optotype presentation in secs
% Get the screen numbers
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[RB./RR LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
%cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected
%cf=[./RR LB./LR; 1 1; 1 1];
%cones(3,2);
%if exist('E10c')==0 | isempty(E10c)==1; load('E_b2_m2_p10_o4_ms10.mat'); end %E optotype base 2

%% CHROMOSTREOPSIS parameters
p5(1)=0.5; %dly stimuli presntation times/delays: maltese, black, bars 
p5(2)=16; %s step size
p5(3)=17; % wh half width of blue&red bars
p5(4)=5; %wv gap half width between blue & red bars
p5(5)=260; %wl length of bar
p5(6)=43; %rd= round(p0(6).*rand(1)); %rd== round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
p5(7)=10; %ni number of trials
%% create green rectangle
p5(8)=250; %v 
p5(9)=250; %h 
p5(10)=10; % wr half vertical, horizontal, width of rectangle 
%% extract visual lines
p5(11)=50; % vl half of visual patch/line length
p5(12)=2; %color on topr and bottom 0=[R; B], 1=[B; R]; 2=rnd

%% CSF parameters

     a1=1; %color to shift 1RED-GREEN 2RED-BLUE
     a0=5; %40 number of trials
     a2=2.*73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
     a3=100; %gaussian  sigma
     a4=1.6; %contrast step size
     a5=10; %angle of image tilt
     a6=[-2:2:2]; % s2=-6:2:6; %ffTCA shift of green plane f 




[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); %add background parameter!

switch ex
    
    case 'LCA'
              p1=LCA8f(LCAim, p0, ey, window1, window2);
             %p1=[power_dispL power_dispR; powerL powerR; magL magR; rot image_displayed];
             
        for k0=1:length(LCAim)
           p2(k0,:)=mean(p1(p1(:,6)==k0,:),1)
            p3(k0,:)=std(p1(p1(:,6)==k0,:), 0, 1) 
        end
             
             
                      if strcmp(ey,'Right') 
            [p3,flag]=set_opt_RightEye(p0(:,2), p2, magn); %gives optotune settings for Right eye only usign defocus adjustments from subject, i.e 2nd column in p0
            %Nadav:add line to save p3 for the subject-> Sub_OptSettings_RightEye_NoAcl_Date
            p4=[p0(:, 1) p3];  %first column for left eye
        elseif strcmp(ey,'Left') 
            [p3,flag]=set_opt_LeftEye(p0(:,1), p2, magn);
            p4=[p3 p0(:,2)]; 
            %Nadav:add line to save p4 for subject--> Sub_OptSettings_LeftEye_NoACL_Date
            %Nadav:load saved p3 for right eye from above
            
            %LEFT SIDE IS GIVING YOU IMAGINERY VALUES
           
        end
        %p5=[p4 p3];
        opt0(p4,flag);

              %LCA_valL=6.5574./exp(0.237*powerL);  LCA_valR=6.5574./exp(0.237*powerR);
        %if sv==1; save(['data\S' num2str(sn) '_LCA_' wn '_' tme], 'magL', 'powerL', 'power_dispL' ,'LCA_valL', 'magR', 'powerR', 'power_dispR' ,'LCA_valR', 'rot'); end                         
        if sv==1; save(['data\S' num2str(sn) '_LCA_' ey '_ACL' n2s(ACL) '_' tme], 'p1', 'LCAim'); end                         

        %         p1=[power_dispL power_dispR; powerL powerR; rot image_displayed];
%n=1; p2=p1(p1(:,6)==n,:); [mean(p2); std(p2)]
%y=6.5574.*exp(0.237.*mag)0
        %KbWait; %% waiat for keystroke
        
    case 'TCA'
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
        xy1=[-1.6 9.7; -21 -3]; %system TCA
        ppp = [5 0.1]; %resolution pixelsPerPress
        n2=2; %number of repetitions
        %TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
        TCAfnm='c130_b145to540_w10_ms10_sd1_6';
        
        
        
        %        cf=[RB./RR LB./LR; 1 1; 1 1];
        clear E10c
        [bxy v0]=TCA7f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);

       %[bxy v0]=TCA6f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
        %bxy=TCA5f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
        if sv==1; save(['data\S' num2str(sn) '_TCA_' ey 'ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0'); end
        %z0=mean(bxy,1); z1=zeros(2, 2); z1(1,:)=z0(1:2); z1(2,:)=z0(3:4); %convert to ETM9f format
        %         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
        %         z1=[0 0 0 0;10 10 0 0;0 0 0 0];
        %          z1=zeros(3,4);
        %rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
        z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
        z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
        
        
        
%         clear E10c
%         [bxy v0]=TCA6f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%         %bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);       
%         %bxy xy coordinates of TCA
%         %rgb [front background; front background]
%         %v0 rgb presentation order/randomization
%         if sv==1; save(['data\S' num2str(sn) '_TCA_'  ey '_ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0'); end
% %         z0=mean(bxy,1); z1=zeros(2, 2); z1(1,:)=z0(1:2); z1(2,:)=z0(3:4); %convert to ETM9f format
%         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
%         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]

    case 'ETM'
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% ETM params
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %bxy=[-10.3 10.7; 10.5 -11]
        d1=5; %trials to drop
        n0=4; % number of experiments/repetitions
        n1=40;% number of trials
        
        % d1=0; %trials to drop
        % % d1=0; %trials to drop
        % n0=4; % number of experiments/repetitions
        % n1=4;% number of trials
        
        % n1=5;% number of trials
        w0=7;% initial size of the optotype, stroke size= 2^w, marty 12
        %t0=0.7; %psignfit threshold
        %sd=0; %blur kernel
        %rgd=[ ]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
        sz = [1080, 1920]; % size of screen
        d0=0.5; %length of optotype presentation in secs, AR 0.5sec, MB 2 sec
        % Get the screen numbers
        screens = Screen('Screens');
        screenNumber = max(screens);
        load cal_val; %cf=[RB./RR LB./LR];
        
        %cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
        cf=ones(3,2);
        %cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
        % cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
        % background LATEST JAN 7
        
        %  cf=ones(3,2);
        % load('E_b2_m2_p10_o4_ms10.mat'); %LOAD BEFORE STARTING, E optotype base 2
        
        %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2_m2_p10_o4_ms10.mat'); end %E optotype base 2
        
        
        
        
        
        z0=[0 0 0 0; -1 4.7 -3 0.3; -2.1 9.5 -6.7 -0.6];
        %if exist('E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat');  end %E optotype base 3 17secs to load
        %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s4_p1_p13_o4_ms10_201130.mat');  end %E optotype base 3 17secs to load
        if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s10_p1_p13_o4_ms10_201207.mat');  end %E optotype base 3 17secs to load
        %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s8_p1_p13_o4_ms10_201207.mat');  end %E optotype base 3 17secs to load
        
        
        %         cf=ones(3,2);
        cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected
        %cf=[0 0; 1 1;0 0]; %green background
        %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
        [y0 y1 w2]=ETM11f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
        c0=0.00384; %deg/pixels
        c1=1./(c0.*60);
        w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
        w4=20.*w3./c1; 20.*STK./c1
        
        %% first step to analyze
        %         c0=0.00384; %deg/pixels
        %         c1=1./(c0.*60);
        %         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
        %         w4=20.*w3./c1; 20.*STK./c1
        %% end of first step
        %         strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
        %         d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
        %         [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
        %         y0=[0 0 0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
        
        if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2'); end
        %% z1 & z2 are TCA values used (mean & std)
        
        
% %        cf=ones(3,2);
%         cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected
% 
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat'); end %E optotype base 3
%         if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s4_p1_p13_o4_ms10_201130.mat');  end %E optotype base 4 17secs to load
% 
%         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype 
%         [y0 y1 w2]=ETM10f([n0 n1 w0 d0], z1, E10c, STK, window1, window2);   
%        %d1=5; clear c c0 c1 r0 r1 r00 r11 w3 rc w4
%         c0=0.00384; %deg/pixels
%         c1=1./(c0.*60);
%         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         w4=20.*w3./c1; 20.*STK./c1
%         
%                 strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]);
%         [r0 r1]=psf(y0, y1, w2, d1, STK);
%         [r00 r11]=psfa(y0, y1, w2, d1, STK);
% %w2=20.*STK(w2)./c1        
% %n=[1 2 3 4]; y3=y1(n,:); w3=w2(n,:); y4=y3(:); w4=w3(:); LCA0_TCA1=hst1(w4', y4',0)
% %n=[1 2 3 4]; y3=y1(n,:); w3=w2(n,:); y4=y3(:); w4=w3(:); LCA1=hst1(w4', y4',0)
% 
% %save('data\AJR201130_RIGHT_GREEN', 'LCA0_TCA0', 'LCA1_TCA0', 'LCA0_TCA1', 'LCA1_TCA1')
% %save('data\AJR201130_RIGHT_GREEN_NO_TCA', 'LCA0', 'LCA1')
% 
% 
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey '_ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'r0, r1'); end        
    case 'CRM'
        
        %% CHROMOSTREOPSIS parameters
p5(1)=0.5; %dly stimuli presntation times/delays: maltese, black, bars 
p5(2)=16; %s step size
p5(3)=17; % wh half width of blue&red bars
p5(4)=5; %wv gap half width between blue & red bars
p5(5)=260; %wl length of bar
p5(6)=43; %rd= round(p0(6).*rand(1)); %rd== round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
p5(7)=10; %ni number of trials
%% create green rectangle
p5(8)=250; %v 
p5(9)=250; %h 
p5(10)=10; % wr half vertical, horizontal, width of rectangle 
%% extract visual lines
p5(11)=50; % vl half of visual patch/line length
p5(12)=2; %color on topr and bottom 0=[R; B], 1=[B; R]; 2=rnd
        
         %[r5 r6]=CRM3f(p5, window1, window2);

         [r5 us]=CRM2f(p5, [-200:100:200], window1, window2);
         %r5 correct respons    es
         %r6 top bottom color: 0=[RED; BLUE] 1=[BLUE RED]
         %top/upper bar positions
         %bottom/lower bar positions
         %if sv == 1; save(['data\S' num2str(sn) '_CRM_' ey '_ACL' n2s(ACL) '_' tme], 'r5', 'r6', 'vu', 'vb'); end        
        if sv == 1; save(['data\S' num2str(sn) '_CRM_' ey '_ACL' n2s(ACL) '_' tme], 'r5', 'r6'); end        

    case 'CSF'
        
%      a1=1; % n4=2; %color to shift 1RED-GREEN 3RED-BLUE
%      a0=5; % ni=40; %n0 number of trials
%      a2=10; %2.*73.6; %f=2*73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
%      a3=100; % s= 100; %gaussian  sigma
%      a4=1.6; % d0=1.6; %contrast step size
%      a5=10; % a0=10; %angle of image tilt
%      % % bxy=[0 0; 37 37; 20 20]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
%      % %bxy=[0 0; 0 0;0 0]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
%      a6=100.*[-2:2:2]; %[-6:2:6]; % s2=-6:2:6; %ffTCA shift of green plane f  
     [a7 a8]=CSF3f(a0, a1, a2, a3, a4, a5, a6, window1, window2);   
     %[r2 c2]=CSF0f(ni, n4, f, s, d0, a0, s2, window1, window2);
     if sv==1; save(['data\S' num2str(sn) '_CSF_'  ey '_ACL' n2s(ACL) '_' tme], 'a7', 'a8', 'a6'); end
     
     %load first data set     
    %a80=a8; a70=a7; 
    %load 2nd data set
    %a8=[a80 a8]; a7=[a70 a7];
    
    
     %a9=psfs(a7, a8, a6, 0); %CSF analysis
     
% surf([0 0.5 1], a6, [a00; a05; a10]')
% xlabel('LCA corrected')
% ylabel('Pixel shift')
% zlabel('Contrast')


    case 'CNT'
        clear p0 p1
        p0(0)=0.5; %stimuli presentation
        p0(1)=10; % number of repetitions
        p1=[-100:100:100]; %vector of disparities
        [y2 y1 y0]=CRM3f(p0, p1, window1, window2); 
        %y0 up/down
        %y1 disparities
        %y2 y2=(y2==0) invert responses
        
        [rslt d0]=psfn(y1, y2)
        %d0
        
        if sv == 1; save(['data\S' num2str(sn) '_CNT_' ey '_ACL' n2s(ACL) '_' tme], 'y1', 'y2'); end
        
        
       
end

sca
%disp(rslt);
% v201222
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
% cls
% 
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% c0=0.00384; %deg/pixels
% %display =10 degrees
% %FOV=5degrees
% 
% %BVAMS_gui; %run input gui
% 
% ey='Stereo'; %eye Right Left Binocular
% ex='TCA'; %LCA TCA ETM %Experiment type CRM chromostereopsis
% ACL=0; %1 or 0
% sn=10007; %subject number
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=0; %activate zebar/optotune 
% rc00=[0 0; 0 0];
% 
% %% LCA params
% p0=zeros(8,2);
% %if set power_disp/optopower=0 randomize.
% p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% p0(2,:)=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR   
% p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)     
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation
% p0(8,:)=10; %number of repetitions              
% 
% LCAim{1}='vrn10_RB_sd1.png';
% LCAim{2}='vrn10_RG_sd1.png';
% LCAim{3}='vrn10_GB_sd1.png';
% %imwrite(i3, 'imgs\vrn10_B_sd1.png')
% 
% 
% % %% TCA params
%  ms=10;
% % rd=540; % red diameter 
% % kd=120; % black diameter
% % bd=108; % blue diameter
% % lineWidthPix = 4; %bar width
% rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
% xy0=10;%200; %initial position of small circle
% ppp = [5 0.2]; %resolution pixelsPerPress
% n2=5; %number of repetitions
% %TCAfnm='c108_b120to540_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
% %TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat';
% TCAfnm='c130_b145to540_w10_ms10_sd1_6';
% 
% %% ETM params
% %bxy=[-10.3 10.7; 10.5 -11]
% d1=5; %number of trials to drop from the begining
% n0=3; %number of experiments/repetitions
% n1=12;% number of trials
% w0=12; %starting optotype size
% t0=0.7; %psignfit threshold
% %sd=0; %Gaussian filter kernel size
% %rgd=[]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
% sz = [1080, 1920]; % size of screen
% d0=1; %length of optotype presentation in secs
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% %cf=[./RR LB./LR; 1 1; 1 1];
% %cones(3,2);
% %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2_m2_p10_o4_ms10.mat'); end %E optotype base 2
% 
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
% p5(12)=2; %color on topr and bottom 0=[R; B], 1=[B; R]; 2=rnd
% 
% 
% 
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); %add background parameter!
% 
% switch ex
%     
%     case 'LCA'
%               p1=LCA8f(LCAim, p0, ey, window1, window2);
%              %p1=[power_dispL power_dispR; powerL powerR; magL magR; rot image_displayed];
%              
%         for k0=1:length(LCAim)
%            p2(k0,:)=mean(p1(p1(:,6)==k0,:),1)
%             p3(k0,:)=std(p1(p1(:,6)==k0,:), 0, 1) 
%         end
%              
%              
%                       if strcmp(ey,'Right') 
%             [p3,flag]=set_opt_RightEye(p0(:,2), p2, magn); %gives optotune settings for Right eye only usign defocus adjustments from subject, i.e 2nd column in p0
%             %Nadav:add line to save p3 for the subject-> Sub_OptSettings_RightEye_NoAcl_Date
%             p4=[p0(:, 1) p3];  %first column for left eye
%         elseif strcmp(ey,'Left') 
%             [p3,flag]=set_opt_LeftEye(p0(:,1), p2, magn);
%             p4=[p3 p0(:,2)]; 
%             %Nadav:add line to save p4 for subject--> Sub_OptSettings_LeftEye_NoACL_Date
%             %Nadav:load saved p3 for right eye from above
%             
%             %LEFT SIDE IS GIVING YOU IMAGINERY VALUES
%            
%         end
%         %p5=[p4 p3];
%         opt0(p4,flag);
% 
%               %LCA_valL=6.5574./exp(0.237*powerL);  LCA_valR=6.5574./exp(0.237*powerR);
%         %if sv==1; save(['data\S' num2str(sn) '_LCA_' wn '_' tme], 'magL', 'powerL', 'power_dispL' ,'LCA_valL', 'magR', 'powerR', 'power_dispR' ,'LCA_valR', 'rot'); end                         
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey '_ACL' n2s(ACL) '_' tme], 'p1', 'LCAim'); end                         
% 
%         %         p1=[power_dispL power_dispR; powerL powerR; rot image_displayed];
% %n=1; p2=p1(p1(:,6)==n,:); [mean(p2); std(p2)]
% %y=6.5574.*exp(0.237.*mag)0
%         %KbWait; %% waiat for keystroke
%         
%     case 'TCA'
%         clear E10c
%         [bxy v0]=TCA6f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%         %bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);       
%         %bxy xy coordinates of TCA
%         %rgb [front background; front background]
%         %v0 rgb presentation order/randomization
%         if sv==1; save(['data\S' num2str(sn) '_TCA_'  ey '_ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0'); end
% %         z0=mean(bxy,1); z1=zeros(2, 2); z1(1,:)=z0(1:2); z1(2,:)=z0(3:4); %convert to ETM9f format
%         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
%         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
% 
%     case 'ETM'
%         cf=ones(3,2);
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat'); end %E optotype base 3
%         if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s4_p1_p13_o4_ms10_201130.mat');  end %E optotype base 4 17secs to load
% 
%         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype 
%         [y0 y1 w2]=ETM10f([n0 n1 w0 d0], z1, E10c, STK, window1, window2);   
%        %d1=5; clear c c0 c1 r0 r1 r00 r11 w3 rc w4
%         c0=0.00384; %deg/pixels
%         c1=1./(c0.*60);
%         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         w4=20.*w3./c1; 20.*STK./c1
%         
%                 strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]);
%         [r0 r1]=psf(y0, y1, w2, d1, STK);
%         [r00 r11]=psfa(y0, y1, w2, d1, STK);
% %w2=20.*STK(w2)./c1        
% %n=[1 2 3 4]; y3=y1(n,:); w3=w2(n,:); y4=y3(:); w4=w3(:); LCA0_TCA1=hst1(w4', y4',0)
% %n=[1 2 3 4]; y3=y1(n,:); w3=w2(n,:); y4=y3(:); w4=w3(:); LCA1=hst1(w4', y4',0)
% 
% %save('data\AJR201130_RIGHT_GREEN', 'LCA0_TCA0', 'LCA1_TCA0', 'LCA0_TCA1', 'LCA1_TCA1')
% %save('data\AJR201130_RIGHT_GREEN_NO_TCA', 'LCA0', 'LCA1')
% 
% 
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey '_ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'r0, r1'); end        
%     case 'CRM'
%         
%          [r5 r6 vu vb]=CRMf1(p5, window1, window2);
%          %r5 correct responses
%          %r6 top bottom color: 0=[RED; BLUE] 1=[BLUE RED]
%          %top/upper bar positions
%          %bottom/lower bar positions
%         if sv == 1; save(['data\S' num2str(sn) '_CRM_' ey '_ACL' n2s(ACL) '_' tme], 'r5', 'r6', 'vu', 'vb'); end        
% 
% end
% 
% sca
% %disp(rslt);

%% version 200928
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
% cls
% %108 pix/degree!!! 108/60=1.8 pixels/minarc, 108/360=0.3 pixels/secarc
% %display =10 degrees
% %FOV=5degrees
% 
% 
% BVAMS_gui; %run input gui
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=0; %activate zebar/optotune 
% rc00=[0 0; 0 0];
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
% % %% TCA params
%  ms=10;
% % rd=540; % red diameter 
% % kd=120; % black diameter
% % bd=108; % blue diameter
% % lineWidthPix = 4; %bar width
% rgb=[3 1]; %TCA [front background] colors 1red 2green 3blue
% xy0=200; %initial position of small circle
% pixelsPerPress = [5 0.1];
% %TCAfnm='c108_b120to540_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
% TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat';
% 
% %% ETM params
% drp=5; %number of trials to drop from the begining
% n=60;% number of trials
% sz = [1080, 1920]; % size of screen
% dly=0.5; %length of optotype presentation in secs
% % Get the screen numbers
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% %cf=[./RR LB./LR; 1 1; 1 1];
% %cf=ones(3,2);
% % load('E_b2_m2_p10_o4_ms10.mat'); %E optotype base 2
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
% 
% switch ex
%     
%     case 'LCA'
% %             [mag, power, power_disp, wn]=LCA2f(LCAim, ey, window1, window2);%closes optotunes in the end
%              %[mag, power, power_disp, wn]=LCA3f(LCAim, ey, window1, window2);%keeps the last setting of optotunes
%              [mag, power, power_disp, wn]=LCA4f(LCAim, p0, ey, window1, window2);%keeps the last setting of optotunes
% 
%              LCA_val=6.5574./exp(0.237*power);
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
%         %bxy=TCA1f(rd, kd, bd, lineWidthPix, pixelsPerPress, window);
%         %y4=TCA2f(fname, rkc, pp, ey ,window1, window2);
%         %bxy=TCA2f(TCAfnm, [ms, rd, kd, lineWidthPix], pixelsPerPress, ey, window1, window2);
%         bxy=TCA3f(TCAfnm, xy0, rgb, ms, pixelsPerPress, ey ,window1, window2);
%         
%         
%         %bxy=TCAf(rd, kd, bd, lineWidthPix, pixelsPerPress, window);        
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' wn '_' tme], 'bxy'); end
%         
%     case 'Tumbling E'
%         cf=ones(3,2);
%         [rv wv wn]=ETM6f(n, bxy, dly, ey, window1, window2);
%          %[rv wv wn]=ETM5f(n, bxy, dly, ey, window1, window2);
%          [rslt cnfd]=psft(wv, rv, drp);
%          disp(rslt);
%         %[rv wv wn]=ETM4f(n, -bxy, dly, ey, window1, window2);
%         %[rv wv wn]=ETM3f(w, b, n, sz, dly, L, ey, window1, window2);
%         %[rv wv wn]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2)
%         %[mm wf]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2);
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' wn '_' tme], 'rv', 'wv'); end        
% end
% 
% sca
% disp(rslt);


%% version 200810
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
