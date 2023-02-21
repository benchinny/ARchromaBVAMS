        if ey(1)=='R'
        ETMp.dspl_pwr=opto(name_map('r_disp')).control.getFocalPower.focal_power;
        ETMp.near_pwr=opto(name_map('r_t_near')).control.getFocalPower.focal_power;
        ETMp.far_pwr=opto(name_map('r_t_far')).control.getFocalPower.focal_power;
        ETMp.trmb_pos=zaber(name_map('r_trombone')).control.getposition;
        elseif ey(1)=='L'
        ETMp.dspl_pwr=opto(name_map('l_disp')).control.getFocalPower.focal_power;
        ETMp.near_pwr=opto(name_map('l_t_near')).control.getFocalPower.focal_power;
        ETMp.far_pwr=opto(name_map('l_t_far')).control.getFocalPower.focal_power;
        ETMp.trmb_pos=zaber(name_map('l_trombone')).control.getposition;
        else
        ETMp.dspl_pwr=[opto(name_map('l_disp')).control.getFocalPower.focal_power   opto(name_map('r_disp')).control.getFocalPower.focal_power];
        ETMp.near_pwr=[opto(name_map('l_t_near')).control.getFocalPower.focal_power opto(name_map('r_t_near')).control.getFocalPower.focal_power];
        ETMp.far_pwr=[opto(name_map('l_t_far')).control.getFocalPower.focal_power opto(name_map('r_t_far')).control.getFocalPower.focal_power];
        ETMp.trmb_pos=[zaber(name_map('l_trombone')).control.getposition zaber(name_map('l_trombone')).control.getposition];
        end