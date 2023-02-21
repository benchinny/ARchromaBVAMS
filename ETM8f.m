%% Tumbling E
function [rv wv wn]=ETM8f(p0, rgd, bxy, ey, window1, window2);
%function [rv wv wn]=ETM6f(n, w, bxy, dly, ey, window1, window2);

%n number of repetitions
%bxy TCA digital correction
%dly optotype presentation time
%ey right, left binocular
%w initial power of optotype base
%rgd pixels to drop
global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi sz cf rc00
n=p0(1); %number of repetitions
w=p0(2); % initial base-power
dly=p0(3); 
sd=p0(4); 


% 2D/1U done!
% average last N reversals
ms=10; %multisample
b=2; %b base of square root
wv0=[-2:10]; % E optotype base 2 powers
%w=11; %length(wv0)-5;
L='E'; %L optotype
cnt=0;% initialization of 1U/2D
%sz = [1080, 1920]; %sz size of screen
o=round(3.*rand(n,1))+1; %orientation R0 D1 L2 U3
rv=zeros(1,n); %response/reply vector
wv=zeros(1,n); %optotype size vector

for k0=1:4; i0(k0)={binv(opt(L, k0-1))}; end %R1 U2 L3 D4

for ni=1:n;
    tic
    %for base=2 w=15 is the largest optotype for 1080 pixels
    %w=-5; ms=10; bxy=[0 0; 1.1 7.4; 20.2 15.1]; sd=0; sz=[1080 1920]; ni=7
    s0=b.^(w./2);%stroke size
    s1=round(5*s0);%optotype size in pixels
    
    if rem(s0, 1)~=0
    i1=dszf(usz(double(i0{o(ni)}), s1.*ms), 5); % up down sample + upsample by 10    
    else    
    i1=usz(double(i0{o(ni)}), s0.*ms); %upsample + upsample by 10 
    end
    
    i2=embd(i1, ones(ms.*sz(1))); %sz(1)=1080
    
    xy=round(ms.*bxy);
    ir=imgf(dszf(circshift(i2, xy(1,:)), ms), sd);
    ig=imgf(dszf(circshift(i2, xy(2,:)), ms), sd);
    ib=imgf(dszf(circshift(i2, xy(3,:)), ms), sd);
    iw=ones(sz); %white background to embed optotype in
    ik=zeros(sz); %black background 
%     i3=uint8(255.*cat(3, embd(ir, iw), embd(ig, iw), embd(ib,iw)));
    %3=ct8( embd(ir, iw), embd(ir, iw), embd(ir,iw));
        i3=ct8( embd(ir, iw), embd(ig, iw), embd(ib,iw));

%     %i4=uint8(zeros(size(i3)));
%     cl3=[1 1 1]; %intermission color
%     for k0=1:length(rgd);
%         i3(:,:, rgd(k0))=0; %background color
%         cl3(rgd(k0))=0;
%     end

    t=toc; %w-5=3.1secs w0=3.2secs w7=3.2secs w11=3secs, w15=15sec, 
    if o(ni)==1; st=rk; elseif o(ni)==2; st=dk; elseif o(ni)==3; st=lk; elseif o(ni)==4; st=uk; end 
        
   wn=cwin0(i3, ey, cf, rc00, window1, window2);     
   disp([ni w s0 s1 t]);% trial, base-power, stroke size, optotype size, time to generate optotype 
    startTime=WaitSecs(0);
    %[secs, keyCode, deltaSecs] = KbStrokeWait([], dly);
    [secs, keyCode, deltaSecs] = KbStrokeWait([], startTime+dly);
%     Screen('FillRect', window1, white);
%     Screen('FillRect', window2, white);

    Screen('FillRect', window1, [1 1 1]);
    Screen('FillRect', window2, [1 1 1]);

    Screen('Flip', window1);     Screen('Flip', window2);

    [secs, keyCode, deltaSecs] = KbStrokeWait;
    
    if find(keyCode)==ek; break; %L80 R79 U82 D81
    elseif find(keyCode)==st %L80 R79 U82 D81
        cnt=cnt+1; % taking care of 2D/1U
        %mm=[mm 1]; %memory
        snd(1000, 0.2); % 1000Hz beep 200ms
        rv(ni)=1; wv(ni)=w;
        %wv(ni)=wv0(w);

        if cnt==2
            %d=d-ds;
            w=w-1; %d=5*w;
            cnt=0;
        end
    else
        %d=d+ds;
        snd(250, 0.2); %250Hz beep 200ms
%         wv(ni)=wv0(w);
          wv(ni)=w;

        w=w+1; %d=5*w
        %mm=[mm 0]; %memory
        cnt=0;
    end
    %calculate current criterion
%     if length(mm)>=n
%         cc=sum(mm(end-n+1:end))/n
%     end
end
%wf=w
% Clear the screen.
%sca;






