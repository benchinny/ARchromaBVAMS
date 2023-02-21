function [i4 y2 y1 y0]=CNT1f(p0, p1, window1, window2);
%method of continouus disparities
global black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00

sz=[1080 1920];
load('CRMimg0.mat'); %u b m 

i0=p0(1); %=0.5; %stimuli presntation times/delays: maltese, black, bars
i1=p1; %vector of disparities s=p0(2); %=16; %step size
i2=p0(2); %30; %number of trials
i3=repmat([1:length(i1)], [1 i2]); i3=i3(randperm(length(i3))); %level of disparity
i4=round(rand(1, length(i3))); % up or down


%cwin2(ct8(zeros(sz), m, zeros(sz)), ct8(zeros(sz), m, zeros(sz)), [0.25 0.25; 0.25 0.25; 1 1], window1, window2);
cwin2(ct8(zeros(sz), m, c), ct8(zeros(sz), m, c), [0.25 0.25; 0.25 0.25; 1 1], window1, window2);


% for k0=1:length(i3)
k0=1;
while k0<=length(i3)
    
    KbWait([], 2);
   
    i5=i1(i3(k0));
    
    if i4(k0)==1
        %%shift blue top
%         ir=ct8(circshift(u, [0 -i5]), zeros(sz), b); %left screen
%         il=ct8(circshift(u, [0  i5]), zeros(sz), b); % right screen
%         
%          ir=ct8(circshift(u, [0 -i5]), m, b); %left screen
%          il=ct8(circshift(u, [0  i5]), m, b); % right screen
        
         ir=ct8(b, zeros(sz), circshift(u, [0 -i5])); %left screen
         il=ct8(b, zeros(sz), circshift(u, [0 i5])); % right screen
         
         
        
    elseif i4(k0)==0
        
%                 %%shift blue bottom
%         ir=ct8(circshift(b, [0 -i5]), zeros(sz), u); %left screen
%         il=ct8(circshift(b, [0  i5]), zeros(sz), u); % right screen
%         
%          ir=ct8(circshift(b, [0 -i5]), m, u); %left screen
%          il=ct8(circshift(b, [0  i5]), m, u); % right screen
         
         ir=ct8(u, zeros(sz), circshift(b, [0 -i5])); %left screen
         il=ct8(u, zeros(sz), circshift(b, [0 i5])); % right screen
%         
        
    end
        
    cwin2(flipud(ir), flipud(il), [0.25 0.25; 0.25 0.25; 1 1], window1, window2);
    %cwin2(ir, il, [0.25 0.25; 0.25 0.25; 1 1], window1, window2);
    
    pause(i0);
    
    cwin2(ct8(zeros(sz), m, c), ct8(zeros(sz), m, c), [0.25 0.25; 0.25 0.25; 1 1], window1, window2);

    
    
    [secs, kc, deltaSecs] = KbStrokeWait;
    
    if kc(KbName('UpArrow'))
        y0(k0)=1;
        
    elseif kc(KbName('DownArrow'))
        y0(k0)=0;
    else
        k0=k0-1;
    end
    y2(k0)=(i4(k0)==y0(k0)); %blue=1 correct, red=0 wrong
    y1(k0)=i5; %disparities
%     disp(n2s(y0));
    disp(n2s(y2));

    k0=k0+1; %enumerate counter
end


% for k0=1:length(i4)
%     if y1(k0)>=0 %positive disparities
%         y2(k0)=(y0(k0)==i4(k0));
%     else % negative disparities
%         y2(k0)=(y0(k0)~=i4(k0));
%     end
% end


sca