function [p4,flag]=set_opt_LeftEye(p0, p2,magn)

% cls;
global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00

p4=p0;

% %% LCA params
% p4=zeros(8,1);
% %if set power_disp/optopower=0 randomize.
% p4(1,1)=8;                     %    power_dispR_min
% p4(2,1)=1000./75+1/0.789; % initial power_dispR  , we will update this using subject's defcous values for green 
% p4(3,1)=25;              %power_dispR_max                   
% p4(4,1)=opL(0.8);        %R_optopower(mag)_min 14.2737D         
% p4(5,1)=opL(1);          %R_optopower(mag)  11.3200D  , we will update this    
% p4(6,1)=opL(1.2);        %R_optopower(mag)_max 9.3665D
% p4(7,1)=0;               %rotation


avg_pow_red_left=p2(1,1);
avg_pow_green_left=p2(2,1);
avg_pow_blue_left=p2(3,1);

fprintf('Magnification setting during focus measurment %.2f \n',magn);
fprintf('\n');
fprintf('Avg Display optoune power for Red Focus %.4f \n', avg_pow_red_left)
fprintf('Avg Display optoune power for Green Focus  %.4f \n',avg_pow_green_left)
fprintf('Avg Display optoune power for Blue Focus  %.4f \n', avg_pow_blue_left)
fprintf('\n');

%Compute the LCA of the system+eye between the primaries using the defocus
%measurments for the subject (when there is NO ACL)
LCA_sys_Eye_RB_left=avg_pow_red_left-avg_pow_blue_left;
LCA_sys_Eye_GB_left=avg_pow_green_left-avg_pow_blue_left;
LCA_sys_Eye_RG_left=avg_pow_red_left-avg_pow_green_left;

fprintf('LCA_system+eye_RB  %.4f \n', LCA_sys_Eye_RB_left)
fprintf('LCA_system+eye_GB  %.4f \n', LCA_sys_Eye_GB_left)
fprintf('LCA_system+eye_RG  %.4f \n', LCA_sys_Eye_RG_left)
fprintf('\n');
% 
%Compute the LCA of the system with no ACL in place
%note: important to use m=1 during subject's defocus adjustment
%We will use same value of mag to compute system LCA 
LCA_sys_RB=0.2174*magn+0.0818;
LCA_sys_GB=0.1231*magn+0.0297;
LCA_sys_RG=0.0943*magn+0.0521;

fprintf('LCA_system_RB  %.4f \n', LCA_sys_RB)
fprintf('LCA_system_GB  %.4f \n', LCA_sys_GB)
fprintf('LCA_system_RG  %.4f \n', LCA_sys_RG)
fprintf('\n');
% 
% 
%Compute the LCA of the eye by subtracting LCA of the systen
LCA_lefteye_RB=(LCA_sys_Eye_RB_left)-(LCA_sys_RB);
LCA_lefteye_GB=(LCA_sys_Eye_GB_left)-(LCA_sys_GB);
LCA_lefteye_RG=(LCA_sys_Eye_RG_left)-(LCA_sys_RG);
% 
fprintf('LCA_lefteye_RB  %.4f \n', LCA_lefteye_RB)
fprintf('LCA_lefteye_GB  %.4f \n',LCA_lefteye_GB)
fprintf('LCA_lefteye_RG  %.4f \n', LCA_lefteye_RG)
% To correct the LCA of the eye, put the ACL in place and adjust the trombone according to the equations on figure 6
trom_opto_pwr_rb_L=9.2813*((LCA_lefteye_RB)^(-0.403));
trom_opto_pwr_gb_L=7.1652*((LCA_lefteye_GB)^(-0.414));
trom_opto_pwr_rg_L=6.8831*((LCA_lefteye_RG)^(-0.39));
fprintf('\n');

%% find and set trombone optotune power
tromb_powersL=[trom_opto_pwr_rb_L trom_opto_pwr_gb_L trom_opto_pwr_rg_L];
mean_trombone_power_left=mean(tromb_powersL);
fprintf('Left Trombone optotune powers  %.4f  %.4f  %.4f \n', trom_opto_pwr_rb_L ,trom_opto_pwr_gb_L ,trom_opto_pwr_rg_L)
fprintf('Averaged Left Trombone optotune power %.4f \n', mean_trombone_power_left)
p4(5,1)=mean_trombone_power_left; %L_optopower , use the equation to set trombone power
fprintf('\n');

