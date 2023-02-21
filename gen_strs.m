%clear all
close all
clc

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
%108 pix/degree!!!
s=10;
nr=100; ng=100; nb=100;
sz = [1080, 1920]; % size of screen

i1=crc0(s, sz); 


% 
% p0=[0 1 0; 1 1 1; 0 1 0];
% p1=usz(p0, s);
% i0=zeros(sz);
% i1=embd(p1, i0);

i2=cat(3, strs(nr, i1), strs(ng, i1), strs(nb, i1));

imshow(i2)