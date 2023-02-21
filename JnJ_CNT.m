  %%220215 JnJ_CNT based on JJVC_CNT
ex='CNT' 
ey0=ey; ey='Binc'; %change eye setting to binocular
clear p0 p1
        p0(1)=0.5; %stimuli presentation time
        p0(2) =20; %20; % number of repetitions, remeber the total repetitions are this multiplied by the length of the disparities vector
p1=[-10 -8 -6 -4 -2 0 2 4 6 8 10]
p1=[-4:4]+3;
%p1=[9 13 17]
% p1=[6 8 10 12];
        %        p1= [-4 -3 -2 -1 0 1 2 3 4];
         %p1= [4 6 8 10 12 14 16];%marty ACL1,
%         p1=[7 9 11]
         %p1= [-20 -10 0 10 20];%marty ACL1,
%         p1= [1 3];%marty ACL1,
         %p1= [-8 -6 -4 -2 0 2 4];%marty ACL0,
%p1=[6 8 10]
%          p1=[-6 0 6];%pratcice nadav
%          p1=[-2 0 2 4 6 8 10];%na/dav
%                   p1= [-6 -4 -2 0 2 4 6];%Austin LCA0
% p1=[-6 -2 2 6 10];%nadav RAnge which WORKED(noACL) on June9, S10007B_CNT_ACL0_2106091232_Best
% p1=[ 0 2 4 6 8 10 12];%nadav fine tuned RAnge which WORKED(with ACL) on June9
%p1=-200;
%           p1=[-2 0 2 4 6 8 10];%Austin's LCA1 4:10
%      0     p1=[-8 -4 -2 0 2 4 8]; %vector of disparities
%           p1=[-10 -8 -6 -4 -2 0 2]; %Nadav CNT3 00vector of disparities
%           p1=[-10 -6 -2 2 6 10]; %Nadav CNT4000
%         p1=[-16 8 16]; %v ector of disparities0
% p1=[50 50 50]; 8888822
         %looking through the system positive is crossed and negative disparity is uncrossed 
        fprintf('\nLeftDisplayPower = %f  , RightDisplayPower = %f\n', opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);         
        disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
        [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0); %start psychtoolbox
       %[y3 y2 y1 y0]=CNT1f(p0, p1, window1, window2);
       %CNTp=CNT2f(p0, p1, window1, window2);
       CNTp=CNT3f(p0, p1, window1, window2);
       CNTp.p0=p0;
       CNTp.p1=p1;
        %y0 up/down responses
        %y1 disparities 
        %y2   invert responses
        %y3 up1 buttom0 blue/disparity
        %[rslt d0]=psf_CNT0(CNTp.y1, CNTp.y2);
        
        
        
        %buttom cases
        %y10=y1(y3==0); y20=y2(y3==0); [rslt d0]=psfn(y10, y20);
        %buttom cases
        %y11=y1(y3==1); y21=y2(y3==1); [rslt d0]=psfn(y11, y21);       
        %VRCMprm; %save varichrome parameters into VRCMp
                CNTprm; %save varichrome parameters into VRCMp

        %if sv == 1; save(['data\S' num2str(sn) '_CNT_' ey '_ACL' n2s(ACL) '_' tme], 'y1', 'y2', 'y3', 'p0', 'p1', 'VRCMp'); end
        %if sv == 1; save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'y1', 'y2', 'y3', 'p0', 'p1', 'VRCMp'); end
        if sv==1; save(['JnJ\S' num2str(sn) 'V' num2str(vs) '_CNT_' ey 'ACL' n2s(ACL) '_' tme], 'CNTp'); end

        
        ey=ey0; %move back to original eye
        
        [iLf iRf]=cwin3(imread('black.png'), imread('black.png') , cf, rc00, window2, window1);
        sca
         