% %set displays to green focus power 
p4(2,1)=avg_pow_green_left; %Green_power_dispL
fprintf('Display optotune power %.4f \n',avg_pow_green_left);
fprintf('\n');
fprintf('updated 2nd and 5th rows of left side matrix \n');

flag=0;

if(mean_trombone_power_left>=opL(1.3) && mean_trombone_power_left<=opL(0.8))
    fprintf('Mean trombone power is within the limits of 0.8 and 1.3\n');
         if mean_trombone_power_left>13.819
            fprintf('\n');
            fprintf('But Mean trombone power is >13.819D, Zaber will go to negative values');
         fprintf( 'Setting mean power to 13.819067 and updating it in matrix\n');
           p4(5,1)=13.819067;
            
         end
else
    fprintf('!!!!!!!!!!CAUTION: Mean trombone power  is OUTSIDE the limits!!!!!!!!!!\n');
    flag=1; %set limit of 1.3 now 
    %note i changed the limit value to 1.3 in jjvc_scrpt p0(6,:)=[opL(1.3) opR(1.3)];   
     %when flag is 1, the limitLCA function will be called in opt0 and will
     %limit the power to min or max value depending on its value
end


% if(mean_trombone_power_left>=opL(1.2) && mean_trombone_power_left<=opL(0.8))
%     fprintf('Mean trombone power is within the limits of 0.8 and 1.2\n');
%          if mean_trombone_power_left>13.819
%             fprintf('\n');
%             fprintf(' Mean trombone power is >13.819D, Zaber will go to neagative values');
%          end
% elseif mean_trombone_power_left<opL(1.2) && mean_trombone_power_left>opL(1.3)
%     fprintf('!!!!!!!!!!CAUTION: Mean trombone power  is OUTSIDE the limits!!!!!!!!!!\n');
%     fprintf('Mag is higher than 1.2,BUT Less than 1.3 (beam size is still less than 5.2 at ACL');
% else
%     fprintf('!!!!!!!!!!CAUTION: Mean trombone power  is FULLY OUTSIDE the limits of 0.8 and 1.3!!!!!!!!!!\n');
%     fprintf('!!!!!!!!!!BEAM SIZE HAS EXCEEDED 5.2 mm !!!!!!!!!!\n');
%     flag=1; %set limit of 1.3 now 
%     %note i changed the limit value to 1.3 in jjvc_scrpt p0(6,:)=[opL(1.3) opR(1.3)];   
%      %when flag is 1, the limitLCA function will be called in opt0 and will
%      %limit the power to min or max value depending on its value
% end




    
% opt0(p4);




%marty settings nov 23rd
% p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% p0(2,:)=[12.01951667     13.43585]; %power_dispL          power_dispR   
% p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[9.156588449              8.757208676];          %L_optopower(mag)     R_optopower(mag)     
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation

% % marty settings nov 24th
% p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% p0(2,:)=[12.2717     13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
% p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[8.7837              8.9288];          %L_optopower(mag)     R_optopower(mag)     
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation




% % 
% % cls;
% % global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% % 
% % c1=2; %-1min, 0random, 1max, 2given values mag use 1 for 
% % 
% % %% LCA params
% % p0=zeros(8,2);
% % %if set power_disp/optopower=0 randomize.
% % p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% % p0(2,:)=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR   
% % p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% % p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% % p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)     
% % p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% % p0(7,:)=-3; %rotation
% %   
% % %marty settings nov 23rd
% % % p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% % % p0(2,:)=[12.01951667     13.43585]; %power_dispL          power_dispR   
% % % p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% % % p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% % % p0(5,:)=[9.156588449              8.757208676];          %L_optopower(mag)     R_optopower(mag)     
% % % p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% % % p0(7,:)=-3; %rotation
% % 
% % if c1==-1;
% %     p0(2,:)=p0(1,:);
% %     p0(5,:)=p0(4,:);
% % elseif c1==0
% %     p0(2,:)=0;
% %     p0(5,:)=0;
% % elseif c1==1;
% %     p0(2,:)=p0(3,:);
% %     p0(5,:)=p0(6,:);
% % elseif c1==2;
% %     %note: p1 comes from doing LCA task and p2 takes average of p1 values
% %     p1(k0,:)=[power_dispL power_dispR powerL powerR rot];
% %     p2=mean(p1,1);
% %     p0(2,:)=p2(1:2);
% %     p0(5,:)=p2(3:4);
% %     p0(7,:)=p2(end);
% %    
% % end
% %     
% % opt0(p0);

