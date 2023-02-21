function [r1 vu vb]=CRMf0(p0, window1, window2);
%r1 un/correct responses
%vu top bars position
%vb bottom bars position
%degree pixels
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec

%500ms fixation point
%250ms blank
%500ms presentation of red & blue bars
%bar random displacement 10 arcmin= 43pixels
%2 arcmin gap size = 9 pixels
% 1degree bar length =260 pixels
% 10 arcmin bar width = 43 pixels

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
dly=p0(1); %=0.5; %stimuli presntation times/delays: maltese, black, bars 
s=p0(2); %=16; %step size
wh=p0(3); %=17; %half width of blue&red bars
wv=p0(4); %=5; %gap half width between blue & red bars
wl=p0(5); %=260; %length of bar
rd= round(p0(6).*rand(1)); %rd== round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
ni=p0(7); %30; %number of trials
%% create green rectangle
v=p0(8); %250; 
h=p0(9); %250; 
wr=p0(10); %10; %half vertical, horizontal, width of rectangle 
%% extract visual lines
vl=p0(11); %50; %half of visual patch/line length
%ey='Left';ex='LCA';
%rc00=[0 0; 0 0];

%screens = Screen('Screens');
%screenNumber = max(screens);
load cal_val; %cf=[1 1];
%cf=[RB./RR LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
cf=ones(3,2);
%[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
ext=false;     
%sz0=[screenYpixels,  screenXpixels];
sz=[1080 1920];
sz2=round(sz./2);
i0=zeros(sz);
i1=i0; i1(:, sz2(2)-wh:sz2(2)+wh+1)=1;

u=i1; u(sz2(1)-wv:end     ,:)=0; 
b=i1; b(1:sz2(1)+wv+1     ,:)=0; 

u(1:sz2(1)-(wv+wl),   :)=0;
b(sz2(1)+wv+wl:end, :)=0; %check again to make sure correct number of pixels

u=circshift(u, [0 rd]); %add random displacement
b=circshift(b, [0 rd]);

u1=u; u2=u;
b1=b; b2=b;

i00=imread('mlt10.png'); i11=i0; %maltese cross
sg=[-50+1:50]; sz22=size(i00)./2;
i11(sz2(1)+sg, sz2(2)+sg)=i00(593+sg, 722+sg, 1);
%% create green rectangle
%v=1000; h=1900; wr=10;
i2=rct0([v h]./2, sz2)-rct0([v h]./2-wr, sz2) ;
%imshow(i2)

%% extract visual lines
%vl=10; %half of visual patch/line length
i3=i0; 
i3(sz2(1)-vl+1:sz2(1)+vl, :)=1;
i3(:, sz2(2)-vl+1: sz2(2)+vl)=1;
i4=i2.*i3;
%imshow(i4)
%extract up right down left lines
i5=repmat(i4, [1 1 4]);
i5(sz2(1)-vl+1:end,: ,1)=0; %up
i5(:, 1:sz2(2)+vl    ,2)=0; %right
i5(1:sz2(1)+vl, :    ,3)=0; %down
i5(:, sz2(2)-vl+1:end,4)=0; % left




%%need to make it for each case!
s0=0; su=s0; sb=-s0;
rsp=zeros(1,ni); r1=rsp;
chk=-1; %%reduce step size every two reversals
c0=0;
vu=su; vb=sb; %output vectors
for n=1:ni
%i5 visual cues
%i2 rectangle
%    ir=ct8(u1+i5(:,:,1)+i5(:,:,2), i2-i4, b1+i5(:,:,3)+i5(:,:,4)); %left screen
%    il=ct8(u2+i5(:,:,1)+i5(:,:,2), i2-i4, b2+i5(:,:,3)+i5(:,:,4)); % right screen
UR=i5(:,:,1)+i5(:,:,2); %upper right patches
BL=i5(:,:,3)+i5(:,:,4); %bottom left patches
   ir=ct8(u1, i2, b1); %left screen
   il=ct8(u2, i2, b2); % right screen
   imr=ct8(i0, i11+i2, i0); %maltese cross
   iml=ct8(i0, i11+i2, i0); %maltese cross
   ib=ct8(i0, i0, i0); %black screen

   
        tex_1 = Screen('MakeTexture', window1, imcal(circshift(imr, rc00(1,:)), [0.25 0.25 1]));
        Screen('DrawTexture', window1, tex_1);
        tex_2 = Screen('MakeTexture', window2, imcal(circshift(iml, rc00(2,:)), [0.25 0.25 1]));
        Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window1);
        Screen('Flip', window2);
        
        %pause(dly(1))%(0.5)
        KbWait;
        
%         tex_1 = Screen('MakeTexture', window1, ib);
%         Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, ib);
%         Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window1);
%         Screen('Flip', window2);
%         
%         
%         pause(dly(2));%(0.25)
%         
        
   

   %wn=cwin(img, ey, cf, window1, window2);
   
