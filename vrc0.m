% clear all
 close all
 clc
global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% p0(1)=1000/75 +1/.789;  %power_disp
% p0(2)=12.5; % power
% p0(3)=0.8; %mag
% p0(4)=0; %rot
% p0(5)=0; % set to 1 to close optotune at the end of LCA experiment, otherwise 0.


%      power_disp = 1000/75 +1/.789;%setting for calibration with offset lens %distance=38.3+40.6=78.9cm as we insreased the distance of display further by putting 40.6 cm cage rods
%      power=12.5;
%      mag = 0.8;
%      rot = 0.0;
%                 power = mag_to_d(mag);
p0=zeros(4,2);
% p0(1,1)=12.800760;  %power_disp_L
% p0(1,2)=13.500760;  %power_disp_R;
% 
% p0(2,1)=12.5;  %power_L;
% p0(2,2)=10.309278;  %power_R;

p0(1,1)= 12.700760;  %power_disp_L
p0(1,2)=13.200760;  %power_disp_R;

% p0(1,1)=14.100760;  %power_disp_L
% p0(1,2)=14.300760;  %power_disp_R;
% 
p0(2,1)=12.5;  %power_L;
p0(2,2)=10.752688;  %power_R;

%  p0(2,1)=1.0;  %mag_L;
%  p0(2,2)=1.0;  %mag_R;

p0(3,1)=-2.9; %rotation
p0(4,1)=0; %turn off system if =1

    %fprintf('Shutting down\n')
    sca;
    %if enable_optotunes
    a = instrfind();
try; fclose(a); catch; end
delete(a)
 clear a
        for p = 1:6
            try
                %                 a = instrfind();
                %                 fclose(a);
                %                 delete(a);
                opto(p).control.Close();
            catch
            end
        end



vrc(p0)
% vrcm(p0)