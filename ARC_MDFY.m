  %%211213 JJVC_MDFY modify trombone & optotune to desired positions!
%%including neutral position MAG1 trombone

% LeftLCA='S1002V2Left_LCA_ACL0_2112211038.mat'
% RightLCA='S1002V2Right_LCA_ACL0_2112211023.mat'

% LeftLCA='S1004V2Left_LCA_ACL0_2203301516.mat'
% RightLCA='S1004V2Right_LCA_ACL0_2203301509.mat'

sn=input('Enter subject number?'); sn=sn+1000;
vs=input('Enter visit number?'); 

filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';

tcaCorrect=0;
ACL=0; %ACL=0;
bFlexTrombones = true;

if ACL==1
   load([filePath 'LCAflsL']); LeftLCA=LCAfls{sn-1000,2};
   load([filePath 'LCAflsR']); RightLCA=LCAfls{sn-1000,2};

%Select Left file
%load('S10004_LCA_LeftACL0_2104061444.mat', 'a18');%Marty's Left eye LCA dat from April 6
%load('S10003_LCA_LeftACL0_2104301034.mat', 'a18');%AR Austin's Left eye data from April 30
% % % % load('S10007_LCA_LeftACL0_2104261613.mat', 'a18'); 
%  load('S10007_LCA_LeftACL0_2105261047.mat', 'a18');% Nadav's Left eye data May 26
 %load('S10003Left_LCA_ACL0_2112071212', 'a18', 'a19');%AR Austin's Left eye data from 211207
%load('S10102Left_LCA_ACL0_2112211038', 'a18', 'a19');%AR Austin's Left eye data from 211207
%load('S1001V5Left_LCA_ACL0_2202151638',  'aFull', 'aHalf'); %ACL=0
   load(LeftLCA,  'LCAp'); aFull=LCAp.Full; aHalf=LCAp.Half; sr=LCAp.sr; clear LCAp
else
    sr = [0 0];
end

% %LCA task
% a18(2,1)=14.6;
% a18(5,1)=opL(1.4);
% a18(2,2)=14.6;
% a18(5,2)=opR(1.4);

power0=8;
%Initialize powers
power_dispL=14+sr(1); %aFull.p9(2,1);
if ACL==0 powerL=opL(1); elseif ACL==1; powerL=aFull.p9(5,1); elseif ACL==2; powerL=aHalf.p9(5,1); end
deg=-3; 
trombone_power_left=powerL;

%Select Right file
%load('S10004_LCA_RightACL0_2105191352.mat', 'a18');%Marty's Rt eye May19
%load('S10003_LCA_RightACL0_2104301024.mat', 'a18'); %AR Austin's Right eye data from April 30
% load('S10007_LCA_RightACL0_2104201412.mat', 'a18'); %Jim data
% load('S10007_LCA_RightACL0_2105261020.mat', 'a18');% Nadav's Rt eye data May 26
% load('S10007Right_LCA_ACL0_2106161205.mat', 'a18');% Nadav's Rt eye data June 16
%  load('S10007Right_LCA_ACL0_2107081210.mat', 'a18');% Nadav's Rt eye data July 8
% load('S10009Right_LCA_ACL0_2107201444.mat', 'a18');% Fabio Rt eye data July 20
%load('S10003Right_LCA_ACL0_2112071148.mat', 'a18', 'a19'); %AR Austin's Right eye data from 211207
%  load('S10102Right_LCA_ACL0_2112211023.mat', 'a18', 'a19'); %AR Austin's Right eye data from 211207
if ACL==1
   load(RightLCA, 'LCAp'); aFull=LCAp.Full; aHalf=LCAp.Half; sr=LCAp.sr; clear LCAp
else
    sr = [0 0];
end
% %LCA task 

%Initialize powers
power_dispR=14.4+sr(2); %aFull.p9(2,2) ;
if ACL==0; powerR=opR(1); elseif ACL==1; powerR=aFull.p9(5,2); elseif ACL==2; powerR=aHalf.p9(5,2); end
trombone_power_right=powerR;
%CHANGE DISPLAY OPTOTUNE LEFT
% power_dispL=a18(2,1);   %[7.1000 28.3450]               
opto(name_map('l_disp')).control.setFocalPower(power_dispL);
opto(name_map('l_disp')).control.getFocalPower.focal_power
                   
%CHANGE LEFT TROMBONE
% powerL=a18(5,1);
            opto(name_map('l_t_near')).control.setFocalPower(powerL); %[6.8400 24.9500]
