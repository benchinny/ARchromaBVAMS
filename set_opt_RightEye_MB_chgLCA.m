% function p3=set_opt_RightEye(p0, p2,magn)
% cls;
global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00



%% LCA params
LCAcorrR=1;
p3=zeros(8,1);
magn=0.8;
% p3=zeros(8,2);
% %if set power_disp/optopower=0 randomize.
% p3(1,:)=[9                    9];               %power_dispL_min      power_dispR_min
% p3(2,:)=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR   
% p3(3,:)=[17                   17];              %power_dispL_max      power_dispL_max                   
% p3(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p3(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)     
% p3(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p3(7,:)=-3; %rotation
% fprintf('p3 initial \n');
% p3

%if set power_disp/optopower=0 randomize.
p3(1,1)=9;                     %    power_dispR_min
p3(2,1)=0; % initial power_dispR  , we will update this using subject's defcous values for green 
p3(3,1)=17;              %power_dispR_max                   
p3(4,1)=opR(0.8);        %R_optopower(mag)_min 14.2737D         
p3(5,1)=opR(magn);          %R_optopower(mag)  11.3200D  , we will update this    
p3(6,1)=opR(1.3);        %R_optopower(mag)_max 9.3665D
p3(7,1)=-3;               %rotation

% p3=p0;


% R	G	B
% 13.40062	12.80192	12.30863
% MARTY avg of 10 trials
% avg_pow_red_right=13.40062;
% avg_pow_green_right=12.80192;
% avg_pow_blue_right=12.30863;

%AR values Dec 17 2020
% avg_pow_red_right=14.8101;
% avg_pow_green_right=  14.2663;
% avg_pow_blue_right=13.3614;

%AR values Dec 22 2020
avg_pow_red_right=14.9011;
avg_pow_green_right=  14.2958;
avg_pow_blue_right=13.4094;
% 
fprintf('Magnification setting during focus measurment %.2f \n',magn);
fprintf('\n');
fprintf('Avg Display optoune power for Red Focus %.4f \n', avg_pow_red_right)
fprintf('Avg Display optoune power for Green Focus  %.4f \n',avg_pow_green_right)
fprintf('Avg Display optoune power for Blue Focus  %.4f \n', avg_pow_blue_right)
fprintf('\n');
% 
% %Compute the LCA of the system+eye between the primaries using the defocus
% %measurments for the subject (when there is NO ACL)
LCA_sys_Eye_RB_right=avg_pow_red_right-avg_pow_blue_right;
LCA_sys_Eye_GB_right=avg_pow_green_right-avg_pow_blue_right;
LCA_sys_Eye_RG_right=avg_pow_red_right-avg_pow_green_right;

fprintf('LCA_system+eye_RB  %.4f \n', LCA_sys_Eye_RB_right)
fprintf('LCA_system+eye_GB  %.4f \n', LCA_sys_Eye_GB_right)
fprintf('LCA_system+eye_RG  %.4f \n', LCA_sys_Eye_RG_right)
fprintf('\n');
% % 
% %Compute the LCA of the system with no ACL in place
% %note: important to use m=1 during subject's defocus adjustment
% %We will use same value of mag to compute system LCA 
LCA_sys_RB=0.2174*magn+0.0818;
LCA_sys_GB=0.1231*magn+0.0297;
LCA_sys_RG=0.0943*magn+0.0521;
% 
% 
fprintf('LCA_system_RB  %.4f \n', LCA_sys_RB)
fprintf('LCA_system_GB  %.4f \n', LCA_sys_GB)
fprintf('LCA_system_RG  %.4f \n', LCA_sys_RG)
fprintf('\n');
% % 
% %Compute the LCA of the eye by subtracting LCA of the systen
LCA_righteye_RB=(LCA_sys_Eye_RB_right)-(LCA_sys_RB);
LCA_righteye_GB=(LCA_sys_Eye_GB_right)-(LCA_sys_GB);
LCA_righteye_RG=(LCA_sys_Eye_RG_right)-(LCA_sys_RG);
% 
fprintf('LCA_righteye_RB  %.4f \n', LCA_righteye_RB);
fprintf('LCA_righteye_GB  %.4f \n', LCA_righteye_GB);
fprintf('LCA_righteye_RG  %.4f \n', LCA_righteye_RG);

% Austin half LCA settings Dec 22 for CSF
% LCA_righteye_RB = 1.2360 /2
% LCA_righteye_GB = 0.7582 /2
% LCA_righteye_RG  =0.4778 /2
% avg_pow_green_right=14.2958 


%Enter the fraction of LCA where you want to set the trombone
%use 1 to use full LCA correction
%use 0.5 for half LCA correction
%use value > 1 for over LCA correction

LCA_righteye_RB = LCA_righteye_RB *LCAcorrR;
LCA_righteye_GB = LCA_righteye_GB *LCAcorrR;
LCA_righteye_RG  =LCA_righteye_RG *LCAcorrR;

fprintf('\n!!!CHANGING LCA CORRECTION TO %0.2f !!!\n', LCAcorrR);

fprintf('%.2f LCA_righteye_RB  %.4f \n', LCAcorrR,LCA_righteye_RB);
fprintf('%.2f LCA_righteye_GB  %.4f \n', LCAcorrR,LCA_righteye_GB);
fprintf('%.2f LCA_righteye_RG  %.4f \n', LCAcorrR,LCA_righteye_RG);


% To correct the LCA of the eye, put the ACL in place and adjust the trombone according to the equations on figure 6
trom_opto_pwr_RB_right=9.1613*((LCA_righteye_RB)^(-0.371));
trom_opto_pwr_GB_right=7.2167*((LCA_righteye_GB)^(-0.382));
trom_opto_pwr_RG_right=6.9543*((LCA_righteye_RG)^(-0.36));

tromb_powersR=[trom_opto_pwr_RB_right trom_opto_pwr_GB_right trom_opto_pwr_RG_right];
mean_trombone_power_right=mean(tromb_powersR);
fprintf('\n');

% %set displays to green focus power
p3(2,1)=avg_pow_green_right; %Green_power_dispL
fprintf('Display optotune power %.4f \n',avg_pow_green_right);
fprintf('\n');

%set trombone optotune power
p3(5,1)=mean_trombone_power_right; %L_optopower , use the equation to set trombone power
fprintf('Right Trombone optotune powers  %.4f  %.4f  %.4f \n\n', trom_opto_pwr_RB_right, trom_opto_pwr_GB_right, trom_opto_pwr_RG_right)
fprintf('Averaged Right Trombone optotune power %f \n\n', mean_trombone_power_right)
fprintf('2nd:Display power, 5th:Trombone OptoPower \n' );
p3

flagR=0;
if(mean_trombone_power_right>=opR(1.2) && mean_trombone_power_right<=opR(0.8))
    fprintf('In above matrix, Mean trombone power is within the limits of 0.8 and 1.2 magnification\n');
elseif mean_trombone_power_right<opR(1.2) && mean_trombone_power_right>opR(1.3)
    
    fprintf('In above matrix, Mag is higher than 1.2,BUT Less than 1.3 (beam size is still less than 5.2 at ACL');
else
    fprintf('!!!!!!!!!!CAUTION: In above matrix, Mean trombone power  is FULLY OUTSIDE the limits of 0.8 and 1.3 mag!!!!!!!!!!\n');
    flagR=1; %set limit of 1.3 now
    if mean_trombone_power_right<opR(1.3)
        fprintf('!!!!!!!!!!BEAM SIZE HAS EXCEEDED 5.2 mm , mag>1.3 !!!!!!!!!!\n\n');
        fprintf('Setting trombone power to mag of 1.3, which is  %f \n', opR(1.3));
        p3(5,1)= opR(1.3);
    elseif mean_trombone_power_right>opR(0.8)
        fprintf('!!!!!!!!!!mag <0.8 (zaber cannot reach lower than around 0.8 due to hard limit !!!!!!!!!!\n\n');
        fprintf('Setting trombone power to mag of 0.8, which is  %f \n', opR(0.8));
        p3(5,1)= opR(0.8);
    end
end


fprintf('\nBelow is updated 2nd and 5th rows of right side (based on limits): 2nd:Display power, 5th:Trombone OptoPower \n' );

p3

fprintf('!!!!!!!!Final LCA CORRECTION Used %0.2f !!!!!!!\n', LCAcorrR);
fprintf('Final Right Display Opto power %f\n', p3(2,1));
fprintf('Final Right Trombone Opto power %f\n', p3(5,1));
% p3=[9.0000
%    12.8019
%    19.0000
%    13.6242
%     9.8375
%     9.2388
%    -3.0000
%     2.0000];
% opt0(p3,flag);




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

