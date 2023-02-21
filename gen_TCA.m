%V210304
clear all
close all
clc
addpath([pwd '\fcns']); addpath([pwd '\imgs'])
%% generate TCA stimulus images
%original parameters were 108pixels per degree turned into 1/0.00384=260.4167, factor
%of 2.4113
f=(1./0.00384)./108; %2.4113
rd=1080./2; %540 %round(f.*540./2); % red radius 651px =1302 too big
kd=70; %80; %round(f.*120./2); % black radius 145px
bd=65; %round(f.*108./2); %blue radius 130
cw=round(f.*4); % cross width 10
sd=1.6; %Gaussian filter standard deviation
sz = [1080, 1080]; % size of screen square
i2=crc0(bd, sz); %circle
i3=crs0(ones(sz), cw); %cross
ms=10;
i4=usz(i2, ms); i40=imgaussfilt(i4,sd);
i50=usz(i3, ms);
m_crc=cell(ms); m_crs=m_crc;
tic
for r0=1:ms
    for c0=1:ms
       i41=circshift(i40, [r0-1, c0-1]); 
       i51=circshift(i50, [r0-1, c0-1]); 

       m_crc(r0, c0) = {uint8(255.*dsz(i41, ms)) };
       m_crs(r0, c0) = {uint8(255.*dsz(i51, ms)) };
    end
end
toc

m_bkg=uint8(255.*crs0(dsz(imgaussfilt(usz(crc0(rd, sz)- crc0(kd, sz), ms), sd), ms), cw)); %red background
b_bkg=uint8(255.*crs0(dsz(imgaussfilt(usz(crc0(350, sz)- crc0(340, sz), ms), sd), ms), cw)); %blue background

save('c65_b80to540_w10_ms10_sd1_6', 'm_crc', 'm_crs', 'm_bkg', 'b_bkg');
save('c65_b75to540_w10_ms10_sd1_6', 'm_crc', 'm_crs', 'm_bkg', 'b_bkg');
save('c65_b70to540_w10_ms10_sd1_6', 'm_crc', 'm_crs', 'm_bkg', 'b_bkg');

%save('c130_b145to540_r340to350_w10_ms10_sd1_6', 'b_bkg', '-append')


% %V210302
% clear all
% close all
% clc
% addpath([pwd '\fcns']); addpath([pwd '\imgs'])
% %% generate TCA stimulus images
% %original parameters were 108pixels per degree turned into 1/0.00384=260.4167, factor
% %of 2.4113
% f=(1./0.00384)./108; %2.4113
% rd=1080./2; %540 %round(f.*540./2); % red radius 651px =1302 too big
% kd=round(f.*120./2); % black radius 145px
% bd=round(f.*108./2); %blue radius 130
% cw=round(f.*4); % cross width 10
% sd=1.6; %Gaussian filter standard deviation
% sz = [1080, 1080]; % size of screen square
% i2=crc0(bd, sz); %circle
% i3=crs0(ones(sz), cw); %cross
% ms=10;
% i4=usz(i2, ms); i40=imgaussfilt(i4,sd);
% i50=usz(i3, ms);
% m_crc=cell(ms); m_crs=m_crc;
% tic
% for r0=1:ms
%     for c0=1:ms
%        i41=circshift(i40, [r0-1, c0-1]); 
%        i51=circshift(i50, [r0-1, c0-1]); 
% 
%        m_crc(r0, c0) = {uint8(255.*dsz(i41, ms)) };
%        m_crs(r0, c0) = {uint8(255.*dsz(i51, ms)) };
%     end
% end
% toc
% 
% m_bkg=uint8(255.*crs0(dsz(imgaussfilt(usz(crc0(rd, sz)- crc0(kd, sz), ms), sd), ms), cw)); %red background
% b_bkg=uint8(255.*crs0(dsz(imgaussfilt(usz(crc0(350, sz)- crc0(340, sz), ms), sd), ms), cw)); %blue background
% 
% save('c130_b145to540_w10_ms10_sd1_6', 'm_crc', 'm_crs', 'm_bkg');
% save('c130_b145to540_r340to350_w10_ms10_sd1_6', 'b_bkg', '-append')




% n=5
% m0=m_crc{5,5}; m1=m_crs{5,5};
% imshow(m0-(m1==0))

%% generate background circle

ib=dsz(imgaussfilt(usz(crc0(rd, sz)- crc0(kd, sz), ms), 5), ms);
figure; imshow(ib);


