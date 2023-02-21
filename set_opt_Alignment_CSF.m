% cls;
global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00

% for nL=1:1:2
for u=1:10
    cls_opt;
end

% LTrompows=[8.6190    8.7990    8.9790    9.1590    9.3390    9.5190    9.6990    9.8790   10.0590   10.2390   10.4190   10.5990   10.7790   10.9590   11.1390   11.3190   11.4990   11.6790   11.8590   12.0390   12.2190   12.3990   12.5790   12.7590   12.9390   13.1190   13.2990   13.4790 13.6590 13.819];
% length(LTrompows);
% % RTrompows=[8.5568    8.7368    8.9168    9.0968    9.2768    9.4568    9.6368    9.8168    9.9968   10.1768   10.3568   10.5368   10.7168   10.8968 11.0768   11.2568   11.4368   11.6168   11.7968   11.9768   12.1568   12.3368   12.5168   12.6968   12.8768   13.0568   13.2368   13.4168 13.5968 13.6242];
% length(RTrompows);
Lmin=11.32.*((1.3).^(-1.039));
Lmax=13.819;
% Lpow=Lmin:0.18:Lmax;
Lpow=linspace(Lmin,Lmax,10);
% Lpow = [8.6190    9.1968    9.7746   10.3524   10.9301   11.5079   12.0857   12.6635   13.2412   13.8190];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nL=1; %change this value to change the position of left trombone
nR=10;  %change this value to change the position of right trombone
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rmin=11.002.*((1.3)^(-0.958));
Rmax=11.002.*((0.8)^(-0.958));
% Rpow=Rmin:0.18:Rmax;
Rpow=linspace(Rmin,Rmax,10);
% Rpow =[ 8.5568    9.1199    9.6829   10.2460   10.8090   11.3721   11.9351   12.4981   13.0612   13.6242];
%%%%%%%%%%%%%System TCA measurment settings%%%%%%%%%%%%%%%%%%%
% %        LEFT      RIGHT
% p0(2,:)=[12.071700     12.7019];%RIGHT DISP TCA FOCUS 13.3019D
p0(2,:)=[12.471700     13.3];%no acl right 13.3 , no ACL left:12.471700 , with ACL Left:12.07,with ACL Right:12.67
% p0(5,:)=[opL(1.05)             8.7925]; %measuring system TCA for AR settings
% p0(5,:)=[opL(1.05)             opR(1.05)]; %RIGHT DISP TCA Adjustment opto power 3, 13.1D
p0(5,:)=[Lpow(nL)             Rpow(nR)];
%measure TCA at different trombone positions
% p0(5,:)=[ opL(1.3)    opR(1.3)];%far
p0(1,:)=[    9.0000    9.0000];
% p0(2,:)=[  12.2718    12.8019]; %display power mb
p0(3,:)=[   17.0000   17.0000];
p0(4,:)=[   13.819   opR(0.8)]; %opL(0.8)=14.27,but zaber can't reach, so setting pwr to 13.819 as limit
% p0(5,:)=[10.9    10.9];%trombone power MB_left=9.8896  MB_right=9.8375
p0(6,:)=[   opL(1.3)    opR(1.3)];
p0(7,:)=[  -3.000   -3.0000];
p0(8,:)=[        0         0];



p0
trombone_power_left=p0(5,1);
trombone_power_right=p0(5,2);
fprintf('Display LEFT %0.7f \n',p0(2,1));
fprintf('Trombone LEFT %0.7f \n',trombone_power_left);
fprintf('\nDisplay RIGHT %0.7f\n',p0(2,2));
fprintf('Trombone RIGHT %0.7f\n',trombone_power_right);
fprintf('\n');
%RUN A CHECK ON VALUES Of trombone power again for sanity
flagL=0;
if(trombone_power_left>=opL(1.3) && trombone_power_left<=opL(0.8))
    fprintf('In above matrix, LEFT trombone power is within the limits of 0.8 and 1.3 magnification\n');
        if trombone_power_left>13.819 
            %zaber for left side can't go exactly to 0.8 mag, may be the
            %limit is around 0.825
            fprintf('\n');
            fprintf(' LEFT trombone power is >13.819D, Zaber will go to negative values\n');
            fprintf('-----> Need to set LEFT trombone power to 13.819D\n');     
        end
else
    fprintf('!!!!!!!!!!CAUTION: In above matix, LEFT trombone power  is FULLY OUTSIDE the limits of 0.8 and 1.3 mag!!!!!!!!!!\n');
    flagL=1; %set limit of 0.8 or 1.3 depending on condition, lmtLCA does that
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
    fprintf('In above matrix, RIGHT trombone power is within the limits of 0.8 and 1.2 magnification\n');

else
    fprintf('!!!!!!!!!!CAUTION: In above matrix, RIGHT trombone power  is FULLY OUTSIDE the limits of 0.8 and 1.3 mag\n!!!!!!!!!!\n');
    flagR=1; %set limit of 0.8 or 1.3 depending on condition, lmtLCA does that
    if trombone_power_right<opR(1.3)
        fprintf('!!!!!!!!!!m>1.3, BEAM SIZE HAS EXCEEDED 5.2 mm !!!!!!!!!!\n');
        fprintf('------>Need to SET RIGHT trombone power to mag of 1.3, which is  %f \n', opR(1.3));

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
    fprintf('\nUsing Lpow %d : %f\n',nL,Lpow(nL));
    fprintf('\nUsing Rpow %d : %f\n',nR,Rpow(nR));
 opt0(p0,flag);
%  ex='TCA'; 
%  screens = Screen('Screens');
%  screenNumber = max(screens);
%  [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 
%  
% %  %% TCA params
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ms=10;  
% rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
% xy0=0; %inital position of small circle
% ppp = [2 0.2]; %resolution pixelsPerPress
% n2=6; %number of repetitions
% TCAfnm='c130_b145to540_w10_ms10_sd1_6';
% [bxy v0]=TCA6f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2);
%  
 
% end
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
