function y=udsz(x, u, d);
%up down sample size
y0=usz(x, u);
y=dszf(y0, d);

% y=dsz(y0, d);

