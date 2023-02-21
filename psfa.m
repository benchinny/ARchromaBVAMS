%combine conditions for psignfit
function [r00 r11]=psfa(y0, y1, w2, d1, STK);

y01=y1; y1(:,1:d1)=[];
w02=w2; w2(:,1:d1)=[];

y11=y1(y0==1, :)'; y11=y11(:)';
y10=y1(y0==0, :)'; y10=y10(:)';

w11=w2(y0==1, :)'; w11=w11(:)';
w10=w2(y0==0, :)'; w10=w10(:)';

y22=[y11; y10];
w22=[w11; w10];
y00=[1 0];

% [r00 r11]=psfa0(y00, y22, w22, 0, STK);
%[r00 r11]=psfa1(y00, y22, w22, 0, STK);
[r00 r11]=psfa2(y00, y22, w22, 0, STK); %210521