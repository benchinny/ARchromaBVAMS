%%

clear;

%%

subjNumAll = [1 3 5 9 10 16 17 18 20];
defocusLCAmeasuredAll = [];
q1bestAll = [];
q2bestAll = [];
q3bestAll = [];
defocusLCAmeasuredBootsAll = [];

for i = 1:length(subjNumAll)
    [defocusLCAmeasured, q1best, q2best, q3best,defocusLCAmeasuredBoots] = ARCacuAnalysisLCA(subjNumAll(i),0,100);
    defocusLCAmeasuredAll(i,:) = defocusLCAmeasured;
    q1bestAll(i) = q1best;
    q2bestAll(i) = q2best;
    q3bestAll(i) = q3best;
    defocusLCAmeasuredBootsAll(:,:,i) = defocusLCAmeasuredBoots;
    display(['Finished subject ' num2str(i)]);
end

%%

wave2fit = 460:624;
standardLCAfit = humanWaveDefocus(wave2fit);
val532 = humanWaveDefocus(532);
standardLCAfit = standardLCAfit-val532;
displacementLambda = -4:4;

figure;
hold on;
plot(wave2fit,standardLCAfit,'k-','LineWidth',1);
for i = 1:size(defocusLCAmeasuredAll,1)
    defocusLCAmeasuredBootsTmp = squeeze(defocusLCAmeasuredBootsAll(:,:,i));
    CIlca = -quantile(defocusLCAmeasuredBootsTmp',[0.16 0.84]);
    set(gca,'ColorOrderIndex',i);
    errorbar([616 533 468]-displacementLambda(i), ...
             -(defocusLCAmeasuredAll(i,:)-defocusLCAmeasuredAll(i,2)), ...
             -(defocusLCAmeasuredAll(i,:)-defocusLCAmeasuredAll(i,2))-CIlca(2,:), ...
             CIlca(1,:)+(defocusLCAmeasuredAll(i,:)-defocusLCAmeasuredAll(i,2)), ...
             '.','MarkerSize',10, ...
        'LineWidth',1,'MarkerFaceColor','w');    
    set(gca,'ColorOrderIndex',i);
    plot([616 533 468]-displacementLambda(i),-(defocusLCAmeasuredAll(i,:)-defocusLCAmeasuredAll(i,2)),'o','MarkerSize',10, ...
        'LineWidth',1,'MarkerFaceColor','w');
end
% axis square;
xlim([460 620]);
ylim([-1.5 1]);
formatFigure('Wavelength (\lambda)','Defocus (D)');
