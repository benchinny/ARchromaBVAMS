cls;
global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00

c1=2; %-1min, 0random, 1max, 2given values mag use 1 for 

%% LCA params
p0=zeros(8,2);
%if set power_disp/optopower=0 randomize.
% p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% p0(2,:)=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR   
% p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)     
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation
  
%marty settings nov 23rd
% p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% p0(2,:)=[12.01951667     13.43585]; %power_dispL          power_dispR   
% p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[9.156588449              8.757208676];          %L_optopower(mag)     R_optopower(mag)     
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation

% marty settings nov 24th
p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
p0(2,:)=[12.2717     13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
p0(5,:)=[8.7837              8.9288];          %L_optopower(mag)     R_optopower(mag)     
p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
p0(7,:)=-3; %rotation


if c1==-1;
    p0(2,:)=p0(1,:);
    p0(5,:)=p0(4,:);
elseif c1==0
    p0(2,:)=0;
    p0(5,:)=0;
elseif c1==1;
    p0(2,:)=p0(3,:);
    p0(5,:)=p0(6,:);
elseif c1==2;
   
%     p1(k0,:)=[power_dispL power_dispR powerL powerR rot];
%     p2=mean(p1,1);
%     p0(2,:)=p2(1:2);
%     p0(5,:)=p2(3:4);
%     p0(7,:)=p2(end);



pow_red_left=p2(1,1)
pow_green_left=p2(2,1)
pow_blue_left=p2(3,1)

pow_red_right=p2(1,2)
pow_green_right=p2(2,2)
pow_blue_right=p2(3,2)

%set displays to green focus power
p0(2,1)=pow_green_left %Green_power_dispL
p0(2,2)=pow_green_right %Green_power_dispR

diff_pow_RB_left=pow_red_left-pow_blue_left
diff_pow_GB_left=pow_green_left-pow_blue_left
diff_pow_RG_left=pow_red_left-pow_green_left

trom_opto_pwr_rb_L=5.4418.*diff_pow_RB_left.^2-14.848.*diff_pow_RB_left+18.256
trom_opto_pwr_gb_L=19.666.*diff_pow_GB_left.^2-27.899.*diff_pow_GB_left+18.515
trom_opto_pwr_rg_L=24.223.*diff_pow_RG_left.^2-30.109.*diff_pow_RG_left+17.973

trombone_left_powers=[trom_opto_pwr_rb_L trom_opto_pwr_gb_L trom_opto_pwr_rg_L]
trombone_left_power=mean(trombone_left_powers)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
diff_pow_RB_right=pow_red_right-pow_blue_right
diff_pow_GB_right=pow_green_right-pow_blue_right
diff_pow_RG_right=pow_red_right-pow_green_right

trom_opto_pwr_rb_R=4.7588.*diff_pow_RB_right.^2-12.817.*diff_pow_RB_right+17.161
trom_opto_pwr_gb_R=17.199.*diff_pow_GB_right.^2-24.684.*diff_pow_GB_right+17.39
trom_opto_pwr_rg_R=21.182.*diff_pow_RG_right.^2-26.648.*diff_pow_RG_right+16.91

trombone_right_powers=[trom_opto_pwr_rb_R trom_opto_pwr_gb_R trom_opto_pwr_rg_R]
trombone_right_power=mean(trombone_right_powers)





% 
% 
% trom_opto_pwr_rb_R=4.7588.*x.^2-12.817.*x+17.161;
% trom_opto_pwr_gb_R=17.199.*x.^2-24.684.*x+17.39;
% trom_opto_pwr_rg_R=21.182.*x.^2-26.648.*x+16.91;

% p0(5,1)=          %L_optopower , use the equation to set trombone power
% p0(5,2)=           %R_optopower, use the equation to set trombone power
end
    
opt0(p0);





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

