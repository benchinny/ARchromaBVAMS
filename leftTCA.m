close all
clc
load('LeftTCA.mat')
figure(1), %in pixels

errorbar(LeftTCA.TromboneOptoPowerD,LeftTCA.Y_BR_AvgTCA,LeftTCA.Y_BR_SD,'--bx'), 
[fitresultYbr,gofYbr]=fit(LeftTCA.TromboneOptoPowerD,LeftTCA.Y_BR_AvgTCA,'poly1')
hold on;
plot(fitresultYbr);

errorbar(LeftTCA.TromboneOptoPowerD,LeftTCA.Y_GR_AvgTCA,LeftTCA.Y_GR_SD,'--gx')
[fitresultYgr,gofYgr]=fit(LeftTCA.TromboneOptoPowerD,LeftTCA.Y_GR_AvgTCA,'poly1')
plot(fitresultYgr);

errorbar(LeftTCA.TromboneOptoPowerD,LeftTCA.X_BR_AvgTCA,LeftTCA.X_BR_SD,'-bo'),
[fitresultXbr,gofXbr]=fit(LeftTCA.TromboneOptoPowerD,LeftTCA.X_BR_AvgTCA,'poly1')
plot(fitresultXbr);

errorbar(LeftTCA.TromboneOptoPowerD,LeftTCA.X_GR_AvgTCA,LeftTCA.X_GR_SD,'-go'),
[fitresultXgr,gofXgr]=fit(LeftTCA.TromboneOptoPowerD,LeftTCA.X_GR_AvgTCA,'poly1')
plot(fitresultXgr);

xlabel('Trombone Opto Power(D)'), ylabel('TCA offset in pixels'),
title('Left side SYSTEM TCA variation (in pixels) with trombone');
hold on;
ax=gca;
legend('Blue-Red Vertical TCA Offset','Fitted curve','Green-Red Vertical TCA Offset','Fitted curve','Blue-Red Horizontal TCA Offset','Fitted curve','Green-Red Horizontal TCA Offset','Fitted curve');
ax.FontSize=34;
hold off;

px=0.2306;%%minofarc
figure(2), %%in minofarc
%note: need to do the fitting on pixel values
errorbar(LeftTCA.TromboneOptoPowerD,px*LeftTCA.Y_BR_AvgTCA,px*LeftTCA.Y_BR_SD,'--bx'), 
[fitresultYbr,gofYbr]=fit(LeftTCA.TromboneOptoPowerD,px*LeftTCA.Y_BR_AvgTCA,'poly1');
hold on;
plot(fitresultYbr);

errorbar(LeftTCA.TromboneOptoPowerD,px*LeftTCA.Y_GR_AvgTCA,px*LeftTCA.Y_GR_SD,'--gx'),
[fitresultYgr,gofYgr]=fit(LeftTCA.TromboneOptoPowerD,px*LeftTCA.Y_GR_AvgTCA,'poly1');
plot(fitresultYgr);

errorbar(LeftTCA.TromboneOptoPowerD,px*LeftTCA.X_BR_AvgTCA,px*LeftTCA.X_BR_SD,'-bo'), 
[fitresultXbr,gofXbr]=fit(LeftTCA.TromboneOptoPowerD,px*LeftTCA.X_BR_AvgTCA,'poly1');
plot(fitresultXbr);

errorbar(LeftTCA.TromboneOptoPowerD,px*LeftTCA.X_GR_AvgTCA,px*LeftTCA.X_GR_SD,'-go'),
[fitresultXgr,gofXgr]=fit(LeftTCA.TromboneOptoPowerD,px*LeftTCA.X_GR_AvgTCA,'poly1');
plot(fitresultXgr);

xlabel('Trombone Opto Power(D)'), ylabel('TCA offset in arc minutes'),
title('Left side SYSTEM TCA variation (in arc min) with trombone');
yticks(-0.6:0.1:0.8);
ax=gca;
ax.FontSize=34;
legend('Blue-Red Vertical TCA Offset','Fitted curve','Green-Red Vertical TCA Offset','Fitted curve','Blue-Red Horizontal TCA Offset','Fitted curve','Green-Red Horizontal TCA Offset','Fitted curve');
% 
hold off;