%%211213 move back to binocular for JJVC subjects
function [y0 y1 w2 y5]=ETM17f(p0, bxyL, bxzL, bxyR, bxzR, e0, s0, window1, window2);
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
n0=p0(1); %number of experiments/repetitions
n1=p0(2); % sequence length/number of trials
w0=p0(3); % initial optotype size
d0=p0(4); %delay 
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
y0=zeros(n0,1); %TCA corrected=1
y1=zeros(n0, n1); %correct responses
w2=y1; %optotype size;

%correct TCA parameters
ms=10; %
%number to integer and decimal
[j4L j3L j2L j1L j0L]=d4i(bxyL, ms); % system+subject TCA
[h4L h3L h2L h1L h0L]=d4i(bxzL, ms); % system TCA

[j4R j3R j2R j1R j0R]=d4i(bxyR, ms); % system+subject TCA
[h4R h3R h2R h1R h0R]=d4i(bxzR, ms); % system TCA

%% set focus green optotype!!!
if ey(1)=='L'
w00=fcs_optL(w0, j4R, j3R, j2R, j1R, i255, e0, s20, window1, window2);

elseif ey(1)=='R'
w00=fcs_optR(w0, j4R, j3R, j2R, j1R, i255, e0, s20, window1, window2);

else
    w00=fcs_optL(w0, j4R, j3R, j2R, j1R, i255, e0, s20, window1, window2);    
    w00=fcs_optR(w0, j4R, j3R, j2R, j1R, i255, e0, s20, window1, window2);
    
end

