%% Tumbling E
function [rv wv wn]=ETM5f(n, bxy, dly, ey, window1, window2);
%w initial stroke size in pix

%n number of repetitions
%bxy TCA digital correction
%dly optotype presentation time

%ey right, left binocular

%function [rv wv wn]=ETM2f(w, ws, n, sz, dly, L, ey, window1, window2)

global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi Ec E10c sz cf rc00

% 2D/1U done!
% average last N reversals
ms=10; %multisample
b=2; %b base of square root
wv0=[-6:15]; % E optotype base 2 powers
w=length(wv0)-5;
L='E'; %L optotype
cnt=0;% initialization of 1U/2D
%sz = [1080, 1920]; %sz size of screen
p=round(3.*rand(n,1)); %orientation R0 D1 L2 U3
rv=zeros(1,n); %response/reply vector
wv=zeros(1,n); %optotype size vector
[x1 x2 x3]=d2i(bxy(1), ms);
[y1 y2 y3]=d2i(bxy(2), ms);

%correct decimal for negative values
% v0=[1 10 9 8 7 6 5 4 3 2]; 
v0=[10:-1:1]; 
x1=x1+1; if x3<0; x1=v0(x1); end
y1=y1+1; if y3<0; y1=v0(y1); end

for ni=1:n;
    
%         i0=o2i(b, w, L, p(ni), sz); % generate optotype with desired size
%tic;
%         i0=double(Ec{w, p(ni)+1});
        i0=E10c{w, p(ni)+1, 1 , 1};        
        i1=circshift(E10c{w, p(ni)+1, x1, y1}, [x2 y2]);    %aaf(i0, ms, round(ms.*[bxy(2) bxy(1)]), 0); %takes a long time!
        if p(ni)==0; st=rk; elseif p(ni)==1; st=dk; elseif p(ni)==2; st=lk; elseif p(ni)==3; st=uk; end 

%          i1=aaf(i0, ms, round(ms.*[bxy(2) bxy(1)]), 0); %takes a long time!
%disp(toc);
%        i1= circshift(i0, bxy);
        
%       i2=cat(3, i1, i0, i0);
        
              i2=cat(3, i0, i1, i1);

        
        %i1=cat(3, i0, i0, i0); % turn optotype to RGB image
        
        %[i2 R0 G0 B0]=RGBs(i1, round(ms.*[0 0; bxy(2) bxy(1); bxy(2) bxy(1)]), ms , 0);
        
        %i3=uint8(i2.*255);
        
   wn=cwin0(i2, ey, cf, rc00, window1, window2);
   disp([w 2.^(w./2) p(ni)+1]);
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
        snd(1000, 0.2); % 1000Hz beep 200ms
        rv(ni)=1; wv(ni)=w;
        if cnt==2
            %d=d-ds;
            w=w-1; %d=5*w;
            cnt=0;
        end
    else
        %d=d+ds;
        snd(250, 0.2); %250Hz beep 200ms
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






