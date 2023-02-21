x=[1:length(y)];
X = categorical({'A0T0g', 'A0T0p', 'A0T1p', 'A0T0w','A0T1w', '0ACL1', 'A1T0g', 'A1T0p', 'A1T1p', 'A1T0w',  'A1T1w'});
X = reordercats(X,{'A0T0g', 'A0T0p', 'A0T1p', 'A0T0w','A0T1w', '0ACL1', 'A1T0g', 'A1T0p', 'A1T1p', 'A1T0w',  'A1T1w'});
%Y = [10 21 33 52];

if(0)
b=bar(X, y);

%% setup bar colors
b.FaceColor = 'flat';
c=[0 1 0]; b.CData(1,:) = c./2; b.CData(7,:) = c;
% c=[1 0 1]; b.CData(2,:) = c./2; b.CData(3,:) = c./2; b.CData(8,:) = c; b.CData(9,:) = c; 
c=[1 0 1]; b.CData(2,:) = 0.25.*c; b.CData(3,:) = 0.5.*c; b.CData(8,:) = 0.75.*c; b.CData(9,:) = c; 
c=[1 1 1]; b.CData(4,:) = 0.25.*c; b.CData(5,:) = 0.5.*c; b.CData(10,:) = 0.75.*c; b.CData(11,:) = c; 

%% set up number of trials at top of bar
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(yC);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
end

if(1) %for log plots
markersize = 20;
greensymbols = [0 1 0]; purplesymbols = [1 0 1]; whitesymbols = [1 1 1];blackedges = [0 0 0];
    
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.5*greensymbols,'MarkerFaceColor', 0.5*greensymbols,'MarkerIndices',[1]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.25*purplesymbols,'MarkerFaceColor', 0.25*purplesymbols,'MarkerIndices',[2]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.5* purplesymbols,'MarkerFaceColor', 0.5* purplesymbols,'MarkerIndices',[3]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.25*whitesymbols,'MarkerFaceColor', 0.25*whitesymbols,'MarkerIndices',[4]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.5* whitesymbols,'MarkerFaceColor', 0.5* whitesymbols,'MarkerIndices',[5]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', greensymbols,'MarkerFaceColor', greensymbols,'MarkerIndices',[7]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.75*purplesymbols,'MarkerFaceColor', 0.75*purplesymbols,'MarkerIndices',[8]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', purplesymbols,'MarkerFaceColor', purplesymbols,'MarkerIndices',[9]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.75*whitesymbols,'MarkerFaceColor', 0.75*whitesymbols,'MarkerIndices',[10]); hold on
p = plot(X,y,'_','MarkerSize', markersize, 'MarkerEdgeColor', 0.75*whitesymbols,'MarkerFaceColor', whitesymbols,'MarkerIndices',[11]); hold on

end

hold on

er = errorbar(x, y, y-yL, yH-y);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 

line (X, 0);


hold off

title(ttl)
ylabel(ylbl)