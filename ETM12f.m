%% Tumbling E
function [y0 y1 w2 y5]=ETM12f(p0, bxy, bxz, e0, s0, window1, window2);
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

y0=zeros(n0,1); %TCA corrected=1
y1=zeros(n0, n1); %correct responses
w2=y1; %optotype size;

%correct TCA parameters
ms=10; %
%number to integer and decimal
[j4 j3 j2 j1 j0]=d4i(bxy, ms); % system+subject TCA
[h4 h3 h2 h1 h0]=d4i(bxz, ms); % system TCA



%% show optotype for fucusing

     %% TCA corrected 
     w1=w0; r1=4;
     ir2= embd(circshift(e0{w1, r1, j3(1,1), j3(1,2)}    ,[j1(1,1)-j4(1,1) j1(1,2)-j4(1,2)] ),i1); %window2 LFT screen RED
     ir1= embd(circshift(e0{w1, r1, j3(1,3), j3(1,4)}    ,[j1(1,3)-j4(1,3) j1(1,4)-j4(1,4)] ),i1); %window1 RGT screen RED

     ig2= embd(circshift(e0{w1, r1, j3(2,1), j3(2,2)}    ,[j1(2,1)-j4(2,1) j1(2,2)-j4(2,2)] ),i1); %window2 LFT screen GREEN
     ig1= embd(circshift(e0{w1, r1, j3(2,3), j3(2,4)}    ,[j1(2,3)-j4(2,3) j1(2,4)-j4(2,4)] ),i1); %window1 RGT screen GREEN

     ib2= embd(circshift(e0{w1, r1, j3(3,1), j3(3,2)}    ,[j1(3,1)-j4(3,1) j1(3,2)-j4(3,2)] ),i1); %window2 LFT screen BLUE
     ib1= embd(circshift(e0{w1, r1, j3(3,3), j3(3,4)}    ,[j1(3,3)-j4(3,3) j1(3,4)-j4(3,4)] ),i1); %window1 RGT screen BLUE

     i3=ct8(ir1, ig1, ib1); %shift TCA right screen
     i4=ct8(ir2, ig2, ib2); %shift TCA left screen
     %contrast
     if cntrst~=1;
     i30=double(i3); i31=i30-mxa(i30); i32=cntrst.*i31; i3=uint8(i32+mxa(i30));
     i40=double(i4); i41=i40-mxa(i40); i42=cntrst.*i41; i4=uint8(i42+mxa(i40));
     end
     cwin1(i3, i4, cf, rc00, window1, window2);
     
     
%% set focus green optotype!!!

power_dispL=opto(name_map('l_disp')).control.getFocalPower.focal_power;
power_dispR=opto(name_map('r_disp')).control.getFocalPower.focal_power;
opt_chk=0;
while opt_chk==0
    [ keyIsDown, keyTime, keyCode ] = KbCheck;
    if keyIsDown
        if keyCode(KbName('RightArrow'))
            if ey(1)=='R'
            power_dispR=power_dispR+0.1;
            elseif ey(1)=='L'
            power_dispL=power_dispL+0.1;
            end
        elseif keyCode(KbName('LeftArrow'))
            if ey(1)=='R'
            power_dispR=power_dispR-0.1;
            elseif ey(1)=='L'
            power_dispL=power_dispL-0.1;
            end
        elseif keyCode(KbName('ESCAPE')) %| keyCode(KbName('Return'))
            %                     break
            opt_chk=1;
        end
        if ey(1)=='L'
        opto(name_map('l_disp')).control.setFocalPower(power_dispL);
        elseif ey(1)=='R'
        opto(name_map('r_disp')).control.setFocalPower(power_dispR);
        end
        disp(['L' n2s2(power_dispL) ' R' n2s2(power_dispR) ' POWER DISPLAY'])
        
    end
    % Key debounce routine, which waits for key to be released
    while keyIsDown
        [ keyIsDown, keyTime, keyCode ] = KbCheck;
    end
