%% set trombone and optotune to predetermined values
function  [powerL powerR]=opt00(p0,flag)


global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00

%% LCA params
%if set power_disp/optopower=0 randomize.
%  1power_dispL_min      power_dispR_min
power_dispL_min=p0(1,1); power_dispR_min=p0(1,2);
%  2power_dispL          power_dispR
power_dispL0=p0(2,1); power_dispR0=p0(2,2);
%  3power_dispL_max      power_dispL_max
power_dispL_max=p0(3,1); power_dispR_max=p0(3,2);
%  4L_optopower(mag)_min R_optopower(mag)_min
powerL_max=p0(4,1);   powerR_max=p0(4,2);
%  5L_optopower(mag)     R_optopower(mag)
powerL0=p0(5,1);   powerR0=p0(5,2);
%  6L_optopower(mag)_max R_optopower(mag)_max
powerL_min=p0(6,1);   powerR_min=p0(6,2);
%  7rot
rot=p0(7,1); %rotation


    cls_opt;
    addpath(genpath(fullfile('toolboxes')));
    %KbName('UnifyKeyNames');
    
    rndLCA; %use initial conditions or randomize optotune/trombone settings
    
    if flag==1
        fprintf('Limit Imposed\n');
        lmtLCA;
    elseif flag==0
         
    end
    save('data\LCATrombPwr', 'powerL','powerR');
    opn_opt; %open optotune&thrombone
    
        if enable_optotunes
            opto(name_map('l_disp')).control.setFocalPower(power_dispL);
            opto(name_map('l_t_near')).control.setFocalPower(powerL);
            opto(name_map('l_t_far')).control.setFocalPower(powerL);
            opto(name_map('r_disp')).control.setFocalPower(power_dispR);
            opto(name_map('r_t_near')).control.setFocalPower(powerR);
            opto(name_map('r_t_far')).control.setFocalPower(powerR);
            
%                     fprintf('Target powerL: %f\n', powerL);
%                     fprintf('Target powerR: %f\n', powerR);
        end
        
        if enable_trombones
            zaber(name_map('rotation')).move_deg(rot);
%             fprintf('Rotation: %f degrees\n', rot);
            
            zaber(name_map('l_trombone')).move(l_trombone_f(powerL));
            zaber(name_map('r_trombone')).move(r_trombone_f(powerR));
%             fprintf('Target powerL: %f\n', powerL);
%             fprintf('Target powerR: %f\n', powerR);
            
            zaber(name_map('rotation')).control.waitforidle();
            zaber(name_map('l_trombone')).control.waitforidle();
            zaber(name_map('r_trombone')).control.waitforidle();
        end
        
                            fprintf('\n');
                            fprintf('Display powerR: %f\n', power_dispR);
                            fprintf('Trombone powerR: %f\n', powerR);
                            fprintf('\n');
                            fprintf('Rotation: %f degrees\n', rot);
                            fprintf('Display powerL: %f\n', power_dispL);
                            fprintf('Trombone powerL: %f\n', powerL);
                            
                            l_trombone_target = l_trombone_f(powerL);
                            r_trombone_target = r_trombone_f(powerR);
                            fprintf('\n');
                            fprintf('Trombone Position(left): %u\n', l_trombone_target);
                            fprintf('Trombone Position (right): %u\n', r_trombone_target);
                              
                    if( l_trombone_target <0 ||  l_trombone_target ==0)
                        fprintf('Trying to access Negative zaber target postion for above value of Left optotune power\n');
                        powerL=13.819067;
                        fprintf('Setting Trombone power to %f\n',powerL);
                        l_trombone_target = l_trombone_f(powerL);
                        fprintf('Updated trombone (left) position: %u\n', l_trombone_target);
                    end
