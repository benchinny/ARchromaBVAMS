function tc0=Rtca_ACL(RightTromPwr)

x=RightTromPwr;

p1 =   0.4722; %-0.2915    ;
p2 =    -7.892; %2.975  ;
RTCA_Y_br=p1*x + p2;


p1 =   0.1467; %-0.192  ;
p2 =    -2.942; %1.796   ;
RTCA_Y_gr= p1*x + p2;


p1 =   -1.686; %0.305;
p2 =    25.8; %-0.2158 ;
RTCA_X_br=p1*x + p2;

    
p1 =    -0.9362; %0.1139     ;
p2 =     14.04; %0.8115  ;
RTCA_X_gr=p1*x + p2;
     
tc0=[RTCA_Y_gr  RTCA_X_gr
     RTCA_Y_br  RTCA_X_br];