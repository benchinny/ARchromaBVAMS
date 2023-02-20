% anti-aliasing function
function out=aaf(in, ms, rc, sg); 


iu=usz(in, ms);

i1=circshift(iu, rc);

if sg ~=0; i2=imgaussfilt(i1,sg); else; i2=i1; end;

out=dsz(i2, ms);

% clear all
% close all
% clc
% sz=[1000, 1000];
% w=100;
% o=0.8;
% 
% 
% rc=[1 1];
% ms=10; %multisample
% sg=1; %sigma of Gaussian filter
% img=Eti(o, w, sz); % generate optype

% 
% B=uint8(ones(ms));
% K=kron(in,B);
% K0=circshift(K, rc);
% if sg ~=0; K1=imgaussfilt(K,sg); else; K1=K0; end;
% out=imresize(K1, 1./ms, 'bicubic'); %%not good enough!

%imshow(K2);

