%% plot staircase


function strc(y0, w2, y2); % [r0 r1]=psf(y0, y1, w2, d0, s0)
for k0=1:size(w2,1)

    figure; plot(w2(k0,:)); axis([1 size(w2,2) 0 y2(2)]); %ylim(y2);
    if y0(k0)==1;
        
%         title(['EXP#' num2str(k0) ' TCA1 Threshold']);
        t=['EXP#' num2str(k0) ' TCA1'];

    else
        
%         title(['EXP#' num2str(k0) ' TCA0 Threshlod']);
        t=['EXP#' num2str(k0) ' TCA0'];


    end
    
    lbl(['Trial #'], ['Visual acuity'], t)
end
% 
% figure; plot(w2)
% % wv(1:drp)=[];
% % bns=[min(wv):max(wv)];
% % v0=zeros(1,length(bns));
% % v1=v0;
% % for k0=1:length(wv)
% %     k1=wv(k0);
% %     v0=v0+(k1==bns);
% %     v1=v1+rv(k0)*(k1==bns);
% % end
% % 
% % figure; bar(bns, v1./v0)
% 
% 
% %% implement psignfit on multiple trial/repetition data
%  function [r0 r1]=psf(y0, y1, w2, d0, s0)
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
% %options.threshPC       = 0.7; %threshold
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
%     figure; plotPsych(result);
%     rslt=result.Fit;
%     cnfd=result.conf_Intervals;
%     if y0(k0)==1;
%         r1=[r1 rslt(1)];
%         title(['EXP#' num2str(k0+4) ' TCA1 Threshold' n2s(rslt(1))  ' VA=20/'  n2s(20.*rslt(1)./c1)]);
%     else
%         r0=[r0 rslt(1)];
%         title(['EXP#' num2str(k0+4) ' TCA0 Threshlod'  n2s(rslt(1))  ' VA=20/' n2s(20.*rslt(1)./c1)]);
% 
%     end
% end