% convert double to integer and decimal components
function [y3 y1 y0]=d2i(x, ms);

% 
% x=-5.7
% ms=10;

y0=round(ms.*x)./ms; % correct number to get exact;    
y1=fix(y0); %integer
y2=round(ms.*y0)-y1.*ms; % get first decimal
y3=round(abs(y2)); % decimal point


% i0=fix(xy); % get integer
% i1=fix(ms.*xy)-ms.*i0; % get first decimal
% v0=[1 10 9 8 7 6 5 4 3 2]; 
% if xy(1)<0;
%     i1(1)=v0(abs(i1(1))+1);
% elseif xy(2)<0
%     i1(2)=v0(abs(i1(2))+1);
% else
%     i1=i1+1;
% end;


