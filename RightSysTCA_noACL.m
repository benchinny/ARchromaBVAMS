close all;
clc;
load('tca_noACL_right.mat', 'tcanoacl')
figure(1),

errorbar(tcanoacl.TromboneOptoPowerD, tcanoacl.Y_BR_AvgTCA, tcanoacl.Y_BR_SD,'--bx')
hold on;
[fitresultYbr,gofYbr]=fit(tcanoacl.TromboneOptoPowerD, tcanoacl.Y_BR_AvgTCA,'poly1')
plot(fitresultYbr,'b');


errorbar(tcanoacl.TromboneOptoPowerD, tcanoacl.Y_GR_AvgTCA, tcanoacl.Y_GR_SD,'--gx')
[fitresultYgr,gofYgr]= fit(tcanoacl.TromboneOptoPowerD, tcanoacl.Y_GR_AvgTCA,'poly1')
plot(fitresultYgr,'g');


errorbar(tcanoacl.TromboneOptoPowerD, tcanoacl.X_BR_AvgTCA, tcanoacl.X_BR_SD,'-bo')
[fitresultXbr,gofXbr]=fit(tcanoacl.TromboneOptoPowerD, tcanoacl.X_BR_AvgTCA,'poly1')
plot(fitresultXbr,'b');


errorbar(tcanoacl.TromboneOptoPowerD, tcanoacl.X_GR_AvgTCA, tcanoacl.X_GR_SD,'-go')
[fitresultXgr,gofXgr]=fit(tcanoacl.TromboneOptoPowerD, tcanoacl.X_GR_AvgTCA,'poly1')
plot(fitresultXgr,'g');

% errorbar(tcanoacl.TromboneOptoPowerD, tcanoacl.X_BR_AvgTCA, tcanoacl.X_BR_SD,'-bo')
% % [fitresultXbr,gofXbr]=fit(tcanoacl.TromboneOptoPowerD, tcanoacl.X_BR_AvgTCA,fittype({'x'}));
% options=fitoptions('Method', 'NonlinearLeastSquares','StartPoint',[0 0]);
% % t2=fitlm(tcanoacl.TromboneOptoPowerD, tcanoacl.X_BR_AvgTCA,'Intercept', false);
% % plot(t2);
% [fitresultXbr,gofXbr]=fit(tcanoacl.TromboneOptoPowerD, tcanoacl.X_BR_AvgTCA,'poly1',options);
% % y1 = polyval(fitresultXbr,tcanoacl.TromboneOptoPowerD);
% % y1=0.14817*tcanoacl.TromboneOptoPowerD;
% % plot(tcanoacl.TromboneOptoPowerD,y1)
% plot(fitresultXbr);
% 
% 
% errorbar(tcanoacl.TromboneOptoPowerD, tcanoacl.X_GR_AvgTCA, tcanoacl.X_GR_SD,'-go')
% [fitresultXgr,gofXgr]=fit(tcanoacl.TromboneOptoPowerD, tcanoacl.X_GR_AvgTCA,fittype({'x'}));
% plot(fitresultXgr);
% t3=fitlm(tcanoacl.TromboneOptoPowerD, tcanoacl.X_GR_AvgTCA,'Intercept', false);
% plot(t3);
% [fitresultXgr,gofXgr]=polyfit(tcanoacl.TromboneOptoPowerD, tcanoacl.X_GR_AvgTCA);
% slope=tcanoacl.X_GR_AvgTCA./tcanoacl.TromboneOptoPowerD;
% % y2=polyval(fitresultXgr,tcanoacl.TromboneOptoPowerD);
% y2=slope.*tcanoacl.TromboneOptoPowerD;
% plot(tcanoacl.TromboneOptoPowerD,y2);

legend('Blue-Red Vertical TCA offset ', 'fit','Green-Red Vertical TCA offset','fit','Blue-Red Horizontal TCA offset ', 'fit','Green-Red Horizontal TCA offset' ,'fit');
xlabel('Trombone Opto Power(D)'), ylabel('TCA offset in pixels'),
title('NO ACL: Right side SYSTEM TCA variation (in px) with trombone');
ax=gca;
ax.FontSize=34;
hold off;

px=0.2306;%%minofarc
figure(2),
errorbar(tcanoacl.TromboneOptoPowerD, px*tcanoacl.Y_BR_AvgTCA, px*tcanoacl.Y_BR_SD,'--bx')
xlabel('Trombone Opto Power(D)'), ylabel('TCA offset in arc min'),
title('Right side SYSTEM TCA variation (in arc minutes) with trombone');
yticks(-0.6:0.1:0.8); 
ax=gca;
hold on;
errorbar(tcanoacl.TromboneOptoPowerD, px*tcanoacl.Y_GR_AvgTCA, px*tcanoacl.Y_GR_SD,'--gx')


errorbar(tcanoacl.TromboneOptoPowerD, px*tcanoacl.X_BR_AvgTCA, px*tcanoacl.X_BR_SD,'-bo')
errorbar(tcanoacl.TromboneOptoPowerD, px*tcanoacl.X_GR_AvgTCA, px*tcanoacl.X_GR_SD,'-go')
% ax.FontSize=34;
% legend('Blue-Red Vertical TCA offset ', 'Green-Red Vertical TCA offset','Blue-Red Horizontal TCA offset ', 'Green-Red Horizontal TCA offset' );