%%211220 for JnJ study
function ETMp=ETMrgb(p0, y0, bxyL, bxyR, e0, s0, sr, window1, window2);
       % ETMp=ETM19f([n0 n1 w0 d0], y0, zL, zR, E10c, STK, sr, window1, window2);



%function [y1 w2 y5]=ETM18f(p0, y0, bxyL, bxzL, bxyR, bxzR, e0, s0, sr, window1, window2);
%bxz = system TCA
%bxy=[10 10 10 10;  0 0 0 0; -10 -10 -10 -10]; subject TCA
%input 3 by 4bxy: [R G B] by [Lx Ly Rx Ry ] 
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
%e0 optotype file
%s0 stroke size vector

% y0=zeros(n0,1); %TCA corrected=1
% y1=zeros(n0, n1); %correct responses
% w2=y1; %optotype size;

%n number of repetitions
%bxy TCA digital correction
%dly optotype presentation time
%ey right, left binocular
%w initial power of optotype base
%rgd pixels to drop
global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi sz cf rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto ey cntrst
n0=length(y0); %p0(1); %number of experiments/repetitions
n1=p0(2); % sequence length/number of trials
w0=p0(3); % initial optotype size
d0=p0(4); %delay 
%r0=p0(5); %tcaCorrect 
ipd=62./1000;
dgs=atand(ipd.*y0)./2-3; dgs(dgs<=-3)=-3;%degrees to rotate

%sd=p0(4); 
addpath(genpath(fullfile('toolboxes')));
KbName('UnifyKeyNames');

% 2D/1U done!
% average last N reversals
c0=0;% initialization of 1U/2D
%sz = [1080, 1920]; %sz size of screen

%sk=stroke size in pixels
s5=s0.*5; %optotype size in pixels
s20= 0.00384.*60.*20.*s0;%acuity over 20
i0=zeros(sz);
i1=ones(sz); i5=ct3(i1);
i255=255.*i1; u255=uint8(i255); %8 bit unsigned integer 255
%y0=zeros(n0,1); %TCA corrected=1
y1=zeros(n0, n1); %correct responses
w2=y1; %optotype size;

%correct TCA parameters
ms=10; %
%number to integer and decimal
[j4L j3L j2L j1L j0L]=d4i(bxyL, ms); % system+subject TCA
%[h4L h3L h2L h1L h0L]=d4i(bxzL, ms); % system TCA

[j4R j3R j2R j1R j0R]=d4i(bxyR, ms); % system+subject TCA
%[h4R h3R h2R h1R h0R]=d4i(bxzR, ms); % system TCA

          snd(500, 0.2); disp('press any key when ready');    %KbWait([], 2);%prime subject about upcoming stimulus
r3=[KbName('2') KbName('4') KbName('8') KbName('6')]
for k0=1:n0; %number of experiments
    %r0=y0(k0);% y0(k0)=r0;%1implemenet TCA or not0
    w1=13; %w00;
          opto(name_map('l_disp')).control.setFocalPower(14+sr(1)-y0(k0));
          opto(name_map('r_disp')).control.setFocalPower(14.4+sr(2)-y0(k0)); fprintf(['Opto power = ' num2str(14.4+sr(2)-y0(k0)) '\n']);
          zaber(name_map('rotation')).move_deg(dgs(k0)); %%-6400
          [iLf iRf]=cwin3(imread('crs10.png'), imread('crs10.png'), cf, rc00, window1, window2);   KbWait([], 2);%prime subject about upcoming stimulus

