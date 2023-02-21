function tc0=Ltca_noACL(LeftTromPwr)
       x=LeftTromPwr;
       
       p1 =   0.1144; %-0.004378 ; 
       p2 =    -2.508; %-1.193  ;
       TCA_Y_br = p1*x + p2; %fitted equation for pixels
       
       p1 =    0.1587; %-0.001754 ; 
       p2 =    -2.063; %-0.897  ; 
       TCA_Y_gr = p1*x + p2; %in pixels
       
       p1 = 0.192; %-0.01922 ;
       p2 =  -3.564; %3.516 ;
       TCA_X_br= p1*x + p2;  %in pixels

       p1 =  0.0319; %-0.0472   ;
       p2 =  0.2079; %2.58   ;
       TCA_X_gr = p1*x + p2;  %in pixels
       
       tc0=[ TCA_Y_gr  TCA_X_gr
             TCA_Y_br  TCA_X_br ];
