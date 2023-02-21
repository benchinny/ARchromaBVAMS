%% increase optotype size and induce blur 
global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
cls
% load('E_b2_m2_p10_o4_ms10.mat'); %E optotype base 2

%108 pix/degree
%0.0093 visual degrees/pixel
%0.5556 arcmin/pixel
%3.333 arcsec/pixel
%display =10 degrees
%FOV=5degrees

ey='Left';ex='LCA'

screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[1 1]; 
%cf=[RB./RR LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
cf=ones(3,2);
[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
ext=false;     chk=0
    sz0=[screenYpixels,  screenXpixels];
    i0=255.*ones(sz0); %[1080 1920]  ;
    s0=STK; v=circshift([1:length(s0)], 4); v0=[-2:10];
    k0=[0.1 0.5 1]; k=1.4.*2.355./2; % set intial conditions for optotype and kernel size
while ext == false; %find(KeyCode)~=ek
    s=v(1);
    i1=E10c{s, 4, 1, 1};
    i2=uint8(imgf(embd(i1, i0), k));
    i3=cat(3, i2, i2, i2);
    disp([v0(s) s0(s) k0(1) k]); %[b toc]); % bar and red background position/offset
    wn=cwin(i3, ey, cf, window1, window2);
    %[keyIsDown,secs, kc] = KbCheck;
    [secs, kc, deltaSecs] = KbStrokeWait;
    if kc(ek); %find(KeyCode)==ek
        ext=true;
   elseif kc(uk);
        v=circshift(v, -1);    
    elseif kc(dk);
        v=circshift(v, 1);
    elseif kc(rk);
        k=k+k0(1);
    elseif kc(lk);
        k=k-k0(1);
    elseif kc(sp);
        k0=circshift(k0, [0 -1]);
        pause(1);
    end
    %KbWait; %% wait for keystroke
end

sca