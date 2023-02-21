% clear all
% close all
% clc
%
% %basic optotype is 5by5 pixels
% x=2;
% v0=[0:10];
% s=v0(2)

function i1=sqrs0(b, s, bs, L, o) %square root step optotype size

i0=binv(opt('E', o)); % binary inverse

%v1=b.^(s./2); %calc square root.
v1=b.^(s./bs); %calc square root.

%1     1.4142    2.0000    2.8284    4.0000    5.6569    8.0000   11.3137   16.0000   22.6274   32.0000
if rem(v1, 1)~=0
    v2=round(5*v1);
    
    i1=udsz(i0, v2, 5); % up down sample
    
else
    
    i1=usz(i0, v1); %upsample
    
end

%imagesc(i1)


% i1=usz(uint8(i0), v2(1));
%
% i2=dsz(i1, 5);