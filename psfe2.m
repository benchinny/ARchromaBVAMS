
%% 210705 psignfit for indivisual ETM staircases
function r1=psfe2(y0, y1, w2, d0, d00)
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
options.fixedPars = [NaN,NaN,0,0.25,NaN]; 

%result.options.borders

% options.threshPC       = 0.781; %threshold
% options.betaPrior=1


options.threshPC       = 0.781;
plotOptions = struct;
plotOptions.plotPar        = false; %true;             % plot indications of threshold and asymptotes
plotOptions.xLabel         = 'LogMAR Acuity'; % X-Axis label

%options.threshPC       = 0.781; %threshold
% options.instantPlot    = 1;
%options.Plot    = 0;
r0=[]; %TCA uncorrected
r1=[]; %TCA corrected

%for k0=1:size(w2,1)
    %d1=hst0(w2(k0,:), y1(k0,:), d0);
%     d1=hst1(w2(k0,:), y1(k0,:), d0);
    d1=hst1(w2, y1, d0);

    %     d2=d1; d2(:,1)=s0(d2(:,1)); %get stroke size
    %    d2=d1; d2(:,1)=20.*s0(d2(:,1))./c1; %get Snellen Acuity
%     d2=d1; d2(:,1)=s0(d2(:,1))./c1; %MAR Acuity
    d2=d1; d2(:,1)=d2(:,1)./c1; %MAR Acuity
    d3=d2; d3(:,1)=log10(d3(:,1));
    
    % % data=[bns' v1' v0'];
    result = psignifit(d3,options);
    %figure; plotPsych(result);
    figure; plotPsych(result,plotOptions);
    rslt=result.Fit; %disp(n2s2(rslt))
    cnfd=result.conf_Intervals;
    [r2 CI]=getThreshold(result, 0.781);%threshold at 78.1% r3=confidence interval
    %     CI(:,3)=(CI(:,2)+CI(:,1))./2;
    %    CI(:,3)=(CI(:,2)-CI(:,1))./2;
    
    %CI=[[68; 90; 95] CI];
%    if y0(k0)==1;
        %r1=[r1 r2];%rslt(1)];
        title(['ALL TCA' n2s(y0)  ' VA@78.1%= ' n2s2(r2) 'LogMAR ' n2s2(10.^r2) 'MAR']); %disp(r2); disp(CI);
        r1=[[1; 95; 90; 68] [[sum(d1(:,3)) sum(d1(:,3)) 10.^r2 r2]; CI(:,1), 10.^CI, CI(:,2)]];
%    elseif y0(k0)==0;
        %r0=[r0 r2];%rslt(1)];
%        title(['ALL TCA0 VA@78.1%=' n2s2(r2) 'LogMAR ' n2s2(10.^r2) 'MAR']); %disp(r2 ); disp(CI);
%        r0=[[0; 95; 90; 68] [[sum(d1(:,3)) sum(d1(:,3)) 10.^r2 r2]; CI(:,1), 10.^CI, CI(:,2)]];
%    end
%end

