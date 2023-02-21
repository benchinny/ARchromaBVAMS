%% show optotype

%show square with fringing;
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
cls

rc00=[0 0; 0 0];
w=60; %optotype stroke size
% bxy=z1; %[0 0 0 0; 2.1 2.1 2.1 2.1; 4.3  4.3 4.3 4.3]; %half and full arcmin, [r g b]
%bxy=[0 0 0 0; 2.1 2.1 2.1 2.1; 4.3  4.3 4.3 4.3]; %half and full arcmin, [r g b]
bxy=[0 0 0 0;0 0 0 0; 20 20  0 0]; %for tca uncorrected presentation

ey='Stereo';ex='LCA';
ms=10; %up/down sampling factor
%[RR RG RB] =1.4010    4.1090    0.4064

%[LR LG LB]= 1.3480    3.9330    0.3604


screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[1 1];
%cf=[RB./RR LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
cf=ones(3,2);
[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0);
ext=false;     chk=0;
sz0=[screenYpixels,  screenXpixels];
sz0=[1080 1080];
sz=[1080 1920]; i00=zeros(sz);


e0=binv(opt('E', 0)); %R1 U2 L3 D4

    %for base=2 w=15 is the largest optotype for 1080 pixels
    %w=-5; ms=10; bxy=[0 0; 1.1 7.4; 20.2 15.1]; sd=0; sz=[1080 1920]; ni=7
    s0=w;%b.^(w./2);%stroke size
    s1=round(5*s0);%optotype size in pixels
    
    if rem(s0, 1)~=0
    i1=dszf(usz(double(e0), s1.*ms), 5); % up down sample + upsample by 10    
    else    
    i1=usz(double(e0), s0.*ms); %upsample + upsample by 10 
    end
    
    i1=embd(i1, ones(ms.*sz(1))); %sz(1)=1080



% sz2=round(sz0./2);
% sz4=round(sz0./4);
% bx=ones(ms.*w);
% i0=zeros(ms.*sz0);
% i1=embd(bx, i0);
 xy=round(ms.*bxy);

im1=ct8(dszf(circshift(i1, xy(1,3:4)),ms), dszf(circshift(i1, xy(2,3:4)),ms), dszf(circshift(i1, xy(3,3:4)),ms));
im2=ct8(dszf(circshift(i1, xy(1,1:2)),ms), dszf(circshift(i1, xy(2,1:2)),ms), dszf(circshift(i1, xy(3,1:2)),ms));


    cwin1(flipud(im1), flipud(im2), cf, rc00, window1, window2);
KbWait;
sca


%% asses chromatic fringing
% 
% % Anyway, 2.c.iii is the chromatic fringing experiment. The stimulus can be a
% % white square on a black background. Or a white E on black. Perhaps Austin
% % wants to weigh in on this choice. Whichever we choose we want the stimulus
% % to be large enough that we can observe the color fringing on vertical edges
% % (white to black transition and black to white transition) and the same for
% % horizontal edges. So that one is simple. Show the stimulus for each one of
% % the 4 CA conditions (which are described under 2.c.i). Then we could also
% % try a forced-choice experiment. Show two stimuli side by side and the
% %     subject indicates the one with more fringing. There’s no staircase to
% %     run here. Just present the two stimuli and determine after, let’s say 20
% %     trials, which one had more fringing. The two stimuli should be LCA_nat,
% %     TCA_nat vs LCA_corrected, TCA_corrected. If this proves interesting we
% %     can try the other conditions.
% %
% % So Nadav’s task here is to make the stimuli (square or optotype) with the
% % various CA conditions. And for the forced-choice experiment to show two
% % stimuli, one above the other, and collect a button press from the subject
% % indicating which had more fringing. 20 such trials. Randomly assign the
% % upper position to the two CA conditions, so that natural and corrected
% % appear in the upper position about half of the time each.
% 
% % Natural TCA, Natural LCA
% % Natural LCA, TCA corrected
% % LCA corrected, natural TCA
% % LCA corrected, TCA corrected
% 
% 
% 
% clear all
% close all
% clc
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% 
% w=400;
% ni=20;
% bxy=[10 10; 0 0; -10 -10];
% ey='Left';ex='LCA'
% ms=10;
% %[RR RG RB] =1.4010    4.1090    0.4064
% 
% %[LR LG LB]= 1.3480    3.9330    0.3604
% 
% 
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1];
% %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=ones(3,2);
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% ext=false;     chk=0;
% sz0=[screenYpixels,  screenXpixels];
% sz0=[1080 1080];
% sz=[1080 1920]; i00=zeros(sz);
% 
% sz2=round(sz0./2);
% sz4=round(sz0./4);
% bx=ones(w);
% i0=zeros(sz0);
% i1=embd(bx, i0);
% u0=circshift(i1, [-sz4(1) 0]); %upper square
% b0=circshift(i1, [sz4(1) 0]); %bottom square
% xy=round(ms.*bxy);
% u=usz(u0, ms);
% u1=uint8(255.*cat(3, embd(dszf(circshift(u, xy(1,:)), ms), i00),...
%     embd(dszf(circshift(u, xy(2,:)), ms), i00),...
%     embd(dszf(circshift(u, xy(3,:)), ms),i00)));
% b=usz(b0, ms);
% b1=uint8(255.*cat(3, embd(dszf(circshift(b, xy(1,:)), ms), i00), embd(dszf(circshift(b, xy(2,:)), ms), i00), embd(dszf(circshift(b, xy(3,:)), ms), i00)));
% 
% u0=uint8(255.*cat(3, embd(u0, i00), embd(u0, i00), embd(u0,i00))); %uncorrected
% b0=uint8(255.*cat(3, embd(b0, i00), embd(b0, i00), embd(b0, i00)));
% 
% %%need to make it for each case!
% 
% rsp=zeros(1,ni);
% for n=1:ni
%     if rand(1)>0.5;
%         img=u1+b0;
%         st=dk;
%     else
%         img=u0+b1;
%         st=uk;
%     end
%     wn=cwin(img, ey, cf, window1, window2);
%     
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     
%     if kc(st)
%         snd(250, 0.2); %250Hz beep 200ms
%         disp(1)
%         rsp(n)=1;
%     else
%         snd(1000, 0.2); %250Hz beep 200ms
%         disp(0)
%     end
%     
%     
%     
% end
% 
% sca

