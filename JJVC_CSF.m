%%210604 JJVC_CSF run CSF task
%nlz CSF;[x y C]=psf_CSF2(h0, h1, g0(2), g1, 0); y00=fit_CSF0(x-rb2,y); figure; plot(x-rb2, y, 's'); hold on; plot(y00)
ex='CSF'        

%input g output h
           %trials frequency  gaussian contrast  angle  beginning-contrast
        %g0=[20     2*73.6    100      1.6       10]; 
      %  g0=[40    2*73.6    100      1.6       10]; %210610 changed to 40 trials
       %g0=[40    73.6    100      1.3       10]; %210621 to 10 CPD & 1.3 factor!
       g0=[40    73.6    100      1.3       10 0.25]; %210621 to 10 CPD & 1.3 factor!


         %g1=[-1 -0.6 -0.3 0 0.3 0.6 1]; %[-6:2:6]%phase shift to shift by 6 pixels 2.*6./(1920./(2.*73.6))=0.92 phase shift  
        g1=[-3 -2 -1 0 1 2 3]./3; %210611 changed to fixed intervals %[-6:2:6]%phase shift to shift by 6 pixels 2.*6./(1920./(2.*73.6))=0.92 phase shift  
         %g1=[3 0 -3]./3; %210611 changed to fixed intervals %[-6:2:6]%phase shift to shift by 6 pixels 2.*6./(1920./(2.*73.6))=0.92 phase shift  

        disp('Change focus to GREEN!!! ')
        disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
        [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0); %start psychtoolbox
          [h0 h1 h2]=CSF6f(g0, g1, window1, window2);
          %r2 responses
          %c2 contrast
          %h2 order of presetation/randomized in te experiment not reflected in output matrices.
        VRCMprm; CSFp=VRCMp;  %save varichrome parameters into VRCMp
        %if sv==1; save(['data\S' num2str(sn) '_CSF_'  ey '_ACL' n2s(ACL) '_' tme], 'h0', 'h1', 'h2', 'g0', 'g1', 'VRCMp'); end
        if sv==1; save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'h0', 'h1', 'h2', 'g0', 'g1', 'CSFp'); end

        %load first data set
        %a80=a8; a70=a7;
        %load 2nd data set
        %a8=[a80 a8]; a7=[a70 a7];
        %         a9=psfs(a7, a8, a6, 0);
%         a0=0; %a7=h0, a8=h1
% %a9=psfs(h0, h1, g1+a0, 0);
% a9=psf_CSF(h0, h1, g0(2), g1+a0, 0);

        
        sca