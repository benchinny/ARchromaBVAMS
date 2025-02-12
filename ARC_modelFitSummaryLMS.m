%%

RMSvals = [0.0891 0.11  0.223; ...
           0.0648 0.143 0.233; ...
           0.157  0.112 0.385; ...
           0.164  0.165 0.432; ...
           0.0902 0.136 0.219; ...
           0.102  0.195 0.259; ...
           0.144  0.111 0.295; ...
           0.105  0.182 0.106];

figure;
set(gcf,'Position',[314 423 915 420]);
hold on;
for i = 1:size(RMSvals,1)
    bar((i-1)*4+1,RMSvals(i,1),'FaceColor','b','LineWidth',1);
    bar((i-1)*4+2,RMSvals(i,2),'FaceColor','k','LineWidth',1);
    bar((i-1)*4+3,RMSvals(i,3),'FaceColor','w','LineWidth',1);
end
set(gca,'FontSize',15);
set(gca,'XTick',1+[1 5 9 13 17 21 25 29]);
set(gca,'XTickLabel',{'S1' 'S3' 'S5' 'S10' 'S16' 'S17' 'S18' 'S20'});
xlabel('Subject');
ylabel('Model RMSE');
legend('(L+M)-S','Always same wavelength','Luminance');
