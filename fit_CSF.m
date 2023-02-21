function y1=fit_CSF(x, y)

a0=max(y)-min(y);
b0=1./(2.*abs(x(find(y==min(y)))-x(find(y==max(y))))) %abs(x(find(y==max(y)))-x(find(y==min(y)))) ];
c0=[-1 -0.75 -0.5 -0.25 0 0.25 0.5 0.75 1];
d0=mean(y);


% fo = fitoptions('Method','NonlinearLeastSquares',...
%                'Lower',[0,0],...
%                'Upper',[Inf,max(cdate)],...
%                'StartPoint',[1 1]);
% ft = fittype('a*(x-b)^n','problem','n','options',fo);
ft=fittype('a*sinpi(2.*b*x-2*c)+d');


Er=Inf;
% y1=fit(x', y', ft); %, 'StartPoint', [max(t0)-min(t0) abs(x(find(t0==max(t0)))-x(find(t0==min(t0)))) 2 0.3]);
for k0=1:length(c0);
 p0=[a0 b0 c0(k0) d0];
y1=fit(x', y', ft, 'StartPoint', p0, 'Lower', [0 0 -2 -Inf], 'Upper', [Inf, Inf, 2, Inf]);
sqrt(sum((y1(x)-y').^2));
 if sqrt(sum((y1(x)-y').^2)) < Er
    p1=p0; Er=sqrt(sum((y1(x)-y').^2));
end

end

y1=fit(x', y', ft, 'StartPoint', p1, 'Lower', [0 0 -2 -Inf], 'Upper', [Inf, Inf, 2, Inf]);

% cls; plot(x,y); hold on; plot(y1)
% figure; x0=[-1:0.01:1]; y0=sinpi(2.*x0); plot(x0, y0); 
% figure; x0=[-1:0.01:1]; y0=sinpi(2.*x0+0.5); plot(x0, y0); 
% figure; x0=[-1:0.01:1]; y0=sinpi(2.*x0-0.5); plot(x0, y0); 


% 1.34+0.264
% 
% ans =
% 
%     1.6040
% 
% 2./y1.b
% 
% ans =
% 
%     1.6048
% 
% y1.b/2
% 
% ans =
% 
%     0.6231