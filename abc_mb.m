[LTCA_Y_br,LTCA_Y_gr,LTCA_X_br,LTCA_X_gr]=LeftSideTCA_tromb(12.2703);
        [RTCA_Y_br,RTCA_Y_gr,RTCA_X_br,RTCA_X_gr]=RightSideTCA_tromb(11);
        z0=[0    0    0    0; LTCA_Y_gr  LTCA_X_gr  RTCA_Y_gr  RTCA_X_gr;  LTCA_Y_br  LTCA_X_br  RTCA_Y_br  RTCA_X_br] %system TCA 
        
        [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(12.2703, 11);
         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);     
         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);