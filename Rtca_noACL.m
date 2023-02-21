function tc0=Rtca_noACL(RightTromPwr)

x=RightTromPwr;
p1 =   0.09784; %0.04396    ;
p2 =    -0.8506; %-1.596   ;
RTCA_Y_br=p1*x + p2;


p1 =    -0.05036; %0.03723  ;
p2 =    0.8839; %-1.109    ;
RTCA_Y_gr= p1*x + p2;


p1 =  0.4314; %-0.01032  ;
p2 =    -7.907; %1.56   ;
RTCA_X_br=p1*x + p2;

    
p1 =      0.1374; %-0.003137   ;
p2 =       -3.128; %1.397 ;
RTCA_X_gr=p1*x + p2;
     
tc0=[RTCA_Y_gr  RTCA_X_gr
     RTCA_Y_br  RTCA_X_br];