%                             
%                             fprintf('l_disp: %u\n', opto(name_map('l_disp')).control.getFocalPower(power_dispL));
%                             fprintf('l_t_near: %u\n', opto(name_map('l_t_near')).control.getFocalPower(powerL));
%                             fprintf('l_t_far: %u\n',  opto(name_map('l_t_far')).control.getFocalPower(powerL));
%                             
%                             fprintf('r_disp: %u\n', opto(name_map('r_disp')).control.getFocalPower(power_dispR));
%                             fprintf('r_t_near: %u\n', opto(name_map('r_t_near')).control.getFocalPower(powerR));
%                             fprintf('r_t_far: %u\n', opto(name_map('r_t_far')).control.getFocalPower(powerR));
                            
%                              fprintf('l_disp: %u\n', opto(name_map('l_disp')).control.getFocalPower());
%                             fprintf('l_t_near: %u\n', opto(name_map('l_t_near')).control.getFocalPower());
%                             fprintf('l_t_far: %u\n',  opto(name_map('l_t_far')).control.getFocalPower());
%                             
%                             fprintf('r_disp: %u\n', opto(name_map('r_disp')).control.getFocalPower());
%                             fprintf('r_t_near: %u\n', opto(name_map('r_t_near')).control.getFocalPower());
%                             fprintf('r_t_far: %u\n', opto(name_map('r_t_far')).control.getFocalPower());
                            
                            % % opto(name_map('l_disp')).control.setFocalPower(power_dispL);
% %                     opto(name_map('r_disp')).control.setFocalPower(power_dispR);

