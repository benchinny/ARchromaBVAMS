function [TCA_Y_br,TCA_Y_gr,TCA_X_br,TCA_X_gr]=LeftSideTCA_tromb(LeftTromPwr)
       x=LeftTromPwr;
       
       p1 =      0.1846  ;
       p2 =      -3.691  ;
       TCA_Y_br = p1*x + p2; %fitted equation for pixels
       
       
       p1 =      0.1976  ;
       p2 =       -2.76  ;
       TCA_Y_gr = p1*x + p2; %in pixels
       
       p1 =     -0.1247  ;
       p2 =        3.64  ;
       TCA_X_br= p1*x + p2;  %in pixels

       p1 =    -0.06521  ;
       p2 =       1.947  ;
       TCA_X_gr = p1*x + p2;  %in pixels
