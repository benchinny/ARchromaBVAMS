%%210622 present same stim on both screen and only upload TCA file
ex='ETM'
%        input e output f
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% ETM params
        %y0=zeros(size(y0)); d1=5; [r00 r11]=psf_ETM1(y0, y1,STK11(w2),d1); disp(r00); disp(r11);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %bxy=[-10.3 10.7; 10.5 -11]
        d1=5; % 5trials to drop
        %n0=4;%4; % number of experiments/repetitions
        n1=40; %40;% 40 number of trials
    cntrst=0.2; %1;%cntrst=1
%purple values
    %Left  0.6153    0.3982    1.0000
    %Right 0.6267    0.4279    1.0000  


%[Right Left]
%cf=[1 1; 0 0; 0 0];n0=4; cg='w'; %test
%                                cf=[0 0;  0.605 0.583;  0 0]; cg='g'; n0=2; %green
%                cf=[0.6267 0.6153; 0.4279 0.3982; 1 1]; n0=4; cg='p';  %210621 gamma corrected/purple background
        cf=[0.538 0.525; 0.538 0.525; 0.538 0.525]; n0=4; cg='w'; %cntrst=1; %white
%                  cf=ones(3,2); n0=4; cg='w'; %cntrst=1; %white
%                 cf=[0 0; 0 0; 1 1]; n0=4; cg='w'; %cntrst=1; %white
 %                 cf=[0 0; 0 0; 0.538 0.525]; n0=4; cg='w'; %cntrst=1; %white
%                cf=[0 0; 0.4279 0.3982; 0 0]; n0=4; cg='p';  %210621 gamma corrected/purple background
%        cf=[0 0; 0.538 0.525; 0 0]; n0=4; cg='w'; %cntrst=1; %white
%                cf=[0.6267 0.6153; 0 0; 0 0]; n0=4; cg='p';  %210621 gamma corrected/purple background
%        cf=[0.538 0.525; 0 0; 0 0]; n0=4; cg='w'; %cntrst=1; %white


      %    !!!!!!!!!!!!!! UPDATE TCA and LCA files!!!!!!!!!!!!!!
        w0=13;% initial size of the optotype, stroke size= 2^w, marty 12
        sz = [1080, 1920]; % size of screen
        d0=0.5; % 0.5length of optotype presentation in secs, AR 0.5sec, MB 2 sec
        % Get the screen numbers
        screens = Screen('Screens');
        screenNumber = max(screens);
        load cal_val; %cf=[RB./RR LB./LR]
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
        %load TCA file
        TCAfnm='S10003Right_TCA_ACL0_2112071206.mat'; load(TCAfnm, 'TCAp');
%          load('.mat', 'TCAp');
        z0L=TCAp.sysTCA; z1L=TCAp.sbjTCA; TCAfnmL=TCAfnm;
        
        TCAfnm='S10003Right_TCA_ACL0_2112071206.mat'; load(TCAfnm, 'TCAp');
