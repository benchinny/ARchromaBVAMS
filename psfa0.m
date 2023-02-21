
%% 210423 implement psignfit on multiple trial/repetition data 
 function [r0 r1]=psfa0(y0, y1, w2, d0, s0)
% y0 TCA1
%y1 response correct =1 rv
%w2  optotype stroke size wv
%s0 STK Stroke size vector
%d0 responses to dropdrp=5
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
options = struct;
options.sigmoidName = 'norm';   % choose a cumulative Gaussian as the sigmoid
options.expType     = '4AFC';   % choose 2-AFC as the paradigm of the experiment
%options.threshPC       = 0.781;
plotOptions = struct;
plotOptions.plotPar        = false; %true;             % plot indications of threshold and asymptotes

%options.threshPC       = 0.781; %threshold
% options.instantPlot    = 1;
%options.Plot    = 0;
r0=[]; %TCA uncorrected
r1=[]; %TCA corrected

for k0=1:size(w2,1)
    d1=hst0(w2(k0,:), y1(k0,:), d0);
    d2=d1; d2(:,1)=s0(d2(:,1));
    % % data=[bns' v1' v0'];
    result = psignifit(d2,options);
    %figure; plotPsych(result);
    figure; plotPsych(result,plotOptions);
    rslt=result.Fit; %disp(n2s2(rslt))
    cnfd=result.conf_Intervals;
    [r2 CI]=getThreshold(result, 0.781);%threshold at 78.1% r3=confidence interval

    if y0(k0)==1;
        r1=[r1 r2];%rslt(1)];
        %title(['EXP#' num2str(k0+4) ' TCA1 Threshold' n2s(rslt(1))  ' VA=20/'  n2s(20.*rslt(1)./c1)]);
        %title(['EXP#' num2str(k0) ' TCA1 Threshold' n2s(rslt(1))  ' VA=20/'  n2s(20.*rslt(1)./c1)]);
        title(['ALL TCA1 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1)]); disp(20.*r2./c1); disp(20.*CI./c1);
        %title(['ALL TCA1 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1) ' p=' n2s2(cnfd)]);


    else
        r0=[r0 r2];%rslt(1)];
        %title(['EXP#' num2str(k0+4) ' TCA0 Threshlod'  n2s(rslt(1))  ' VA=20/' n2s(20.*rslt(1)./c1)]);
        %title(['EXP#' num2str(k0) ' TCA0 Threshlod'  n2s(rslt(1))  ' VA=20/' n2s(20.*rslt(1)./c1)]);
        title(['ALL TCA0 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1)]); disp(20.*r2./c1); disp(20.*CI./c1);
        %title(['ALL TCA0 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1) ' p=' n2s2(cnfd)]);


    end
end
% 
% %% 210423 implement psignfit on multiple trial/repetition data 
%  function [r0 r1]=psfa0(y0, y1, w2, d0, s0)
% % y0 TCA1
% %y1 response correct =1 rv
% %w2  optotype stroke size wv
% %s0 STK Stroke size vector
% %d0 responses to dropdrp=5
% c0=0.00384; %deg/pixels
% c1=1./(c0.*60);
% options = struct;
% options.sigmoidName = 'norm';   % choose a cumulative Gaussian as the sigmoid
% options.expType     = '4AFC';   % choose 2-AFC as the paradigm of the experiment
% plotOptions = struct;
% plotOptions.plotPar        = false; %true;             % plot indications of threshold and asymptotes
% 
% %options.threshPC       = 0.781; %threshold
% % options.instantPlot    = 1;
% %options.Plot    = 0;
% r0=[]; %TCA uncorrected
% r1=[]; %TCA corrected
% 
% for k0=1:size(w2,1)
%     d1=hst0(w2(k0,:), y1(k0,:), d0);
%     d2=d1; d2(:,1)=s0(d2(:,1));
%     % % data=[bns' v1' v0'];
%     result = psignifit(d2,options);
%     %figure; plotPsych(result);
%     figure; plotPsych(result,plotOptions);
%     rslt=result.Fit;
%     cnfd=result.conf_Intervals;
%     r2=getThreshold(result, 0.781)%threshold at 78.1%
% 
%     if y0(k0)==1;
%         r1=[r1 r2];%rslt(1)];
%         %title(['EXP#' num2str(k0+4) ' TCA1 Threshold' n2s(rslt(1))  ' VA=20/'  n2s(20.*rslt(1)./c1)]);
%         %title(['EXP#' num2str(k0) ' TCA1 Threshold' n2s(rslt(1))  ' VA=20/'  n2s(20.*rslt(1)./c1)]);
%         title(['ALL TCA1 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1)]);
%         %title(['ALL TCA1 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1) ' p=' n2s2(cnfd)]);
% 
% 
%     else
%         r0=[r0 r2];%rslt(1)];
%         %title(['EXP#' num2str(k0+4) ' TCA0 Threshlod'  n2s(rslt(1))  ' VA=20/' n2s(20.*rslt(1)./c1)]);
%         %title(['EXP#' num2str(k0) ' TCA0 Threshlod'  n2s(rslt(1))  ' VA=20/' n2s(20.*rslt(1)./c1)]);
%         title(['ALL TCA0 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1)]);
%         %title(['ALL TCA0 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1) ' p=' n2s2(cnfd)]);
% 
% 
%     end
% end