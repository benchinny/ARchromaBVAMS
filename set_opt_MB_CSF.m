% cls;
global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00

%updating Display power as per sharpness values
%        LEFT      RIGHT
% p0(2,:)=[12.371700     13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
% p0(2,:)=[11.171700     13.0019 ]; %Jan 13 MB new power values for both eyes
% %update Trombone powers as needed
% %        LEFT      RIGHT
% p0(5,:)=[9.8896    9.8375]; %full LCA MB
% % p0(5,:)=[13.095800   9.8375]; %half LCA MB

%%%%%%%%%%%%%System TCA measurment settings%%%%%%%%%%%%%%%%%%%
% %        LEFT      RIGHT
% p0(2,:)=[12.071700     12.7019];%RIGHT DISP TCA FOCUS 13.3019D
% p0(5,:)=[9.8896    9.8375]; %RIGHT DISP TCA Adjustment opto power 1, 9.8375D
% % p0(5,:)=[9.8896    12.2]; %RIGHT DISP TCA Adjustment opto power 2, 12.2D
% % p0(5,:)=[9.8896    13.1]; %RIGHT DISP TCA Adjustment opto power 3, 13.1D
% 
% p0(2,:)=[12.371700     13.4717];%RIGHT DISP E green FOCUS 13.4717
% p0(5,:)=[9.8896    9.8375]; %RIGHT DISP TCA Adjustment opto power 1, 9.8375D
% p0(5,:)=[9.8896    12.2]; %RIGHT DISP TCA Adjustment opto power 2, 12.2D
% p0(5,:)=[9.8896    13.1]; %RIGHT DISP TCA Adjustment opto power 3, 13.1D

% % marty settings nov 24th
% p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% p0(2,:)=[12.2717     13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
% p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[8.7837              8.9288];          %L_optopower(mag)     R_optopower(mag)     
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation
% trom_powrL=linspace(8.619, 13.819,10);
% % trom_powrL=[8.6190    9.1968    9.7746   10.3523   10.9301   11.5079   12.0857   12.6634   13.2412   13.8190];
% 
% trom_powrR=linspace(8.5586, 13.6242,10);
% % trom_powrR=[ 8.5586    9.1214    9.6843   10.2471   10.8100   11.3728   11.9357   12.4985   13.0614   13.6242];

p0(1,:)=[    9.0000    9.0000];

% UPDATE
p0(2,:)=[ 12.133300  12.133300]; %display power mb UPDATE
% p0(2,:)=[14.3167  14.43 ]; %ar right14.3958
% p0(2,:)=[12.471700     13.3]; %disp

p0(3,:)=[   17.0000   17.0000];

p0(4,:)=[   13.819   opR(0.8)];
%UPDATE
p0(5,:)=[8.7  8.6];%move far
% p0(5,:)=[12.2703  9.8375];%trombone power MB_left=9.8896  MB_right=9.8375 UPDATE
% p0(5,:)=[10.7858   10.9621];%trombone power MB_left=9.8896  MB_right=9.8375 UPDATE
% p0(5,:)=[8.8752    8.7925]; %AR march 2021
% p0(5,:)=[9.0393 9.1922];
% p0(5,:)=[8.8752    8.7925];
% p0(5,:)=[opL(1)   opR(1)];
% p0(5,:)=[ 11.6895   opR(1)]; %mb mar30


p0(6,:)=[   opL(1.3)    opR(1.3)];
p0(7,:)=[  -3.000   -3.0000];
p0(8,:)=[        0         0];

% % p0(2,:)=[11.2718    14.195751]; %ar right
% % p0(5,:)=[10.9   11.016400]; %dec22


% p0(5,:)=[13.9    10.7]; 
p0
trombone_power_left=p0(5,1);
trombone_power_right=p0(5,2);
fprintf('Display LEFT %0.7f \n',p0(2,1));
fprintf('Trombone LEFT %0.7f \n',trombone_power_left);
fprintf('\nDisplay RIGHT %0.7f\n',p0(2,2));
fprintf('Trombone RIGHT %0.7f\n',trombone_power_right);
fprintf('\n');
%output final reticle position
[PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);     
         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
 [LTCA_Y_br,LTCA_Y_gr,LTCA_X_br,LTCA_X_gr]=LeftSideTCA_tromb(trombone_power_left); %(LeftTromPwr);
        [RTCA_Y_br,RTCA_Y_gr,RTCA_X_br,RTCA_X_gr]=RightSideTCA_tromb(trombone_power_right); %(RightTromPwr);
        
        %Use the above System TCA values
        %[Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]
        z0=[0    0    0    0; LTCA_Y_gr  LTCA_X_gr  RTCA_Y_gr  RTCA_X_gr;  LTCA_Y_br  LTCA_X_br  RTCA_Y_br  RTCA_X_br]; %system TCA 

%RUN A CHECK ON VALUES Of trombone power again for sanity
flagL=0;
if(trombone_power_left>=opL(1.3) && trombone_power_left<=opL(0.8))
    fprintf('In above matrix, LEFT trombone power is within the limits of 0.8 and 1.3 magnification\n');
        if trombone_power_left>13.819 
            
            %zaber for left side can't go exactly to 0.8 mag, may be the
            %limit is around 0.825
            fprintf('\n');
            fprintf(' LEFT trombone power is >13.819D, Zaber will go to negative values\n');
            fprintf('----->Setting LEFT trombone power to 13.819D\n');
            trombone_power_left=13.819;
        end
    

else
    fprintf('!!!!!!!!!!CAUTION: In above matix, LEFT trombone power  is FULLY OUTSIDE the limits of 0.8 and 1.3 mag!!!!!!!!!!\n');
    flagL=1; %set limit of 1.3 now
    if trombone_power_left<opL(1.3)
        fprintf('!!!!!!!!!!LEFT BEAM SIZE HAS EXCEEDED 5.2 mm , mag>1.3 !!!!!!!!!!\n');
        fprintf('-----> Need to set LEFT trombone power to mag of 1.3, which is  %0.7f \n', opL(1.3));

    elseif trombone_power_left>opL(0.8)
        fprintf('!!!!!!!!!!mag <0.8 (zaber cannot reach lower than around 0.8 due to hard limit !!!!!!!!!!\n');
        fprintf('----->NEED TO SET LEFT trombone power to mag of 0.8, which is  %0.7f \n', opL(0.8));
       
    end
end


fprintf('\n');
flagR=0;
if(trombone_power_right>=opR(1.3) && trombone_power_right<=opR(0.8))
    fprintf('In above matrix, RIGHT trombone power is within the limits of 0.8 and 1.3 magnification\n');

else
    fprintf('!!!!!!!!!!CAUTION: In above matrix, RIGHT trombone power  is FULLY OUTSIDE the limits of 0.8 and 1.3 mag\n!!!!!!!!!!\n');
    flagR=1; %set limit of 1.3 now
    if trombone_power_right<opR(1.3)
        fprintf('!!!!!!!!!!BEAM SIZE HAS EXCEEDED 5.2 mm , mag>1.3 !!!!!!!!!!\n');
        fprintf('------>Need to SET RIGHT trombone power to mag of 1.3, which is  %f \n', opR(1.3));
%         p0(5,2)= opR(1.3);
%         fprintf('\nBelow is updated 2nd and 5th rows of right side (based on limits): 2nd:Display power, 5th:Trombone OptoPower \n' );
%          p0
    elseif trombone_power_right>opR(0.8)
        fprintf('!!!!!!!!!!mag <0.8 (zaber cannot reach lower than around 0.8 due to hard limit !!!!!!!!!!\n');
        fprintf('----->Need to set trombone power to mag of 0.8, which is  %f \n', opR(0.8));
%         p0(5,2)= opR(0.8);
%         fprintf('\nBelow is updated 2nd and 5th rows of right side (based on limits): 2nd:Display power, 5th:Trombone OptoPower \n' );
%         p0
    end
end



flag=0;
if flagR == 1 
        flag=1;
    elseif flagL==1
        flag=1;
    else 
        flag=0;
end
    fprintf('\n');
    fprintf('Flag is %d',flag);
    fprintf('\n');



c1=2; %-1min, 0random, 1max, 2given values  
if c1==-1;
    p0(2,:)=p0(1,:);
    p0(5,:)=p0(4,:);
elseif c1==0
    p0(2,:)=0;
    p0(5,:)=0;
elseif c1==1; %use this for sending trombone far
    p0(2,:)=p0(3,:);
    p0(5,:)=p0(6,:);
elseif c1==2;
    p0=p0;
end
    
 opt0(p0,flag);

%     p1(k0,:)=[power_dispL power_dispR powerL powerR rot];
%     p2=mean(p1,1);
%     p0(2,:)=p2(1:2);
%     p0(5,:)=p2(3:4);
%     p0(7,:)=p2(end);

% p0(2,1)=p2(1,1); %power_dispL
% p0(2,2)=p2(1,2); %power_dispR
% 
% trom_opto_pwr_rb_L=5.4418.*x.^2-14.848.*x+18.256;
% trom_opto_pwr_gb_L=19.666.*x.^2-27.899.*x+18.515;
% trom_opto_pwr_rg_L=24.223.*x.^2-30.109.*x+17.973;
% 
% 
% trom_opto_pwr_rb_R=4.7588.*x.^2-12.817.*x+17.161;
% trom_opto_pwr_bg_R=17.199.*x.^2-24.684.*x+17.39;
% trom_opto_pwr_rg_R=21.182.*x.^2-26.648.*x+16.91;

% p0(5,1)=          %L_optopower , use the equation to set trombone power
% p0(5,2)=           %R_optopower, use the equation to set trombone power





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



% % cls;
% global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% 
% % % marty settings nov 24th
% % p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% % p0(2,:)=[12.2717     13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
% % p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% % p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% % p0(5,:)=[8.7837              8.9288];          %L_optopower(mag)     R_optopower(mag)     
% % p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% % p0(7,:)=-3; %rotation
% trom_powrL=linspace(8.619, 13.819,10);
% % trom_powrL=[8.6190    9.1968    9.7746   10.3523   10.9301   11.5079   12.0857   12.6634   13.2412   13.8190];
% 
% trom_powrR=linspace(8.5586, 13.6242,10);
% % trom_powrR=[ 8.5586    9.1214    9.6843   10.2471   10.8100   11.3728   11.9357   12.4985   13.0614   13.6242];
% 
% p0(1,:)=[    9.0000    9.0000];
% p0(2,:)=[  12.2718    12.8019]; %display power
% p0(3,:)=[   17.0000   17.0000];
% p0(4,:)=[   14.2737   13.6242];
% p0(5,:)=[10.9    10.9];%trombone power MB_left=9.8896  MB_right=9.8375
% p0(6,:)=[   8.6190    8.5568];
% p0(7,:)=[  -3.0000   -3.0000];
% p0(8,:)=[        0         0];
% p0
% %updating display power as per sharpness values
% % p0(2,:)=[12.2717     13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
% 
% %update trombone powers as needed
% % p0(5,:)=[9.8896    9.8375]; 
% 
% c1=2; %-1min, 0random, 1max, 2given values  
% if c1==-1;
%     p0(2,:)=p0(1,:);
%     p0(5,:)=p0(4,:);
% elseif c1==0
%     p0(2,:)=0;
%     p0(5,:)=0;
% elseif c1==1; %use this for sending trombone far
%     p0(2,:)=p0(3,:);
%     p0(5,:)=p0(6,:);
% elseif c1==2;
%     p0=p0;
% end
%     
% opt0(p0,0);
% 
% %     p1(k0,:)=[power_dispL power_dispR powerL powerR rot];
% %     p2=mean(p1,1);
% %     p0(2,:)=p2(1:2);
% %     p0(5,:)=p2(3:4);
% %     p0(7,:)=p2(end);
% 
% % p0(2,1)=p2(1,1); %power_dispL
% % p0(2,2)=p2(1,2); %power_dispR
% % 
% % trom_opto_pwr_rb_L=5.4418.*x.^2-14.848.*x+18.256;
% % trom_opto_pwr_gb_L=19.666.*x.^2-27.899.*x+18.515;
% % trom_opto_pwr_rg_L=24.223.*x.^2-30.109.*x+17.973;
% % 
% % 
% % trom_opto_pwr_rb_R=4.7588.*x.^2-12.817.*x+17.161;
% % trom_opto_pwr_bg_R=17.199.*x.^2-24.684.*x+17.39;
% % trom_opto_pwr_rg_R=21.182.*x.^2-26.648.*x+16.91;
% 
% % p0(5,1)=          %L_optopower , use the equation to set trombone power
% % p0(5,2)=           %R_optopower, use the equation to set trombone power
% 
% 
% 
% 
% 
% % % 
% % % cls;
% % % global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% % % 
% % % c1=2; %-1min, 0random, 1max, 2given values mag use 1 for 
% % % 
% % % %% LCA params
% % % p0=zeros(8,2);
% % % %if set power_disp/optopower=0 randomize.
% % % p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% % % p0(2,:)=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR   
% % % p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% % % p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% % % p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)     
% % % p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% % % p0(7,:)=-3; %rotation
% % %   
% % % %marty settings nov 23rd
% % % % p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% % % % p0(2,:)=[12.01951667     13.43585]; %power_dispL          power_dispR   
% % % % p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% % % % p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% % % % p0(5,:)=[9.156588449              8.757208676];          %L_optopower(mag)     R_optopower(mag)     
% % % % p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% % % % p0(7,:)=-3; %rotation
% % % 
% % % if c1==-1;
% % %     p0(2,:)=p0(1,:);
% % %     p0(5,:)=p0(4,:);
% % % elseif c1==0
% % %     p0(2,:)=0;
% % %     p0(5,:)=0;
% % % elseif c1==1;
% % %     p0(2,:)=p0(3,:);
% % %     p0(5,:)=p0(6,:);
% % % elseif c1==2;
% % %     %note: p1 comes from doing LCA task and p2 takes average of p1 values
% % %     p1(k0,:)=[power_dispL power_dispR powerL powerR rot];
% % %     p2=mean(p1,1);
% % %     p0(2,:)=p2(1:2);
% % %     p0(5,:)=p2(3:4);
% % %     p0(7,:)=p2(end);
% % %    
% % % end
% % %     
% % % opt0(p0);
% 
