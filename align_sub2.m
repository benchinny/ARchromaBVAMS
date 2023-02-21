%Select Left file
% load('S10004_LCA_LeftACL0_2104061444.mat', 'a18');%Marty's Left eye LCA dat from April 6
% load('S10003_LCA_LeftACL0_2104301034.mat', 'a18');%AR Austin's Left eye data from April 30
% load('S10007_LCA_LeftACL0_2104261613.mat', 'a18');
load('S10007_LCA_LeftACL0_2105261047.mat', 'a18');
%Initialize powers
power_dispL=a18(2,1)
powerL=a18(5,1)
deg=-3; 
trombone_power_left=powerL;

%Select Right file
% load('S10004_LCA_RightACL0_2105191352.mat', 'a18');%Marty's Rt eye May19
% load('S10003_LCA_RightACL0_2104301024.mat', 'a18'); %AR Austin's Right eye data from April 30
% load('S10007_LCA_RightACL0_2104201412.mat', 'a18');
load('S10007_LCA_RightACL0_2105261020.mat', 'a18');
%Initialize powers
power_dispR=a18(2,2) 
powerR=a18(5,2)
trombone_power_right=powerR;

%CHANGE DISPLAY OPTOTUNE LEFT
% power_dispL=a18(2,1);   %[7.1000 28.3450]               
opto(name_map('l_disp')).control.setFocalPower(power_dispL);
opto(name_map('l_disp')).control.getFocalPower.focal_power
                   
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
        
