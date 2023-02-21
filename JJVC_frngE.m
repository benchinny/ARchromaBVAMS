%%210621 code to run fringe experiment input m output n
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
global black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
cf=[0.538 0.525; 0.538 0.525; 0.538 0.525]; %color
% rc00=[0 -8; 4 -7]; % updated april 20 2021, use this
%rc00=[4 -7; 8 -6]; % updated June 102021, by fitting circle+centering it,looking thru syste

m0=[];
%for k0=1:5; m0=[m0 randperm(8)]; end %[randi(8, 1, ni)];%choose orientation of edge 1UP2RIGHT3DOWN4LEFT5UP6RIGHT7DOWN8LEFT
ex='FRNGE'
% ey='L'; %eye L R B S
% ACL=0; %ACL attached=1 otherwise=0  %!!!NOTE!!! NEED TO SET VALUE OF ACL correctly for findz0 to work correctly!
% sn=10001; %subject  number 10001NNN 10004MSB 10003AJR 10007NHI 
load('S10003Right_TCA_ACL0_2107211557.mat','TCAp'); bxy0=TCAp.sysTCA; bxy1=TCAp.sbjTCA; %bxy0=zeros(3,2)
% load('S10007Right_TCA_ACL1_2106161328','VRCMp'); %NHI ACL1
%bxy1=zeros(3,2); bxy0=bxy1; 
%bxy0(2,:)=-1; bxy0(3,:)=1; bxy0=bxy0.*5; %testing
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[1 1];
%cf=[RB./RR LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=ones(3,2);
cf=[0.538 0.525; 0.538 0.525; 0.538 0.525];
[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0);

disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']);
KbWait([], 2);
% n0=FRNG0f(m0, bxy0, bxy1, window1, window2); sca;
if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p5_p17_o4_ms10_210621.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load
%           number_of_trial0s initial_optotype_size shift_between_Left&Right optotypes_presentation_time
[n0 n1]=FRNG4f([5 13 50 1], bxy0, bxy1, E10c, STK00, window1, window2); sca;
%bxy0=zeros(3,2); [n0 n1]=FRNG4f([1 13 50 1], bxy0, bxy1, E10c, STK00, window1, window2); sca;

VRCMprm; FRNGp=VRCMp;
save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'n0', 'n1', 'bxy0', 'bxy1', 'FRNGp');
%if sv==1; save(['data\S' num2str(sn) '_CSF_'  ey '_ACL' n2s(ACL) '_' tme], 'rsp', 'rsd', 'bxy0', 'bxy1'); end


%m0 rsd response direction 1UP2RIGHT3DOWN4LEFT5UP6RIGHT7DOWN8LEFT
%n0 rsp 1correct0wrong responses 








% %%210617 code to run fringe experiment input m output n
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% global black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% cf=[0.538 0.525; 0.538 0.525; 0.538 0.525]; %color
% % rc00=[0 -8; 4 -7]; % updated april 20 2021, use this
% rc00=[4 -7; 8 -6]; % updated June 102021, by fitting circle+centering it,looking thru syste
% 
% m0=[];
% %for k0=1:5; m0=[m0 randperm(8)]; end %[randi(8, 1, ni)];%choose orientation of edge 1UP2RIGHT3DOWN4LEFT5UP6RIGHT7DOWN8LEFT
% ex='FRNGE'
% % ey='L'; %eye L R B S
% % ACL=0; %ACL attached=1 otherwise=0  %!!!NOTE!!! NEED TO SET VALUE OF ACL correctly for findz0 to work correctly!
% % sn=10001; %subject  number 10001NNN 10004MSB 10003AJR 10007NHI 
% 
% %% set z0 based on trombone positon 
% %   load('S10004_LCA_LeftACL0_2104061444.mat', 'a18'); %LOAD LCA  MB
% load('S10003_LCA_RightACL0_2104301024.mat', 'a18'); %LOAD LCA AR April 30
% % load('S10007_LCA_RightACL0_2105261020.mat', 'a18');%Nadav LCA from May 26
% %load('S10005Right_LCA_ACL0_2106081156.mat', 'a18');% JIM#2009 LOAD LCA
% %z0=zeros(3,6);
% %load('S10003Right_TCA_ACL1_2106181307.mat', 'z1'); %LOAD TCA AR June 11
% %z1=z0; z1(2,:)=-1; z1(3,:)=1;
% %load('S10003Right_TCA_ACL0_2106111415_corrected.mat', 'z1'); %LOAD TCA AR June 11
% % load('S10004Left_TCA_ACL0_2106101231.mat', 'z10'); %LOAD TCA
% %load('S10003_TCA_RightACL0_2105211001', 'z1'); %LOAD TCA
% % load('S10003_TCA_RightACL1_2105211056.mat', 'z1'); %LOAD TCA
% %  load('S10004_TCA_LeftACL1_2105241249.mat','z1');
% %   load('S10007_TCA_RightACL0_2105271213.mat','z1');%nadav tca May 27 Rt
% %   load('S10007_TCA_RightACL1_2105271334.mat','z1');%nadav May 27 Rt acl=1
% %load('S10005Right_TCA_ACL1_2106081435_combined.mat','z1');%JIM#2009 LOAD TCA
% load('S10003Right_TCA_ACL1_2106181307.mat','z1');
% load('S10003Right_TCA_ACL1_2106181307.mat');
% 
% if ey(1)=='L'
% z0=fnz0(a18(5,1), ACL); bxy0=z0(:,1:2); bxy1=z1(:,1:2);%LEFT
% 
% elseif ey(1)=='R'
% z0=fnz0(a18(5,2), ACL); bxy0=z0(:,3:4); bxy1=z1(:,3:4);%RIGHT
% end
% 
% %check tca
% % z0=zeros(3,6); bxy0=z0(:,1:2);
% % z1=z0; z1(2,:)=1; z1(3,:)=1; z1=z1.*5; bxy1=z1(:,1:2);
% % 
% 
% 
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1];
% %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% % cf=ones(3,2);
% cf=[0.538 0.525; 0.538 0.525; 0.538 0.525];
% [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0);
% 
% disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']);
% KbWait([], 2);
% % n0=FRNG0f(m0, bxy0, bxy1, window1, window2); sca;
% if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load
% %           number_of_trial0s initial_optotype_size shift_between_Left&Right optotypes_presentation_time
% [n0 n1]=FRNG2f([2 13 50 3], bxy0, bxy1, E10c, STK00, window1, window2); sca;
% 
% VRCMprm;
% save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'n0', 'n1', 'bxy0', 'bxy1', 'VRCMp');
% %if sv==1; save(['data\S' num2str(sn) '_CSF_'  ey '_ACL' n2s(ACL) '_' tme], 'rsp', 'rsd', 'bxy0', 'bxy1'); end
% 
% 
% %m0 rsd response direction 1UP2RIGHT3DOWN4LEFT5UP6RIGHT7DOWN8LEFT
% %n0 rsp 1correct0wrong responses 
% 
