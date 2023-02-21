%210504 gabor function with phase
function m=gbr0(x, sz); 

f=x(1); %frquency
p=x(2); %phase 2 = 2.*pi phase shift
s=x(3); %gaussian gabor

%% generate gabor stimuli
%cls
%sz = [1080, 1920]; % size of screen
%f=50; %frequency/number of bands
%s=100; %gaussian sigma
%v=2.*pi.*[0:sz(1)]./sz(1)-pi
%v=2.*[0:(sz(1)-1)]./(sz(1)-1); 
%v=[ 0:sz(1)-1 ]./(sz(1)-1); 
t0=repmat(vct(sz(2)), [sz(1) 1]); t=sinpi(2.*f.*t0-p); %imshow(v0)
h=repmat(normpdf([1:sz(2)], round(sz(2)./2), s), [sz(1) 1]); h=h./mxa(h);
v=repmat(normpdf([1:sz(1)], round(sz(1)./2), s)', [1 sz(2)]); v=v./mxa(v);
m=t.*h.*v; %raise background to 0.5;
m=(m-mna(m)); 
m=m./mxa(m);

%i0=i0-mna(i0); i0=i0./mxa(i0); c0=mne(i0);

% %present 2AFC gabor stimuli
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% cls
% 
% ni=40; %number of trials
% f=73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
% s= 100; %gaussian sigma
% d0=0.1; %contrast step size
% a0=10; %angle of image tilt
% bxy=[0 0; 37 37; 20 20]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb] 
%  
% ey='Left';ex='LCA';
% rc00=[0 0; 0 0];
% sz = [1080, 1920]; % size of screen
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1];
% cf=ones(3,2); 
% cf(3,:)=0; %turn blue off
% [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 2);
% ext=false;     
% 
% r0=zeros(1,ni); %responses
% chk=0; %%reduce  size every two reversals
% 
% 
% d1=1; %contrast;
% %im=ct3(gbr(f, s, sz)); c0=mean(stretchlim(im, 0));
% im=cs3(gbr(f, s, sz), bxy); c0=mean(stretchlim(im, 0));
% 
% im0=ct3(zeros(sz));
% snd(500, 0.2); %prime subject about upcoming stimulus
% for n=1:ni
%     if d1>1; d1=1; elseif d1<=0; d1=0; end;
%     im1= imadjust(im, stretchlim(im, 0), [c0-d1.*c0; c0+d1.*c0]);
%     if rand<0.5
%         im2=imrotate(im1, a0);
%         r1=1; d2='L';
%     else
%         im2=imrotate(im1, -a0);
%         r1=2; d2='R';
%     end
%         
%     cwin1(im0, im0, cf, rc00, window1, window2);
%         
%         KbWait;
%         
%     cwin1(flipud(im2), flipud(im2), cf, rc00, window1, window2);
%     
%    disp([n2s(n) ' ' d2]) ;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     
%     if kc(KbName('RightArrow'))
%         r0(n)=(r1==2);
%     elseif kc(KbName('LeftArrow'))
%         r0(n)=(r1==1);
%     end
%     if r0(n)==1; 
%         snd(1000, 0.2);
%         chk=chk+1;
%         if chk == 2
%             d1=d1-d0;
%             chk=0;
%         end        
%     else; 
%         snd(250, 0.2);
%         d1=d1+d0;
%     end
%     disp([n2s(r0(n)) ' ' n2s(d1)]);
% end
%    
% sca

% %present 2AFC gabor stimuli
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% cls
% 
% ni=5; %number of trials
% ey='Left';ex='LCA';
% rc00=[0 0; 0 0];
% sz = [1080, 1920]; % size of screen
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1];
% cf=ones(3,2);
% [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 2);
% ext=false;     
% 
% r0=zeros(1,ni); %responses
% chk=-1; %%reduce step size every two reversals
% c0=0;
% 
% f=73.6; %frequency/number of bands : 73.6 cycles for 10cpd 
% s= 100; %gaussian sigma
% 
% im=ct3(gbr(f, s, sz));
% im0=ct3(zeros(sz));
% for n=1:ni
%     
%     if rand<0.5
%         im1=imrotate(im, 10);
%         r1=1; d0='L';
%     else
%         im1=imrotate(im, -10);
%         r1=2; d0='R';
%     end
%         
%     cwin1(im0, im0, cf, rc00, window1, window2);
%         
%         KbWait;
%         
%     cwin1(im1, im1, cf, rc00, window1, window2);
%     
%    disp(d0) ;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     
%     if kc(KbName('RightArrow'))
%         r0(n)=(r1==2);
%     elseif kc(KbName('LeftArrow'))
%         r0(n)=(r1==1);
%     end
%     disp(n2s(r0(n)))
% end
%    
% sca

