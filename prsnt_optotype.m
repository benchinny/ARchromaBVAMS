%clear all
close all
clc

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
%108 pix/degree
%display =10 degrees
%FOV=5degrees

ey='Left'; ex='LCA';
sz = [1080, 1920]; % size of screen
o=0; %orientation R0 D1 L2 U3    
v1=10; % stroke size in pixels; 
rc=[0 0; 1 1; 2 2]; % shift pixels R G B
ms=1; % multisample/subpixel
sg=0; %gaussian filter

i0=binv(opt('E', o)); % binary inverse
i1=strk(i0, v1); %% generate optotypre with specific stroke
im1=ones(sz);
im3=embd(i1, im1); %embed
im33=cat(3, im3, im3, im3);
[RGB R G B]=RGBs(im33, rc, ms , sg);

img=uint8(RGB*255);

%imshow(img)

screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; cf=[RB./RR LB./LR];

[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex); 

wn=cwin(img, ey, cf, window1, window2);

 KbWait; %% wait for keystroke

sca