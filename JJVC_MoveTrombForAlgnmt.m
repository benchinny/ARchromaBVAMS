powerL=8;%for alignment
powerR=8;%for alignment

%CHANGE LEFT TROMBONE
% powerL=a18(5,1);
            opto(name_map('l_t_near')).control.setFocalPower(powerL); %[6.8400 24.9500]
            opto(name_map('l_t_far')).control.setFocalPower(powerL); %[7.2400 27.2950]
            zaber(name_map('l_trombone')).move(l_trombone_f(powerL));%[8.619 13.8]
            zaber(name_map('l_trombone')).control.waitforidle();
            
            [opto(name_map('l_t_near')).control.getFocalPower.focal_power...
            opto(name_map('l_t_far')).control.getFocalPower.focal_power...
            zaber(name_map('l_trombone')).control.getposition]
        
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