 z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)] %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
        z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)] %input for ETM: [R G B] by [xL yL xR yR]
        
      z1GB=  [z1(2,3:4) ;
             z1(3,3:4)]
        
       z2GB=[ z2(2,3:4);
              z2(3,3:4) ]
     