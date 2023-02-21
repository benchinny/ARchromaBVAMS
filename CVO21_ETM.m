%211208 CVO21_ETM
subplot(1, 3, 3)
y([2 3 8 9])=[]; yL([2 3 8 9])=[]; yH([2 3 8 9])=[]; x=[1:length(y)];
X = categorical({'A0T0g', 'A0T0w','A0T1w', '0ACL1', 'A1T0g','A1T0w',  'A1T1w'});
X = reordercats(X,{'A0T0g', 'A0T0w','A0T1w', '0ACL1', 'A1T0g', 'A1T0w',  'A1T1w'});

if(1) %for log plots
markersize = 20;
greensymbols = [0 1 0]; purplesymbols = [1 0 1]; whitesymbols = [1 1 1];blackedges = [0 0 0];
    
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.5*greensymbols,'MarkerFaceColor', 0.5*greensymbols,'MarkerIndices',[1]); hold on
% p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.25*purplesymbols,'MarkerFaceColor', 0.25*purplesymbols,'MarkerIndices',[2]); hold on
% p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.5* purplesymbols,'MarkerFaceColor', 0.5* purplesymbols,'MarkerIndices',[3]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.25*whitesymbols,'MarkerFaceColor', 0.25*whitesymbols,'MarkerIndices',[2]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.5* whitesymbols,'MarkerFaceColor', 0.5* whitesymbols,'MarkerIndices',[3]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', greensymbols,'MarkerFaceColor', greensymbols,'MarkerIndices',[5]); hold on
% p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.75*purplesymbols,'MarkerFaceColor', 0.75*purplesymbols,'MarkerIndices',[8]); hold on
% p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', purplesymbols,'MarkerFaceColor', purplesymbols,'MarkerIndices',[9]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.75*whitesymbols,'MarkerFaceColor', 0.75*whitesymbols,'MarkerIndices',[6]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.75*whitesymbols,'MarkerFaceColor', whitesymbols,'MarkerIndices',[7]); hold on

end

hold on

er = errorbar(x, y, y-yL, yH-y);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 

line (X, 0);


hold off
ylim([-0.12 0.25])
set(gca, 'YTickLabel', [])
set(gca, 'XTickLabel', [])
title(ttl)
ylabel(ylbl)