powerL=opL(1);
powerR=opR(1);
deg=-3;
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
        
        trombone_power_left=powerL; trombone_power_right=powerR;
        [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
             fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY); 