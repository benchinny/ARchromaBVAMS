function tc0=Ltca_ACL(LeftTromPwr)
       x=LeftTromPwr;
       
       p1 = -0.2168; %0.02272   ; 
       p2 =   3.369; %-0.6549  ;
       TCA_Y_br = p1*x + p2; %fitted equation for pixels
       
       p1 =  -0.0992; %-0.01224  ; 
       p2 =  1.8; %-0.3293   ; 
       TCA_Y_gr = p1*x + p2; %in pixels
       
       p1 = -0.2644; %0.1005  ;
       p2 = 6.652; %2.481;
       TCA_X_br= p1*x + p2;  %in pixels

       p1 =  -0.2192; %0.04458  ;
       p2 =   5.143; %1.608     ;
       TCA_X_gr = p1*x + p2;  %in pixels
       
       tc0=[ TCA_Y_gr  TCA_X_gr
             TCA_Y_br  TCA_X_br ];
