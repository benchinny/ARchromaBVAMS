 load('G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL0_2102231430.mat')
 TCA_noAcl_1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)] %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
 SD1=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)] %input for ETM: [R G B] by [xL yL xR yR]
 
 load('G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL0_2102231435.mat')   
 TCA_noAcl_2=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)] %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
 SD2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)] %input for ETM: [R G B] by [xL yL xR yR]
 
 load('G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL1_2102231448.mat')
 TCA_Acl_1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)] %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
 SD3=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)] %input for ETM: [R G B] by [xL yL xR yR]
 
 load('G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL1_2102231452.mat')
 TCA_Acl_2=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)] %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
 SD4=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)] %input for ETM: [R G B] by [xL yL xR yR]

%  [Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]

LeftTromPwr= 12.2703;
RightTromPwr=10;
[LTCA_Y_br,LTCA_Y_gr,LTCA_X_br,LTCA_X_gr]=LeftSideTCA_tromb(LeftTromPwr);
 [RTCA_Y_br,RTCA_Y_gr,RTCA_X_br,RTCA_X_gr]=RightSideTCA_tromb(RightTromPwr);
        
        %Use the above System TCA values
        %[Red(leftY leftX rightY rightX);Green(leftY leftX rightY rightX);Blue(leftY leftX rightY rightX)]
  sys_tca=[0    0    0    0; LTCA_Y_gr  LTCA_X_gr  RTCA_Y_gr  RTCA_X_gr;  LTCA_Y_br  LTCA_X_br  RTCA_Y_br  RTCA_X_br] %system TCA 

        
        %     

  Efftca1_withacl=TCA_Acl_1-  sys_tca 
  Efftca2_withacl=TCA_Acl_2-  sys_tca