clear all
close all
clc
addpath([pwd '\fcns']); addpath([pwd '\imgs'])



t=156;
i0=imread('rice0.jpg');
%i0=imread('pmix1.jpg');

i1=rgb2gray(i0);
i2=mde(i1)>i1;

imshow(i2)

r=sum(i2(:))/prod(size(i2));

i3=cat(3, i2, zeros(size(i2)), i2==0);

figure; imshow(i3); title(['ratio=' num2str(r)])




%hst(i1)







% i2=edge(i1,'canny',0.1);
% i3 = bwareaopen(i2,200);
% 
% %subplot(2,2,1)
% imshow(i2)
% figure; %subplot(2,2,2)
% imshow(i3)