% %present 2AFC gabor stimuli
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% cls
% 
% ni=5; %number of trials
% ey='Left';ex='LCA';
% rc00=[0 0; 0 0];
% sz = [1080, 1920]; % size of screen
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1];
% cf=ones(3,2);
% [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 2);
% ext=false;     
% 
% r0=zeros(1,ni); %responses
% chk=-1; %%reduce step size every two reversals
% c0=0;
% 
% f=73.5; %frequency/number of bands 50*1.47=73.5 (10 cycles per degree)
% s=100; %gaussian sigma
% 
% im=ct3(gbr(f, s, sz));
% im0=ct3(zeros(sz));
% for n=1:ni
%     
%     if rand<0.5
%         im1=imrotate(im, 10);
%         r1=1; d0='L';
%     else
%         im1=imrotate(im, -10);
%         r1=2; d0='R';
%     end
%         
%     cwin1(im0, im0, cf, rc00, window1, window2);
%         
%         KbWait;
%         
%     cwin1(im1, im1, cf, rc00, window1, window2);
%     
%    disp(d0) ;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     
%     if kc(KbName('RightArrow'))
%         r0(n)=(r1==2);
%     elseif kc(KbName('LeftArrow'))
%         r0(n)=(r1==1);
%     end
%     disp(n2s(r0(n)))
% end
%    
% sca
% 
% 
% % global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% % addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% % cls
% % dly=0.5; %stimuli presntation times/delays: maltese, black, bars 
% % %dly=[5 5 5]; %stimuli presntation times/delays: maltese, black, bars 
% % 
% % s=16; %step size
% % wh=17; %half width of blue&red bars
% % wv=5; %gap half width between blue & red bars
% % wl=260; %length of bar
% % rd= round(43.*rand(1)); ; % random displacement up to 10 arcmin=43 pixels
% % ni=30; %number of trials
% % %% create green rectangle
% % v=250; h=250; wr=10; %half vertical, horizontal, width of rectangle 
% % %% extract visual lines
% % vl=50; %half of visual patch/line length
% % ey='Left';ex='LCA';
% % rc00=[0 0; 0 0];
% % 
% % screens = Screen('Screens');
% % screenNumber = max(screens);
% % load cal_val; %cf=[1 1];
% % %cf=[RB./RR LB./LR];
% % %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% % cf=ones(3,2);
% % [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% % ext=false;     
% % %sz0=[screenYpixels,  screenXpixels];
% % sz=[1080 1920];
% % sz2=round(sz./2);
% % i0=zeros(sz);
% % i1=i0; i1(:, sz2(2)-wh:sz2(2)+wh+1)=1;
% % 
% % u=i1; u(sz2(1)-wv:end     ,:)=0; 
% % b=i1; b(1:sz2(1)+wv+1     ,:)=0; 
% % 
% % u(1:sz2(1)-(wv+wl),   :)=0;
% % b(sz2(1)+wv+wl:end, :)=0; %check again to make sure correct number of pixels
% % 
% % u=circshift(u, [0 rd]); %add random displacement
% % b=circshift(b, [0 rd]);
% % 
% % u1=u; u2=u;
% % b1=b; b2=b;
% % 
% % i00=imread('mlt10.png'); i11=i0; %maltese cross
% % sg=[-50+1:50]; sz22=size(i00)./2;
% % i11(sz2(1)+sg, sz2(2)+sg)=i00(593+sg, 722+sg, 1);
% % %% create green rectangle
% % %v=1000; h=1900; wr=10;
% % i2=rct0([v h]./2, sz2)-rct0([v h]./2-wr, sz2) ;
% % %imshow(i2)
% % 
% % %% extract visual lines
% % %vl=10; %half of visual patch/line length
% % i3=i0; 
% % i3(sz2(1)-vl+1:sz2(1)+vl, :)=1;
% % i3(:, sz2(2)-vl+1: sz2(2)+vl)=1;
% % i4=i2.*i3;
% % %imshow(i4)
% % %extract up right down left lines
% % i5=repmat(i4, [1 1 4]);
% % i5(sz2(1)-vl+1:end,: ,1)=0; %up
% % i5(:, 1:sz2(2)+vl    ,2)=0; %right
% % i5(1:sz2(1)+vl, :    ,3)=0; %down
% % i5(:, sz2(2)-vl+1:end,4)=0; % left
% % 
% % 
% % 
% % 
% % %%need to make it for each case!
% % s0=0; su=s0; sb=-s0;
% % rsp=zeros(1,ni);
% % chk=-1; %%reduce step size every two reversals
% % c0=0;
% % for n=1:ni
% % %i5 visual cues
% % %i2 rectangle
% % %    ir=ct8(u1+i5(:,:,1)+i5(:,:,2), i2-i4, b1+i5(:,:,3)+i5(:,:,4)); %left screen
% % %    il=ct8(u2+i5(:,:,1)+i5(:,:,2), i2-i4, b2+i5(:,:,3)+i5(:,:,4)); % right screen
% % UR=i5(:,:,1)+i5(:,:,2); %upper right patches
% % BL=i5(:,:,3)+i5(:,:,4); %bottom left patches
% %    ir=ct8(u1, i2, b1); %left screen
% %    il=ct8(u2, i2, b2); % right screen
% %    imr=ct8(i0, i11+i2, i0); %maltese cross
% %    iml=ct8(i0, i11+i2, i0); %maltese cross
% %    ib=ct8(i0, i0, i0); %black screen
% % 
% %    
% %         tex_1 = Screen('MakeTexture', window1, imcal(circshift(imr, rc00(1,:)), [0.25 0.25 1]));
% %         Screen('DrawTexture', window1, tex_1);
% %         tex_2 = Screen('MakeTexture', window2, imcal(circshift(iml, rc00(2,:)), [0.25 0.25 1]));
% %         Screen('DrawTexture', window2, tex_2);
% %         Screen('Flip', window1);
% %         Screen('Flip', window2);
% %         
% %         %pause(dly(1))%(0.5)
% %         KbWait;
% %         
% % %         tex_1 = Screen('MakeTexture', window1, ib);
% % %         Screen('DrawTexture', window1, tex_1);
% % %         tex_2 = Screen('MakeTexture', window2, ib);
% % %         Screen('DrawTexture', window2, tex_2);
% % %         Screen('Flip', window1);
% % %         Screen('Flip', window2);
% % %         
% % %         
% % %         pause(dly(2));%(0.25)
% % %         
% %         
% %    
% % 
% %    %wn=cwin(img, ey, cf, window1, window2);
% %    
% % %         tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), cf(:,1)));
% % %         Screen('DrawTexture', window1, tex_1);
% % %         tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), cf(:,2)));
% %         %tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), [0.25 0.25 1]));
% %         tex_1 = Screen('MakeTexture', window1, imcal(circshift(ir, rc00(1,:)), [RB./RR RB./RG 1]));
% %         Screen('DrawTexture', window1, tex_1);
% %         %tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), [0.25 0.25 1]));
% %         tex_2 = Screen('MakeTexture', window2, imcal(circshift(il, rc00(2,:)), [LB./LR LB./LG 1]));
% % 
% %         Screen('DrawTexture', window2, tex_2);
% %         Screen('Flip', window1);
% %         Screen('Flip', window2);
% %         
% %         %
% %         
% %         pause(dly);%(0.5)
% %         %KbWait
% %         
% %         tex_1 = Screen('MakeTexture', window1, ib);
% %         Screen('DrawTexture', window1, tex_1);
% %         tex_2 = Screen('MakeTexture', window2, ib);
% %         Screen('DrawTexture', window2, tex_2);
% %         Screen('Flip', window1);
% %         Screen('Flip', window2);
% %         
% %    
% %    
% %    disp([su sb s]) ;
% %     [secs, kc, deltaSecs] = KbStrokeWait;
% %     
% %     if kc(uk)
% %         u1=circshift(u1, [0 -s]);
% %         u2=circshift(u2, [0 s]);
% %         c=1;
% %         su=su+s;
% %     elseif kc(dk)
% %         b1=circshift(b1, [0 -s]);
% %         b2=circshift(b2, [0 s]);
% %         c=2;
% %         sb=sb+s;
% %     end
% %     if c0~=c; c0=c; chk=chk+1; end;
% %     if chk>=2 & s~=1; s=s./2; chk=0; end
% % end
% % chk
% % sca
% 
% 
% 
% 
