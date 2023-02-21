function [TCA_Y_br,TCA_Y_gr,TCA_X_br,TCA_X_gr]=LeftSysTCA_noACL_tromb(LeftTromPwr)
       x=LeftTromPwr;
       
       p1 =     -0.2514; 
       p2 =      0.6038 ;
       TCA_Y_br = p1*x + p2; %fitted equation for pixels
       
       p1 =     -0.1196 ; 
       p2 =     -0.3784 ; 
       TCA_Y_gr = p1*x + p2; %in pixels
       
       p1 =     0.05944  ;
       p2 =        1.12  ;
       TCA_X_br= p1*x + p2;  %in pixels

       p1 =     -0.2524  ;
       p2 =       2.972  ;
       TCA_X_gr = p1*x + p2;  %in pixels
