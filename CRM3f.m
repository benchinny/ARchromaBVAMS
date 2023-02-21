function [y2 y1 y0]=CRM3f(p0, p1, window1, window2);

global black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00

sz=[1080 1920];
load('CRMimg.mat'); %u b m 

i0=p0(1); %=0.5; %stimuli presntation times/delays: maltese, black, bars
i1=p1; %vector of disparities s=p0(2); %=16; %step size
i2=p0(2); %30; %number of trials
i3=repmat([1:length(i1)], [1 i2]); i3=i3(randperm(length(i3))); %level of disparity
i4=round(rand(1, length(i3))); % up or down


cwin2(ct8(zeros(sz), m, zeros(sz)), ct8(zeros(sz), m, zeros(sz)), [0.25 0.25; 0.25 0.25; 1 1], window1, window2);


% for k0=1:length(i3)
k0=1;
while k0<=length(i3)
    
    KbWait([], 2);
   
    i5=i1(i3(k0));
    
    if i4(k0)==1
        %%shift blue top
        ir=ct8(circshift(u, [0 -i5]), zeros(sz), b); %left screen
        il=ct8(circshift(u, [0  i5]), zeros(sz), b); % right screen
        
%         ir=ct8(circshift(u, [0 -i5]), m, b); %left screen
%         il=ct8(circshift(u, [0  i5]), m, b); % right screen
        
        
    elseif i4(k0)==0
        
                %%shift blue bottom
        ir=ct8(circshift(b, [0 -i5]), zeros(sz), u); %left screen
        il=ct8(circshift(b, [0  i5]), zeros(sz), u); % right screen
        
%         ir=ct8(circshift(b, [0 -i5]), m, u); %left screen
%         il=ct8(circshift(b, [0  i5]), m, u); % right screen
%         
        
    end
        
    cwin2(flipud(ir), flipud(il), [0.25 0.25; 0.25 0.25; 1 1], window1, window2);
    %cwin2(ir, il, [0.25 0.25; 0.25 0.25; 1 1], window1, window2);
    
    pause(i0);
    
    cwin2(ct8(zeros(sz), m, zeros(sz)), ct8(zeros(sz), m, zeros(sz)), [0.25 0.25; 0.25 0.25; 1 1], window1, window2);

    
    
    [secs, kc, deltaSecs] = KbStrokeWait;
    
    if kc(KbName('UpArrow'))
        y0(k0)=1;
        
    elseif kc(KbName('DownArrow'))
        y0(k0)=0;
    else
        k0=k0-1;
    end
    
    y1(k0)=i5; %disparities
    disp(n2s(y0));
    k0=k0+1; %enumerate counter
end


for k0=1:length(i4)
    if y1(k0)>=0 %positive disparities
        y2(k0)=(y0(k0)==i4(k0));
    else % negative disparities
        y2(k0)=(y0(k0)~=i4(k0));
    end
end


sca





