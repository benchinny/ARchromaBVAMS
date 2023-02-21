%%210604 VRCMprm save varichrome parameters into struct

        if ey(1)=='R'
        TCAp.dspl_pwr=opto(name_map('r_disp')).control.getFocalPower.focal_power;
        TCAp.near_pwr=opto(name_map('r_t_near')).control.getFocalPower.focal_power;
        TCAp.far_pwr=opto(name_map('r_t_far')).control.getFocalPower.focal_power;
        TCAp.trmb_pos=zaber(name_map('r_trombone')).control.getposition;
        elseif ey(1)=='L'
        TCAp.dspl_pwr=opto(name_map('l_disp')).control.getFocalPower.focal_power;
        TCAp.near_pwr=opto(name_map('l_t_near')).control.getFocalPower.focal_power;
        TCAp.far_pwr=opto(name_map('l_t_far')).control.getFocalPower.focal_power;
        TCAp.trmb_pos=zaber(name_map('l_trombone')).control.getposition;
        else
        TCAp.dspl_pwr=[opto(name_map('l_disp')).control.getFocalPower.focal_power   opto(name_map('r_disp')).control.getFocalPower.focal_power];
        TCAp.near_pwr=[opto(name_map('l_t_near')).control.getFocalPower.focal_power opto(name_map('r_t_near')).control.getFocalPower.focal_power];
        TCAp.far_pwr=[opto(name_map('l_t_far')).control.getFocalPower.focal_power opto(name_map('r_t_far')).control.getFocalPower.focal_power];
        TCAp.trmb_pos=[zaber(name_map('l_trombone')).control.getposition zaber(name_map('l_trombone')).control.getposition];
        end
        
        
%                 if ey(1)=='R'
%         dspl_pwr=opto(name_map('r_disp')).control.getFocalPower.focal_power;
%         trmb_pwr=opto(name_map('r_t_near')).control.getFocalPower.focal_power;
%         zaber(name_map('l_trombone')).control.getposition
%         elseif ey(1)=='L'
%         dspl_pwr=opto(name_map('l_disp')).control.getFocalPower.focal_power;
%         trmb_pwr=opto(name_map('l_t_near')).control.getFocalPower.focal_power;
%         else
%         dspl_pwr=[opto(name_map('l_disp')).control.getFocalPower.focal_power   opto(name_map('r_disp')).control.getFocalPower.focal_power];
%         trmb_pwr=[opto(name_map('l_t_near')).control.getFocalPower.focal_power opto(name_map('r_t_near')).control.getFocalPower.focal_power];
%         end