%210609 fgr_CNT
       %y0 up/down responses
        %y1 disparities 
        %y2   invert responses
        %y3 up1 buttom0 blue/disparity
        
        
        
%NHI ACL0
        load('S10007B_CNT_ACL0_2106091232_Best.mat'); [rslt d0]=psfn(y1, y2);
        
        %NHI ACL1
        load('S10007B_CNT_ACL1_2106091417BEST.mat'); [rslt d0]=psfn(y1, y2);