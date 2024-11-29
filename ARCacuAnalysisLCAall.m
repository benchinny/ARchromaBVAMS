%%

subjNumAll = [1 3 5 9 10 16 17 18 20];
defocusLCAmeasuredAll = [];
q1bestAll = [];
q2bestAll = [];
q3bestAll = [];

for i = 1:length(subjNumAll)
    [defocusLCAmeasured, q1best, q2best, q3best] = ARCacuAnalysisLCA(subjNumAll(i),0);
    defocusLCAmeasuredAll(i,:) = defocusLCAmeasured;
    q1bestAll(i) = q1best;
    q2bestAll(i) = q2best;
    q3bestAll(i) = q3best;
end

%%

wave2fit = 468:616;
standardLCAfit = humanWaveDefocus(wave2fit);
val532 = humanWaveDefocus(532);
standardLCAfit = standardLCAfit-val532;

figure;
hold on;
plot(wave2fit,standardLCAfit,'k-','LineWidth',1);
for i = 1:size(defocusLCAmeasuredAll,1)
    plot([616 533 468],-(defocusLCAmeasuredAll(i,:)-defocusLCAmeasuredAll(i,2)),'ko','MarkerSize',10, ...
        'LineWidth',1,'MarkerFaceColor','w');
end
% axis square;
xlim([460 620]);
ylim([-1.5 1]);
formatFigure('Wavelength (\lambda)','Defocus (D)');
