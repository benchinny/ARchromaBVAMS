%psignfit for contrast sensitivity
 function [x t0]=psf_CSF(r2, c2, s1, s2, d0)
 
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
options = struct;
options.sigmoidName = 'norm';   % choose a cumulative Gaussian as the sigmoid
options.expType     = '2AFC';%  % choose 2-AFC as the paradigm of the experiment
%For example this would set the borders to 
%options.borders= [ 1, 2; 0.1, 5; 0.05, 0.05; 0, 0; exp(-20), 0.2];   

for k0=1:length(s2)
d0=hst1(c2(k0,:), r2(k0,:), 0);
result = psignifit(d0,options);
figure; plotPsych(result);
t0(k0)=result.Fit(1);
%CI(k0,:)=result.conf_Intervals(1,:,3).
%title(['PIXEL SHIFT=' n2s(s2(k0)) ' THRESHOLD=' n2s2(100.*t0(k0)) '% CONTRAST']);
title(['PHASE SHIFT=' n2s(s2(k0)) ' THRESHOLD=' n2s2(100.*t0(k0)) '% CONTRAST']);
ylabel('Proportion Correct')
xlabel('CONTRAST')
end

% figure; plot(s2, t0, 'o-')
%figure; plot(1920./(2.*s1).*s2, t0, 'o-'); %abscissa in pixels
x=1920./(2.*s1).*s2./c1; %-1.5026   -1.0017   -0.5009         0    0.5009    1.0017    1.5026
%fo=fitoptions('Method','NonlinearLeastSquares','StartPoint', [max(t0)-min(t0) 1/3 pi mean(t0)]);
%ft=fittype('a*sin(b*x+b)+d', 'options', fo);
% ft=fittype('a*sin(b*x+c)+d');
% 
% % y=fit(x', t0', ft, 'StartPoint', [max(t0)-min(t0) 1/3 pi mean(t0)]);
% a0=max(t0)-min(t0);
% b0=abs(x(find(t0==max(t0)))-x(find(t0==min(t0))))
% 
% y=fit(x', t0', ft, 'StartPoint', [max(t0)-min(t0) abs(x(find(t0==max(t0)))-x(find(t0==min(t0)))) 2 0.3]);
% plot(y)
% hold on
figure; plot(x, t0, 'o-'); %abscissa in arcmin
lbl('Phase Shift (arcmin)', 'Contrast', 'Pixel shift vs. Contrast')
%y
%1920./(2.*g0(2)).*s2./c1

% d2(d1==0)=[]
% d1(d1==0)=[]
% % d0=hst0(abs([vu-vb]), [r5 0], 0);
% d0=hst0(d1, d2, 0);
% 
%     result = psignifit(d0,options);
%     figure; plotPsych(result);
%     rslt=result.Fit;
%     title(['THRESHOLD=' n2s(rslt(1)) ' pixels = 20/'  n2s(20.*rslt(1)./c1)])
% 
% 
% 
% % '2AFC', fixes the lower asymptote to .5 and fits the rest, for 2
% % alternative forced choice experiments.
% options.expType        = '2AFC';   
%     
% %% options.threshPC       = .5
% % Which percent correct correspond to the threshold? 
% % Given in Percent correct on the unscaled sigmoid (reaching from 0 to 1).
% 
% % For example to define the threshold as 90% correct try:  
% 
% options.threshPC       = .9;
%     
% %% options.borders
% % In this field you may provide your own bounds for the parameters.
% % This should be a 5x2 matrix of start and end of the range for the 5
% % parameters. (threshold,width,upper asymptote,lower asymptote,variance
% % scale)
% 
% %For example this would set the borders to 
% options.borders= [ 1,2  ...   % threshold between 1 and 2
%                   .1,5  ...   % width between .1 and 5
%                  .05,.05...   % a fixed lapse rate of .05
%                   .5,.5 ...   % a fixed lower asymptote at .05
%             exp(-20),.2];     % a maximum on the variance scale of .2
% 
% % NOTE: By this you artificially exclude all values out of this range. Only
% % exclude parameter values, which are truely impossible!
% 
% %% options.widthalpha     = .05
% % This changes how the width of a psychometric function is defined
% % width= psi^(-1)(1-alpha) - psi^(-1)(alpha)
% % where psi^(-1) is the inverse of the sigmoid function.
% % widthalpha must be between 0 and .5 excluding
% 
% % Thus this would enable the useage of the interval from .1 to .9 as the
% % width for example:
% options.widthalpha     = .1;
% 
% 
% %% obtaining threshold values 
% % For comparison to other estimation techniques we provide functions to
% % calculate thresholds at any given percent correct. 
% 
% % The first function is getThreshold(result, pCorrect, unscaled). It
% % calculates the threshold of the function fit in result with pCorrect
% % proportion correct. Unscaled toggles, whether you refer to the pCorrect
% % obtained in the experiment (default), or to the percent correct on the
% % original function unscaled by guessing and lapse rate.
% 
% % For example: This call will find the value at which our function reaches
% % 90% correct:
% getThreshold(res,0.9)
% % which should be 0.0058 
%      
% 
% % A usecase for the unscaled case might be to find the threshold for the
% % middle of the psychometric function independent of the guessing and lapse
% % rate:
% getThreshold(res,0.5,1)
% % which should be 0.0046, which is exactly the definition of the threshold
% % we use in the fitting.
% 
% % The function also computes worst case credible intervals for the
% % threshold. 
% 
% [threshold,CI] = getThreshold(res,0.5,1)
% 
% % The credible intervals are for the confidence levels given for your
% % function fit. 
% % The estimates calculated by this function are very conservative, when
% % you move far away from the original threshold, as we simply assume the
% % worst case for all other parameters instead of averaging over the values
% % correctly.