% based on d2i, including correction for negative values.
% [negative=1 correct_index decimal integer number]
y0=rem(randperm(n0),2);
snd(500, 0.2); %prime subject about upcoming stimulus
for k0=1:n0; %number of experiments
    r0=y0(k0);% y0(k0)=r0;%1implemenet TCA or not0
    w1=w00;
    for k1=1:n1    
     r1=round(3.*rand)+1; %orientation 1U 2L 3D 4R
     if r1==1; r2=KbName('DownArrow'); elseif r1==2; r2=KbName('LeftArrow'); elseif r1==3; r2=KbName('UpArrow'); elseif r1==4; r2=KbName('RightArrow'); end
     %ir=embd(e0{w1, r1, 1, 1},i1); %red primer
     
     %% TCA corrected 
     ir1L= embd(circshift(e0{w1, r1, j3L(1,1), j3L(1,2)}    ,[j1L(1,1)-j4L(1,1) j1L(1,2)-j4L(1,2)] ),i255); %window2 LFT screen RED

     ig1L= embd(circshift(e0{w1, r1, j3L(2,1), j3L(2,2)}    ,[j1L(2,1)-j4L(2,1) j1L(2,2)-j4L(2,2)] ),i255); %window2 LFT screen GREEN

     ib1L= embd(circshift(e0{w1, r1, j3L(3,1), j3L(3,2)}    ,[j1L(3,1)-j4L(3,1) j1L(3,2)-j4L(3,2)] ),i255); %window2 LFT screen BLUE
     
     
     ir1R= embd(circshift(e0{w1, r1, j3R(1,1), j3R(1,2)}    ,[j1R(1,1)-j4R(1,1) j1R(1,2)-j4R(1,2)] ),i255); %window2 RGT screen RED

     ig1R= embd(circshift(e0{w1, r1, j3R(2,1), j3R(2,2)}    ,[j1R(2,1)-j4R(2,1) j1R(2,2)-j4R(2,2)] ),i255); %window2 RGT screen GREEN

     ib1R= embd(circshift(e0{w1, r1, j3R(3,1), j3R(3,2)}    ,[j1R(3,1)-j4R(3,1) j1R(3,2)-j4R(3,2)] ),i255); %window2 RGT screen BLUE
     
     
     
     %% TCA UNcorrected 
     jr0L= embd(circshift(e0{w1, r1, h3L(1,1), h3L(1,2)}    ,[h1L(1,1)-h4L(1,1) h1L(1,2)-h4L(1,2)] ),i255); %window2 LFT screen RED

     jg0L= embd(circshift(e0{w1, r1, h3L(2,1), h3L(2,2)}    ,[h1L(2,1)-h4L(2,1) h1L(2,2)-h4L(2,2)] ),i255); %window2 LFT screen GREEN

     jb0L= embd(circshift(e0{w1, r1, h3L(3,1), h3L(3,2)}    ,[h1L(3,1)-h4L(3,1) h1L(3,2)-h4L(3,2)] ),i255); %window2 LFT screen BLUE
     
     
     jr0R= embd(circshift(e0{w1, r1, h3R(1,1), h3R(1,2)}    ,[h1R(1,1)-h4R(1,1) h1R(1,2)-h4R(1,2)] ),i255); %window2 RGT screen RED

     jg0R= embd(circshift(e0{w1, r1, h3R(2,1), h3R(2,2)}    ,[h1R(2,1)-h4R(2,1) h1R(2,2)-h4R(2,2)] ),i255); %window2 RGT screen GREEN

     jb0R= embd(circshift(e0{w1, r1, h3R(3,1), h3R(3,2)}    ,[h1R(3,1)-h4R(3,1) h1R(3,2)-h4R(3,2)] ),i255); %window2 RGT screen BLUE
     

     if r0==0

         im0L=cat(3, jr0L, jg0L, jb0L); %TCA0
         im2L=im0L;
         
         im0R=cat(3, jr0R, jg0R, jb0R); %TCA0
         im2R=im0R;

     elseif r0==1;

         im1L=cat(3, ir1L, ig1L, ib1L); %TCA1
         im2L=im1L;
         
         im1R=cat(3, ir1R, ig1R, ib1R); %TCA1
         im2R=im1R;
         
     end

     if cntrst~=1;
     i30=im2L-mxa(im2L); i31=cntrst.*i30; im2L=i31+mxa(im2L);
     i30=im2R-mxa(im2R); i31=cntrst.*i30; im2R=i31+mxa(im2R);

     end


     [iLf iRf]=cwin3(im2L, im2R, cf, rc00, window1, window2);
     disp(['EXP' n2s(k0) ' TRL' n2s(k1) ' TCA' n2s(r0) ' OPT'  n2s(w1) ' 20/' n2s(s20(w1))]); %([ni w s0 s1 t])
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
           
       else
           w1=w1+1;
           snd(250, 0.2); %250Hz beep 200ms
           c0=0;
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





