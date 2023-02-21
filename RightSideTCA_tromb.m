function [RTCA_Y_br,RTCA_Y_gr,RTCA_X_br,RTCA_X_gr]=RightSideTCA_tromb(RightTromPwr)

x=RightTromPwr;

p1 =     -0.1141  ;
p2 =     -0.5563  ;
RTCA_Y_br=p1*x + p2;


p1 =     -0.1592  ;
p2 =      0.8528  ;
RTCA_Y_gr= p1*x + p2;


 p1 =      0.3881  ;
 p2 =      -2.718  ;
RTCA_X_br=p1*x + p2;

    
p1 =      0.2129  ;
p2 =      -1.157  ;     
RTCA_X_gr=p1*x + p2;
     
       