%     for k1=1:n1
    k1=1;
    while k1<=n1    

     r1=round(3.*rand)+1; %orientation 1U 2L 3D 4R
     %if r1==1; r2=KbName('DownArrow'); elseif r1==2; r2=KbName('LeftArrow'); elseif r1==3; r2=KbName('UpArrow'); elseif r1==4; r2=KbName('RightArrow'); end
     if r1==1; r2=KbName('2'); elseif r1==2; r2=KbName('4'); elseif r1==3; r2=KbName('8'); elseif r1==4; r2=KbName('6'); end
     r4=r3; r4(r4==r2)=[];
     %ir=embd(e0{w1, r1, 1, 1},i1); %red primer
     
     irL= embd(circshift(e0{w1, r1, j3L(1,1), j3L(1,2)}    ,[j1L(1,1)-j4L(1,1) j1L(1,2)-j4L(1,2)] ),i255); %window2 LFT screen RED

     igL= embd(circshift(e0{w1, r1, j3L(2,1), j3L(2,2)}    ,[j1L(2,1)-j4L(2,1) j1L(2,2)-j4L(2,2)] ),i255); %window2 LFT screen GREEN

     ibL= embd(circshift(e0{w1, r1, j3L(3,1), j3L(3,2)}    ,[j1L(3,1)-j4L(3,1) j1L(3,2)-j4L(3,2)] ),i255); %window2 LFT screen BLUE
     
     
     irR= embd(circshift(e0{w1, r1, j3R(1,1), j3R(1,2)}    ,[j1R(1,1)-j4R(1,1) j1R(1,2)-j4R(1,2)] ),i255); %window2 RGT screen RED

     igR= embd(circshift(e0{w1, r1, j3R(2,1), j3R(2,2)}    ,[j1R(2,1)-j4R(2,1) j1R(2,2)-j4R(2,2)] ),i255); %window2 RGT screen GREEN

     ibR= embd(circshift(e0{w1, r1, j3R(3,1), j3R(3,2)}    ,[j1R(3,1)-j4R(3,1) j1R(3,2)-j4R(3,2)] ),i255); %window2 RGT screen BLUE
     
     im2L=cat(3, irL, igL, ibL); %TCA0
     
     im2R=cat(3, irR, igR, ibR); %TCA0

     if cntrst~=1;
     i30=im2L-mxa(im2L); i31=cntrst.*i30; im2L=i31+mxa(im2L);
     i30=im2R-mxa(im2R); i31=cntrst.*i30; im2R=i31+mxa(im2R);

     end
     
     [iLf iRf]=cwin3(im2L, im2R, cf, rc00, window1, window2);
     disp(['EXP' n2s(k0) ' TRL' n2s(k1) ' OPT'  n2s(w1) ' 20/' n2s(s20(w1)) ' ACMD' n2s(y0(k0))]); %([ni w s0 s1 t])
     %disp(['EXP' n2s(k0) ' TRL' n2s(k1) ' TCA' n2s(r0) ' OPT'  n2s(w1) ' 20/' n2s(s20(w1))]); %([ni w s0 s1 t])

     w2(k0, k1)=w1; %take in responses
      pause(d0);
      
      cwin1(i5, i5, cf, rc00, window1, window2); % white screen
         
       [secs, kc, deltaSecs] = KbStrokeWait;

       %[secs, keyCode, deltaSecs] = KbStrokeWait;
       %[keyIsDown,secs, kc] = KbCheck;
       
       if kc(KbName('ESCAPE')); break;
       elseif find(kc)  == r2;
           c0=c0+1; y1(k0, k1)=1;
           snd(1000, 0.2); % 1000Hz beep 200ms
           if c0==2;
               
           w1=w1-1; c0=0;
           end
           k1=k1+1;
       elseif sum(find(kc) == r4)
           w1=w1+1;
           snd(250, 0.2); %250Hz beep 200ms
           c0=0;
           k1=k1+1;
       else
           disp('WRONG KEY'); snd(100, 0.25); %250Hz beep 200msk1=k1-1;
       end
       if w1<1; w1=1; elseif w1>length(s0); w1=length(s0); end %set optotype size limits
    end
    
    
   %%save final varichrome settings 
   y5=[opto(name_map('l_disp')).control.getFocalPower.focal_power   opto(name_map('r_disp')).control.getFocalPower.focal_power;...
   opto(name_map('l_t_near')).control.getFocalPower.focal_power opto(name_map('r_t_near')).control.getFocalPower.focal_power;...
   opto(name_map('l_t_far')).control.getFocalPower.focal_power  opto(name_map('r_t_far')).control.getFocalPower.focal_power;...
   zaber(name_map('l_trombone')).control.getposition            zaber(name_map('r_trombone')).control.getposition;...
   zaber(name_map('rotation')).control.getposition              0];
    
    save('data\ETMtmp.mat', 'y1', 'w2', 'y0', 'k0', 'y5', 'iLf', 'iRf');
    %sz=1; sn=10004;
    %load('ETMtmp.mat'); y1=y1(1:k0,:); w2=w2(1:k0,:); y0=y0(1,:k0);
    %if sv == 1; save(['data\S' num2str(sn) '_ETM_' tme], 'y0', 'y1', 'w2'); end        

end
%[y1 w2 y5]
ETMp.y1=y1;
ETMp.w2=w2;
ETMp.y5=y5;