% %V210302
% clear all
% close all
% clc
% addpath([pwd '\fcns']); addpath([pwd '\imgs'])
% %% generate TCA stimulus images
% %original parameters were 108pixels per degree turned into 1/0.00384=260.4167, factor
% %of 2.4113
% f=(1./0.00384)./108; %2.4113
% rd=1080./2; %540 %round(f.*540./2); % red radius 651px =1302 too big
% kd=round(f.*120./2); % black radius 145px
% bd=round(f.*108./2); %blue radius 130
% cw=round(f.*4); % cross width 10
% sd=1.6; %Gaussian filter standard deviation
% sz = [1080, 1080]; % size of screen square
% i2=crc0(bd, sz); %circle
% i3=crs0(ones(sz), cw); %cross
% ms=10;
% i4=usz(i2, ms); i40=imgaussfilt(i4,sd);
% i50=usz(i3, ms);
% m_crc=cell(ms); m_crs=m_crc;
% tic
% for r0=1:ms
%     for c0=1:ms
%        i41=circshift(i40, [r0-1, c0-1]); 
%        i51=circshift(i50, [r0-1, c0-1]); 
% 
%        m_crc(r0, c0) = {uint8(255.*dsz(i41, ms)) };
%        m_crs(r0, c0) = {uint8(255.*dsz(i51, ms)) };
%     end
% end
% toc
% 
% m_bkg=uint8(255.*crs0(dsz(imgaussfilt(usz(crc0(rd, sz)- crc0(kd, sz), ms), sd), ms), cw)); %red background
% 
% save('c130_b145to540_w10_ms10_sd1_6', 'm_crc', 'm_crs', 'm_bkg');
% 
% 
% 
% 
% 
% n=5
% m0=m_crc{5,5}; m1=m_crs{5,5};
% imshow(m0-(m1==0))
% 
% %% generate background circle
% 
% ib=dsz(imgaussfilt(usz(crc0(rd, sz)- crc0(kd, sz), ms), 5), ms);
% figure; imshow(ib);

%% version 201002
% clear all
% close all
% clc
% addpath([pwd '\fcns']); addpath([pwd '\imgs'])
% %% generate TCA stimulus images
% %original parameters were 108pixels per degree turned into 260.4167, factor
% %of 2.4113
% rd=540./2; % red radius 
% kd=120./2; % black radius
% bd=108./2; %blue radius
% cw=4; % cross width
% sd=5; %Gaussian filter standard deviation
% sz = [1080, 1080]; % size of screen square
% i2=crc0(bd, sz); %circle
% i3=crs0(ones(sz), cw); %cross
% ms=10;
% i4=usz(i2, ms); i40=imgaussfilt(i4,sd);
% i50=usz(i3, ms);
% m_crc=cell(ms); m_crs=m_crc;
% tic
% for r0=1:ms
%     for c0=1:ms
%        i41=circshift(i40, [r0-1, c0-1]); 
%        i51=circshift(i50, [r0-1, c0-1]); 
% 
%        m_crc(r0, c0) = {uint8(255.*dsz(i41, ms)) };
%        m_crs(r0, c0) = {uint8(255.*dsz(i51, ms)) };
%     end
% end
% toc
% 
% m_bkg=uint8(255.*crs0(dsz(imgaussfilt(usz(crc0(rd, sz)- crc0(kd, sz), ms), sd), ms), cw));
% 
% save('c54_b60to270_w4_ms10_sd5_v1', 'm_crc', 'm_crs', 'm_bkg');
% 
% 
% 
% 
% 
% n=5
% m0=m_crc{5,5}; m1=m_crs{5,5};
% imshow(m0-(m1==0))
% 
% %% generate background circle
% 
% ib=dsz(imgaussfilt(usz(crc0(rd, sz)- crc0(kd, sz), ms), 5), ms);
% figure; imshow(ib);


% clear all
% close all
% clc
% addpath([pwd '\fcns']); addpath([pwd '\imgs'])
% 
% 
% kd=108; 
% cw=4; % cross width
% sz = [1080, 1920]; % size of screen
% i2=crc0(kd, sz);
% i3=crs0(i2, cw);
% ms=10;
% i4=usz(i3, ms); i4=imgaussfilt(i4,3); 
% m=cell(ms);
% tic
% for r0=1:ms
%     for c0=1:ms
%        i5=circshift(i4, [r0-1, c0-1]); 
%        m(r0, c0)= {dsz(i5, ms) }; 
%     end
% end
% toc
% save('b108_c4_ms10_sg3', 'm');

%imshow(i4)
% sz2=sz./2; l=sz2-cw; u=sz2+cw;
% 
% i2(l(1):u(1),:)=0; i2(:,l(2):u(2))=0; 
% 
% 
% imshow(i2);

% i2=edge(i1,'canny',0.1);
% i3 = bwareaopen(i2,200);
% 
% %subplot(2,2,1)
% imshow(i2)
% figure; %subplot(2,2,2)
% imshow(i3)


