close all;
clc;
load('RightTCA.mat');
figure(1),

errorbar(RightTCA.RightTrombonePowerD, RightTCA.Y_BlueRed_AvgTCA, RightTCA.Y_BlueRed_StdDev,'--bx')
hold on;
[fitresultYbr,gofYbr]=fit(RightTCA.RightTrombonePowerD, RightTCA.Y_BlueRed_AvgTCA,'poly1')
plot(fitresultYbr);


errorbar(RightTCA.RightTrombonePowerD, RightTCA.Y_GreenRed_AvgTCA, RightTCA.Y_GreenRed_StdDev,'--gx')
[fitresultYgr,gofYgr]= fit(RightTCA.RightTrombonePowerD, RightTCA.Y_GreenRed_AvgTCA,'poly1')
plot(fitresultYgr);


errorbar(RightTCA.RightTrombonePowerD, RightTCA.X_BlueRed_AvgTCA, RightTCA.X_BlueRed_StdDev,'-bo')
[fitresultXbr,gofXbr]=fit(RightTCA.RightTrombonePowerD, RightTCA.X_BlueRed_AvgTCA,'poly1')
plot(fitresultXbr);


errorbar(RightTCA.RightTrombonePowerD, RightTCA.X_GreenRed_AvgTCA, RightTCA.X_GreenRed_StdDev,'-go')
[fitresultXgr,gofXgr]=fit(RightTCA.RightTrombonePowerD, RightTCA.X_GreenRed_AvgTCA,'poly1')
plot(fitresultXgr);

% errorbar(RightTCA.RightTrombonePowerD, RightTCA.X_BlueRed_AvgTCA, RightTCA.X_BlueRed_StdDev,'-bo')
% % [fitresultXbr,gofXbr]=fit(RightTCA.RightTrombonePowerD, RightTCA.X_BlueRed_AvgTCA,fittype({'x'}));
% options=fitoptions('Method', 'NonlinearLeastSquares','StartPoint',[0 0]);
% % t2=fitlm(RightTCA.RightTrombonePowerD, RightTCA.X_BlueRed_AvgTCA,'Intercept', false);
% % plot(t2);
% [fitresultXbr,gofXbr]=fit(RightTCA.RightTrombonePowerD, RightTCA.X_BlueRed_AvgTCA,'poly1',options);
% % y1 = polyval(fitresultXbr,RightTCA.RightTrombonePowerD);
% % y1=0.14817*RightTCA.RightTrombonePowerD;
% % plot(RightTCA.RightTrombonePowerD,y1)
% plot(fitresultXbr);
% 
% 
% errorbar(RightTCA.RightTrombonePowerD, RightTCA.X_GreenRed_AvgTCA, RightTCA.X_GreenRed_StdDev,'-go')
% [fitresultXgr,gofXgr]=fit(RightTCA.RightTrombonePowerD, RightTCA.X_GreenRed_AvgTCA,fittype({'x'}));
% plot(fitresultXgr);
% t3=fitlm(RightTCA.RightTrombonePowerD, RightTCA.X_GreenRed_AvgTCA,'Intercept', false);
% plot(t3);
% [fitresultXgr,gofXgr]=polyfit(RightTCA.RightTrombonePowerD, RightTCA.X_GreenRed_AvgTCA);
% slope=RightTCA.X_GreenRed_AvgTCA./RightTCA.RightTrombonePowerD;
% % y2=polyval(fitresultXgr,RightTCA.RightTrombonePowerD);
% y2=slope.*RightTCA.RightTrombonePowerD;
% plot(RightTCA.RightTrombonePowerD,y2);

legend('Blue-Red Vertical TCA offset ', 'fit','Green-Red Vertical TCA offset','fit','Blue-Red Horizontal TCA offset ', 'fit','Green-Red Horizontal TCA offset' ,'fit');
xlabel('Trombone Opto Power(D)'), ylabel('TCA offset in pixels'),
title('Right side SYSTEM TCA variation (in pixels) with trombone');
ax=gca;
ax.FontSize=34;
hold off;

px=0.2306;%%minofarc
figure(2),
errorbar(RightTCA.RightTrombonePowerD, px*RightTCA.Y_BlueRed_AvgTCA, px*RightTCA.Y_BlueRed_StdDev,'--bx')
xlabel('Trombone Opto Power(D)'), ylabel('TCA offset in arc min'),
title('Right side SYSTEM TCA variation (in arc minutes) with trombone');
yticks(-0.6:0.1:0.8); 
ax=gca;
hold on;
errorbar(RightTCA.RightTrombonePowerD, px*RightTCA.Y_GreenRed_AvgTCA, px*RightTCA.Y_GreenRed_StdDev,'--gx')


errorbar(RightTCA.RightTrombonePowerD, px*RightTCA.X_BlueRed_AvgTCA, px*RightTCA.X_BlueRed_StdDev,'-bo')
errorbar(RightTCA.RightTrombonePowerD, px*RightTCA.X_GreenRed_AvgTCA, px*RightTCA.X_GreenRed_StdDev,'-go')
% ax.FontSize=34;
% legend('Blue-Red Vertical TCA offset ', 'Green-Red Vertical TCA offset','Blue-Red Horizontal TCA offset ', 'Green-Red Horizontal TCA offset' );