%%

sn = [18 23 24 26 27 29 32 33];
frmDuration = 0.033;

figure;
set(gcf,'Position',[105 245 1479 647]);
for i = 1:length(sn) 
    subplot(2,4,i);
    set(gca,'FontSize',15);
    hold on;
    [x3stackRed,x3stackBlue,x3stackMixed,tInterp,AFCp,indCndCell] = ARCnlz_redVsBlueVsMixed(sn(i),0);
    meanAnchor = mean(x3stackMixed(:,1));
    tSamples = [0:frmDuration:(size(x3stackMixed,2)-1)*frmDuration];
    xStackCIred = quantile(x3stackRed,[0.16 0.84])-meanAnchor;
    xStackCIblue = quantile(x3stackBlue,[0.16 0.84])-meanAnchor;
    xStackCImixed = quantile(x3stackMixed,[0.16 0.84])-meanAnchor;
    fill([tSamples fliplr(tSamples)],[xStackCIred(1,:) fliplr(xStackCIred(2,:))],[1 0 0],'FaceAlpha',0.1,'EdgeColor','none');
    fill([tSamples fliplr(tSamples)],[xStackCIblue(1,:) fliplr(xStackCIblue(2,:))],[0 0 1],'FaceAlpha',0.1,'EdgeColor','none');
    fill([tSamples fliplr(tSamples)],[xStackCImixed(1,:) fliplr(xStackCImixed(2,:))],[1 0 1],'FaceAlpha',0.1,'EdgeColor','none');
    plot([0:frmDuration:(size(x3stackRed,2)-1)*frmDuration],mean(x3stackRed)-meanAnchor,'-','Color',[1 0 0],'LineWidth',2);
    plot([0:frmDuration:(size(x3stackBlue,2)-1)*frmDuration],mean(x3stackBlue)-meanAnchor,'-','Color',[0 0 1],'LineWidth',2);
    plot([0:frmDuration:(size(x3stackMixed,2)-1)*frmDuration],mean(x3stackMixed)-meanAnchor,'-','Color',[1 0 1],'LineWidth',2);
    display(['Done with subject: ' num2str(i)]);
    axis square;
    xlim([0 3]);
    ylim([-3 3]);
    xlabel('Time (s)'); ylabel('Relative Power (Diopters)');     
end

%%

clear;