              %% generate optotype image with TCA correction

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz rc00
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
cls
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
 load('G:\My Drive\exp_bvams\code_repo\data\MB data\Nov 25 2020\S10004_TCA_Left_ACL1_2011251230.mat')
z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
bxy=z1;
ms=10; % downsampling factor
r1=4; % right standing E optotype
w1=7; % initial optotype size.

%% LCA param+s
p0=zeros(8,2);

% ACL=0 %or1
load('S10003_LCA_RightACL0_2103261450.mat', 'a18'); a18R=a18; %RIGHT LCA when ACL=0
load('S10003_LCA_LeftACL0_2103261603.mat', 'a18');  a18L=a18; %LEFT LCA when ACL=0

a18(:,2)=a18R(:,2);

p0=a18;

%TROMBONE POWERS
% p0(5,:)=[   8.619048  8.556850]; %far

%UPDATE DISPLAY POWER IF NEEDED
% p0(2,:)=a18(2,:);
p0(2,:)=[ 13.716667  a18(2,2)];    

p0(4,:)=[13.819067              opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
p0(8,:)=10; %number of repetitions  

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
 

sz = [1080, 1920];
zbr=1; %activate zebar/optotune 
% rc00=[0 0; 0 0];
rc00=[40 0; 4 -7];
%  cf=ones(3,2); %to show white background
cf=[0 0; 1 1;0 0]; %to show green bkg
i1=ones(sz);
%if exist(  'E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat'); end ; e0=E10c;%E optotype base 3
if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s4_p1_p13_o4_ms10_201130.mat');  end %E optotype base 4 17secs to load
e0=E10c;
disp(['OPTOTYPE 20/' n2s(20.*STK(w1)./c1)]);

screens = Screen('Screens');
screenNumber = max(screens);
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
         
        p1=LCAfcs(i4, i3, p0, window1, window2);  
         
         sca
         
         

 