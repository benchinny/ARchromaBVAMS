%CHECK IF OPTOTUNES ARE OPEN
for k=1:6; disp(opto(6).control.modeFocalPower()); end

%CHECK IF ZABER&ROTATION ARE OPEN
[zaber(name_map('l_trombone')).control.getposition...
zaber(name_map('r_trombone')).control.getposition...
zaber(name_map('rotation')).control.getposition]


%OPEN VARICHROME

global zbr cf rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto
for k=1:3; cls_opt; pause(2); end
addpath(genpath(fullfile('toolboxes')));
OPNT

%CHANGE DISPLAY OPTOTUNE LEFT
power_dispL=8   %[7.1000 28.3450]               
opto(name_map('l_disp')).control.setFocalPower(power_dispL);
opto(name_map('l_disp')).control.getFocalPower
                   
                   
%CHANGE DISPLAY OPTOTUNE RIGHT
power_dispR=10; %[6.9100 28.0750]
opto(name_map('r_disp')).control.setFocalPower(power_dispR);
opto(name_map('r_disp')).control.getFocalPower

%CHANGE LEFT TROMBONE
powerL=8;
            opto(name_map('l_t_near')).control.setFocalPower(powerL); %[6.8400 24.9500]
            opto(name_map('l_t_far')).control.setFocalPower(powerL); %[7.2400 27.2950]
            zaber(name_map('l_trombone')).move(l_trombone_f(powerL));%[8.619 13.8]
            zaber(name_map('l_trombone')).control.waitforidle();
            
            [opto(name_map('l_t_near')).control.getFocalPower.focal_power...
            opto(name_map('l_t_far')).control.getFocalPower.focal_power...
            zaber(name_map('l_trombone')).control.getposition]

        
        
%CHANGE RIGHT TROMBONE
powerR=10;
            opto(name_map('r_t_near')).control.setFocalPower(powerR); %[6.8550 25.2250]
            opto(name_map('r_t_far')).control.setFocalPower(powerR); %[7.2400 27.2950]
            zaber(name_map('r_trombone')).move(r_trombone_f(powerR)); %[7 20]
            zaber(name_map('r_trombone')).control.waitforidle();
            
            
            [opto(name_map('r_t_near')).control.getFocalPower.focal_power...
            opto(name_map('r_t_far')).control.getFocalPower.focal_power...
            zaber(name_map('r_trombone')).control.getposition]
        
        
%ROTATION
deg=-3;            
zaber(name_map('rotation')).move_deg(deg); %%6400            
zaber(name_map('rotation')).control.getposition            
