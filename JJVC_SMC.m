%210713 Start modify change BVAMS ACL
global ek uk dk lk rk st snt  black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto ey cntrst
% edit JJVC_stro
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); addpath([pwd '\data\System TCA\Data Processing']);  addpath(genpath(fullfile('toolboxes')));
cls
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
c0=0.00384; %deg/pixels
%display =10 degrees
%FOV= 5 degrees

%BVAMS_gui; %run input gui
ey='Right'; %eye Right Left Binocular
%ey='Left'; %eye Right Left Binocular
% magn=0.8;
magn=1;
ACL=1; %ACL attached=1 otherwise=0  %!!!NOTE!!! NEED TO SET VALUE OF ACL correctly for findz0 to work correctly!
sn=10003; %subject  number 10003AJR 10004MSB 10005JOL 10007NHI

%Select Left file
load('S10004_LCA_LeftACL0_2104061444.mat', 'a18');%Marty's Left eye LCA dat from April 6
% load('S10003_LCA_LeftACL0_2104301034.mat', 'a18');%AR Austin's Left eye data from April 30
% % % % load('S10007_LCA_LeftACL0_2104261613.mat', 'a18'); 
%load('S10007_LCA_LeftACL0_2105261047.mat', 'a18');% Nadav's Left eye data May 26
%Initialize powers
power_dispL=a18(2,1); powerL=a18(5,1); trombone_power_left=powerL;

%Select Right file
load('S10004_LCA_RightACL0_2105191352.mat', 'a18');%Marty's Rt eye May19
% load('S10003_LCA_RightACL0_2104301024.mat', 'a18'); %AR Austin's Right eye data from April 30
% load('S10007_LCA_RightACL0_2104201412.mat', 'a18'); %Jim data
% load('S10007_LCA_RightACL0_2105261020.mat', 'a18');% Nadav's Rt eye data May 26
% load('S10007Right_LCA_ACL0_2106161205.mat', 'a18');% Nadav's Rt eye data June 16
%load('S10007Right_LCA_ACL0_2107081210.mat', 'a18');% Nadav's Rt eye data July 8
%Initialize powers
power_dispR=a18(2,2); powerR=a18(5,2); trombone_power_right=powerR;
deg=-3; 


if sn==0; sv=0; else sv=1; end%set saving data to null if subject number =0
zbr=1; %activate zebar/optotune

rc00=[4 -7; 8 -6]; % updated June 210610, by fitting circle+centering it,looking thru system 210610
%  [right_Y right_X; left_Y Left_X]

sz = [1080, 1920]; % size of screen
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[RB./RR LB./LR];
cf=ones(3,2);
%cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
% cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% background LATEST JAN 7
try;     
%     for k0=1:6; disp(opto(k0).control.focal_power); end
    for k0=1:6; disp(opto(k0).control.getFocalPower); end
    for k0=1:3; disp(zaber(k0).control.getposition); end
catch ERROR;
    for k0=1:3
        cls_opt; pause(3);
        
    end
    
    OPNT;
end
%%run up to here to START/OPEN the system
%move trombone to change position
power0=8;
zaber(name_map('l_trombone')).move(l_trombone_f(power0));%[8.619 13.8]
            zaber(name_map('l_trombone')).control.waitforidle();
zaber(name_map('r_trombone')).move(r_trombone_f(power0)); %[7 20]
            zaber(name_map('r_trombone')).control.waitforidle();

            KbWait([], 2); %wait for key press



%CHANGE LEFT TROMBONE
% powerL=a18(5,1);
            opto(name_map('l_t_near')).control.setFocalPower(powerL); %[6.8400 24.9500]
            opto(name_map('l_t_far')).control.setFocalPower(powerL); %[7.2400 27.2950]
            zaber(name_map('l_trombone')).move(l_trombone_f(powerL));%[8.619 13.8]
            zaber(name_map('l_trombone')).control.waitforidle();
            
            [opto(name_map('l_t_near')).control.getFocalPower.focal_power...
            opto(name_map('l_t_far')).control.getFocalPower.focal_power...
            zaber(name_map('l_trombone')).control.getposition]

%ROTATION LEFT
% deg=-3;            
zaber(name_map('rotation')).move_deg(deg); %%-6400            
zaber(name_map('rotation')).control.getposition  

%LEFT RETICLE
% trombone_power_left=powerL;

fprintf('Display LEFT %0.7f \n',power_dispL);
fprintf('Trombone LEFT %0.7f \n',trombone_power_left);
fprintf('\n');
%output final reticle position
[PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CHANGE DISPLAY OPTOTUNE RIGHT
% power_dispR=a18(2,2) ; %[6.9100 28.0750]
opto(name_map('r_disp')).control.setFocalPower(power_dispR);
opto(name_map('r_disp')).control.getFocalPower.focal_power
        
%CHANGE RIGHT TROMBONE
% powerR=a18(5,2); % opR(1);
% powerR=opR(1);
            opto(name_map('r_t_near')).control.setFocalPower(powerR); %[6.8550 25.2250]
            opto(name_map('r_t_far')).control.setFocalPower(powerR); %[7.2400 27.2950]
            zaber(name_map('r_trombone')).move(r_trombone_f(powerR)); %[7 20]
            zaber(name_map('r_trombone')).control.waitforidle();
            
            
            [opto(name_map('r_t_near')).control.getFocalPower.focal_power...
            opto(name_map('r_t_far')).control.getFocalPower.focal_power...
            zaber(name_map('r_trombone')).control.getposition]
        
                  
%RIGHT RETICLE
% trombone_power_right=powerR;
fprintf('\nDisplay RIGHT %0.7f\n',power_dispR);
fprintf('Trombone RIGHT %0.7f\n',trombone_power_right);
fprintf('\n');
%output final reticle position
[PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);    


