%% TCA correct RGB images

clear all
close all
clc
ms=10;
xy=[10.5 10.5];

b=cellstr(["texture1_nrm_br.png", "lprd0.png", "lprd_blk1.png", "lprd_blk2.png", "lprd_blk3.png"]);


i0=imread(b{4});

ir=i0(:,:,1); ig=i0(:,:,2); ib=i0(:,:,3);

ig1=aaf8(ig, ms, round(ms.*xy), 0);
ib1=aaf8(ib, ms, round(ms.*xy), 0);


i1=cat(3, ir, ig1, ib1);

imshow(i1)