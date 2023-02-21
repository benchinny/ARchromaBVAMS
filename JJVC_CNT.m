 %%210604 JJVC_CNT
ex='CNT' 
ey0=ey; ey='B'; %change eye setting to binocular
clear p0 p1
        p0(1)=5; %1; %0.5; %stimuli presentation time
        p0(2) =1; %20; % number of repetitions, remeber the total repetitions are this multiplied by the length of the disparities vector
%        p1= [-4 -3 -2 -1 0 1 2 3 4];
         %p1= [-6 -4 -2 0 2 4 6];%marty ACL1,
%         p1= [1 3];%marty ACL1,
         p1= [-6 -4 -2 0 2 4 6];%marty ACL0,

%          p1=[-6 0 6];%pratcice nadav
%          p1=[-2 0 2 4 6 8 10];%nadav
%                   p1= [-6 -4 -2 0 2 4 6];%Austin LCA0
% p1=[-6 -2 2 6 10];%nadav RAnge which WORKED(noACL) on June9, S10007B_CNT_ACL0_2106091232_Best
% p1=[ 0 2 4 6 8 10 12];%nadav fine tuned RAnge which WORKED(with ACL) on June9
%p1=-200;
%              p1=[-2 0 2 4 6 8 10];%Austin's LCA1 4:10
%      0     p1=[-8 -4 -2 0 2 4 8]; %vector of disparities
%           p1=[-10 -8 -6 -4 -2 0 2]; %Nadav CNT3 00vector of disparities
%           p1=[-10 -6 -2 2 6 10]; %Nadav CNT4000
%         p1=[-16 8 16]; %vector of disparities0
% p1=0;
         %looking through the system positive is crossed and negative disparity is uncrossed 
        disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
        [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0); %start psychtoolbox
       [y3 y2 y1 y0]=CNT1f(p0, p1, window1, window2);
        %y0 up/down responses
        %y1 disparities 
        %y2   invert responses
        %y3 up1 buttom0 blue/disparity
        %[rslt d0]=psfn(y1, y2);
        
        
        %buttom cases
        %y10=y1(y3==0); y20=y2(y3==0); [rslt d0]=psfn(y10, y20);
        %buttom cases
        %y11=y1(y3==1); y21=y2(y3==1); [rslt d0]=psfn(y11, y21);       
        VRCMprm; %save varichrome parameters into VRCMp
        %if sv == 1; save(['data\S' num2str(sn) '_CNT_' ey '_ACL' n2s(ACL) '_' tme], 'y1', 'y2', 'y3', 'p0', 'p1', 'VRCMp'); end
        if sv == 1; save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'y1', 'y2', 'y3', 'p0', 'p1', 'VRCMp'); end
        ey=ey0; %move back to original eye
        sca
         