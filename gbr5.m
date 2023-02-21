%present 2AFC gabor stimuli RED-BLUE

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
cls

ni=40; %number of trials
f=2*73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
s= 100; %gaussian  sigma
d0=1.6; %contrast step size
a0=10; %angle of image tilt
% bxy=[0 0; 37 37; 20 20]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
bxy=[0 0; 0 0;0 0]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
s2=-6:2:6; %ffTCA shift of green plane f
%s2=10.*[-6:2:6]; %ffTCA shift of green plane f

% s2=6 ; %TCA shift of green plane
% cc{1}=[0 0; 37 37; 20 20]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
% cc{2}=[0 0; 18 18; 20 20];
% cc{3}=[0 0; 9 9; 20 20];
%'a*x^b'
%RED a=58.05 b=2.473
%GREEN a=174.8 b=2.501
%BLUE a=17.47 b=2.431
a1=[58.05 174.8 17.47]; %a gamma correcion
n1=[2.473 2.501 2.431]; %ones(1,3).*2.33;
n2=(a1.*1.^n1); n3= 255.*((n2./a1).^(1./n1));
n2=n2(3).*ones(1,3); %set equiluminance 1RED 2GREEN 3BLUE
%for k0=1:3; i3(:,:,k0)=255.*(i2(:,:,k0)./a1(k0)).^(1./n1(k0)); end ; %working
ey='Left';ex='LCA';
rc00=[0 0; 0 0];
sz = [1080, 1920]; % size of screen
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[1 1];
cf=ones(3,2);
cf(2,:)=0; %turn off primer 1RED 2GREEN 3BLUE
[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 2);

r0=zeros(1,ni); %responses
chk=0; %%reduce step size every two reversals


%d1=1; %contrast;
%im=ct3(gbr(f, s, sz)); c0=mean(stretchlim(im, 0));
%im=cs3(gbr(f, s, sz), bxy); c0=mean(stretchlim(im, 0));
i1=gbr(f, s, sz); i1=i1-mna(i1); i1=i1./mxa(i1); c0=mne(i1);
i1=cs1(i1, bxy, n2);
%i1=cs1(gbr(f, s, sz), bxy, n2); c0=mean(stretchlim(i1, 0));
i0=ct3(zeros(sz));
snd(500, 0.2); %prime subject about upcoming stimulus
clear r2 c2
for k2=1:length(s2)
    d1=1; %initial contrast
    for n=1:ni
        if d1>1; d1=1; elseif d1<=0; d1=0; end;
        
        %c1=d1.*c0; %disp([n2s2(c0) ' ' n2s2(c1) ' ' n2s2(c0-c1) ' ' n2s2([c0+c1])])
        if  d1>=1;
            i2=i1;
        else
            %i2= imadjust(i1, stretchlim(i1, 0), [c0-c1; c0+c1]);
            for k0=1:3; i2(:,:,k0)=idj(i1(:,:,k0), d1); end
        end
        %gamma correction
        
        for k0=1:3; i3(:,:,k0)=255.*(i2(:,:,k0)./a1(k0)).^(1./n1(k0)); end ; %working
        %i3(:,:,2)=circshift(i3(:,:,2), [0 s2(k2)]); %change green plane
        i3(:,:,3)=circshift(i3(:,:,3), [0 s2(k2)]); %change blue plane

        %imshow(uint8(i3))
        if rand<0.5
            i4=imrotate(uint8(i3), a0);
            r1=1; d2='L';
        else
            i4=imrotate(uint8(i3), -a0);
            r1=2; d2='R';
        end
        
        cwin1(i0, i0, cf, rc00, window1, window2);
        
        KbWait;
        
        cwin1(flipud(i4), flipud(i4), cf, rc00, window1, window2);
        
        disp(['CS_SHIFT' n2s(s2(k2)) ' trl' n2s(n) ' orientation' d2]) ;
        [secs, kc, deltaSecs] = KbStrokeWait;
        
        if kc(KbName('RightArrow'))
            r0(n)=(r1==2);
        elseif kc(KbName('LeftArrow'))
            r0(n)=(r1==1);
        end
        c1(n)=d1; %record contrast
        if r0(n)==1;
            snd(1000, 0.2);
            chk=chk+1;
            if chk == 2
                d1=d1./d0; %reduce contrast
                chk=0;
            end
        else
            snd(250, 0.2);
            d1=d1.*d0; %increase contrasr
        end
        if d1>1; d1=1; elseif d1<=0; d1=0; end;
        disp(['RESPONSE' n2s(r0(n)) ' CONTRAST' n2s(d1)]);
    end
    r2(k2,:)=r0;
    c2(k2,:)=c1;
end

sca
save(['data\MB_CSF_Left_ACL0 _' tme], 'r2', 'c2', 's2')



% %present 2AFC gabor stimuli
%
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% cls
%
% ni=20; %number of trials
% f=73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
% s= 100; %gaussian sigma
% d0=1.6; %contrast step size
% a0=10; %angle of image tilt
% bxy=[0 0; 37 37; 20 20]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
% a1=[0.000144 0.00042 0.000045]; %a gamma correction
% n1=2.33;
%
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
% chk=0; %%reduce step size every two reversals
%
%
% d1=1; %contrast;
% %im=ct3(gbr(f, s, sz)); c0=mean(stretchlim(im, 0));
% %im=cs3(gbr(f, s, sz), bxy); c0=mean(stretchlim(im, 0));
% i1=cs0(gbr(f, s, sz), bxy); c0=mean(stretchlim(i1, 0));
% i0=ct3(zeros(sz));
% snd(500, 0.2); %prime subject about upcoming stimulus
% for n=1:ni
%     if d1>1; d1=1; elseif d1<=0; d1=0; end;
%     i2= imadjust(i1, stretchlim(i1, 0), [c0-d1.*c0; c0+d1.*c0]);
%     %gamma correction
% %     for k0=1:3; im1(:,:,k0)=255.*(a1(k0).*(im1(:,:,k0)./255).^(1./n1)); end
%     %for k0=1:3; i3(:,:,k0)=255.*(a1(k0).*i2(:,:,k0).^(1./n1)); end
%     for k0=1:3; i3(:,:,k0)=255.*(i2(:,:,k0).^(1./n1)); end ; %working
%     %                                                                                                                   for k0=1:3; i3(:,:,k0)=255.*10.^((1./n1).*(log10(i2(:,:,k0))-log10(a1(k0)))); end %
%
%     if rand<0.5
%         i4=imrotate(uint8(i3), a0);
%         r1=1; d2='L';
%     else
%         i4=imrotate(uint8(i3), -a0);
%         r1=2; d2='R';
%     end
%
%     cwin1(i0, i0, cf, rc00, window1, window2);
%
%         KbWait;
%
%     cwin1(flipud(i4), flipud(i4), cf, rc00, window1, window2);
%
%    disp([n2s(n) ' ' d2]) ;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%
%     if kc(KbName('RightArrow'))
%         r0(n)=(r1==2);
%     elseif kc(KbName('LeftArrow'))
%         r0(n)=(r1==1);
%     end
%     c1(n)=d1; %record contrast
%     if r0(n)==1;
%         snd(1000, 0.2);
%         chk=chk+1;
%         if chk == 2
%             d1=d1./d0; %reduce contrast
%             chk=0;
%         end
%     else
%         snd(250, 0.2);
%         d1=d1.*d0; %increase contrasr
%     end
%     disp([n2s(r0(n)) ' ' n2s(d1)]);
% end
%
% sca
% %save(['MSB_CST_Left_' tme], 'r0', 'c1')





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
