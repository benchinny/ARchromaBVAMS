%% v200914 add green half offset
clear all
close all
clc

bxy=[5 5];
b=2
L='E';
w=2;


%% show images of TCA task
sz = [1080, 1920]; % size of screen
TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; load(TCAfnm);
i0=uint8(zeros(sz));
i1=uint8(255.*ones(size(m_bkg)));
ic=circshift(m_crc{1,1}, bxy);
ib=m_bkg-ic;
ic=ic-(i1-circshift(m_crs{1,1}, bxy));

imshow(cat(3, embd(ib, i0), i0, embd(ic, i0)))


s=1;
bxy=[0 0]; w=12; 2.^(w./2)
i00=o2i(b, w, L, 0, sz);
i11=circshift(i00, bxy);
i22=circshift(i00, 2.*bxy);

i33=uint8(255.*cat(3, imgf(i00, s), imgf(i11,s), imgf(i11,s)));

%i3=uint8(255.*crs0(i2, cw));
imshow(i33)


%% v200912 add green half offset
% clear all
% close all
% clc
% 
% bxy=[5 5];
% b=2
% L='E';
% w=2;
% 
% 
% %% show images of TCA task
% sz = [1080, 1920]; % size of screen
% TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; load(TCAfnm);
% i0=uint8(zeros(sz));
% i1=uint8(255.*ones(size(m_bkg)));
% ic=circshift(m_crc{1,1}, bxy);
% ib=m_bkg-ic;
% ic=ic-(i1-circshift(m_crs{1,1}, bxy));
% 
% imshow(cat(3, embd(ib, i0), i0, embd(ic, i0)))
% 
% 
% 
% bxy=[-16 -16]; w=12; 2.^(w./2)
% i00=o2i(b, w, L, 0, sz);
% i11=circshift(i00, bxy);
% i22=circshift(i00, 2.*bxy);
% 
% i33=uint8(255.*cat(3, i00, i11, i11));
% 
% %i3=uint8(255.*crs0(i2, cw));
% imshow(i33)


%% v200906
% clear all
% close all
% clc
% 
% bxy=[0 0];
% b=2
% L='E';
% w=2;
% 
% 
% %% show images of TCA task
% sz = [1080, 1920]; % size of screen
% TCAfnm='c54_b60to270_w4_ms10_sd5_v1.mat'; load(TCAfnm);
% i0=uint8(zeros(sz));
% i1=uint8(255.*ones(size(m_bkg)));
% ic=circshift(m_crc{1,1}, bxy);
% ib=m_bkg-ic;
% ic=ic-(i1-circshift(m_crs{1,1}, bxy));
% 
% imshow(cat(3, embd(ib, i0), i0, embd(ic, i0)))
% 
% 
% 
% %w=16; 2.^(w./2)
% i00=o2i(b, w, L, 0, sz);
% i11=circshift(i00, bxy);
% 
% i22=uint8(255.*cat(3, i11, i11, i11));
% 
% %i3=uint8(255.*crs0(i2, cw));
% imshow(i22)

%% original version
% %clear all
% close all
% clc
% 
% %% show images of TCA task
% sz = [1080, 1920]; % size of screen
% rd=540;
% kd=120;
% bd=108; % blue diameter
% cw=4;
% TCAfnm='r108_c4_10.mat';
% bxy=[250 250];
% b=2
% L='E';
% w=12;
% 
% %load(TCAfnm)
% ir=crs0(crc0(rd, sz)-crc0(kd, sz), cw);
% %ib=crs0(crc0(bd, sz), cw);
% ib=circshift(crc0(bd, sz), bxy);
% ic=(circshift(crs0(ones(sz), cw), bxy)==0);
% 
% %ib=circshift(m{1,1}, bxy);
% ir=ir-ib;
% ib=ib-ic;
% i3=cat(3, uint8(255.*ir), uint8(zeros(sz)), uint8(255.*ib));
% 
% i0=o2i(b, w, L, 0, sz);
% i1=circshift(i0, bxy);
% 
% i2=uint8(255.*cat(3, i1, i0, i0));
% 
% 
% 
% %i3=uint8(255.*crs0(i2, cw));
% imshow(i2)