end
                    

   
% based on d2i, including correction for negative values.
% [negative=1 correct_index decimal integer number]
y0=rem(randperm(n0),2);
snd(500, 0.2); %prime subject about upcoming stimulus
for k0=1:n0; %number of experiments
    r0=y0(k0);% y0(k0)=r0;%1implemenet TCA or not0
    w1=w0;
    for k1=1:n1    
     r1=round(3.*rand)+1; %orientation 1U 2L 3D 4R
     if r1==1; r2=KbName('DownArrow'); elseif r1==2; r2=KbName('LeftArrow'); elseif r1==3; r2=KbName('UpArrow'); elseif r1==4; r2=KbName('RightArrow'); end
     %ir=embd(e0{w1, r1, 1, 1},i1); %red primer
     
     %% TCA corrected 
     ir2= embd(circshift(e0{w1, r1, j3(1,1), j3(1,2)}    ,[j1(1,1)-j4(1,1) j1(1,2)-j4(1,2)] ),i1); %window2 LFT screen RED
     ir1= embd(circshift(e0{w1, r1, j3(1,3), j3(1,4)}    ,[j1(1,3)-j4(1,3) j1(1,4)-j4(1,4)] ),i1); %window1 RGT screen RED

     ig2= embd(circshift(e0{w1, r1, j3(2,1), j3(2,2)}    ,[j1(2,1)-j4(2,1) j1(2,2)-j4(2,2)] ),i1); %window2 LFT screen GREEN
     ig1= embd(circshift(e0{w1, r1, j3(2,3), j3(2,4)}    ,[j1(2,3)-j4(2,3) j1(2,4)-j4(2,4)] ),i1); %window1 RGT screen GREEN

     ib2= embd(circshift(e0{w1, r1, j3(3,1), j3(3,2)}    ,[j1(3,1)-j4(3,1) j1(3,2)-j4(3,2)] ),i1); %window2 LFT screen BLUE
     ib1= embd(circshift(e0{w1, r1, j3(3,3), j3(3,4)}    ,[j1(3,3)-j4(3,3) j1(3,4)-j4(3,4)] ),i1); %window1 RGT screen BLUE
     
     
     %% TCA UNcorrected 
     jr2= embd(circshift(e0{w1, r1, h3(1,1), h3(1,2)}    ,[h1(1,1)-h4(1,1) h1(1,2)-h4(1,2)] ),i1); %window2 LFT screen RED
     jr1= embd(circshift(e0{w1, r1, h3(1,3), h3(1,4)}    ,[h1(1,3)-h4(1,3) h1(1,4)-h4(1,4)] ),i1); %window1 RGT screen RED

     jg2= embd(circshift(e0{w1, r1, h3(2,1), h3(2,2)}    ,[h1(2,1)-h4(2,1) h1(2,2)-h4(2,2)] ),i1); %window2 LFT screen GREEN
     jg1= embd(circshift(e0{w1, r1, h3(2,3), h3(2,4)}    ,[h1(2,3)-h4(2,3) h1(2,4)-h4(2,4)] ),i1); %window1 RGT screen GREEN

     jb2= embd(circshift(e0{w1, r1, h3(3,1), j3(3,2)}    ,[h1(3,1)-j4(3,1) h1(3,2)-h4(3,2)] ),i1); %window2 LFT screen BLUE
     jb1= embd(circshift(e0{w1, r1, h3(3,3), j3(3,4)}    ,[h1(3,3)-j4(3,3) h1(3,4)-h4(3,4)] ),i1); %window1 RGT screen BLUE
     

     if r0==0
%          i3=ct3(ir1); %RIGHT
%          i4=ct3(ir2); %LEFT
         i3=ct8(jr1, jg1, jb1); %shift TCA right screen
         i4=ct8(jr2, jg2, jb2); %shift TCA left screen
         %i4=i3;
     elseif r0==1;
         i3=ct8(ir1, ig1, ib1); %shift TCA right screen
         i4=ct8(ir2, ig2, ib2); %shift TCA left screen
         
         %i3=ct8(ir, ib1, ib1); %shift TCA right screen
         %i4=ct8(ir, ib2, ib2); %shift TCA left screen
     end
     if cntrst~=1;
     i30=double(i3); i31=i30-mxa(i30); i32=cntrst.*i31; i3=uint8(i32+mxa(i30));
     i40=double(i4); i41=i40-mxa(i40); i42=cntrst.*i41; i4=uint8(i42+mxa(i40));
     end

     cwin1(i3, i4, cf, rc00, window1, window2);
     disp(['EXP' n2s(k0) ' TRL' n2s(k1) ' TCA' n2s(r0) ' OPT 20/' n2s(s20(w1))]); %([ni w s0 s1 t])
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
    
    save('data\ETMtmp.mat', 'y1', 'w2', 'y0', 'k0', 'y5');
    %sz=1; sn=10004;
    %load('ETMtmp.mat'); y1=y1(1:k0,:); w2=w2(1:k0,:); y0=y0(1,:k0);
    %if sv == 1; save(['data\S' num2str(sn) '_ETM_' tme], 'y0', 'y1', 'w2'); end        

end


           
    
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






