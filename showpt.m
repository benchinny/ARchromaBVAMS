%present optotype with TCA correction and uncorrected

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
cls
o=0; %orientation
v0=20; %Visual acuity
% cxy=[0 0; 1.8333   -1.7333; 2.1667   -2.2333]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
cxy=[0 0; 2.3333   -5.2667; 4.5000  -11.4667]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
z01 = [1080, 1080]; % size of screen
z10 = [1080, 1920]; % size of screen
2.3333   -5.2667
ms=10;

v1=v0./(0.00384.*60.*20); %stroke size
i0=binv(opt('E', o)); % binary inverse

%v1=4.34; %b.^(s./2); %calc square root.
%1     1.4142    2.0000    2.8284    4.0000    5.6569    8.0000   11.3137   16.0000   22.6274   32.0000
if rem(v1, 1)~=0
    v2=round(5*v1);    
    i1=udsz(i0, v2, 5); % up down sample    
else    
    i1=usz(i0, v1); %upsample    
end
    i2=ones(z01);
    i3=embd(i1, i2);
    i0=ct3(embd(i1, ones(z10))); %No TCA correction
        
    i4=usz(i3, ms);
    i5=cs2(i4, round(ms.*cxy), ms);
    for k0=1:3; i6(:,:,k0)=embd(i5(:,:,k0), ones(z10)); end
    
    i1=uint8(255.*i6); %TCA corrected

KbName('UnifyKeyNames');

ey='Right';ex='LCA';
rc00=[0 0; 0 0];
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[1 1];
cf=ones(3,2); 
[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 1);
x0=0; %exit condition
c0=0; %counter
while x0==0;
snd(500, 0.2); %prime subject about upcoming stimulus    
if rem(c0,2)==0;
    cwin1(i0, i0, cf, rc00, window1, window2);
    disp('TCA0');    
else
     cwin1(i1, i1, cf, rc00, window1, window2);
     disp('TCA1');  
end  
    [secs, kc, deltaSecs] = KbStrokeWait;
    if kc(KbName('ESCAPE'))
        x0=1;
    end
    c0=c0+1;
end   
sca




