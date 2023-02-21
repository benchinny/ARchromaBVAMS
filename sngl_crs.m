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
w=10; % width of line

ey='Right';ex='LCA'

%[RR RG RB] =1.4010    4.1090    0.4064

%[LR LG LB]= 1.3480    3.9330    0.3604


screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[1 1]; 
%cf=[RB./RR LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
cf=ones(3,2);
[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
ext=false;     chk=0;
    sz0=[screenYpixels,  screenXpixels];
    sz2=round(sz0./2)
    
while ext == false; %find(KeyCode)~=ek
     i0=bkg.*ones(sz0);
     i0(sz2(1)+[0:w-1],:)=255;
     i0(:,sz2(2)+[0:w-1])=255;
     for k0=1:sz0(1); i0(k0, k0)=255; end;
     img=uint8(cat(3, i0,i0,i0));
    %img=imread(b,'png'); %% image to show
    disp([bkg w])
    wn=cwin(img, ey, cf, window1, window2);
    
    %[keyIsDown,secs, kc] = KbCheck;
    [secs, kc, deltaSecs] = KbStrokeWait;
    if kc(ek); %find(KeyCode)==ek
        ext=true;
    elseif kc(uk);
        bkg=bkg+1;
    elseif kc(dk);
        bkg=bkg-1;
    elseif kc(rk);
        w=w+1;
    elseif kc(lk);
        w=w-1;        
    end
    %KbWait; %% wait for keystroke
end

sca