%         tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), cf(:,1)));
%         Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), cf(:,2)));
        %tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), [0.25 0.25 1]));
        tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), [RB./RR RB./RG 1]));
        Screen('DrawTexture', window1, tex_1);
        %tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), [0.25 0.25 1]));
        tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), [LB./LR LB./LG 1]));

        Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window1);
        Screen('Flip', window2);
        
        %
        
        pause(dly);%(0.5)
        %KbWait
        
        tex_1 = Screen('MakeTexture', window1, ib);
        Screen('DrawTexture', window1, tex_1);
        tex_2 = Screen('MakeTexture', window2, ib);
        Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window1);
        Screen('Flip', window2);
        
   
   
%    disp(['TRL' n2s(n) ' TOP' n2s(su)  ' BTM' n2s(sb) ' RES' n2s(s) ' RSP' n2s(r1(end))]) ;
    [secs, kc, deltaSecs] = KbStrokeWait;
    if sb>su; c2=1; elseif su>sb; c2=2; else; c2=0; end
    if kc(uk)
        u1=circshift(u1, [0 -s]);
        u2=circshift(u2, [0 s]);
        c=1;
        su=su+s;
    elseif kc(dk)
        b1=circshift(b1, [0 -s]);
        b2=circshift(b2, [0 s]);
        c=2;
        sb=sb+s;
    end
    if c0~=c; c0=c; chk=chk+1; end;
    if chk>=2 & s~=1; s=s./2; chk=0; end
    vu=[vu su];
    vb=[vb sb];
    r1(n)=(c2==c);
    
        disp(['TRL' n2s(n) ' TOP' n2s(su)  ' BTM' n2s(sb) ' RES' n2s(s) ' RSP' n2s(r1(n))]) ; %after you answer it will show the bars positions and if you pressed correctly or not

    
    
end
%chk
%sca
%% asses chromostereopsis

% 2.c.iv is the chromostereopsis experiment. Present a blue line segment and 
% a red line segment on both screens. Viewer looks at them binocularly. One 
% segment is above the other. Random choice as to which one. Subject 
% indicates with a button press which one looked closer. Let’s say it was 
% red. Then on the next trial, uncrossed disparity is injected into the red 
% stimulus. We run a 1-down/1-up staircase to find the 50% point (the 
% disparity for each red and blue look on average equidistant). Let the 
% staircase run for 40 trials. Disparity steps should be large at the 
% beginning (let’s say 2 minutes of arc) and then reduce by factors of 2 with 
% every two staircase reversals until we hit ~5 seconds of arc. We’ll run 
% this experiment for all CA conditions. The vergence distance doesn’t really 
% matter except that it’s comfortable for the subject. Zero physical 
% disparity is where the blue and red lines are presented at the same 
% horizontal positions in both screens. The injected uncrossed disparity is 
% presenting by shifting the line seen as nearer in opposite directions in 
% the two screens. Uncrossed is where the line is shifted left in the left 
% screen and right in the right screen (from the viewer’s standpoint). We’ll 
% take the psychometric data generated and put into psignfit to determine the 
% 50% threshold.

