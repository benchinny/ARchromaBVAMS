function [RGB R G B]=RGBs(i0, rc, ms , sg);
% 
% clear all
% close all
% clc
% 
% rc=[0 0; 100 100; 100 100];
% ms=10; %multisample
% sg=0; %sigma of Gaussian filter
% 
% % sz=[1000, 1000];
% % w=100;
% % o=0.8;
% % img=Eti(o, w, sz); % generate optype
% 
% i0=imread('peppers.png');
r=i0(:,:,1); g=i0(:,:,2); b=i0(:,:,3);

R=aaf(r, ms, rc(1,:), sg);
G=aaf(g, ms, rc(2,:), sg);
B=aaf(b, ms, rc(3,:), sg);

RGB=cat(3, R, G, B);
%montage({i0, RGB})



% % shift RGB pixels for TCA correction
% function [RGB R G B]=RGBs(i0, rc, sg);
% r=rc(1); c=rc(2); p0=i0;
% p0(:,:,2)=circshift(p0(:,:,2), [r c]);
% p0(:,:,3)=circshift(p0(:,:,3), [r c]);
% if sg ~=0; p0=imgaussfilt3(p0, sg); end
% p01=zeros(size(p0)); p01(:,:, 1)=p0(:,:,1);
% p02=zeros(size(p0)); p02(:,:, 2)=p0(:,:,2);
% p03=zeros(size(p0)); p03(:,:, 3)=p0(:,:,3);
% 
% R=uint8(p01); G=uint8(p02); B=uint8(p03); RGB=p0; 


% % shift RGB pixels for TCA correction
% function [RGB R G B]=RGBs(i0, rc);
% r=rc(1); c=rc(2); p0=i0;
% p0(:,:,1)=circshift(p0(:,:,1), [r c]);
% p0(:,:,3)=circshift(p0(:,:,3), [-r -c]);
% p01=zeros(size(p0)); p01(:,:, 1)=p0(:,:,1);
% p02=zeros(size(p0)); p02(:,:, 2)=p0(:,:,2);
% p03=zeros(size(p0)); p03(:,:, 3)=p0(:,:,3);
% 
% R=uint8(p01); G=uint8(p02); B=uint8(p03); RGB=p0; 



