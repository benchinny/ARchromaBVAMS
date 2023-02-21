%% extract maltese cross
clr
i0=imread('texture3_1080_newfill_malt.png');
i1=crc0(30, [1080 1080]);
i20=i0.*uint8(i1);
%i02=uint8(255.*((i20-255)==0));
% i02=uint8(255.*((double(i20)./255-i1)<0));
i02=uint8(255.*i1)-i20;
i3=cat(3, i20(:,:,1), uint8(zeros([1080 1080])), i02(:,:,1));


imshow(i02)
figure; imshow(i20)
figure; imshow(i3)
