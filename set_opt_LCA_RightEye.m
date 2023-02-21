cls;
global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00



%% LCA params
% p3=zeros(8,2);
% %if set power_disp/optopower=0 randomize.
% p3(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% p3(2,:)=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR   
% p3(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% p3(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p3(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)     
% p3(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p3(7,:)=-3; %rotation

p3=zeros(8,1);
%if set power_disp/optopower=0 randomize.
p3(1,1)=8;                     %    power_dispR_min
p3(2,1)=1000./75+1/0.789; % initial power_dispR  , we will update this using subject's defcous values for green 
p3(3,1)=25;              %power_dispR_max                   
p3(4,1)=opL(0.8);        %R_optopower(mag)_min 14.2737D         
p3(5,1)=opL(1);          %R_optopower(mag)  11.3200D  , we will update this    
p3(6,1)=opL(1.2);        %R_optopower(mag)_max 9.3665D
p3(7,1)=0;               %rotation

magn=0.8;
avg_pow_red_right=p2(1,2)
avg_pow_green_right=p2(2,2)
avg_pow_blue_right=p2(3,2)

%Compute the LCA of the system+eye between the primaries using the defocus
%measurments for the subject (when there is NO ACL)
LCA_sys_Eye_RB_right=avg_pow_red_right-avg_pow_blue_right
LCA_sys_Eye_GB_right=avg_pow_green_right-avg_pow_blue_right
LCA_sys_Eye_RG_right=avg_pow_red_right-avg_pow_green_right

% 
%Compute the LCA of the system with no ACL in place
%note: important to use m=1 during subject's defocus adjustment
%We will use same value of mag to compute system LCA 
LCA_sys_RB=0.2174*magn+0.0818
LCA_sys_GB=0.1231*magn+0.0297
LCA_sys_RG=0.0943*magn+0.0521
% 
% 
%Compute the LCA of the eye by subtracting LCA of the systen
LCA_righteye_RB=(LCA_sys_Eye_RB_right)-(LCA_sys_RB)
LCA_righteye_GB=(LCA_sys_Eye_GB_right)-(LCA_sys_GB)
LCA_righteye_RG=(LCA_sys_Eye_RG_right)-(LCA_sys_RG)
% 

% To correct the LCA of the eye, put the ACL in place and adjust the trombone according to the equations on figure 6
trom_opto_pwr_RB_right=9.1613*((LCA_righteye_RB)^(-0.371))
trom_opto_pwr_GB_right=7.2167*((LCA_righteye_GB)^(-0.382))
trom_opto_pwr_RG_right=6.9543*((LCA_righteye_RG)^(-0.36))

tromb_powersR=[trom_opto_pwr_RB_right trom_opto_pwr_GB_right trom_opto_pwr_RG_right]
mean_trombone_power_right=mean(tromb_powersR)

fprintf('updated 2nd and 5th rows of right side');
% %set displays to green focus power
p3(2,1)=avg_pow_green_right; %Green_power_dispL
p3(5,1)=mean_trombone_power_right %L_optopower , use the equation to set trombone power


    
% opt0(p3);




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

