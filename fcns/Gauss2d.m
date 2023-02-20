function  df=Gauss2d(A, x0, y0, sigv, sigw, theta)
global X Y sz
% A=1
% y0=5; x0=5;
% sigv=1; sigw=1; theta=0.*(pi./180);
if isempty(X)==1
x=[1:sz(2)]; y=[1:sz(1)];
[X,Y] = meshgrid(x,y)
end
v=(X-x0).*cos(theta)+(Y-y0).*sin(theta);
w=(X-x0).*sin(theta)+(Y-y0).*cos(theta);
df=A.*exp(-(   ((v.^2)./(2.*sigv.^2)) + ((w.^2)./(2.*sigw.^2))));
%figure; imagesc(df);

%% sigv alongates on horizontal 
%% sigw alongates on vertical
%% theta rotates counter-clock wise from horizontal