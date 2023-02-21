load('RightTCA.mat');
ft1 = fittype({'x'}) %This creates a linear 'fittype' variable that is of the form f(a,x)=ax.
ft2 = fittype({'x','1'}) %This creates a linear 'fittype' variable that is of the form f(a,x)=ax+b.
% x = [1 2 3 4]; y = [2 3 4 5]; 
x=RightTCA.RightTrombonePowerD;
y=RightTCA.X_BlueRed_AvgTCA;
[p1 gof]= fit(x,y,ft1) %This creates a 'cfit' variable p that is your fitted function
% p2 = fit(x,y,ft2); %This creates a 'cfit' variable p that is your fitted function
% x_fit = linspace(0,14,50); %x-values to evaluate
% y1_fitted = feval(p1, x_fit); %y-values for the evaluated x-values
% y2_fitted = feval(p2, x_fit); %y-values for the evaluated x-values
% plot(x,y,'ro'); hold on;
% plot(x_fit,y1_fitted,'b-')
% plot(x_fit,y2_fitted,'b--')
% plot(p1)
% % xlim( [0 10])
% % ylim([0 10])
% hold on;
% legend({'Raw Data','Fitted with y-int','Fitted through (0,0)'})
n=1;
polyval(p,xfix) = yfix
xfix=8.557;
yfix=0.144;
polyfix(x,y,n,xfix,yfix)
plot(x,y,'.',x,polyval(p,x));
hold off;
figure(2)
x = linspace(0,2,100)';y = sin(pi*x)+ 0.1*randn(100,1);
 p = polyfix(x,y,3,[0,2],[0,0]);plot(x,y,'.',x,polyval(p,x));