clear all
close all
clc

%STARS: create crosses/dots code sparse/ randomly !
%3by3 pixel crosses
%position stimuli/stars at random spots in the image
sz = [1080, 1920]; % size of screen
d=6; %size
n=100; %number
sg=1; %sigma

%i1=imgf(double(crc0(d, sz)), sg); % gaussian filter


k0=[0 1 0 ; 1 1 1 ; 0 1 0];
k=usz(k0,d);
 i0=zeros(sz);
i1=embd(k,i0);


i3=cat(3, strs(n, i1), strs(n, i1), strs(n,i1));

imshow(i3)