% 
% 
% 
% 
% 
% 
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
% %% create green rectangle
% %v=1000; h=1900; wr=10;
% i2=rct0([v h]./2, sz2)-rct0([v h]./2-wr, sz2) ;
% %imshow(i2)
% 
% 
% 
% si=repmat([1:length(sv)], [1 ni]); si=si(randperm(length(si)));
% %%need to make it for each case!
% s0=0; su=s0; sb=-s0;
% %rsp=zeros(1,ni); %r1=rsp;
% chk=-1; %%reduce step size every two reversals
% c0=0;
% vu=[]; %su;
% vb=[]; %sb;
% r1=[]; c=3;%output vectors
% 
% if r2==2; r2=round(rand); end % top bottom colors: 0=[R; B] 1=[B; R]
% 
% % for n=1:ni
% for n=1:ni.*length(sv)
%     %i5 visual cues
%     %i2 rectangle
%     % if r2==0
%     s=sv(si(n));
%     
%     if rand<0.5
%         
%         uv(n)=1;
%         
%         ir=ct8(circshift(u1, [0 -s]), i2, b1); %left screen
%         il=ct8(circshift(u2, [0  s]), i2, b2); % right screen
%         
%         
%     else
%         uv(n)=0;
%         ir=ct8(circshift(b1, [0 -s]), i2, u1); %left screen
%         il=ct8(circshift(b2, [0  s]), i2, u2); % right screen
%         
%     end
%     
%     
%     imr=ct8(i0, i11+i2, i0); %maltese cross
%     iml=ct8(i0, i11+i2, i0); %maltese cross
%     ib=ct8(i0, i0, i0); %black screen
%     
%     
%     tex_1 = Screen('MakeTexture', window1, imcal(circshift(imr, rc00(1,:)), [0.25 0.25 1]));
%     Screen('DrawTexture', window1, tex_1);
%     tex_2 = Screen('MakeTexture', window2, imcal(circshift(iml, rc00(2,:)), [0.25 0.25 1]));
%     Screen('DrawTexture', window2, tex_2);
%     Screen('Flip', window1);
%     Screen('Flip', window2);
%     
%     %pause(dly(1))%(0.5)
%     KbWait;
%     
%     
%     tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), [RB./RR RB./RG 1]));
%     Screen('DrawTexture', window1, tex_1);
%     tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), [LB./LR LB./LG 1]));
%     Screen('DrawTexture', window2, tex_2);
%     Screen('Flip', window1);
%     Screen('Flip', window2);
%     
%     %
%     
%     pause(dly);%(0.5)
%     %KbWait
%     
%     tex_1 = Screen('MakeTexture', window1, ib);
%     Screen('DrawTexture', window1, tex_1);
%     tex_2 = Screen('MakeTexture', window2, ib);
%     Screen('DrawTexture', window2, tex_2);
%     Screen('Flip', window1);
%     Screen('Flip', window2);
%     
%     
%     
%     %    disp(['TRL' n2s(n) ' TOP' n2s(su)  ' BTM' n2s(sb) ' RES' n2s(s) ' RSP' n2s(r1(end))]) ;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     
%     if kc(KbName('UpArrow'))
%         ur(n)=1;
%         
%     elseif kc(KbName('DownArrow'))
%         ur(n)=0;
%     end
%     
%     if s>0
%         r1(n)=(ur(n)==uv(n));
%     elseif s<0
%         r1(n)=(ur(n)~=uv(n));
%     end
%     
%     us(n)=s;
%         
% end



