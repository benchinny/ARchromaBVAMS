                       %% generate optotype image with TCA correction

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
cls
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
%  load('G:\My Drive\exp_bvams\code_repo\data\MB data\Nov 25 2020\S10004_TCA_Left_ACL1_2011251230.mat')
% z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
z1=[0 0 0 0;   0 0 0 0; 0 0 0 0]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
% imshow(E10c{9,1,1,1})
bxy=z1; 
ms=10; % downsampling factor
r1=4; % right standing E optotype
w1=13; % initial optotype size.
 
%        cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected/purple background
      cf=[0 0;  0.605 0.583;  0 0  ]; %green
%         cf=[0.538 0.525; 0.538 0.525  ; 0.538 0.525]; %white
 
%% LCA params
p0=zeros(8,2);
%updating display pow   er as per sharpness values
%        LEFT        RIGHT
p0(2,:)=[11.2718   12.8019]; %mb
% p0(2,:)=[ 11.28   12.3500];%nadav
% p0(2,:)=[  12.133300  12.133300];  %display power mb UPDATE
% p0(2,:)=[   12.166700   12.0667];%DISPLAY 11.8667
%    p0(2,:)=[12.3717            13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
%  p0(2,:)=[15.57        11.1717   ];
% p0(2,:)=[11.2718   14.2958 ]; %ar right14.3958\p0(2,:)=[14.3167  13.1000 ]; %ar right14.3958
%   p0(2,:)=[14.4167  14.3838 ]; %ar right14.3958
% 
% p0(5,:)=[8.9973 8.5568]; %AR used on April 30 %AR march -aprl 2021
% p0(2,:)=[13.5167  14.3838 ]; %AR used on April 30 %ar right

% p0(2,:)=[12.071700     13.9]; 
% p0(2,:)=[11.9667   11.9667]; %mb
% p0(2,:)=[11.9667  13.9];
%update trombone powers as needed
%        LEFT     RIGHT
% p0(5,:)=[10.4513   10.5555];%nadav apr 20
%     p0(5,:)=[opL(1)  opR(1) ];
  p0(5,:)=[10.9687   10.9687]; % mb TROMBONE!! april 2021

%   p0(5,:)=[10.9687   9.1616]; % mb TROMBONE!! april 2021
%    p0(5,:)=[10.9687    opR(1)]; % mb TROMBONE!! april 2021
% p0(5,:)=[opL(1.2)   opR(1.2)];%[ 11.3200 11.0020]
% p0(5,:)=[9.8896    9.8375]; %mb
% p0(5,:)=[9.3665   9.2388]; % setting it ot the limit AR
% p0(5,:)=[8.8752    8.7925]; %AR march 2021
% p0(5,:)=[opL(1)    9.1616]; %TROMBONE AR april 16 2021
% p0(5,:)=[8.619048  8.556850]; %far
% p0(5,:)=[10.7858   10.5219];
p0(1,:)=[9                   9];               %power_dispL_min      power_dispR_min
% p0(2,:)=[12.2717     13.40192]; %power_dispL11.27175          power_dispR 12.80192  
p0(3,:)=[17                  17];              %power_dispL_max      power_dispL_max                   
p0(4,:)=[13.819067              opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[8.7838            8.9288];          %L_optopower(mag)     R_optopower(mag)     
p0(6,:)=[opL(1.3)             opR(1.3)];        %L_optopower(mag)_max R_optopower(mag)_ma   x
p0(7,:)=-3; %rotation
p0(8,:)=10; %number of repetitions  
% p0(2,:)=[ 12.2717     13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
% p0(5,:)=[9.8896    9.8375];
% p0(2,:)=[14.379142    14.379142]; %AR 
% p0(5,:)=[9.406237    9.406237];
% p0(2,:)=[13.719038   14.266333]; %AR 14.6663 17 dec
% p0(5,:)=[8.619048       8.687687];
% p0(2,:)=[11.2718   12.8019]; %mb
% p0(5,:)=[10.9   10.9  ]; %dec18
% p0(2,:)=[11.2718   14.295751]; %ar
% p0(5,:)=[10.9   11.0164  ]; %dec228.556850
% p0(5,:)=[8.619048 8.687687] ;%for moving trombone to far for changing ACL
% p0=p4; run after loading LCA file
% p0(5,:)=[opL(1.4) opR(1.4)]   
trombone_power_left=p0(5,1);
trombone_power_right=p0(5,2);
fprintf('Display LEFT %0.7f \n',p0(2,1));
fprintf('Trombone LEFT %0.7f \n',trombone_power_left);
fprintf('\nDisplay RIGHT %0.7f\n',p0(2,2));
fprintf('Trombone RIGHT %0.7f\n',trombone_power_right);
fprintf('\n');
%output final reticle position
[PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);     
         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
 
    % for v=1:10
    %     cls_opt;
    % end
sz = [1080, 1920];
zbr=1; %activate zebar/optotune 
%  rc00=[0 0; 0 0];
% rc00=[40 0; 4 -7];
rc00=[0 -8; 4 -7]; % updated april 20 2021, use this
%  [right_Y right_X; left_Y Left_X]
%   cf=ones(3,2); %to show white background
%cf=[0 0;  0.583 0.583;  0 0]    ; %to show green bkg

i1=ones(sz);
%if exist(  'E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat'); end ; e0=E10c;%E optotype base 3
%if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s4_p1_p13_o4_ms10_201130.mat');  end %E optotype base 4 17secs to load
%if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load
%ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0); 

ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0); 

e0=E10c;
clear E10c
disp(['OPTOTYPE 20/' n2s(20.*STK(w1)./c1)]);

screens = Screen('Screens');
screenNumber = max(screens);

%       


% cf=[0 0;  0.583 0.583;  0 0]; %green Left side, luminance adjusted on Aptil 11, 21 to equalize with purple and white
[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, 'ETM'); %add background parameter!


[j4 j3 j2 j1 j0]=d4i(bxy, ms); % number to integer and decimal
%  
     %r1=round(3.*rand)+1; %orientation 1U 2L 3D 4R
     %if r1==1; r2=KbName('DownArrow'); elseif r1==2; r2=KbName('LeftArrow'); elseif r1==3; r2=KbName('UpArrow'); elseif r1==4; r2=KbName('RightArrow'); end
     %ir=embd(e0{w1, r1, 1, 1},i1); %red primer
     
     ir2= embd(circshift(e0{w1, r1, j3(1,1), j3(1,2)}    ,[j1(1,1)-j4(1,1) j1(1,2)-j4(1,2)] ),i1); %window2 LFT screen RED
     ir1= embd(circshift(e0{w1, r1, j3(1,3), j3(1,4)}    ,[j1(1,3)-j4(1,3) j1(1,4)-j4(1,4)] ),i1); %window1 RGT screen RED

     ig2= embd(circshift(e0{w1, r1, j3(2,1), j3(2,2)}    ,[j1(2,1)-j4(2,1) j1(2,2)-j4(2,2)] ),i1); %window2 LFT screen GREEN
     ig1= embd(circshift(e0{w1, r1, j3(2,3), j3(2,4)}    ,[j1(2,3)-j4(2,3) j1(2,4)-j4(2,4)] ),i1); %window1 RGT screen GREEN

     ib2= embd(circshift(e0{w1, r1, j3(3,1), j3(3,2)}    ,[j1(3,1)-j4(3,1) j1(3,2)-j4(3,2)] ),i1); %window2 LFT screen BLUE
     ib1= embd(circshift(e0{w1, r1, j3(3,3), j3(3,4)}    ,[j1(3,3)-j4(3,3) j1(3,4)-j4(3,4)] ),i1); %window1 RGT screen BLUE

         i3=ct8(ir1, ig1, ib1); %shift TCA right screen
         i4=ct8(ir2, ig2, ib2); %shift TCA left screen
         
%         p1=LCAfcs(i4, i3, p0, window1, window2);  
        p1=LCAfcs0(i4, i3, p0, window1, window2);  
         
         sca
         
         

 