%% v201018
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% cls
% s=16; %step size
% wh=17; %half width of blue&red bars
% wv=5; %gap half width between blue & red bars
% wl=260; %length of bar
% rd= round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
% ni=10;
% %bxy=[10 10; 0 0; -10 -10];
% ey='Left';ex='LCA';
% rc00=[0 0; 0 0];
% 
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
% ext=false;     
% %sz0=[screenYpixels,  screenXpixels];
% sz=[1080 1920];
% sz2=round(sz./2);
% i0=zeros(sz);
% i1=i0; i1(:, sz2(2)-wh:sz2(2)+wh+1)=1;
% 
% u=i1; u(sz2(1)-wv:end     ,:)=0; 
% b=i1; b(1:sz2(1)+wv+1     ,:)=0; 
% 
% u(1:sz2(1)-(wv+wl),   :)=0;
% b(sz2(1)+wv+wl:end, :)=0; %check again to make sure correct number of pixels
% 
% u=circshift(u, [0 rd]); %add random displacement
% b=circshift(b, [0 rd]);
% 
% u1=u; u2=u;
% b1=b; b2=b;
% 
% i00=imread('mlt10.png'); i11=i0; %maltese cross
% sg=[-50+1:50]; sz22=size(i00)./2;
% i11(sz2(1)+sg, sz2(2)+sg)=i00(593+sg, 722+sg, 1);
% %%need to make it for each case!
% s0=0; su=s0; sb=-s0;
% rsp=zeros(1,ni);
% chk=-1; %%reduce step size every two reversals
% c0=0;
% for n=1:ni
% % 
% %    ir=ct8(u1, i11, b1);
% %    il=ct8(u2, i11, b2);
% 
%    ir=ct8(u1, i0, b1); %left screen
%    il=ct8(u2, i0, b2); % right screen
%    im=ct8(i0, i11, i0); %maltese cross
%    ib=ct8(i0, i0, i0); %black screen
%    
%         tex_1 = Screen('MakeTexture', window1, imcal(circshift(im, rc00(1,:)), cf(:,1)));
%         Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, imcal(circshift(im, rc00(2,:)), cf(:,2)));
%         Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window1);
%         Screen('Flip', window2);
%         
%         pause(0.5)
%         
%         tex_1 = Screen('MakeTexture', window1, ib);
%         Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, ib);
%         Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window1);
%         Screen('Flip', window2);
%         
%         
%         pause(0.25)
%         
%         
%    
% 
%    %wn=cwin(img, ey, cf, window1, window2);
%    
%         tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), cf(:,1)));
%         Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), cf(:,2)));
%         Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window1);
%         Screen('Flip', window2);
%         
%         pause(0.5)
%         
%         
%         tex_1 = Screen('MakeTexture', window1, ib);
%         Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, ib);
%         Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window1);
%         Screen('Flip', window2);
%         
%    
%    
%    disp([su sb s]) ;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     
%     if kc(uk)
%         u1=circshift(u1, [0 -s]);
%         u2=circshift(u2, [0 s]);
%         c=1;
%         su=su+s;
%     elseif kc(dk)
%         b1=circshift(b1, [0 -s]);
%         b2=circshift(b2, [0 s]);
%         c=2;
%         sb=sb+s;
%     end
%     if c0~=c; c0=c; chk=chk+1; end;
%     if chk>=2 & s~=1; s=s./2; chk=0; end
% end
% chk
% sca

