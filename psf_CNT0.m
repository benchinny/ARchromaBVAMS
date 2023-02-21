%%220227 psf_CNT0 psignfit for constant chromostereopsis based on psf_CNT
 %function [rslt CI95]=psf_CNT(y1, y2)
 function [rslt CI90]=psf_CNT(y1, y2)

% %[[r5 0] ;vu-vb]
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
options = struct;
options.sigmoidName = 'norm';   % choose a cumulative Gaussian as the sigmoid
options.expType     = 'YesNo' ;%  '2AFC';%  % choose 2-AFC as the paradigm of the experiment
%For example this would set the borders to 
%options.borders= [ 1, 2; 0.1, 5; 0.05, 0.05; 0, 0; exp(-20), 0.2];   
% result.options.borders
%    -6.0000    5.0000 threshold 
%     2.0000   28.9655 width 
%          0    0.3889 a fixed lapse rate 
%          0    0.3889 a fixed lower asymptote 
%          0    0.6429 a maximum on the variance scale

    options.borders=[-15 15; %6 32; %8.7927   25.9276;
                    0   30; %2.0771   31.0570;
                    0    0; %0.5000;
                    0    0;
                    0    1];
                options.fixedPars = [NaN,NaN,0,0,NaN]; 

%d1=abs(vu-vb); d1(end)=[];
d0=hst1(y1, y2, 0);

% d11=d1;
% r55=r5;
% 
% d1=[d11 d1];
% r5=[r55 r5];

% d1=abs(vu-vb); d2=d1; d2(d1==0)=[];
% d3=[r5 0]; d4=d3; d4(d1==0)=[];
% d0=hst1(d2, d4, 0);


result = psignifit(d0,options);
figure; plotPsych(result);

rslt=result.Fit;
%CI95=result.conf_Intervals(1,:,3);
CI90=result.conf_Intervals(1,:,2);

title(['THRESHOLD=' n2s(rslt(1))]);
ylabel('Proportion Blue Infront') %Behined 210521
xlabel('Pixels of Disparity')