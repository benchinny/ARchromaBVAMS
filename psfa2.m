
%% 210518 implement psignfit on multiple trial/repetition data
function [r0 r1]=psfa2(y0, y1, w2, d0, s0)
% y0 TCA1
%y1 response correct =1 rv
%w2  optotype stroke size wv
%s0 STK Stroke size vector
%d0 responses to dropdrp=5
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
options = struct;
options.sigmoidName = 'norm';   % choose a cumulative Gaussian as the sigmoid
%options.expType     = '4AFC';   % choose 2-AFC as the paradigm of the experiment
options.expType        = 'nAFC';
options.expN           = 4;

% options.borders= [ 1,2  ...   % threshold between 1 and 2
%                   .1,5  ...   % width between .1 and 5
%                   0, 1 ...   % a fixed lapse rate of .05
%                   0, 1 ...   % a fixed lower asymptote at .05
%             exp(-20),.2];     % a maximum on the variance scale of .2

%     options.borders=[0 40; %6 32; %8.7927   25.9276;
%                     0   31.0570; %2.0771   31.0570;
%                     0    0; %0.5000;
%                     0.2500    0.2500;
%                     0    1]; %0.7368];
%result.options.borders

% options.threshPC       = 0.781; %threshold
% options.betaPrior=1


options.threshPC       = 0.781;
plotOptions = struct;
plotOptions.plotPar        = false; %true;             % plot indications of threshold and asymptotes
plotOptions.xLabel         = 'MAR Acuity'; % X-Axis label

%options.threshPC       = 0.781; %threshold
% options.instantPlot    = 1;
%options.Plot    = 0;
r0=[]; %TCA uncorrected
r1=[]; %TCA corrected

for k0=1:size(w2,1)
    d1=hst0(w2(k0,:), y1(k0,:), d0);
    %     d2=d1; d2(:,1)=s0(d2(:,1)); %get stroke size
    %    d2=d1; d2(:,1)=20.*s0(d2(:,1))./c1; %get Snellen Acuity
    d2=d1; d2(:,1)=s0(d2(:,1))./c1; %MAR Acuity
    
    % % data=[bns' v1' v0'];
    result = psignifit(d2,options);
    %figure; plotPsych(result);
    figure; plotPsych(result,plotOptions);
    rslt=result.Fit; %disp(n2s2(rslt))
    cnfd=result.conf_Intervals;
    [r2 CI]=getThreshold(result, 0.781);%threshold at 78.1% r3=confidence interval
    %     CI(:,3)=(CI(:,2)+CI(:,1))./2;
    %    CI(:,3)=(CI(:,2)-CI(:,1))./2;
    CI=[[68; 90; 95] CI];
    if y0(k0)==1;
        r1=[r1 r2];%rslt(1)];
        %title(['EXP#' num2str(k0+4) ' TCA1 Threshold' n2s(rslt(1))  ' VA=20/'  n2s(20.*rslt(1)./c1)]);
        %title(['EXP#' num2str(k0) ' TCA1 Threshold' n2s(rslt(1))  ' VA=20/'  n2s(20.*rslt(1)./c1)]);
        %        title(['ALL TCA1 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1)]); disp(20.*r2./c1); disp(20.*CI./c1);
        %         title(['ALL TCA1 VA@78.1%=' n2s2(r2)]); disp([r2 rslt(1)]); disp(CI);
        %        title(['ALL TCA1 VA@78.1%=20/' n2s2(rslt(1))]); disp([r2 rslt(1)]); disp( cnfd);
        
        title(['ALL TCA1 VA@78.1%=' n2s2(r2)]); disp(r2); disp(CI);
        
        
        
    else
        r0=[r0 r2];%rslt(1)];
        %title(['EXP#' num2str(k0+4) ' TCA0 Threshlod'  n2s(rslt(1))  ' VA=20/' n2s(20.*rslt(1)./c1)]);
        %title(['EXP#' num2str(k0) ' TCA0 Threshlod'  n2s(rslt(1))  ' VA=20/' n2s(20.*rslt(1)./c1)]);
        %title(['ALL TCA0 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1)]); disp(20.*r2./c1); disp(20.*CI./c1);
        %title(['ALL TCA0 @78.1%=' n2s2(r2)  ' VA=20/'  n2s2(20.*r2./c1) ' p=' n2s2(cnfd)]);
        title(['ALL TCA0 VA@78.1%=' n2s2(r2)]); disp(r2 ); disp(CI);
        
        %title(['ALL TCA0 VA@78.1%=20/' n2s2(rslt(1))]); disp([r2 rslt(1)]); disp( cnfd);
        
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