% %%210712 try trick to implement more optotype sizes
% function [y0 y1 w2 y5]=ETM17f(p0, bxy, bxz, e0, s0, window1, window2);
% %bxz = system TCA
% %bxy=[10 10 10 10;  0 0 0 0; -10 -10 -10 -10]; subject TCA
% %input 3 by 4bxy: [R G B] by [Lx Ly Rx Ry ] 
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% %e0 optotype file
% %s0 stroke size vector
% 
% % y0=zeros(n0,1); %TCA corrected=1
% % y1=zeros(n0, n1); %correct responses
% % w2=y1; %optotype size;
% 
% %n number of repetitions
% %bxy TCA digital correction
% %dly optotype presentation time
% %ey right, left binocular
% %w initial power of optotype base
% %rgd pixels to drop
% global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi sz cf rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto ey cntrst
% n0=p0(1); %number of experiments/repetitions
% n1=p0(2); % sequence length/number of trials
% w0=p0(3); % initial optotype size
% d0=p0(4); %delay 
% %sd=p0(4); 
% addpath(genpath(fullfile('toolboxes')));
% KbName('UnifyKeyNames');
% 
% % 2D/1U done!
% % average last N reversals
% c0=0;% initialization of 1U/2D
% %sz = [1080, 1920]; %sz size of screen
% 
% %sk=stroke size in pixels
% s5=s0.*5; %optotype size in pixels
% s20= 0.00384.*60.*20.*s0;%acuity over 20
% i0=zeros(sz);
% i1=ones(sz); i5=ct3(i1);
% i255=255.*i1; u255=uint8(i255); %8 bit unsigned integer 255
% y0=zeros(n0,1); %TCA corrected=1
% y1=zeros(n0, n1); %correct responses
% w2=y1; %optotype size;
% 
% %correct TCA parameters
% ms=10; %
% %number to integer and decimal
% [j4 j3 j2 j1 j0]=d4i(bxy, ms); % system+subject TCA
% [h4 h3 h2 h1 h0]=d4i(bxz, ms); % system TCA
% 
% %% set focus green optotype!!!
% w00=fcs_opt(w0, j4, j3, j2, j1, i255, e0, s20, window1, window2); 
% 
% % based on d2i, including correction for negative values.
% % [negative=1 correct_index decimal integer number]
% y0=rem(randperm(n0),2);
% snd(500, 0.2); %prime subject about upcoming stimulus
% for k0=1:n0; %number of experiments
%     r0=y0(k0);% y0(k0)=r0;%1implemenet TCA or not0
%     w1=w00;
%     for k1=1:n1    
%      r1=round(3.*rand)+1; %orientation 1U 2L 3D 4R
%      if r1==1; r2=KbName('DownArrow'); elseif r1==2; r2=KbName('LeftArrow'); elseif r1==3; r2=KbName('UpArrow'); elseif r1==4; r2=KbName('RightArrow'); end
%      %ir=embd(e0{w1, r1, 1, 1},i1); %red primer
%      
%      %tmbl function
%      if r1==1 %up
%        er=e1{w1, j3(1,2), j3(1,2)};   
%        eg=e1{w1, j3(2,2), j3(2,2)};    
%        eb=e1{w1, j3(3,2), j3(3,2)};  
%      
%          
%      
%      
%      elseif r1==2; %right 
%      er=e1{w1, j3(1,1), j3(1,2)};   
% 
%      eg=e1{w1, j3(2,1), j3(2,2)};    
% 
%      eb=e1{w1, j3(3,1), j3(3,2)};   
%      
%      
%      
%      ir1= embd(circshift(er    ,[j1(1,1)-j4(1,1) j1(1,2)-j4(1,2)] ),i255); %window2 LFT screen RED
% 
%      ig1= embd(circshift(eg    ,[j1(2,1)-j4(2,1) j1(2,2)-j4(2,2)] ),i255); %window2 LFT screen GREEN
% 
%      ib1= embd(circshift(eb    ,[j1(3,1)-j4(3,1) j1(3,2)-j4(3,2)] ),i255); %window2 LFT screen BLUE
%      
%      
%      
%      
%      %% TCA corrected 
%      ir1= embd(circshift(e0{w1, r1, j3(1,1), j3(1,2)}    ,[j1(1,1)-j4(1,1) j1(1,2)-j4(1,2)] ),i255); %window2 LFT screen RED
% 
%      ig1= embd(circshift(e0{w1, r1, j3(2,1), j3(2,2)}    ,[j1(2,1)-j4(2,1) j1(2,2)-j4(2,2)] ),i255); %window2 LFT screen GREEN
% 
%      ib1= embd(circshift(e0{w1, r1, j3(3,1), j3(3,2)}    ,[j1(3,1)-j4(3,1) j1(3,2)-j4(3,2)] ),i255); %window2 LFT screen BLUE
%      
%      %% TCA UNcorrected 
%      jr0= embd(circshift(e0{w1, r1, h3(1,1), h3(1,2)}    ,[h1(1,1)-h4(1,1) h1(1,2)-h4(1,2)] ),i255); %window2 LFT screen RED
% 
%      jg0= embd(circshift(e0{w1, r1, h3(2,1), h3(2,2)}    ,[h1(2,1)-h4(2,1) h1(2,2)-h4(2,2)] ),i255); %window2 LFT screen GREEN
% 
%      jb0= embd(circshift(e0{w1, r1, h3(3,1), h3(3,2)}    ,[h1(3,1)-h4(3,1) h1(3,2)-h4(3,2)] ),i255); %window2 LFT screen BLUE
%      
% 
%      if r0==0
% 
%          im0=cat(3, jr0, jg0, jb0); %TCA0
%          im2=im0;
% 
%      elseif r0==1;
% 
%          im1=cat(3, ir1, ig1, ib1); %TCA1
%          im2=im1;
%      end
% 
%      if cntrst~=1;
%      i30=im2-mxa(im2); i31=cntrst.*i30; im2=i31+mxa(im2);
%      end
% 
% 
%      [iLf iRf]=cwin3(im2, im2, cf, rc00, window1, window2);
%      disp(['EXP' n2s(k0) ' TRL' n2s(k1) ' TCA' n2s(r0) ' OPT'  n2s(w1) ' 20/' n2s(s20(w1))]); %([ni w s0 s1 t])
%       w2(k0, k1)=w1; %take in responses
%       pause(d0);
%       
%       cwin1(i5, i5, cf, rc00, window1, window2); % white screen
%       
%       
%        [secs, kc, deltaSecs] = KbStrokeWait;
% 
%        %[secs, keyCode, deltaSecs] = KbStrokeWait;
%        %[keyIsDown,secs, kc] = KbCheck;
%        
%        if kc(KbName('ESCAPE')); break;
%        elseif find(kc)  == r2;
%            c0=c0+1; y1(k0, k1)=1;
%            snd(1000, 0.2); % 1000Hz beep 200ms
%            if c0==2;
%                
%            w1=w1-1; c0=0;
%            end
%            
%        else
%            w1=w1+1;
%            snd(250, 0.2); %250Hz beep 200ms
%            c0=0;
%        end
%        if w1<1; w1=1; elseif w1>length(s0); w1=length(s0); end %set optotype size limits
%     end
%     
%     
%    %%save final varichrome settings 
%    y5=[opto(name_map('l_disp')).control.getFocalPower.focal_power   opto(name_map('r_disp')).control.getFocalPower.focal_power;...
%    opto(name_map('l_t_near')).control.getFocalPower.focal_power opto(name_map('r_t_near')).control.getFocalPower.focal_power;...
%    opto(name_map('l_t_far')).control.getFocalPower.focal_power  opto(name_map('r_t_far')).control.getFocalPower.focal_power;...
%    zaber(name_map('l_trombone')).control.getposition            zaber(name_map('r_trombone')).control.getposition;...
%    zaber(name_map('rotation')).control.getposition              0];
%     
%     save('data\ETMtmp.mat', 'y1', 'w2', 'y0', 'k0', 'y5', 'iLf', 'iRf');
%     %sz=1; sn=10004;
%     %load('ETMtmp.mat'); y1=y1(1:k0,:); w2=w2(1:k0,:); y0=y0(1,:k0);
%     %if sv == 1; save(['data\S' num2str(sn) '_ETM_' tme], 'y0', 'y1', 'w2'); end        
% 
% end


           
    
