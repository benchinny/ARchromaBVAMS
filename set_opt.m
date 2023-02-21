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

% % marty settings nov 24th
% p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% p0(2,:)=[12.2717     13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
% p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[8.7837              8.9288];          %L_optopower(mag)     R_optopower(mag)     
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation

% Austin settings nov 24th
p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
p0(2,:)=[13.8190    14.266333]; %power_dispL 11.27175          power_dispR  12.80192 
p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
p0(5,:)=[8.619048              8.687687];          %L_optopower(mag)     R_optopower(mag)     
p0(6,:)= [opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
p0(7,:)=-3; %rotation

p0(2,:)=[13.719038   14.266333]; %AR 14.6663
p0(5,:)=[8.619048       8.687687];
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
    p0=p0;
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
end
    
opt0(p0,0);





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

