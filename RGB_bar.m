%% red green blue horizontal stripes with moving black bar in the middle


clear all
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
% bkg=127; %background luminance 
% w=10; % width of line
ms=2; %up/downsmapling
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
    sz2=round(sz0./2);
    sz3=round(sz0./3);
    i0=zeros(sz0);
    ir=i0; ir(1:sz3(1),:)=255; ir0=ir; ir1=usz(ir, ms);
    ig=i0; ig(sz3(1)+1: 2.*sz3(1),:)=255; ig0=ig;
    ib=i0; ib(2.*sz3(1)+1: 3.*sz3(1), :)=255; ib0=ib;
    i1=ones(sz0); i1(:, sz2(2)-1 : sz2(2)+2)=0; i11=usz(i1, ms); 
    imshow(uint8(cat(3, i1.*ir, i1.*ig, i1.*ib)));
    
    r=0; b=0; % set intial position of red background and vertical bar
while ext == false; %find(KeyCode)~=ek
%      i0=bkg.*ones(sz0);
%      i0(sz2(1)+[0:w-1],:)=255;
%      i0(:,sz2(2)+[0:w-1])=255;
%      for k0=1:sz0(1); i0(k0, k0)=255; end;
     tic; i2=dsz(i11, ms); %ir=dsz(ir1, ms);
     
     img=uint8(cat(3, i2.*ir, i2.*ig, i2.*ib));
    %img=imread(b,'png'); %% image to show
    disp(b); %[b toc]); % bar and red background position/offset
    wn=cwin(img, ey, cf, window1, window2);
    
    %[keyIsDown,secs, kc] = KbCheck;
    [secs, kc, deltaSecs] = KbStrokeWait;
    if kc(ek); %find(KeyCode)==ek
        ext=true;
    elseif kc(uk);
%         bkg=bkg+1;
           ir1=circshift(ir1, [0 1]);
           r=r+1./ms;
    elseif kc(dk);
        %bkg=bkg-1;
           ir1=circshift(ir1, [0 -1]);
           r=r-1./ms;
    elseif kc(rk);
        %w=w+1;
        i11=circshift(i11, [0 1]);
        b=b+1./ms;
    elseif kc(lk);
        %w=w-1;
        i11=circshift(i11, [0 -1]);
        b=b-1./ms;
    end
    %KbWait; %% wait for keystroke
end

sca