%     if find(keyCode)==ek; break; %L80 R79 U82 D81
%     elseif find(keyCode)==st %L80 R79 U82 D81
%         cnt=cnt+1; % taking care of 2D/1U
%         %mm=[mm 1]; %memory
%         snd(1000, 0.2); % 1000Hz beep 200ms
%         rv(ni)=1; wv(ni)=w;
%         %wv(ni)=wv0(w);
% 
%         if cnt==2
%             %d=d-ds;
%             w=w-1; %d=5*w;
%             cnt=0;
%         end
%     else
%         %d=d+ds;
%         snd(250, 0.2); %250Hz beep 200ms
% %         wv(ni)=wv0(w);
%           wv(ni)=w;
% 
%         w=w+1; %d=5*w
%         %mm=[mm 0]; %memory
%         cnt=0;
%     end
%       
      
      
      
      
      
      
      

      
      
      
      
      
     
     
     
%          
%          
%          
%          
%          
%          
%      
%      
%      
%      
% 
%     
%     
%     
%     
%     
%     %for k0=1:4; i0(k0)={binv(opt(L, k0-1))}; end %R1 U2 L3 D4
% 
% for ni=1:n;
%     tic
%     %for base=2 w=15 is the largest optotype for 1080 pixels
%     %w=-5; ms=10; bxy=[0 0; 1.1 7.4; 20.2 15.1]; sd=0; sz=[1080 1920]; ni=7
%     s0=b.^(w./2);%stroke size
%     s1=round(5*s0);%optotype size in pixels
%     
%     if rem(s0, 1)~=0
%     i1=dszf(usz(double(i0{o(ni)}), s1.*ms), 5); % up down sample + upsample by 10    
%     else    
%     i1=usz(double(i0{o(ni)}), s0.*ms); %upsample + upsample by 10 
%     end
%     
%     i2=embd(i1, ones(ms.*sz(1))); %sz(1)=1080
%     
%     xy=round(ms.*bxy);
%     ir=imgf(dszf(circshift(i2, xy(1,:)), ms), sd);
%     ig=imgf(dszf(circshift(i2, xy(2,:)), ms), sd);
%     ib=imgf(dszf(circshift(i2, xy(3,:)), ms), sd);
%     iw=ones(sz); %white background to embed optotype in
%     ik=zeros(sz); %black background 
% %     i3=uint8(255.*cat(3, embd(ir, iw), embd(ig, iw), embd(ib,iw)));
%     %3=ct8( embd(ir, iw), embd(ir, iw), embd(ir,iw));
%         i3=ct8( embd(ir, iw), embd(ig, iw), embd(ib,iw));
% 
% %     %i4=uint8(zeros(size(i3)));
% %     cl3=[1 1 1]; %intermission color
% %     for k0=1:length(rgd);
% %         i3(:,:, rgd(k0))=0; %background color
% %         cl3(rgd(k0))=0;
% %     end
% 
%     t=toc; %w-5=3.1secs w0=3.2secs w7=3.2secs w11=3secs, w15=15sec, 
%     if o(ni)==1; st=rk; elseif o(ni)==2; st=dk; elseif o(ni)==3; st=lk; elseif o(ni)==4; st=uk; end 
%         
%    wn=cwin0(i3, ey, cf, rc00, window1, window2);     
%    disp([ni w s0 s1 t]);% trial, base-power, stroke size, optotype size, time to generate optotype 
%     startTime=WaitSecs(0);
%     %[secs, keyCode, deltaSecs] = KbStrokeWait([], dly);
%     [secs, keyCode, deltaSecs] = KbStrokeWait([], startTime+dly);
% %     Screen('FillRect', window1, white);
% %     Screen('FillRect', window2, white);
% 
%     Screen('FillRect', window1, [1 1 1]);
%     Screen('FillRect', window2, [1 1 1]);
% 
%     Screen('Flip', window1);     Screen('Flip', window2);
% 
%     [secs, keyCode, deltaSecs] = KbStrokeWait;
%     
%     if find(keyCode)==ek; break; %L80 R79 U82 D81
%     elseif find(keyCode)==st %L80 R79 U82 D81
%         cnt=cnt+1; % taking care of 2D/1U
%         %mm=[mm 1]; %memory
%         snd(1000, 0.2); % 1000Hz beep 200ms
%         rv(ni)=1; wv(ni)=w;
%         %wv(ni)=wv0(w);
% 
%         if cnt==2
%             %d=d-ds;
%             w=w-1; %d=5*w;
%             cnt=0;
%         end
%     else
%         %d=d+ds;
%         snd(250, 0.2); %250Hz beep 200ms
% %         wv(ni)=wv0(w);
%           wv(ni)=w;
% 
%         w=w+1; %d=5*w
%         %mm=[mm 0]; %memory
%         cnt=0;
%     end
%     %calculate current criterion
% %     if length(mm)>=n
% %         cc=sum(mm(end-n+1:end))/n
% %     end
% end
% %wf=w
% % Clear the screen.
% %sca;
%     
%     
%     
% end