% clear all
% close all
% clc
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% s=10; %step size
% wh=50; %half width of blue&red bars
% wv=10; %half width between blue & red bars
% ni=40;
% %bxy=[10 10; 0 0; -10 -10];
% ey='Left';ex='LCA';
% rc00=[0 0; 0 0];
% 
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
% %sz0=[screenYpixels,  screenXpixels];
% sz=[1080 1920];
% sz2=round(sz./2);
% i0=zeros(sz);
% i1=i0; i1(:, sz2(2)-wh:sz2(2)+wh+1)=1;
% u=i1; u(sz2(1)-wv:end     ,:)=0; u1=u; u2=u;
% b=i1; b(1:sz2(1)+wv+1     ,:)=0; b1=b; b2=b;
% 
% %%need to make it for each case!
% s0=0; su=s0; sb=-s0;
% rsp=zeros(1,ni);
% for n=1:ni
% 
%    ir=cat(3, u1, i0, b1);
%    il=cat(3, b2, i0, u2);
% 
%    %wn=cwin(img, ey, cf, window1, window2);
%    
%         tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), cf(:,1)));
%         Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), cf(:,2)));
%         Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window1);
%         Screen('Flip', window2);
%    
%    
%    disp([su sb]) ;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     
%     if kc(uk)
%         u1=circshift(u1, [0 s]);
%         b2=circshift(b2, [0 -s]);
% 
%         su=su-s;
%     elseif kc(dk)
%         b1=circshift(b1, [0 s]);
%         u2=circshift(u2, [0 -s]);
% 
%         sb=sb+s;
%     end   
% end
% 
% sca



% %% asses chromostereopsis
% 
% % 2.c.iv is the chromostereopsis experiment. Present a blue line segment and 
% % a red line segment on both screens. Viewer looks at them binocularly. One 
% % segment is above the other. Random choice as to which one. Subject 
% % indicates with a button press which one looked closer. Let’s say it was 
% % red. Then on the next trial, uncrossed disparity is injected into the red 
% % stimulus. We run a 1-down/1-up staircase to find the 50% point (the 
% % disparity for each red and blue look on average equidistant). Let the 
% % staircase run for 40 trials. Disparity steps should be large at the 
% % beginning (let’s say 2 minutes of arc) and then reduce by factors of 2 with 
% % every two staircase reversals until we hit ~5 seconds of arc. We’ll run 
% % this experiment for all CA conditions. The vergence distance doesn’t really 
% % matter except that it’s comfortable for the subject. Zero physical 
% % disparity is where the blue and red lines are presented at the same 
% % horizontal positions in both screens. The injected uncrossed disparity is 
% % presenting by shifting the line seen as nearer in opposite directions in 
% % the two screens. Uncrossed is where the line is shifted left in the left 
% % screen and right in the right screen (from the viewer’s standpoint). We’ll 
% % take the psychometric data generated and put into psignfit to determine the 
% % 50% threshold.
% 
% 
% clear all
% close all
% clc
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% s=10; %step size
% w=50; %half width of blue&red line
% ni=40;
% %bxy=[10 10; 0 0; -10 -10];
% ey='Left';ex='LCA';
% rc00=[0 0; 0 0];
% 
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
% %sz0=[screenYpixels,  screenXpixels];
% sz=[1080 1920];
% sz2=round(sz./2);
% sz4=round(sz./4);
% i0=zeros(sz);
% 
% i1=i0; i1(sz2(1)-w:sz2(1)+w, :)=1;
% u=circshift(i1, [-sz4(1) 0]); u1=u; u2=u;
% b=circshift(i1, [sz4(1)  0]); b1=b; b2=b;
% %imshow(i1)
% 
% %%need to make it for each case!
% s0=sz4(1); su=s0; sb=-s0;
% rsp=zeros(1,ni);
% for n=1:ni
% %     if rand(1)>0.5;
% %         il=cat(3,u1, i0, b2);
% %         ir=cat(3,u2, i0, b1);
% %         st=dk;
% %     else
% %         ir=cat(3,u1, i0, b2);
% %         il=cat(3,u2, i0, b1);
% %         st=uk;
% %     end
% 
%    il=cat(3, u1, i0, b1);
%    ir=cat(3, b2, i0, u2);
% 
%    %wn=cwin(img, ey, cf, window1, window2);
%    
%         tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), cf(:,1)));
%         Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), cf(:,2)));
%         Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window1);
%         Screen('Flip', window2);
%    
%    
%    disp([su sb]) ;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     
%     if kc(uk)
%         u1=circshift(u1, [s 0]);
%         b2=circshift(b2, [-s 0]);
% 
%         su=su-s;
%     elseif kc(dk)
%         b1=circshift(b1, [-s 0]);
%         u2=circshift(u2, [s 0]);
% 
%         sb=sb+s;
%     end   
% end
% 
% sca