% %function [s2 s0]=CRM3f(p0, window1, window2);
% %r1 un/correct responses
% %vu top bars position
% %vb bottom bars position
% %degree pixels
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% 
% %500ms fixation point
% %250ms blank
% %500ms presentation of red & blue bars
% %bar random displacement 10 arcmin= 43pixels
% %2 arcmin gap size = 9 pixels
% % 1degree bar length =260 pixels
% % 10 arcmin bar width = 43 pixels
% 
% 
% %% original parameters
% % global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% % dly=p0(1); %=0.5; %stimuli presntation times/delays: maltese, black, bars
% % % s=p0(2); %=16; %step size
% % s0=[100 200 300 400 500]; %diparities
% % wh=p0(3); %=17; %half width of blue&red bars
% % wv=p0(4); %=5; %gap half width between blue & red bars
% % wl=p0(5); %=260; %length of bar
% % rd= round(p0(6).*rand(1)); %rd== round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
% % ni=p0(7); %30; %number of trials
% % %% create green rectangle
% % v=p0(8); %250;
% % h=p0(9); %250;
% % wr=p0(10); %10; %half vertical, horizontal, width of rectangle
% % %% extract visual lines
% % vl=p0(11); %50; %half of visual patch/line length
% % r2=p0(12); %color on topr and bottom 0=[R; B], 1=[B; R]; 2=rnd
% % %ey='Left';ex='LCA';
% % %rc00=[0 0; 0 0];
% % KbName('UnifyKeyNames')
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% dly=0.5; %stimuli presntation times/delays: maltese, black, bars
% % s=p0(2); %=16; %step size
% s0=[100 200 300 400 500]; %diparities
% wh=17; %half width of blue&red bars
% wv=5; %gap half width between blue & red bars
% wl=260; %length of bar
% rd= 0;%round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
% ni=10; %number of trials
% %% create green rectangle
% v=250;
% h=250;
% wr=10; %half vertical, horizontal, width of rectangle
% %% extract visual lines
% vl=50; %half of visual patch/line length
% r2=1 ; %p0(12); %color on topr and bottom 0=[R; B], 1=[B; R]; 2=rnd
% %ey='Left';ex='LCA';
% %rc00=[0 0; 0 0];
% KbName('UnifyKeyNames')
% 
% 
% 
% %screens = Screen('Screens');
% %screenNumber = max(screens);
% load cal_val; %cf=[1 1];
% %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=ones(3,2);
% %[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% ext=false;
% %sz0=[screenYpixels,  screenXpixels];
% sz=[1080 1920];
% sz2=round(sz./2);
% i0=zeros(sz);
% i1=i0; i1(:, sz2(2)-wh:sz2(2)+wh+1)=1; %vertical bar
% 
% u=i1; u(sz2(1)-wv:end     ,:)=0; %top bar
% b=i1; b(1:sz2(1)+wv+1     ,:)=0; %bottom bar
% 
% u(1:sz2(1)-(wv+wl),   :)=0; %chop top
% b(sz2(1)+wv+wl:end, :)=0; %chop bottom 
% 
% %add random displacement
% u=circshift(u, [0 rd]); 
% b=circshift(b, [0 rd]);
% 
% u1=u; u2=u;
% b1=b; b2=b;
% 
% 
% %% extract maltese cross 
% i00=imread('mlt10.png'); i11=i0; %maltese cross
% sg=[-50+1:50]; sz22=size(i00)./2;
% i11(sz2(1)+sg, sz2(2)+sg)=i00(593+sg, 722+sg, 1);
% 
% 
% %% create green rectangle
% %v=1000; h=1900; wr=10;
% i2=rct0([v h]./2, sz2)-rct0([v h]./2-wr, sz2) ;
% %imshow(i2)
% 
% imr=ct8(i0, i11+i2, i0); %maltese cross
% iml=ct8(i0, i11+i2, i0); %maltese cross
% ib=ct8(i0, i0, i0); %black screen
% 
% %%need to make it for each case!
% %s0=0; su=s0; sb=-s0;
% %rsp=zeros(1,ni); %r1=rsp;
% chk=-1; %%reduce step size every two reversals
% c0=0;
% vu=[]; %su;
% vb=[]; %sb;
% r1=[]; c=3;%output vectors
% 
% if r2==2; r2=round(rand); end % top bottom colors: 0=[R; B] 1=[B; R]
% 
% s1=randi(length(s0), [1 ni]); %stimulus level
% s2=round(rand(1, ni)); %up or down stimuli vector 1UP 0DOWN
% s3=zeros(1, ni); %responses
% 
% for n=1:ni %length(s0)
%     
%     s4=s0(s1(n));
%     
%     uL=circshift(u, [0 -s4]);
%     uR=circshift(u, [0  s4]);
%     
%     bL=circshift(b, [0 -s4]);
%     bR=circshift(b, [0  s4]);
%     
%     if s2(n)==1;
%         
%         iL=uint8(255.*cat(3,b, zeros(sz), uL));
%         iR=uint8(255.*cat(3,b, zeros(sz), uR));
%     else
%         iL=uint8(255.*cat(3,bL, zeros(sz), u));
%         iR=uint8(255.*cat(3,bR, zeros(sz), u));
%     end
%     
%     imshow(iL); disp(['TRL' n2s(n) ' UP' n2s(s2(n)) ' DSP' n2s(s4)])
%     KbWait([], 2)
%     
% %     close all; figure   
% %     subplot(1,2,1); imshow(iL);
% %     subplot(1,2,2); imshow(iR);
% %     
%     
%     %i1=uint8(255.*cat(3,bR, zeros(sz), u));
% %     %imshow(i1)
% %     KbWait([], 2)
%     
%     %uint8()
%     %imshow()
%     
%     
%     
% end
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
% for n=1:ni
%     
%     if s1(n)==1; %rand(1)>0.5 %kc(uk)
%         u1=circshift(u, [0 -s0(s1(n))]);
%         u2=circshift(u, [0  s0(s1(n))]);
%         %c=1;
%         %su=su+s;
%     else   %if %kc(dk)
%         b1=circshift(b, [0 -s0(s1(n))]);
%         b2=circshift(b, [0  s0(s1(n))]);
%         %c=2;
%         %sb=sb+s;
%     end
%     
%     
%     
%     if r2==0
%         ir=ct8(u1, i2, b1); %left screen
%         il=ct8(u2, i2, b2); % right screen
%         
%         
%     else
%         ir=ct8(b1, i2, u1); %left screen
%         il=ct8(b2, i2, u2); % right screen
%         
%     end
%     
%     
%     %cwin2(imr, iml, [0.25 0.25; 0.25 0.25; 1 1], rc00, window1, window2);
% 
%     %KbWait;
%     imshow(ir)
%     %cwin2(ir, il, [RB./RR LB./LR; RB./RG LB./LG; 1 1], rc00, window1, window2);
%     disp(['TRL' n2s(n) ' TOP' n2s(s2(n))  ' DSP' n2s2(s0(s1(n)))]) ; %after you answer it will show the bars positions and if you pressed correctly or not
% 
%     %pause(dly);%(0.5)
% 
%     %cwin2(ib, ib, ones(3, 2), rc00, window1, window2);
% 
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     
%     if kc(KbName('UpArrow'))
%         s3(n)=(s2(n)==1);
%         
%     elseif kc(KbName('DownArrow'))
%         s3(n)=(s2(n)==0);
%         
%     end
% 
%     save('data\CRMtmp.mat', 's3', 's1', 's0');
% 
% end
% 
% sca
% 
% 
% % function [s2 s0]=CRM3f(p0, window1, window2);
% % %r1 un/correct responses
% % %vu top bars position
% % %vb bottom bars position
% % %degree pixels
% % % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% % 
% % %500ms fixation point
% % %250ms blank
% % %500ms presentation of red & blue bars
% % %bar random displacement 10 arcmin= 43pixels
% % %2 arcmin gap size = 9 pixels
% % % 1degree bar length =260 pixels
% % % 10 arcmin bar width = 43 pixels
% % 
% % global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% % dly=p0(1); %=0.5; %stimuli presntation times/delays: maltese, black, bars
% % % s=p0(2); %=16; %step size
% % s0=[100 200 300 400 500]; %diparities
% % wh=p0(3); %=17; %half width of blue&red bars
% % wv=p0(4); %=5; %gap half width between blue & red bars
% % wl=p0(5); %=260; %length of bar
% % rd= round(p0(6).*rand(1)); %rd== round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
% % ni=p0(7); %30; %number of trials
% % %% create green rectangle
% % v=p0(8); %250;
% % h=p0(9); %250;
% % wr=p0(10); %10; %half vertical, horizontal, width of rectangle
% % %% extract visual lines
% % vl=p0(11); %50; %half of visual patch/line length
% % r2=p0(12); %color on topr and bottom 0=[R; B], 1=[B; R]; 2=rnd
% % %ey='Left';ex='LCA';
% % %rc00=[0 0; 0 0];
% % KbName('UnifyKeyNames')
% % 
% % %screens = Screen('Screens');
% % %screenNumber = max(screens);
% % load cal_val; %cf=[1 1];
% % %cf=[RB./RR LB./LR];
% % %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% % cf=ones(3,2);
% % %[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% % ext=false;
% % %sz0=[screenYpixels,  screenXpixels];
% % sz=[1080 1920];
% % sz2=round(sz./2);
% % i0=zeros(sz);
% % i1=i0; i1(:, sz2(2)-wh:sz2(2)+wh+1)=1; %vertical bar
% % 
% % u=i1; u(sz2(1)-wv:end     ,:)=0; %top bar
% % b=i1; b(1:sz2(1)+wv+1     ,:)=0; %bottom bar
% % 
% % u(1:sz2(1)-(wv+wl),   :)=0; %chop top
% % b(sz2(1)+wv+wl:end, :)=0; %chop bottom 
% % 
% % %add random displacement
% % u=circshift(u, [0 rd]); 
% % b=circshift(b, [0 rd]);
% % 
% % u1=u; u2=u;
% % b1=b; b2=b;
% % 
% % 
% % %% extract maltese cross 
% % i00=imread('mlt10.png'); i11=i0; %maltese cross
% % sg=[-50+1:50]; sz22=size(i00)./2;
% % i11(sz2(1)+sg, sz2(2)+sg)=i00(593+sg, 722+sg, 1);
% % 
% % 
% % %% create green rectangle
% % %v=1000; h=1900; wr=10;
% % i2=rct0([v h]./2, sz2)-rct0([v h]./2-wr, sz2) ;
% % %imshow(i2)
% % 
% % imr=ct8(i0, i11+i2, i0); %maltese cross
% % iml=ct8(i0, i11+i2, i0); %maltese cross
% % ib=ct8(i0, i0, i0); %black screen
% % 
% % %%need to make it for each case!
% % %s0=0; su=s0; sb=-s0;
% % %rsp=zeros(1,ni); %r1=rsp;
% % chk=-1; %%reduce step size every two reversals
% % c0=0;
% % vu=[]; %su;
% % vb=[]; %sb;
% % r1=[]; c=3;%output vectors
% % 
% % if r2==2; r2=round(rand); end % top bottom colors: 0=[R; B] 1=[B; R]
% % 
% % s1=randi(length(s0), [1 ni]); %stimulus level
% % s2=round(rand(1, ni)); %up or down stimuli vector 1UP 0DOWN
% % s3=zeros(1, ni); %responses
% % for n=1:ni
% %     
% %     if s1(n)==1; %rand(1)>0.5 %kc(uk)
% %         u1=circshift(u, [0 -s0(s1(n))]);
% %         u2=circshift(u, [0  s0(s1(n))]);
% %         %c=1;
% %         %su=su+s;
% %     else   %if %kc(dk)
% %         b1=circshift(b, [0 -s0(s1(n))]);
% %         b2=circshift(b, [0  s0(s1(n))]);
% %         %c=2;
% %         %sb=sb+s;
% %     end
% %     
% %     
% %     
% %     if r2==0
% %         ir=ct8(u1, i2, b1); %left screen
% %         il=ct8(u2, i2, b2); % right screen
% %         
% %         
% %     else
% %         ir=ct8(b1, i2, u1); %left screen
% %         il=ct8(b2, i2, u2); % right screen
% %         
% %     end
% %     
% %     
% %     %cwin2(imr, iml, [0.25 0.25; 0.25 0.25; 1 1], rc00, window1, window2);
% % 
% %     %KbWait;
% %     disp(['TRL' n2s(n) ' TOP' n2s(s2(n))  ' DSP' n2s2(s0(s1(n)))]) ; %after you answer it will show the bars positions and if you pressed correctly or not
% % 
% %     cwin2(ir, il, [RB./RR LB./LR; RB./RG LB./LG; 1 1], rc00, window1, window2);
% % 
% %     %pause(dly);%(0.5)
% % 
% %     %cwin2(ib, ib, ones(3, 2), rc00, window1, window2);
% % 
% %     [secs, kc, deltaSecs] = KbStrokeWait;
% %     
% %     if kc(KbName('UpArrow'))
% %         s3(n)=(s2(n)==1);
% %         
% %     elseif kc(KbName('DownArrow'))
% %         s3(n)=(s2(n)==0);
% %         
% %     end
% % 
% %     save('data\CRMtmp.mat', 's3', 's1', 's0');
% % 
% % end
% % 
% % sca