%                             fprintf('Trombone Position Target(left): %u\n', l_trombone_target);
%                             fprintf('Trombone Position Target(right): %u\n', r_trombone_target);
%                             
%                             fprintf('Trombone Position Actual(left): %u\n', zaber(name_map('l_trombone')).control.getposition);
%                             fprintf('Trombone Position Actual(right): %u\n', zaber(name_map('r_trombone')).control.getposition);
%                             
%                             fprintf('l_disp: %u\n', zaber(name_map('l_disp')).control.getposition);
%                             fprintf('r_disp: %u\n', zaber(name_map('r_disp')).control.getposition);
%                             
%                             fprintf('l_t_near: %u\n', zaber(name_map('l_t_near')).control.getposition);
%                             fprintf('r_t_near: %u\n', zaber(name_map('r_t_near')).control.getposition);
%                             
%                             fprintf('l_t_far: %u\n', zaber(name_map('l_t_far')).control.getposition);
%                             fprintf('r_t_far: %u\n', zaber(name_map('r_t_far')).control.getposition);
% %                     opto(name_map('l_disp')).control.setFocalPower(power_dispL);
% %                     opto(name_map('r_disp')).control.setFocalPower(power_dispR);
         
                            
                
        
%         
%                          pos_l = zaber(name_map('l_trombone')).control.getposition;
%                          pos_r = zaber(name_map('r_trombone')).control.getposition;
%                          power_int_l = l_opto_f(pos_l);
%                          power_int_r = r_opto_f(pos_r);
% %                             power_int_l = l_opto_f(pos_l);
% %                             power_int_r = r_opto_f(pos_r);
% 
%                          
%                          
%                          
%                         disp(['trmbL' n2s(pos_l)  ' trmbR' n2s(pos_r)];) 
%                         disp(['pwrL' n2s(power_int_l)  ' pwrRR' n2s(power_int_r)]);
%                         fprintf('Rotation: %f degrees\n', rot);
%         
% %         
% %         %% Control loop
% %         ListenChar(2);
% %         try
% %             %magR=mag; magL=mag;
% %             %power_dispR=power_disp; power_dispL=power_disp;
% %             %'left_shift'
% %             opt_chk=0;
% %             while opt_chk==0
% %                 [ keyIsDown, keyTime, keyCode ] = KbCheck;
% %                 if keyIsDown
% %                     %kbLCA; %take input from keyboard
% %                     lmtLCA; %check optotune and thrombone limits
% %                     
% %                     %fprintf('Initial MagnificationL: %f\n', magL);
% %                     %fprintf('Initial MagnificationR: %f\n', magR);
% %                     fprintf('Rotation: %f degrees\n', rot);
% %                     
% %                     opto(name_map('l_disp')).control.setFocalPower(power_dispL);
% %                     opto(name_map('r_disp')).control.setFocalPower(power_dispR);
% %                     fprintf('Target powerL: %f\n', powerL);
% %                     fprintf('Target powerR: %f\n', powerR);
% %                     
% %                     %powerL = mag_to_d(magL);
% %                     %powerR = mag_to_d(magR);
% %                     fprintf('Target powerL: %f\n', powerL);
% %                     fprintf('Target powerR: %f\n', powerR);
% %                     
% %                     l_trombone_target = l_trombone_f(powerL);
% %                     r_trombone_target = r_trombone_f(powerR);
% %                     %                 while( l_trombone_target <0 ||  l_trombone_target ==0)
% %                     %                     fprintf('Trying to access Negative zaber target postion for above value of Left optotune power');
% %                     %                     powerL=powerL-0.0001;
% %                     %                     fprintf('Setting powerL to %f\n',powerL);
% %                     %                     l_trombone_target = l_trombone_f(powerL);
% %                     %                 end
% %                     if( l_trombone_target <0 ||  l_trombone_target ==0)
% %                         fprintf('Trying to access Negative zaber target postion for above value of Left optotune power');
% %                         powerL=13.819067;
% %                         fprintf('Setting powerL to %f\n',powerL);
% %                         l_trombone_target = l_trombone_f(powerL);
% %                     end
% %                     fprintf('Target trombone (left): %u\n', l_trombone_target);
% %                     fprintf('Target trombone (right): %u\n', r_trombone_target);
% %                     
% %                     if enable_trombones && enable_optotunes
% %                         zaber(name_map('rotation')).move_deg(rot);
% %                         zaber(name_map('l_trombone')).move(l_trombone_target);
% %                         zaber(name_map('r_trombone')).move(r_trombone_target);
% %                         
% %                         pos_l = zaber(name_map('l_trombone')).control.getposition;
% %                         pos_r = zaber(name_map('r_trombone')).control.getposition;
% %                         while (pos_l ~= l_trombone_target) || (pos_r ~= r_trombone_target)
% %                             power_int_l = l_opto_f(pos_l);
% %                             power_int_r = r_opto_f(pos_r);
% %                             opto(name_map('l_t_near')).control.setFocalPower(power_int_l);
% %                             opto(name_map('l_t_far')).control.setFocalPower(power_int_l);
% %                             opto(name_map('r_t_near')).control.setFocalPower(power_int_r);
% %                             opto(name_map('r_t_far')).control.setFocalPower(power_int_r);
% %                             % fprintf('L (pos, opto): %u, %f\n', pos_l, power_int_l);
% %                             % fprintf('R (pos, opto): %u, %f\n', pos_r, power_int_r);
% %                             
% %                             pos_l = zaber(name_map('l_trombone')).control.getposition;
% %                             pos_r = zaber(name_map('r_trombone')).control.getposition;
% %                         end
% %                         zaber(name_map('rotation')).control.waitforidle();
% %                         zaber(name_map('l_trombone')).control.waitforidle();
% %                         zaber(name_map('r_trombone')).control.waitforidle();
% %                     elseif enable_trombones
% %                         % Only trombones are enabled
% %                         zaber(name_map('rotation')).move_deg(rot);
% %                         zaber(name_map('l_trombone')).move(l_trombone_target);
% %                         zaber(name_map('r_trombone')).move(l_trombone_target);
% %                         zaber(name_map('rotation')).control.waitforidle();
% %                         zaber(name_map('l_trombone')).control.waitforidle();
% %                         zaber(name_map('r_trombone')).control.waitforidle();
% %                     elseif enable_optotunes
% %                         % Only optotunes are enabled
% %                         opto(name_map('l_t_near')).control.setFocalPower(powerL);
% %                         opto(name_map('l_t_far')).control.setFocalPower(powerL);
% %                         opto(name_map('r_t_near')).control.setFocalPower(powerR);
% %                         opto(name_map('r_t_far')).control.setFocalPower(powerR);
% %                     end
% %                     fprintf('\n');
% %                 end
% %                 
% % 
% %             end
% %             
% % 
% %             
% %             
% % 
% %     end
% % end