% for k0=1:4; i0(k0)={binv(opt(L, k0-1))}; end %R1 U2 L3 D4
% 
% for ni=1:n;
%     tic
%     %for base=2 w=15 is the largest optotype for 1080 pixels
%     %w=-5; ms=10; bxy=[0 0; 1.1 7.4; 20.2 15.1]; sd=0; sz=[1080 1920]; ni=7
%     s0=b.^(w./2);%stroke size
%     s1=round(5*s0);%optotype size in pixels
%     
%     if rem(s0, 1)~=0
%     i1=dszf(usz(double(i0{o(ni)}), s1.*ms), 5); % up down sample + upsample by 10    
%     else    
%     i1=usz(double(i0{o(ni)}), s0.*ms); %upsample + upsample by 10 
%     end
%     
%     i2=embd(i1, ones(ms.*sz(1))); %sz(1)=1080
%     
%     xy=round(ms.*bxy);
%     ir=imgf(dszf(circshift(i2, xy(1,:)), ms), sd);
%     ig=imgf(dszf(circshift(i2, xy(2,:)), ms), sd);
%     ib=imgf(dszf(circshift(i2, xy(3,:)), ms), sd);
%     iw=ones(sz); %white background to embed optotype in
%     ik=zeros(sz); %black background 
% %     i3=uint8(255.*cat(3, embd(ir, iw), embd(ig, iw), embd(ib,iw)));
%     %3=ct8( embd(ir, iw), embd(ir, iw), embd(ir,iw));
%         i3=ct8( embd(ir, iw), embd(ig, iw), embd(ib,iw));
% 
% %     %i4=uint8(zeros(size(i3)));
% %     cl3=[1 1 1]; %intermission color
% %     for k0=1:length(rgd);
% %         i3(:,:, rgd(k0))=0; %background color
% %         cl3(rgd(k0))=0;
% %     end
% 
%     t=toc; %w-5=3.1secs w0=3.2secs w7=3.2secs w11=3secs, w15=15sec, 
%     if o(ni)==1; st=rk; elseif o(ni)==2; st=dk; elseif o(ni)==3; st=lk; elseif o(ni)==4; st=uk; end 
%         
%    wn=cwin0(i3, ey, cf, rc00, window1, window2);     
%    disp([ni w s0 s1 t]);% trial, base-power, stroke size, optotype size, time to generate optotype 
%     startTime=WaitSecs(0);
%     %[secs, keyCode, deltaSecs] = KbStrokeWait([], dly);
%     [secs, keyCode, deltaSecs] = KbStrokeWait([], startTime+dly);
% %     Screen('FillRect', window1, white);
% %     Screen('FillRect', window2, white);
% 
%     Screen('FillRect', window1, [1 1 1]);
%     Screen('FillRect', window2, [1 1 1]);
% 
%     Screen('Flip', window1);     Screen('Flip', window2);
% 
%     [secs, keyCode, deltaSecs] = KbStrokeWait;
%     
%     if find(keyCode)==ek; break; %L80 R79 U82 D81
%     elseif find(keyCode)==st %L80 R79 U82 D81
%         cnt=cnt+1; % taking care of 2D/1U
%         %mm=[mm 1]; %memory
%         snd(1000, 0.2); % 1000Hz beep 200ms
%         rv(ni)=1; wv(ni)=w;
%         %wv(ni)=wv0(w);
% 
%         if cnt==2
%             %d=d-ds;
%             w=w-1; %d=5*w;
%             cnt=0;
%         end
%     else
%         %d=d+ds;
%         snd(250, 0.2); %250Hz beep 200ms
% %         wv(ni)=wv0(w);
%           wv(ni)=w;
% 
%         w=w+1; %d=5*w
%         %mm=[mm 0]; %memory
%         cnt=0;
%     end
%     %calculate current criterion
% %     if length(mm)>=n
% %         cc=sum(mm(end-n+1:end))/n
% %     end
% end
% %wf=w
% % Clear the screen.
% %sca;






