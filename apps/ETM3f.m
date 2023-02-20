%% Tumbling E
function [rv wv wn]=ETM3f(w, b, n, sz, dly, L, ey, window1, window2);
%w initial stroke size in pix
%b base of square root
%n number of repetitions 
%sz size of screen
%dly optotype presentation time
%L optotype
%ey right, left binocular

%function [rv wv wn]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2)

global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi

% 2D/1U done!
% average last N reversals

cnt=0;% initialization of 1U/2D

p=round(3.*rand(n,1)); %orientation R0 D1 L2 U3
rv=zeros(1,n); %response/reply vector
wv=zeros(1,n); %optotype size vector
for ni=1:n;
    
        img=o2i(b, w, L, p(ni), sz);
    
   wn=cwin(img, ey, [1 1], window1, window2)

    startTime=WaitSecs(0);
    %[secs, keyCode, deltaSecs] = KbStrokeWait([], dly);
    [secs, keyCode, deltaSecs] = KbStrokeWait([], startTime+dly);

    Screen('FillRect', window1, white);
    Screen('FillRect', window2, white);

    Screen('Flip', window1);     Screen('Flip', window2);

    [secs, keyCode, deltaSecs] = KbStrokeWait;
    
    if find(keyCode)==ek; break; %L80 R79 U82 D81
    elseif find(keyCode)==st %L80 R79 U82 D81
        cnt=cnt+1; % taking care of 2D/1U
        %mm=[mm 1]; %memory
        snd(1000, 0.2) % 1000Hz beep 200ms
        rv(ni)=1; wv(ni)=w;
        if cnt==2
            %d=d-ds;
            w=w-1; %d=5*w;
            cnt=0;
        end
    else
        %d=d+ds;
        snd(250, 0.2) %250Hz beep 200ms
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






