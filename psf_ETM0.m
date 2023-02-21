%210624 psignfit for tumbling E task with different optotype sets
function [r00 r11]=psf_ETM0(y0, y1, w2, d1);

y01=y1; y1(:,1:d1)=[];
w02=w2; w2(:,1:d1)=[];

y11=y1(y0==1, :)'; y11=y11(:)';
y10=y1(y0==0, :)'; y10=y10(:)';

w11=w2(y0==1, :)'; w11=w11(:)';
w10=w2(y0==0, :)'; w10=w10(:)';

y22=[y11; y10];
w22=[w11; w10];
y00=[1 0];


y22=[y10; y11];
w22=[w10; w11];
y00=[0 1];

% [r00 r11]=psfa0(y00, y22, w22, 0, STK);
%[r00 r11]=psfa1(y00, y22, w22, 0, STK);
[r00 r11]=psfe0(y00, y22, w22, 0); %210521


r00(1,1)=numel(y01(y0==0,:));
r11(1,1)=numel(y01(y0==1,:));