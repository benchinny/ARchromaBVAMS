% clear all
close all
clc

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
%108 pix/degree
%0.0093 visual degrees/pixel
%0.5556 arcmin/pixel
%3.333 arcsec/pixel
%display =10 degrees
%FOV=5degrees
bkg=127; %background luminance 
w=1; % width of line

ey='Right'; ex='LCA'


screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; cf=[1 1]; %cf=[RB./RR LB./LR];

[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
ext=false;     chk=0;

while ext == false; %find(KeyCode)~=ek
    sz0=[screenYpixels,  screenXpixels]
    i1=zeros(sz0);
    i1(100,:)=1;
    img=uint8(255.*cat(3, i1, i1, i1));
    
    %img=imread(b,'png'); %% image to show
    
    wn=cwin(img, ey, cf, window1, window2);
    
    %[keyIsDown,secs, kc] = KbCheck;
    [secs, kc, deltaSecs] = KbStrokeWait;
    if kc(ek); %find(KeyCode)==ek
        ext=true;
    end
    %KbWait; %% wait for keystroke
end

sca