%          load('.mat', 'TCAp');
        z0R=TCAp.sysTCA; z1R=TCAp.sbjTCA; TCAfnmR=TCAfnm;
        
        %%%%%%%%%%%%%CHECK RETICLE%%%%%%%%%%%%%%
        trombone_power_left=opto(name_map('l_t_far')).control.getFocalPower.focal_power; %a18(5,1);
        trombone_power_right=opto(name_map('r_t_far')).control.getFocalPower.focal_power; %a18(5,2);
        fprintf('Display LEFT %0.7f \n',opto(name_map('l_disp')).control.getFocalPower.focal_power);
        fprintf('Trombone LEFT %0.7f \n',trombone_power_left);
        fprintf('\nDisplay RIGHT %0.7f\n',opto(name_map('r_disp')).control.getFocalPower.focal_power);
        fprintf('Trombone RIGHT %0.7f\n',trombone_power_right);
        fprintf('\n');
        %output final reticle position
        [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
        fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);
        fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %NOTE: NEED TO SELECT APPROPRAITE VALUE OF ACL for findz0 to work
        %correctly!
        %          input(['\n WAS ACL VALUE UPDATED CORRECTLY?? Currently it is: ' n2s2(ACL)]);

        %if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load
        if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p5_p17_o4_ms10_210621.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load

                    %if exist('E10c')==0 | isempty(E10c)==1;
        %ETMfnm0='E_b2s5_p10_p22_o4_ms10_210608.mat';load(ETMfnm0);end %JOL

        % 'E_b2s5_p2_p14_o4_ms10_210320.mat' acuities: 6 to  32: namely 6.0803    6.9844    8.0230    9.2160   10.5864   12.1606   13.9688 16.0460   18.4320   21.1728   24.3212   27.9377   32.0920
        % 'E_b2s2_p1_p11_o4_ms10_210319.mat' acuities:6 to 417
        % E_b2s10_p1_p13_o4_ms10_201207.mat buggy
        % 'E_b2s6_p2_p14_o4_ms10_210318.mat' 'E_b2s10_p1_p13_o4_ms10_210316.mat'
        disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
        [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 1); %start psychtoolbox
        
        %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
        %if cg=='g'; z1L=zeros(size(z1L)); z0=z1; end; %zero TCA offset for green stim
        if cg=='g'; z1L=zeros(3,2); z0L=z1L; z0R=z0L; z1R=z0R; end %zero TCA offset for green stim

        %[y0 y1 w2 y5]=ETM16f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
        [y0 y1 w2 y5]=ETM17f([n0 n1 w0 d0], z1L, z0L, z1R, z0R, E10c, STK, window1, window2);


        %y0=zeros(size(y0)); d1=5; [r00 r11]=psf_ETM(y0, y1, w2, d1, STK00);
        %%y5=save final varichrome settings
        c0=0.00384; %deg/pixels
        c1=1./(c0.*60); %pixels/minute
        w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
        w4=20.*w3./c1; 20.*STK./c1
        STK11=STK00;
        
        %         %% first step to analyze
        %                 c0=0.00384; %deg/pixels
        %                 c1=1./(c0.*60);
        %                 w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
        %                 w4=20.*w3./c1; 20.*STK./c1
        %         %% end of first step
        %                 strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
        %                 strc(y0, w4, [mna(20.*STK./c1) mxa(w4)]); %step 2: show staircase
        % % %
        %                   d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
        %                    d1=5; [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
        %y0=zeros(size(y0)); d1=5; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
        %
        VRCMprm; ETMp=VRCMp;%save varichrome parameters into VRCMp
        ETMp.opt_fnm=ETMfnm0;
        ETMp.sysTcaL=z0L; ETMp.sysTcaR=z0R;
        ETMp.sbjTcaL=z1L; ETMp.sbjTcaL=z1L;
        ETMp.TCAfnm=TCAfnm; clear TCAp;
        %if sv == 1; save(['data\S' num2str(sn) '_ETM' cg '_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'z0', 'z1', 'ETMfnm0', 'y5', 'VRCMp'); end
        if sv == 1; save(['data\S' num2str(sn) ey '_' ex cg '_ACL' n2s(ACL) '_C' n2s(round(100.*cntrst)) '_' tme], 'y0', 'y1', 'w2', 'y5','STK11', 'ETMp'); end

        %% z1 & z2 are TCA values used (mean & std)
        
        sca

% %%210604 JJVC_ETM run ETM task
% ex='ETM'
% %        input e output f
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %% ETM params
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %bxy=[-10.3 10.7; 10.5 -11]
%         d1=5; % 5trials to drop
%         %n0=4;%4; % number of experiments/repetitions
%         n1=40; %40;% 40 number of trials
%         cntrst=0.2;
% %               cf=[0.6267 0.6153; 0.4279 0.3982; 1 1]; n0=4; cg='p';  %210621 gamma corrected/purple background
% %purple values
%     %Left  0.6153    0.3982    1.0000
%     %Right 0.6267    0.4279    1.0000  
% 
% 
% %[Right Left]
% 
% %                                 cf=[0 0;  0.605 0.583;  0 0]; cg='g'; n0=2; %green
%         cf=[0.538 0.525; 0.538 0.525; 0.538 0.525]; n0=4; cg='w'; %cntrst=1; %white
%       %    !!!!!!!!!!!!!! UPDATE TCA and LCA files!!!!!!!!!!!!!!
%         w0=13;% initial size of the optotype, stroke size= 2^w, marty 12
%         sz = [1080, 1920]; % size of screen
%         d0=0.5; % 0.5length of optotype presentation in secs, AR 0.5sec, MB 2 sec
%         % Get the screen numbers
%         screens = Screen('Screens');
%         screenNumber = max(screens);
%         load cal_val; %cf=[RB./RR LB./LR]
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %%%%LOAD CORRECT LCA FILE with ACL=0: FOR getting SYSTEM TCA%%%%%%%
%  
% %       load('S10005Right_LCA_ACL0_2106081156.mat', 'a18');  a18L=a18; %LEFT EYE LCA JIM 2009       
% %       load('S10005Right_LCA_ACL0_2106081156.mat', 'a18'); a18R=a18; %RIght EYE LCA JIM 2009
% % 
% % load('S10003_LCA_RightACL0_2104301024.mat', 'a18'); a18R=a18; %RIGHT LCA ar
% % load('S10003_LCA_LeftACL0_2104301034.mat', 'a18'); a18L=a18;  % LEFT LCA ar
% %         load('S10003_LCA_RightACL0_2103261450.mat', 'a18'); a18R=a18; %old RIGHT LCA ar
% %         load('S10003_LCA_LeftACL0_2103261603.mat', 'a18');a18L=a18; %old LEFT LCA ar
%         
%         load('S10004_LCA_RightACL0_2105191352.mat', 'a18'); a18R=a18; %RIGHT EYE LCA  mb
%           load('S10004_LCA_LeftACL0_2104061444.mat', 'a18');  a18L=a18; %LEFT EYE LCA mb 10004   
% % %         load('S10003_LCA_RightACL0_2104301024.mat', 'a18'); a18R=a18; %
% %        load('S10007_LCA_RightACL0_2105261020.mat', 'a18'); a18R=a18;
% 
%         %%nadav
% %         load('S10007_LCA_LeftACL0_2105261047.mat', 'a18');a18L=a18;  %Nadav Left May26
% %       load('S10007Right_LCA_ACL0_2106161205.mat', 'a18'); a18R=a18; %RIGHT EYE LCA  Nadav June16
%         % load('S10007_LCA_RightACL0_2104201412.mat', 'a18'); a18R=a18; %RIGHT EYE LCA  Nadav
% %        load('S10004_LCA_LeftACL0_2104061444.mat', 'a18'); a18R=a18; %RIGHT EYE LCA       
%         
%         %above is needed for correct system TCA evaluation
%          a18(:,1)=a18L(:,1); a18(:,2)=a18R(:,2);
%         %a18(:,2)=a18R(:,1);
%         
%         % a18(5,1)=opL(1);
%         % a18(5,2)=opR(1);
%         
%         findz0; %based on trombone location calculate z0 (system tca)
%         % z0=[        0         0         0         0
%         %    -0.9167    2.0500   -0.7856    1.3697
%         %    -1.2417    3.3000   -1.2141    1.4703];
%         % z0=zeros(3,4);
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %%%%%LOAD CORRECT SUBJECT+SYSTEM TCA FILE FOR RESPECTIVE EYE and ACL condition%%%%%
%         %change the below TCA file depending on ACL=0 or ACL=1 and which Eye you're doing
%         %acuity on
% %         load('S10007Right_TCA_ACL1_2106161328.mat','z1');
% %         load('S10007Right_TCA_ACL0_2106161238.mat','z1');
% %         load('S10003Right_TCA_ACL1_2106111624.mat','z1');
% %          load('S10003Right_TCA_ACL1_2106181307.mat','z1');
% %           load('S10004Left_TCA_ACL0_2106101231.mat','z1');% LOAD JIM 2009 TCA ACL0
% %            load('.mat','z1');% LOAD JIM 2009 TCA ACL1
% %          load('S10004_TCA_LeftACL1_2104141337.mat', 'z1'); % mb load TCA z1 variable example
%         % load('S10007_TCA_LeftACL1_CAm2104191224.mat', 'z1');
%         % load('S10007_TCA_LeftACL1_Cam2104191252.mat', 'z1');
%         
%         % load('S10007_TCA_LeftACL1_Cam2104191322.mat', 'z1');
%         % z1=[ 0 0 0 0; -20 20 -20 20; -40 40 -40 40];
%         % load('S10007_TCA_LeftACL1_Cam2104191415.mat', 'z1');
%         % load('S10007_TCA_LeftACL1_CAm2104191534.mat', 'z1');
%         % load('S10007_TCA_RightACL0_Cam2104201011.mat', 'z1');
%         load('S10004Left_TCA_ACL0_2106221413.mat', 'z1');
%         % load('S10007_TCA_RightACL0_2104201425.mat', 'z1'); %nadav april 20
%         % load('S10007_TCA_RightACL0_2104211453.mat', 'z1'); %nadav april 21
% %         load('S10004_TCA_LeftACL0_2105061400.mat', 'z1'); %nadav april 22 acl=1
% %          load('S10004_TCA_LeftACL0_2105201111.mat','z1'); %MARTY May 20 2021 
% %         load('S10003_TCA_RightACL1_2105211056.mat','z1'); %MARTY May 20 2021 
% %         load('S10004_TCA_LeftACL1_2105241249.mat','z1');%Marty ACL=1 May 24 left
% %          load('S10007_TCA_RightACL0_2105261224.mat','z1');%nadav May 26 Rt
% %           load('S10007_TCA_RightACL0_2105271213.mat','z1');%nadav May 27 Rt acl=0
% %           load('S10007_TCA_RightACL1_2105271334.mat','z1');;%nadav May 27 Rt acl=1
%           
%           
%         %%%%%%%%%%%%%CHECK RETICLE%%%%%%%%%%%%%%
%         trombone_power_left=a18(5,1);
%         trombone_power_right=a18(5,2);
%         fprintf('Display LEFT %0.7f \n',a18(2,1));
%         fprintf('Trombone LEFT %0.7f \n',trombone_power_left);
%         fprintf('\nDisplay RIGHT %0.7f\n',a18(2,2));
%         fprintf('Trombone RIGHT %0.7f\n',trombone_power_right);
%         fprintf('\n');
%         %output final reticle position
%         [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
%         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);
%         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  %NOTE: NEED TO SELECT APPROPRAITE VALUE OF ACL for findz0 to work
%         %correctly!
%         %          input(['\n WAS ACL VALUE UPDATED CORRECTLY?? Currently it is: ' n2s2(ACL)]);
% 
%         %if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load
%         if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p5_p17_o4_ms10_210621.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load
% 
%                     %if exist('E10c')==0 | isempty(E10c)==1;
%         %ETMfnm0='E_b2s5_p10_p22_o4_ms10_210608.mat';load(ETMfnm0);end %JOL
% 
%         % 'E_b2s5_p2_p14_o4_ms10_210320.mat' acuities: 6 to  32: namely 6.0803    6.9844    8.0230    9.2160   10.5864   12.1606   13.9688 16.0460   18.4320   21.1728   24.3212   27.9377   32.0920
%         % 'E_b2s2_p1_p11_o4_ms10_210319.mat' acuities:6 to 417
%         % E_b2s10_p1_p13_o4_ms10_201207.mat buggy
%         % 'E_b2s6_p2_p14_o4_ms10_210318.mat' 'E_b2s10_p1_p13_o4_ms10_210316.mat'
%         disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
%         [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 1); %start psychtoolbox
%         
%         %presented in command window: trial #, base-power, stroke size, optotype size, time to generate optotype
%         if cg=='g'; z1=zeros(size(z1)); z0=z1; end; %zero TCA offset for green stim
%         [y0 y1 w2 y5]=ETM14f([n0 n1 w0 d0], z1, z0, E10c, STK, window1, window2);
%         %y0=zeros(size(y0)); d1=5; [r00 r11]=psf_ETM(y0, y1, w2, d1, STK00);
%         %%y5=save final varichrome settings
%         c0=0.00384; %deg/pixels
%         c1=1./(c0.*60); %pixels/minute
%         w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         w4=20.*w3./c1; 20.*STK./c1
%         STK11=STK00;
%         
%         %         %% first step to analyze
%         %                 c0=0.00384; %deg/pixels
%         %                 c1=1./(c0.*60);
%         %                 w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
%         %                 w4=20.*w3./c1; 20.*STK./c1
%         %         %% end of first step
%         %                 strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
%         %                 strc(y0, w4, [mna(20.*STK./c1) mxa(w4)]); %step 2: show staircase
%         % % %
%         %                   d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
%         %                    d1=5; [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
%         %y0=zeros(size(y0)); d1=5; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
%         %
%         VRCMprm; ETMp=VRCMp;%save varichrome parameters into VRCMp
%         %if sv == 1; save(['data\S' num2str(sn) '_ETM' cg '_' ey 'ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'z0', 'z1', 'ETMfnm0', 'y5', 'VRCMp'); end
%         if sv == 1; save(['data\S' num2str(sn) ey '_' ex cg '_ACL' n2s(ACL) '_' tme], 'y0', 'y1', 'w2', 'z0', 'z1', 'ETMfnm0', 'y5','STK11', 'ETMp'); end
% 
%         %% z1 & z2 are TCA values used (mean & std)
%         
%         sca