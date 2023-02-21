close all

clc
load('tca_noACL_left.mat', 'tcanoacl')
figure(1), %in pixels

errorbar(tcanoacl.TromboneOptoPowerD,tcanoacl.Y_BR_AvgTCA,tcanoacl.Y_BR_SD,'--bx'), 
[fitresultYbr,gofYbr]=fit(tcanoacl.TromboneOptoPowerD,tcanoacl.Y_BR_AvgTCA,'poly1')
hold on;
plot(fitresultYbr);

errorbar(tcanoacl.TromboneOptoPowerD,tcanoacl.Y_GR_AvgTCA,tcanoacl.Y_GR_SD,'--gx')
[fitresultYgr,gofYgr]=fit(tcanoacl.TromboneOptoPowerD,tcanoacl.Y_GR_AvgTCA,'poly1')
plot(fitresultYgr);

errorbar(tcanoacl.TromboneOptoPowerD,tcanoacl.X_BR_AvgTCA,tcanoacl.X_BR_SD,'-bo'),
[fitresultXbr,gofXbr]=fit(tcanoacl.TromboneOptoPowerD,tcanoacl.X_BR_AvgTCA,'poly1')
plot(fitresultXbr);

errorbar(tcanoacl.TromboneOptoPowerD,tcanoacl.X_GR_AvgTCA,tcanoacl.X_GR_SD,'-go'),
[fitresultXgr,gofXgr]=fit(tcanoacl.TromboneOptoPowerD,tcanoacl.X_GR_AvgTCA,'poly1')
plot(fitresultXgr);

xlabel('Trombone Opto Power(D)'), ylabel('TCA offset in pixels'),
title('NO ACL: Left side SYSTEM TCA variation (in pixels) with trombone');
hold on;
ax=gca;
legend('Blue-Red Vertical TCA Offset','Fitted curve','Green-Red Vertical TCA Offset','Fitted curve','Blue-Red Horizontal TCA Offset','Fitted curve','Green-Red Horizontal TCA Offset','Fitted curve');
ax.FontSize=34;
hold off;

px=0.2306;%%minofarc
figure(2), %%in minofarc
%note: need to do the fitting on pixel values
errorbar(tcanoacl.TromboneOptoPowerD,px*tcanoacl.Y_BR_AvgTCA,px*tcanoacl.Y_BR_SD,'--bx'), 
[fitresultYbr,gofYbr]=fit(tcanoacl.TromboneOptoPowerD,px*tcanoacl.Y_BR_AvgTCA,'poly1');
hold on;
plot(fitresultYbr);

errorbar(tcanoacl.TromboneOptoPowerD,px*tcanoacl.Y_GR_AvgTCA,px*tcanoacl.Y_GR_SD,'--gx'),
[fitresultYgr,gofYgr]=fit(tcanoacl.TromboneOptoPowerD,px*tcanoacl.Y_GR_AvgTCA,'poly1');
plot(fitresultYgr);

errorbar(tcanoacl.TromboneOptoPowerD,px*tcanoacl.X_BR_AvgTCA,px*tcanoacl.X_BR_SD,'-bo'), 
[fitresultXbr,gofXbr]=fit(tcanoacl.TromboneOptoPowerD,px*tcanoacl.X_BR_AvgTCA,'poly1');
plot(fitresultXbr);

errorbar(tcanoacl.TromboneOptoPowerD,px*tcanoacl.X_GR_AvgTCA,px*tcanoacl.X_GR_SD,'-go'),
[fitresultXgr,gofXgr]=fit(tcanoacl.TromboneOptoPowerD,px*tcanoacl.X_GR_AvgTCA,'poly1');
plot(fitresultXgr);

xlabel('Trombone Opto Power(D)'), ylabel('TCA offset in arc minutes'),
title('NO ACL: Left side SYSTEM TCA variation (in arc min) with trombone');
yticks(-0.6:0.1:0.8);
ax=gca;
ax.FontSize=34;
legend('Blue-Red Vertical TCA Offset','Fitted curve','Green-Red Vertical TCA Offset','Fitted curve','Blue-Red Horizontal TCA Offset','Fitted curve','Green-Red Horizontal TCA Offset','Fitted curve');
% 
hold off;