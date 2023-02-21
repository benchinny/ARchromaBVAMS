%% Version 220311
%clr
global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% edit JJVC_stro
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); addpath([pwd '\data\System TCA\Data Processing']);
cls
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
c0=0.00384; %deg/pixels
%display =10 degrees
%FOV= 5 degrees

%BVAMS_gui; %run input gui
ey='Left'; %eye Right Left Binocular
% ey='Left'; %eye Right Left Binocular
% magn=0.8;
magn=1;
ex='ETM'; %Experiment type TCA LCA CRM chromostereopsis CSF
ACL=0; %ACL attached=1 otherwise=0  %!!!NOTE!!! NEED TO SET VALUE OF ACL correctly for findz0 to work correctly!
sn=10003; %subject  nu mber 10004MB
%subject number 10003AR

%sn=77 for te st

if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
zbr=1; %activate zebar/optotune
rc00=[0 0; 0 0]; %moving screen %[right_Y right_X; left_Y Left_X]


sz = [1080, 1920]; % size of screen
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[RB./RR LB./LR];
cf=ones(3,2);
%cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% background LATEST JAN 7

[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);

switch ex
    
    case 'LCA'

        cf=ones(3,2);
        %   power_disp_min  initial_power_disp max_power_disp mag_min mag mag_max rotation reptitions 
        a0=[9               13.5                  17             0.8     1   1.3     -3       6];
          
        LCAim{1}='vrn10_R_sd1.png';
        LCAim{2}='vrn10_G_sd1.png';
        LCAim{3}='vrn10_B_sd1.png';
        
        [a10, a11, a12, a13, a14, a15, a16, a17, a18]=LCA10f(LCAim, a0, ey, window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr
        
         [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(a18(5,1), a18(5,2)); %(LeftTromPwr, RightTromPwr);
         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);     
         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
         
         
        findz0;
        if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0'); end
        save('data\SPTtmp', 'a18', '-append');
        
        input(['\n PLEASE UPDATE PUPIL CENTER IN LABVIEW \n' 'rtX: ' n2s2(PupCtr_RtX) ' rtY: ' n2s2(PupCtr_RtY) ' ltX: ' n2s2(PupCtr_LtX) ' ltY: ' n2s2(PupCtr_LtY)])
    
    case 'TCA'
        cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
        ms=10;
        rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue

        xy0=15; %inital position of small circle
        ppp = [5 0.5] ; %resolution pixelsPerPress
        n2=6; %number of repetitions
%         TCAfnm='c130_b145to540_w10_ms10_sd1_6';
        TCAfnm='c65_b75to540_w10_ms10_sd1_6';
%         TCAfnm='c130_b145to540_r340to350_w10_ms10_sd1_6'; %for big circle

%         input('\n UPDATED LABVIEW PUPIL CENTER?\n');
        clear E10c
        [bxy v0]=TCA9f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2); %line62 in TCA9f to add/remove blue reticle on green

        z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)] %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
        z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
        
        if sv==1; save(['data\S' num2str(sn) '_TCA_' ey 'ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0', 'z1','z2'); end
       
        save('data\SPTtmp', 'z1', 'z2', '-append');

    case 'ETM'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% ETM params
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %bxy=[-10.3 10.7; 10.5 -11]
        d1=5; %trials to drop
        n0=4; % number of experiments/repetitions
        n1=40;% number of trials

        w0=12;% initial size of the optotype, stroke size= 2^w, marty 12
        sz = [1080, 1920]; % size of screen
        d0=50; %length of optotype presentation in secs, AR 0.5sec, MB 2 sec
            % Get the screen numbers
        screens = Screen('Screens');
        screenNumber = max(screens);
        load cal_val; %cf=[RB./RR LB./LR]; 
        %NOTE: NEED TO SELECT APPROPRAITE VALUE OF ACL for findz0 to work
        %correctly!
%          input(['\n WAS ACL VALUE UPDATED CORRECTLY?? Currently it is: ' n2s2(ACL)]);
        findz0; %based on trombone location calculate z0 (system tca)

        if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s5_p2_p14_o4_ms10_210320.mat');  end %E optotype base 3 17secs to load

% 'E_b2s5_p2_p14_o4_ms10_210320.mat' acuities: 6 to  32: namely 6.0803    6.9844    8.0230    9.2160   10.5864   12.1606   13.9688 16.0460   18.4320   21.1728   24.3212   27.9377   32.0920
% 'E_b2s2_p1_p11_o4_ms10_210319.mat' acuities:6 to 417
% E_b2s10_p1_p13_o4_ms10_201207.mat buggy
% 'E_b2s6_p2_p14_o4_ms10_210318.mat' 'E_b2s10_p1_p13_o4_ms10_210316.mat'

        cf=ones(3,2); %white
%         cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected/purple background
%         cf=[0 0; 1 1;0 0]; %green background
        %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
        [y0 y1 w2]=ETM11f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
        c0=0.00384; %deg/pixels
        c1=1./(c0.*60);
        w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
        w4=20.*w3./c1; 20.*STK./c1
        
        %% first step to analyze
%                 c0=0.00384; %deg/pixels
%                 c1=1./(c0.*60);
%                 w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%                 w4=20.*w3./c1; 20.*STK./c1
        %% end of first step
                %strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
%                 strc(y0, w4, [mna(20.*STK./c1) mxa(w4)]); %step 2: show staircase
% 
                  d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
                  [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
%                 y0=[0 0 0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
%         
        if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'z0', 'z1'); end
        %% z1 & z2 are TCA values used (mean & std)
        
end

sca




% %% V ersion 210311
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% % edit JJVC_stro
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
% cls
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% c0=0.00384; %deg/pixels
% %display =10 degrees
% %FOV= 5 degrees
% 
% %BVAMS_gui; %run input gui
% ey='Right'; %eye Right Left Binocular
% % ey='Left'; %eye Right Left Binocular
% % magn=0.8;
% magn=1;
% ex='TCA'; %Experiment type TCA LCA CRM chromostereopsis CSF
% ACL=0; %ACL attached=1 otherwise=0
% sn=10003; %subject  nu mber 10004MB
% %subject number 10003AR
% %Tsystem TCA measurements sn=789
% %sn=77 for te st
% %sn=122 chnaged trombone pwr to 12.2
% %sn=131 chnaged trombone pwr to 13.1 using set_opt_MB_CSF
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune
% rc00=[0 0; 0 0]; %
% 
% 
% sz = [1080, 1920]; % size of screen
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% cf=ones(3,2);
% %cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% % cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% % background LATEST JAN 7
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% 
% switch ex
%     
%     case 'LCA'
%         cf=ones(3,2);
%         %   power_disp_min  initial_power_disp max_power_disp mag_min mag mag_max rotation reptitions 
%         a0=[9               13.5                  17             0.8     1   1.3     -3       6];
%           
%         LCAim{1}='vrn10_R_sd1.png';
%         LCAim{2}='vrn10_G_sd1.png';
%         LCAim{3}='vrn10_B_sd1.png';
%         
%         [a10, a11, a12, a13, a14, a15, a16, a17, a18]=LCA10f(LCAim, a0, ey, window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr
%         
%          [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(a18(5,1), a18(5,2)); %(LeftTromPwr, RightTromPwr);
%          fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);     
%          fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
%          
%          
%          if ACL==1
%         %Calculate the system TCA with ACL based on trombone powers
%         [LTCA_Y_br,LTCA_Y_gr,LTCA_X_br,LTCA_X_gr]=LeftSideTCA_tromb(a18(5,1)); %(LeftTromPwr);
%         [RTCA_Y_br,RTCA_Y_gr,RTCA_X_br,RTCA_X_gr]=RightSideTCA_tromb(a18(5,2)); %(RightTromPwr);
%         
%         %Use the above System TCA values with ACL
%         %[Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]
%         z0=[0    0    0    0; LTCA_Y_gr  LTCA_X_gr  RTCA_Y_gr  RTCA_X_gr;  LTCA_Y_br  LTCA_X_br  RTCA_Y_br  RTCA_X_br]; %system TCA with ACL
%          elseif ACL==0
%         %Calculate the system TCA withOUT ACL (No ACL)based on trombone powers
%         [TCA_LN_Y_br,TCA_LN_Y_gr,TCA_LN_X_br,TCA_LN_X_gr]=LeftSysTCA_noACL_tromb(a18(5,1));%(LeftTromPwr)
%         [TCA_RN_Y_br,TCA_RN_Y_gr,TCA_RN_X_br,TCA_RN_X_gr]=RightSysTCA_noACL_tromb(a18(5,2));%(RightTromPwr);
%         
%         %system TCA no ACL
%         %[Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]
% %         z0_noACL=[0   0    0   0; TCA_LN_Y_gr   TCA_LN_X_gr  TCA_RN_Y_gr  TCA_RN_X_gr; TCA_LN_Y_br  TCA_LN_X_br  TCA_RN_Y_br  TCA_RN_X_br]; %system TCA no ACL
%          z0=[0   0    0   0; TCA_LN_Y_gr   TCA_LN_X_gr  TCA_RN_Y_gr  TCA_RN_X_gr; TCA_LN_Y_br  TCA_LN_X_br  TCA_RN_Y_br  TCA_RN_X_br]; %system TCA no ACL
% 
%          end
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','z0','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY'); end
%         save('data\SPTtmp', 'a18', 'z0', '-append');
%         
%         input(['\n UPDATE in LABVIEW rtX' n2s2(PupCtr_RtX) ' rtY' n2s2(PupCtr_RtY) ' ltX' n2s2(PupCtr_LtX) ' ltY' n2s2(PupCtr_LtY)])
%     case 'TCA'
%         cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
%         ms=10;
%         rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
% 
%         xy0=15; %inital position of small circle
%         ppp = [5 0.5] ; %resolution pixelsPerPress
%         n2=6; %number of repetitions
% %         TCAfnm='c130_b145to540_w10_ms10_sd1_6';
%         TCAfnm='c65_b75to540_w10_ms10_sd1_6';
% %         TCAfnm='c130_b145to540_r340to350_w10_ms10_sd1_6'; %for big circle
% 
% 
%         clear E10c
%         [bxy v0]=TCA9f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2); %line62 in TCA9f to add/remove blue reticle on green
% 
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' ey 'ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0'); end
%         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
%         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
%         save('data\SPTtmp', 'z1', 'z2', '-append');
% 
%     case 'ETM'
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %% ETM params
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %bxy=[-10.3 10.7; 10.5 -11]
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
% 
% %          cf=ones(3,2); 'E_b2s2_p1_p11_o4_ms10_210319.mat','E_b2s6_p2_p14_o4_ms10_210318.mat' 'E_b2s10_p1_p13_o4_ms10_210316.mat'
%         if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s2_p1_p11_o4_ms10_210319.mat');  end %E optotype base 3 17secs to load
% %  if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s10_p1_p13_o4_ms10_201207.mat ');  end 
% 
% 
% 
% %      if ey=='Right'
% %          
% %         if ACL==0
% %             z0 =[ 0         0         0         0
% %                   0         0   -0.69583	1.3625
% %                   0         0   -1.10834	1.44585];
% %         elseif ACL==1
% %             z0 = [0         0         0         0
% %                   0         0   -0.4167	 1.5833
% %                   0         0   0.1667	 2.1667]; %updated from march 19 calibration %note : with ACL, the ACL was in a different plane!! so will have to redo!
% %         end
% 
%         if ACL==0
%             z0 =[ 0         0         0         0
%                   0         0   -1.6667    0.5333
%                   0         0   -2.2667   -0.6333];
%         elseif ACL==1
%             z0 = [0         0         0         0
%                   0         0   -1.5667    1.1333
%                   0         0   -2.1000    0.6000];
%         end
% %         
% %      elseif ey=='Left'
%          
% %          if ACL==0
% %             z0 =[ 0         0         0         0
% %                   0         0    -0.91666	2.05
% %                   0         0    -1.24168	3.3 ];
% %          elseif ACL==1
% %             z0 = [0         0         0         0
% %                   0         0    -0.46667	2.10833
% %                   0         0    -0.39999	3.60834];
% %         end
%          
% %      end
%         %         cf=ones(3,2);
%         cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected/purple background
% %         cf=[0 0; 1 1;0 0]; %green background
%         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
%         [y0 y1 w2]=ETM11f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
%         c0=0.00384; %deg/pixels
%         c1=1./(c0.*60);
%         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         w4=20.*w3./c1; 20.*STK./c1
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
% %                 d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
% %                 [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
% %                 y0=[0 0 0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
% %         
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2'); end
%         %% z1 & z2 are TCA values used (mean & std)
%         
% end
% 
% sca



% %% V ersion 210311
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']);
% cls
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% c0=0.00384; %deg/pixels
% %display =10 degrees
% %FOV= 5 degrees
% 
% %BVAMS_gui; %run input gui
% % ey='Right'; %eye Right Left Binocular
% ey='Right'; %eye Right Left Binocular
% % magn=0.8;
% magn=1;
% ex='LCA'; %Experiment type TCA LCA CRM chromostereopsis CSF
% ACL=0; %ACL attached=1 otherwise=0
% sn=10004; %subject  nu mber 10004MB
% %subject number 10003AR
% %Tsystem TCA measurements sn=789
% %sn=77 for te st
% %sn=122 chnaged trombone pwr to 12.2
% %sn=131 chnaged trombone pwr to 13.1 using set_opt_MB_CSF
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune
% rc00=[0 0; 0 0]; %
% 
% 
% sz = [1080, 1920]; % size of screen
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% cf=ones(3,2);
% %cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% % cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% % background LATEST JAN 7
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% 
% switch ex
%     
%     case 'LCA'
%         cf=ones(3,2);
%         %   power_disp_min  initial_power_disp max_power_disp mag_min mag mag_max rotation reptitions 
%         a0=[9               13.5                  17             0.8     1   1.3     -3       6];
%           
%         LCAim{1}='vrn10_R_sd1.png';
%         LCAim{2}='vrn10_G_sd1.png';
%         LCAim{3}='vrn10_B_sd1.png';
%         
%         [a10, a11, a12, a13, a14, a15, a16, a17, a18]=LCA10f(LCAim, a0, ey, window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr
%         
%          [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(a18(5,1), a18(5,2)); %(LeftTromPwr, RightTromPwr);
%          fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);     
%          fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
%          
%         %Calculate the system TCA with ACL based on trombone powers
%         [LTCA_Y_br,LTCA_Y_gr,LTCA_X_br,LTCA_X_gr]=LeftSideTCA_tromb(a18(5,1)); %(LeftTromPwr);
%         [RTCA_Y_br,RTCA_Y_gr,RTCA_X_br,RTCA_X_gr]=RightSideTCA_tromb(a18(5,2)); %(RightTromPwr);
%         
%         %Use the above System TCA values with ACL
%         %[Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]
%         z0=[0    0    0    0; LTCA_Y_gr  LTCA_X_gr  RTCA_Y_gr  RTCA_X_gr;  LTCA_Y_br  LTCA_X_br  RTCA_Y_br  RTCA_X_br]; %system TCA with ACL
%          
%         %Calculate the system TCA withOUT ACL (No ACL)based on trombone powers
%         [TCA_LN_Y_br,TCA_LN_Y_gr,TCA_LN_X_br,TCA_LN_X_gr]=LeftSysTCA_noACL_tromb(a18(5,1));%(LeftTromPwr)
%         [TCA_RN_Y_br,TCA_RN_Y_gr,TCA_RN_X_br,TCA_RN_X_gr]=RightSysTCA_noACL_tromb(a18(5,2));%(RightTromPwr);
%         
%         %system TCA no ACL
%         %[Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]
%         z0_noACL=[0   0    0   0; TCA_LN_Y_gr   TCA_LN_X_gr  TCA_RN_Y_gr  TCA_RN_X_gr; TCA_LN_Y_br  TCA_LN_X_br  TCA_RN_Y_br  TCA_RN_X_br]; %system TCA no ACL
%         
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','z0','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY'); end
%         save('data\SPTtmp', 'a18', 'z0', '-append');
%         
%         input(['\n UPDATE in LABVIEW rtX' n2s2(PupCtr_RtX) ' rtY' n2s2(PupCtr_RtY) ' ltX' n2s2(PupCtr_LtX) ' ltY' n2s2(PupCtr_LtY)])
%     case 'TCA'
%         cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
%         ms=10;
%         rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
% 
%         xy0=40; %inital position of small circle
%         ppp = [5 0.5] ; %resolution pixelsPerPress
%         n2=3; %number of repetitions
%         %TCAfnm='c130_b145to540_w10_ms10_sd1_6';
%         TCAfnm='c65_b80to540_w10_ms10_sd1_6';
%         %TCAfnm='c130_b145to540_r340to350_w10_ms10_sd1_6';
% 
%         clear E10c
%         [bxy v0]=TCA9f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2); %line62 in TCA9f to add/remove blue reticle on green
% 
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' ey 'ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0'); end
%         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
%         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
%         save('data\SPTtmp', 'z1', 'z2', '-append');
% 
%     case 'ETM'
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %% ETM params
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %bxy=[-10.3 10.7; 10.5 -11]
%         d1=5; %trials to drop
%         n0=4; % number of experiments/repetitions
%         n1=10;% number of trials
% 
%         w0=7;% initial size of the optotype, stroke size= 2^w, marty 12
%         sz = [1080, 1920]; % size of screen
%         d0=0.5; %length of optotype presentation in secs, AR 0.5sec, MB 2 sec
%         % Get the screen numbers
%         screens = Screen('Screens');
%         screenNumber = max(screens);
%         load cal_val; %cf=[RB./RR LB./LR];
% 
%         %  cf=ones(3,2);
%         if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s10_p1_p13_o4_ms10_201207.mat');  end %E optotype base 3 17secs to load
%         
%         
%         %         cf=ones(3,2);
%         cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected/purple background
%         %cf=[0 0; 1 1;0 0]; %green background
%         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
%         [y0 y1 w2]=ETM11f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
%         c0=0.00384; %deg/pixels
%         c1=1./(c0.*60);
%         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         w4=20.*w3./c1; 20.*STK./c1
%         
%         %% first step to analyze
%         %         c0=0.00384; %deg/pixels
%         %         c1=1./(c0.*60);
%         %         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         %         w4=20.*w3./c1; 20.*STK./c1
%         %% end of first step
%         %         strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
%         %         d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
%         %         [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
%         %         y0=[0 0 0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
%         
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2'); end
%         %% z1 & z2 are TCA values used (mean & std)
%         
% end
% 
% sca



% %% V ersion 210301
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']);
% cls
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% c0=0.00384; %deg/pixels
% %display =10 degrees
% %FOV= 5 degrees
% 
% %BVAMS_gui; %run input gui
% % ey='Right'; %eye Right Left Binocular
% ey='Left'; %eye Right Left Binocular
% % magn=0.8;
% magn=1;
% ex='LCA'; %Experiment type TCA LCA CRM chromostereopsis CSF
% ACL=0; %ACL attached=1 otherwise=0
% sn=77; %subject  nu mber 10004MB
% %subject number 10003AR
% %Tsystem TCA measurements sn=789
% %sn=77 for test
% %sn=122 chnaged trombone pwr to 12.2
% %sn=131 chnaged trombone pwr to 13.1 using set_opt_MB_CSF
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune
% rc00=[0 0; 0 0]; %
% 
% 
% sz = [1080, 1920]; % size of screen
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% cf=ones(3,2);
% %cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% % cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% % background LATEST JAN 7
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% 
% switch ex
%     
%     case 'LCA'
%         cf=ones(3,2);
%         %   power_disp_min  initial_power_disp max_power_disp mag_min mag mag_max rotation reptitions 
%         a0=[9               10                  17             0.8     1   1.3     -3       2];
%         
% %         p0=zeros(8,2);
% %         %if set power_disp/optopower=0 randomize.
% %         p0(1,:)=[9                    9];               %power_dispL_min      power_dispR_min
% %         %p0=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR
% %         p0(2,:)=[0             0];               %initial power_dispL          power_dispR
% %         p0(3,:)=[17                 17];              %power_dispL_max      power_dispL_max
% %         p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min
% %         %p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)
% %         %making trombone go to a specific lowest magnification
% %         p0(5,:)=[opL(magn)             opR(magn)];               %L_optopower(mag)     R_optopower(mag)
% %         p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% %         p0(7,:)=-3; %rotation
% %         p0(8,:)=4; %number of repetitions
% %         % LCAim='subpixel-e1403202931818.png';
%         
%         LCAim{1}='vrn10_R_sd1.png';
%         LCAim{2}='vrn10_G_sd1.png';
%         LCAim{3}='vrn10_B_sd1.png';
%         
%         [a10, a11, a12, a13, a14, a15, a16, a17, a18]=LCA10f(LCAim, a0, ey, window1, window2);
%         
%          [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(a18(5,1), a18(5,2)); %(LeftTromPwr, RightTromPwr);
%          fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);     
%          fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
%          
%         %Calculate the system TCA based on trombone powers
%         [LTCA_Y_br,LTCA_Y_gr,LTCA_X_br,LTCA_X_gr]=LeftSideTCA_tromb(a18(5,1)); %(LeftTromPwr);
%         [RTCA_Y_br,RTCA_Y_gr,RTCA_X_br,RTCA_X_gr]=RightSideTCA_tromb(a18(5,2)); %(RightTromPwr);
%         
%         %Use the above System TCA values
%         %[Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]
%         z0=[0    0    0    0; LTCA_Y_gr  LTCA_X_gr  RTCA_Y_gr  RTCA_X_gr;  LTCA_Y_br  LTCA_X_br  RTCA_Y_br  RTCA_X_br]; %system TCA 
% 
%         
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim'); end
% 
% 
% %         a1=LCA9f(LCAim, a0, ey, window1, window2);
% %         
% %         
% %         
% %         for k0=1:length(LCAim)
% %             a2(k0,:)=mean(a1(a1(:,6)==k0,:),1)
% %             %            p3(k0,:)=std(p1(p1(:,6)==k0,:), 0, 1) %CAUTION:also p3 is being used further!!!
% %             a3(k0,:)=std(a1(a1(:,6)==k0,:), 0, 1) %CAUTION:also p3 is being used further!!!
% %             
% %         end
% %         
% %         %correct LCA values based on RGB differences
% %         [a4R, flagR]=set_opt_RightEye(a0', a2, a0(5));
% %         [a4L, flagL]=set_opt_LeftEye(a0' , a2, a0(5));
% % 
% %         [a5L ,a5R]=opt00([a4L a4R], (flagR+flagL)>0 ); %apply corrected LCA values and ger power
% %         
% %         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a1', 'a2', 'a3', 'a4R', 'a4L', 'a5L', 'a5R', 'LCAim'); end
% %         
%         
% %         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'p1', 'p2', 'p4', 'LCAim'); end
%     case 'TCA'
%         cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
%         ms=10;
%         % rd=540; % red diameter
%         % kd=120; % black diameter
%         % bd=108; % blue diameter
%         % lineWidthPix = 4; %bar width
%         rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
%         
%         %rgb=[3 1]; %TCA [inner-small-circle background-outer-circle] colors 1red 2green 3blue
%         % rgb=[3 2]; %BLUE GREEN
%         xy0=40; %inital position of small circle
%         % xy0=0; %inital position of small circle
%         %         xy1=[-1.6 9.7; -21 -3]; %system TCA
%         ppp = [5 0.5] ; %resolution pixelsPerPress
%         n2=3; %number of repetitions
%         %TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
%         TCAfnm='c130_b145to540_w10_ms10_sd1_6';
%         
%         
%         
%         %        cf=[RB./RR LB./LR; 1 1; 1 1];
%         clear E10c
%         [bxy v0]=TCA8f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%         
%         %[bxy v0]=TCA6f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%         %bxy=TCA5f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' ey 'ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0'); end
%         %z0=mean(bxy,1); z1=zeros(2, 2); z1(1,:)=z0(1:2); z1(2,:)=z0(3:4); %convert to ETM9f format
%         %         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
%         %         z1=[0 0 0 0;10 10 0 0;0 0 0 0];
%         %          z1=zeros(3,4);
%         %rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
%         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
%         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
%         
%     case 'ETM'
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %% ETM params
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %bxy=[-10.3 10.7; 10.5 -11]
%         d1=5; %trials to drop
%         n0=4; % number of experiments/repetitions
%         n1=40;% number of trials
%         
%         % d1=0; %trials to drop
%         % % d1=0; %trials to drop
%         % n0=4; % number of experiments/repetitions
%         % n1=4;% number of trials
%         
%         % n1=5;% number of trials
%         w0=7;% initial size of the optotype, stroke size= 2^w, marty 12
%         %t0=0.7; %psignfit threshold
%         %sd=0; %blur kernel
%         %rgd=[ ]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
%         sz = [1080, 1920]; % size of screen
%         d0=0.5; %length of optotype presentation in secs, AR 0.5sec, MB 2 sec
%         % Get the screen numbers
%         screens = Screen('Screens');
%         screenNumber = max(screens);
%         load cal_val; %cf=[RB./RR LB./LR];
%         
%         %cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
%         %         cf=ones(3,2);
%         %cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% %         cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
%         % background LATEST JAN 7
%         
%         %  cf=ones(3,2);
%         % load('E_b2_m2_p10_o4_ms10.mat'); %LOAD BEFORE STARTING, E optotype base 2
%         
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2_m2_p10_o4_ms10.mat'); end %E optotype base 2
%         
%         
%         
%         
%         %[Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]
% %         z0=[0    0    0    0;        -1    4.7     -3      0.4;        -2.1   9.6   -6.7    -0.6]; %system TCA
%         %  z0=[0    0    0    0;        0    0    0    0;       0    0    0    0]; %system TCA
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat');  end %E optotype base 3 17secs to load
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s4_p1_p13_o4_ms10_201130.mat');  end %E optotype base 3 17secs to load
%         if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s10_p1_p13_o4_ms10_201207.mat');  end %E optotype base 3 17secs to load
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s8_p1_p13_o4_ms10_201207.mat');  end %E optotype base 3 17secs to load
%         
%         
%         %         cf=ones(3,2);
%         cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected
%         %cf=[0 0; 1 1;0 0]; %green background
%         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
%         [y0 y1 w2]=ETM11f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
%         c0=0.00384; %deg/pixels
%         c1=1./(c0.*60);
%         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         w4=20.*w3./c1; 20.*STK./c1
%         
%         %% first step to analyze
%         %         c0=0.00384; %deg/pixels
%         %         c1=1./(c0.*60);
%         %         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         %         w4=20.*w3./c1; 20.*STK./c1
%         %% end of first step
%         %         strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
%         %         d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
%         %         [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
%         %         y0=[0 0 0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
%         
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2'); end
%         %% z1 & z2 are TCA values used (mean & std)
%         
% end
% 
% sca



% %% V ersion 210224
% %clr
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']);
% cls
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% c0=0.00384; %deg/pixels
% %display =10 degrees
% %FOV= 5 degrees
% 
% %BVAMS_gui; %run input gui
% % ey='Right'; %eye Right Left Binocular
% ey='Left'; %eye Right Left Binocular
% % magn=0.8;
% magn=1;
% ex='LCA'; %Experiment type TCA LCA CRM chromostereopsis CSF
% ACL=1; %ACL attached=1 otherwise=0
% sn=09; %subject  nu mber 10004MB
% %subject number 10003AR
% %Tsystem TCA measurements sn=789
% %sn=77 for test
% %sn=122 chnaged trombone pwr to 12.2
% %sn=131 chnaged trombone pwr to 13.1 using set_opt_MB_CSF
% if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
% zbr=1; %activate zebar/optotune
% rc00=[0 0; 0 0]; %
% 
% 
% sz = [1080, 1920]; % size of screen
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% cf=ones(3,2);
% %cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% % cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% % background LATEST JAN 7
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% 
% switch ex
%     
%     case 'LCA'
%         
%         %   power_disp_min  initial_power_disp max_power_disp mag_min mag mag_max rotation reptitions 
%         a0=[9               10                  17             0.8     1   1.3     -3       1];
%         
% %         p0=zeros(8,2);
% %         %if set power_disp/optopower=0 randomize.
% %         p0(1,:)=[9                    9];               %power_dispL_min      power_dispR_min
% %         %p0=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR
% %         p0(2,:)=[0             0];               %initial power_dispL          power_dispR
% %         p0(3,:)=[17                 17];              %power_dispL_max      power_dispL_max
% %         p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min
% %         %p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)
% %         %making trombone go to a specific lowest magnification
% %         p0(5,:)=[opL(magn)             opR(magn)];               %L_optopower(mag)     R_optopower(mag)
% %         p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% %         p0(7,:)=-3; %rotation
% %         p0(8,:)=4; %number of repetitions
% %         % LCAim='subpixel-e1403202931818.png';
%         
%         LCAim{1}='vrn10_R_sd1.png';
%         LCAim{2}='vrn10_G_sd1.png';
%         LCAim{3}='vrn10_B_sd1.png';
%         
%         
%         
%         
%         a1=LCA9f(LCAim, a0, ey, window1, window2);
%         
%         
%         
%         for k0=1:length(LCAim)
%             a2(k0,:)=mean(a1(a1(:,6)==k0,:),1)
%             %            p3(k0,:)=std(p1(p1(:,6)==k0,:), 0, 1) %CAUTION:also p3 is being used further!!!
%             a3(k0,:)=std(a1(a1(:,6)==k0,:), 0, 1) %CAUTION:also p3 is being used further!!!
%             
%         end
%         
%         %correct LCA values based on RGB differences
%         [a4R, flagR]=set_opt_RightEye(a0', a2, a0(5));
%         [a4L, flagL]=set_opt_LeftEye(a0' , a2, a0(5));
% 
%         [a5L ,a5R]=opt00([a4L a4R], (flagR+flagL)>0 ); %apply corrected LCA values and ger power
%         
%         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a1', 'a2', 'a3', 'a4R', 'a4L', 'a5L', 'a5R', 'LCAim'); end
%         
%         
% %         if strcmp(ey,'Right')
% %             [p3,flag]=set_opt_RightEye(p0(:,2), p2, magn); %gives optotune settings for Right eye only usign defocus adjustments from subject, i.e 2nd column in p0
% %             %Nadav:add line to save p3 for the subject-> Sub_OptSettings_RightEye_NoAcl_Date
% %             p4=[p0(:, 1) p3];  %first column for left eye
% %         elseif strcmp(ey,'Left')
% %             [p3,flag]=set_opt_LeftEye(p0(:,1), p2, magn);
% %             p4=[p3 p0(:,2)];
% %             %Nadav:add line to save p4 for subject--> Sub_OptSettings_LeftEye_NoACL_Date
% %             %Nadav:load saved p3 for right eye from above
% %             %LEFT SIDE IS GIVING YOU IMAGINERY VALUES
% %         end
% %         %p5=[p4 p3];
% %         opt0(p4,flag);
%         
%         
%         
%         
% %         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'p1', 'p2', 'p4', 'LCAim'); end
%     case 'TCA'
%         
%         ms=10;
%         % rd=540; % red diameter
%         % kd=120; % black diameter
%         % bd=108; % blue diameter
%         % lineWidthPix = 4; %bar width
%         rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
%         
%         %rgb=[3 1]; %TCA [inner-small-circle background-outer-circle] colors 1red 2green 3blue
%         % rgb=[3 2]; %BLUE GREEN
%         xy0=0; %inital position of small circle
%         % xy0=0; %inital position of small circle
%         %         xy1=[-1.6 9.7; -21 -3]; %system TCA
%         ppp = [5 0.1] ; %resolution pixelsPerPress
%         n2=4; %number of repetitions
%         %TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; %'r108_c4_10.mat';
%         TCAfnm='c130_b145to540_w10_ms10_sd1_6';
%         
%         
%         
%         %        cf=[RB./RR LB./LR; 1 1; 1 1];
%         clear E10c
%         [bxy v0]=TCA7f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%         
%         %[bxy v0]=TCA6f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%         %bxy=TCA5f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%         if sv==1; save(['data\S' num2str(sn) '_TCA_' ey 'ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0'); end
%         %z0=mean(bxy,1); z1=zeros(2, 2); z1(1,:)=z0(1:2); z1(2,:)=z0(3:4); %convert to ETM9f format
%         %         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
%         %         z1=[0 0 0 0;10 10 0 0;0 0 0 0];
%         %          z1=zeros(3,4);
%         %rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
%         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
%         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
%         
%     case 'ETM'
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %% ETM params
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %bxy=[-10.3 10.7; 10.5 -11]
%         d1=5; %trials to drop
%         n0=4; % number of experiments/repetitions
%         n1=40;% number of trials
%         
%         % d1=0; %trials to drop
%         % % d1=0; %trials to drop
%         % n0=4; % number of experiments/repetitions
%         % n1=4;% number of trials
%         
%         % n1=5;% number of trials
%         w0=7;% initial size of the optotype, stroke size= 2^w, marty 12
%         %t0=0.7; %psignfit threshold
%         %sd=0; %blur kernel
%         %rgd=[ ]; %[1 3]; %colors to drop 1-red, 2-green, 3-blue
%         sz = [1080, 1920]; % size of screen
%         d0=0.5; %length of optotype presentation in secs, AR 0.5sec, MB 2 sec
%         % Get the screen numbers
%         screens = Screen('Screens');
%         screenNumber = max(screens);
%         load cal_val; %cf=[RB./RR LB./LR];
%         
%         %cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
%         %         cf=ones(3,2);
%         %cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
%         % cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
%         % background LATEST JAN 7
%         
%         %  cf=ones(3,2);
%         % load('E_b2_m2_p10_o4_ms10.mat'); %LOAD BEFORE STARTING, E optotype base 2
%         
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2_m2_p10_o4_ms10.mat'); end %E optotype base 2
%         
%         
%         
%         
%         %[Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]
%         z0=[0    0    0    0;        -1    4.7     -3      0.4;        -2.1   9.6   -6.7    -0.6]; %system TCA
%         %  z0=[0    0    0    0;        0    0    0    0;       0    0    0    0]; %system TCA
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat');  end %E optotype base 3 17secs to load
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s4_p1_p13_o4_ms10_201130.mat');  end %E optotype base 3 17secs to load
%         if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s10_p1_p13_o4_ms10_201207.mat');  end %E optotype base 3 17secs to load
%         %if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s8_p1_p13_o4_ms10_201207.mat');  end %E optotype base 3 17secs to load
%         
%         
%         %         cf=ones(3,2);
%         cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected
%         %cf=[0 0; 1 1;0 0]; %green background
%         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
%         [y0 y1 w2]=ETM11f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
%         c0=0.00384; %deg/pixels
%         c1=1./(c0.*60);
%         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         w4=20.*w3./c1; 20.*STK./c1
%         
%         %% first step to analyze
%         %         c0=0.00384; %deg/pixels
%         %         c1=1./(c0.*60);
%         %         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         %         w4=20.*w3./c1; 20.*STK./c1
%         %% end of first step
%         %         strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
%         %         d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
%         %         [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
%         %         y0=[0 0 0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
%         
%         if sv == 1; save(['data\S' num2str(sn) '_ETM_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2'); end
%         %% z1 & z2 are TCA values used (mean & std)
%         
% end
% 
% sca