%            opto(name_map('l_t_far')).control.setFocalPower(powerL); %[7.2400 27.2950]
            %zaber(name_map('l_trombone')).move(l_trombone_f(powerL));%[8.619 13.8]
            if bFlexTrombones
               zaber(name_map('l_trombone')).move(l_trombone_f(power0));%[8.619 13.8]
            end
            zaber(name_map('l_trombone')).control.waitforidle();
            
            [opto(name_map('l_t_near')).control.getFocalPower.focal_power...
%            opto(name_map('l_t_far')).control.getFocalPower.focal_power...
            zaber(name_map('l_trombone')).control.getposition]

%ROTATION LEFT
% deg=-3;            
zaber(name_map('rotation')).move_deg(deg); %%-6400            
zaber(name_map('rotation')).control.getposition  

%LEFT RETICLE
% trombone_power_left=powerL;

fprintf('Display LEFT %0.7f \n',power_dispL);
fprintf('Trombone LEFT %0.7f \n',trombone_power_left);
fprintf('\n');
%output final reticle position
%[PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
     %    fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CHANGE DISPLAY OPTOTUNE RIGHT
% power_dispR=a18(2,2) ; %[6.9100 28.0750]
opto(name_map('r_disp')).control.setFocalPower(power_dispR);
opto(name_map('r_disp')).control.getFocalPower.focal_power
        
%CHANGE RIGHT TROMBONE
% powerR=a18(5,2); % opR(1);
% powerR=opR(1);
            opto(name_map('r_t_near')).control.setFocalPower(powerR); %[6.8550 25.2250]
            opto(name_map('r_t_far')).control.setFocalPower(powerR); %[7.2400 27.2950]
%             zaber(name_map('r_trombone')).move(r_trombone_f(powerR)); %[7 20]
            if bFlexTrombones
               zaber(name_map('r_trombone')).move(r_trombone_f(power0)); %[7 20]
            end
            zaber(name_map('r_trombone')).control.waitforidle();
            
            
            [opto(name_map('r_t_near')).control.getFocalPower.focal_power...
            opto(name_map('r_t_far')).control.getFocalPower.focal_power...
            zaber(name_map('r_trombone')).control.getposition];
        
[PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(powerL, powerR); %(LeftTromPwr, RightTromPwr);
        
        
[window1, window2, vbl0]=strt_psych0(screenNumber-2, screenNumber-1, 0);
cf=ones(3,2); [iLf iRf]=cwin3(imread('texture0_1080_newfill_malt.png'), imread('texture0_1080_newfill_malt.png') , cf, rc00, window2, window1);                
fprintf('\nLx = %f  , Ly = %f, Rx = %f  , Ry = %f\n',PupCtr_LtX, PupCtr_LtY, PupCtr_RtX, PupCtr_RtY);         
if ACL~=0
 disp(['ACL=' n2s(ACL) ' Put ACL lens in! TCA=' n2s(tcaCorrect)]); KbWait([], 2); 
else 
    disp(['ACL=' n2s(ACL) ' Remove ACL lens out! TCA=' n2s(tcaCorrect) ]); KbWait([], 2);
end
zaber(name_map('l_trombone')).move(l_trombone_f(powerL));%[8.619 13.8]
zaber(name_map('l_trombone')).control.waitforidle();        
zaber(name_map('r_trombone')).move(r_trombone_f(powerR));%[8.619 13.8]
zaber(name_map('r_trombone')).control.waitforidle();          
                  
%RIGHT RETICLE
% trombone_power_right=powerR;
fprintf('\nDisplay RIGHT %0.7f\n',power_dispR);
fprintf('Trombone RIGHT %0.7f\n',trombone_power_right);
fprintf('\n');
%output final reticle position
% [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
         %fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);     

[iLf iRf]=cwin3(imread('black.png'), imread('black.png') , cf, rc00, window2, window1);
sca



         
         
         
         
         
% %%210607 JJVC_MDFY modify trombone & optotune to desired positions!
% 
% %Select Left file
% %load('S10004_LCA_LeftACL0_2104061444.mat', 'a18');%Marty's Left eye LCA dat from April 6
% %load('S10003_LCA_LeftACL0_2104301034.mat', 'a18');%AR Austin's Left eye data from April 30
% % % % % load('S10007_LCA_LeftACL0_2104261613.mat', 'a18'); 
% %  load('S10007_LCA_LeftACL0_2105261047.mat', 'a18');% Nadav's Left eye data May 26
%  load('S10003Left_LCA_ACL0_2112071212', 'a18');%AR Austin's Left eye data from 211207
% % %LCA task
% % a18(2,1)=14.6;
% % a18(5,1)=opL(1.4);
% % a18(2,2)=14.6;
% % a18(5,2)=opR(1.4);
% 
% 
% %Initialize powers
% power_dispL=a18(2,1);
% powerL=a18(5,1);
% deg=-3; 
% trombone_power_left=powerL;
% 
% %Select Right file
% %load('S10004_LCA_RightACL0_2105191352.mat', 'a18');%Marty's Rt eye May19
% %load('S10003_LCA_RightACL0_2104301024.mat', 'a18'); %AR Austin's Right eye data from April 30
% % load('S10007_LCA_RightACL0_2104201412.mat', 'a18'); %Jim data
% % load('S10007_LCA_RightACL0_2105261020.mat', 'a18');% Nadav's Rt eye data May 26
% % load('S10007Right_LCA_ACL0_2106161205.mat', 'a18');% Nadav's Rt eye data June 16
% %  load('S10007Right_LCA_ACL0_2107081210.mat', 'a18');% Nadav's Rt eye data July 8
% % load('S10009Right_LCA_ACL0_2107201444.mat', 'a18');% Fabio Rt eye data July 20
%  load('S10003Right_LCA_ACL0_2112071148.mat', 'a18');%AR Austin's Right eye data from 211207
% %Initialize powers
% power_dispR=a18(2,2) ;
% powerR=a18(5,2);
% trombone_power_right=powerR;
% %CHANGE DISPLAY OPTOTUNE LEFT
% % power_dispL=a18(2,1);   %[7.1000 28.3450]               
% opto(name_map('l_disp')).control.setFocalPower(power_dispL);
% opto(name_map('l_disp')).control.getFocalPower.focal_power
%                    
% %CHANGE LEFT TROMBONE
% % powerL=a18(5,1);
%             opto(name_map('l_t_near')).control.setFocalPower(powerL); %[6.8400 24.9500]
%             opto(name_map('l_t_far')).control.setFocalPower(powerL); %[7.2400 27.2950]
%             zaber(name_map('l_trombone')).move(l_trombone_f(powerL));%[8.619 13.8]
%             zaber(name_map('l_trombone')).control.waitforidle();
%             
%             [opto(name_map('l_t_near')).control.getFocalPower.focal_power...
%             opto(name_map('l_t_far')).control.getFocalPower.focal_power...
%             zaber(name_map('l_trombone')).control.getposition]
% 
% %ROTATION LEFT
% % deg=-3;            
% zaber(name_map('rotation')).move_deg(deg); %%-6400            
% zaber(name_map('rotation')).control.getposition  
% 
% %LEFT RETICLE
% % trombone_power_left=powerL;
% 
% fprintf('Display LEFT %0.7f \n',power_dispL);
% fprintf('Trombone LEFT %0.7f \n',trombone_power_left);
% fprintf('\n');
% %output final reticle position
% [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
%          fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %CHANGE DISPLAY OPTOTUNE RIGHT
% % power_dispR=a18(2,2) ; %[6.9100 28.0750]
% opto(name_map('r_disp')).control.setFocalPower(power_dispR);
% opto(name_map('r_disp')).control.getFocalPower.focal_power
%         
% %CHANGE RIGHT TROMBONE
% % powerR=a18(5,2); % opR(1);
% % powerR=opR(1);
%             opto(name_map('r_t_near')).control.setFocalPower(powerR); %[6.8550 25.2250]
%             opto(name_map('r_t_far')).control.setFocalPower(powerR); %[7.2400 27.2950]
%             zaber(name_map('r_trombone')).move(r_trombone_f(powerR)); %[7 20]
%             zaber(name_map('r_trombone')).control.waitforidle();
%             
%             
%             [opto(name_map('r_t_near')).control.getFocalPower.focal_power...
%             opto(name_map('r_t_far')).control.getFocalPower.focal_power...
%             zaber(name_map('r_trombone')).control.getposition]
%         
%                   
% %RIGHT RETICLE
% % trombone_power_right=powerR;
% fprintf('\nDisplay RIGHT %0.7f\n',power_dispR);
% fprintf('Trombone RIGHT %0.7f\n',trombone_power_right);
% fprintf('\n');
% %output final reticle position
% [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(trombone_power_left, trombone_power_right); %(LeftTromPwr, RightTromPwr);
%          fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);     
        
         
         

