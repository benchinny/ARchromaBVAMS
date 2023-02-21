
        CNTp.dspl_pwr=[opto(name_map('l_disp')).control.getFocalPower.focal_power   opto(name_map('r_disp')).control.getFocalPower.focal_power];
        CNTp.near_pwr=[opto(name_map('l_t_near')).control.getFocalPower.focal_power opto(name_map('r_t_near')).control.getFocalPower.focal_power];
        CNTp.far_pwr=[opto(name_map('l_t_far')).control.getFocalPower.focal_power opto(name_map('r_t_far')).control.getFocalPower.focal_power];
        CNTp.trmb_pos=[zaber(name_map('l_trombone')).control.getposition zaber(name_map('l_trombone')).control.getposition];
