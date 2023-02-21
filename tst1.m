clear all
close all
clc

%% show images of TCA task
sz = [1080, 1920]; % size of screen
rd=540;
kd=120;
bd=270; % blue diameter
cw=4;

ir=crs0(crc0(rd, sz)-crc0(kd, sz), cw);
ib=crs0(crc0(bd, sz), cw);
i3=cat(3, uint8(255.*ir), uint8(zeros(sz)), uint8(255.*ib));

%i3=uint8(255.*crs0(i2, cw));
imshow(i3)