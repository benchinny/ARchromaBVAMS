function [RTCA_Y_br,RTCA_Y_gr,RTCA_X_br,RTCA_X_gr]=RightSysTCA_noACL_tromb(RightTromPwr)

x=RightTromPwr;

p1 =    -0.02727  ;
p2 =      -2.124  ;
RTCA_Y_br=p1*x + p2;


p1 =    -0.03839  ;
p2 =      -1.258  ;
RTCA_Y_gr= p1*x + p2;


p1 =    -0.03265  ;
p2 =     -0.7679  ;
RTCA_X_br=p1*x + p2;

    
p1 =      0.1015  ;
p2 =      -1.736  ;
RTCA_X_gr=p1*x + p2;
     
