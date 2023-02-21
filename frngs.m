%% 210409 changed the square stimuli to half screen one

% Natural TCA, Natural LCA
% Natural LCA, TCA corrected
% LCA corrected, natural TCA
% LCA corrected, TCA corrected
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
global ek uk dk lk rk sp n0m n1m n2m n0d n1d n2d st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])

cls

w=130; %width of square % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
ni=10; % number of trials
%bxy=[10 10; 0 0; -10 -10];

%UPDATE THE TCA FILES depedning on ACL=0 or 1
% load('S10003_TCA_RightACL1_2104021427.mat'); z1R=z1; %ar 10003
% load('S10003_TCA_LeftACL0_2103261614.mat'); z1L=z1;
% These files already have z1 values saved. Need to extract the correct part of z1 values from each of above 2 files, and create a new z1 matrix which can be used in a binocular task.

% load('S10003_TCA_RightACL1_2104021427.mat'); z1R=z1; % 
% load('S10004_TCA_LeftACL0_2103301253.mat'); z1L=z1; %
% 
% z1(:, 3:4)=z1R(:, 3:4);
% bxy1=[0 0; z1(2,3) z1(2,4); z1(3,3) z1(3,4)];%right
% % bxy1=[0 0; z1(2,1) z1(2,2); z1(3,1) z1(3,2)]; %left


%LOAD LCA DATA SYSTEM TCA found from trombone powers, so load ACL=0 LCA data 
% load('S10003_LCA_RightACL0_2103261450.mat', 'a18'); a18R=a18; %RIGHT LCA
% ar

% load('S10003_LCA_LeftACL0_2103261603.mat', 'a18');  a18L=a18; %LEFT LCA
% ar

%UPDATE1: filename for LCA!!!!!!!!!!!!!!!
load('S10003_LCA_RightACL0_2103261450.mat', 'a18'); a18R=a18; %RIGHT LCA AJR
% load('S10004_LCA_LeftACL0_2103301234.mat', 'a18');  a18L=a18; %LEFT LCA msb
load('S10004_LCA_LeftACL0_2104061444.mat', 'a18');  a18L=a18; %LEFT LCA msb
a18(:,2)=a18R(:,2);
% 
a18(5,1)=opL(1);%n
a18(5,2)=opR(1);%n


findz0;
%SYSTEM TCA 
%UPDATE2: choose which eye!!!!!!!!!!!!!!!
%bxy0=[0 0; z0(2,3) z0(2,4); z0(3,3) z0(3,4)];%right eye z0 based on LCA values
 bxy0=[0 0; z0(2,1) z0(2,2); z0(3,1) z0(3,2)]; %left eye z0 based on LCA values
%  bxy0=[0 0; 0 0; 0 0];%right eye z0 based on LCA values

% bxy0=[0	    0 ; -0.7679    1.3683; -1.1933    1.4655]; %right acl=0
% bxy0=[0	    0 ; -0.9175    2.0283;  -1.2442    3.2913 ];  %left acl=0
% bxy0=[0	0; -0.33332	2.07501;-0.25834	3.16666]; %right acl=1
% bxy0= [0	0;-0.46667	2.10833;-0.39999	3.60834	 ];%left acl=1

%enter subject+system tca here for one eye, redY redX, greenY grnX, BlueY
%BlueX]
%load tca and run  z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]

%UPDATE3: filename!!!!!!!!!!!!!!!!
%load('S10003_TCA_RightACL1_2104161120.mat','z1');
% load('S10004_TCA_LeftACL1_2104161525.mat','z1');
%  load('S10007_TCA_LeftACL1_Cam_2104191127.mat', 'z1');
%  load('S10007_TCA_LeftACL1_CAm2104191224.mat', 'z1');

load('S10007_TCA_LeftACL1_Cam2104191322.mat', 'z1');
%UPDATE4: choose left or right bxy1!!!!!!!!!!!!!!!!
%bxy1=[0 0; z1(2,3) z1(2,4); z1(3,3) z1(3,4)]; %Right Eye Z1
bxy1=[0 0; z1(2,1) z1(2,2); z1(3,1) z1(3,2)]; %left eye z1 
% bxy1=[0 0; -50 50; -100 100]; %Right Eye Z1

bxy1(:,1)=-1.*bxy1(:,1);
bxy0(:,1)=-1.*bxy0(:,1);

ey='Stereo';ex='LCA'
ms=10; 
dly=[2 0.5]; %[5 0.5]; %stim presentation time
ts=60; %text size
%[RR RG RB] =1.4010    4.1090    0.4064

%[LR LG LB]= 1.3480    3.9330    0.3604


screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; %cf=[1 1];
KbName('UnifyKeyNames');
%cf=[RB./RR LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
cf=ones(3,2);
[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
ext=false;     chk=0;
sz0=[screenYpixels,  screenXpixels];
sz0=[1080 1080];

%sz=[1080 1920]; i0=zeros(sz); i00=zeros(ms.*sz); sz2=ms.*sz./2;
sz=[1080 1080]; i0=zeros(sz); i00=zeros(ms.*sz); sz2=ms.*sz./2;

im{1}=i00; im{2}=i00; im{3}=i00; im{4}=i00;

 

im{1}(1:sz2(1),:)=1; %up

im{3}(sz2(1)+1:end,:)=1; %down

 

im{4}(:, 1:sz2(2))=1; %left

im{2}(:, sz2(2)+1:end)=1; %right

%tp=[1 1.5; 0.5 1; 1 0.5; 1.5 1]; %text position
% tp=[1 1.25; 0.75 1; 1 0.75; 1.25 1]; %text position
tp=[1 1.25; 0.65 1; 1 0.75; 1.35 1]; %text position



% sz=[1080 1920]; i00=zeros(sz);
% 
% sz2=round(sz0./2);
% sz4=round(sz0./4);
% bx=ones(ms.*w);
% i0=zeros(ms.*sz0);
% i1=embd(bx, i0);
%xy=round(ms.*bxy);
xy0=round(ms.*bxy0);
xy1=round(ms.*bxy1);

%im0=ct8(dszf(i1 ,ms), dszf(i1 ,ms), dszf(i1 ,ms));


for k0=1:4
im0{k0}=ct8(dszf(circshift(im{k0}, xy0(1,:)),ms), dszf(circshift(im{k0}, xy0(2,:)),ms), dszf(circshift(im{k0}, xy0(3,:)),ms));
im1{k0}=ct8(dszf(circshift(im{k0}, xy1(1,:)),ms), dszf(circshift(im{k0}, xy1(2,:)),ms), dszf(circshift(im{k0}, xy1(3,:)),ms));
end
tx={sprintf('Option 1'), sprintf('Option 2'), sprintf('Which option was \n more fringed?')};

% ib=insertText(ct8(i00, i00, i00), sz2.*[1.75 1], tx{3}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)

ic0=crc0(100, sz); ic1=crc0(400, sz); %circle 
%ib=insertText(ct8(zeros(sz), zeros(sz), ic0-ic1), sz2.*[1.75 1]./10, tx{3}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)
% ib=insertText(ct8(zeros(sz), zeros(sz), ic0-ic1), sz2./10, tx{3}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)
ib=insertText(ct8(zeros(sz), zeros(sz), ic0), sz2./10, tx{3}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)

rsp=zeros(1,ni);
chk1=0;
rsd=randi(4, 1, ni);%choose orientation of half screen


wn=cwin(ct8(zeros(sz), zeros(sz), ic0), ey, cf, window1, window2);

[secs, kc, deltaSecs] = KbStrokeWait;

for n=1:ni
    chk0=0;
    if rand(1)>=0.5
%         c1=im1;
%         c2=im0;
%         c1=insertText(im1{rsd(n)}, sz2.*[1 0.5]./10, tx{1}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c2=insertText(im0{rsd(n)}, sz2.*[1 0.5]./10, tx{2}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c=1;

        c1=insertText(im1{rsd(n)}, sz2.*tp(rsd(n),:)./10, tx{1}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
        c2=insertText(im0{rsd(n)}, sz2.*tp(rsd(n),:)./10, tx{2}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
        c=1;
%         st0=n1m;
%         st1=n1d;
    else
        c1=insertText(im0{rsd(n)}, sz2.*tp(rsd(n),:)./10, tx{1}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
        c2=insertText(im1{rsd(n)}, sz2.*tp(rsd(n),:)./10, tx{2}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
        c=2;
%         st0=n2m;
%         st1=n2d;
    end
    
    wn=cwin(ct8(i00, i00, i00), ey, cf, window1, window2);

    pause(dly(2));

    wn=cwin(flipud(c1), ey, cf, window1, window2);
    
    pause(dly(1));
    
    wn=cwin(ct8(i00, i00, i00), ey, cf, window1, window2);

    pause(dly(2));
    
    wn=cwin(flipud(c2), ey, cf, window1, window2);
    
    pause(dly(1));
    
    wn=cwin(flipud(ib), ey, cf, window1, window2);
    while chk0==0 & chk1==0;
            [secs, kc, deltaSecs] = KbStrokeWait;
            
            if kc(KbName('1!')) | kc(KbName('1'))
                c10=1;
            elseif kc(KbName('2@')) | kc(KbName('2'))
                c10=2;
            end

        %if kc(st0) | kc(st1); keyCode(KbName('RightArrow'))
        if c==c10; %check if keypress matches the fringed option
            disp(1);
            rsp(n)=1;
            chk0=0;
            c10=0;
        elseif kc(KbName('0)')) | kc(KbName('0')); %kc(n0m) | kc(n0d) %zero 
            chk0=1;
        elseif kc(KbName('ESCAPE'))%  | kc(KbName('1')); kc(ek)
            chk1=1; 
        else
            disp(0);
            rsp(n)=0;
            chk0=0;
        end
    end   
    if chk1==1; break; end
end

save(['data\FRNG_' tme], 'bxy0','bxy1', 'rsp', 'rsd'); 

sca




% %% 210409 Option 1 vs 2, which one looks fringed? 2AFC
% 
% % Natural TCA, Natural LCA
% % Natural LCA, TCA corrected
% % LCA corrected, natural TCA
% % LCA corrected, TCA corrected
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% global ek uk dk lk rk sp n0m n1m n2m n0d n1d n2d st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% 
% cls
% 
% w=130; %width of square % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% ni=10; % number of trials
% %bxy=[10 10; 0 0; -10 -10];
% 
% %UPDATE THE TCA FILES depedning on ACL=0 or 1
% % load('S10003_TCA_RightACL1_2104021427.mat'); z1R=z1; %ar 10003
% % load('S10003_TCA_LeftACL0_2103261614.mat'); z1L=z1;
% % These files already have z1 values saved. Need to extract the correct part of z1 values from each of above 2 files, and create a new z1 matrix which can be used in a binocular task.
% 
% load('S10003_TCA_RightACL1_2104021427.mat'); z1R=z1; %mb 10004
% load('S10004_TCA_LeftACL0_2103301253.mat'); z1L=z1;
% 
% z1(:, 3:4)=z1R(:, 3:4);
% bxy1=[0 0; z1(2,3) z1(2,4); z1(3,3) z1(3,4)];%right
% % bxy1=[0 0; z1(2,1) z1(2,2); z1(3,1) z1(3,2)]; %left
% 
% 
% %LOAD LCA DATA SYSTEM TCA found from trombone powers, so load ACL=0 LCA data 
% % load('S10003_LCA_RightACL0_2103261450.mat', 'a18'); a18R=a18; %RIGHT LCA
% % ar
% 
% % load('S10003_LCA_LeftACL0_2103261603.mat', 'a18');  a18L=a18; %LEFT LCA
% % ar
% 
% load('S10003_LCA_RightACL0_2103261450.mat', 'a18'); a18R=a18; %RIGHT LCA mb
% load('S10004_LCA_LeftACL0_2103301234.mat', 'a18');  a18L=a18; %LEFT LCA mb
% 
% a18(:,2)=a18R(:,2);
% 
% findz0;
% %SYSTEM TCA 
% bxy0=[0 0; z0(2,3) z0(2,4); z0(3,3) z0(3,4)];%right
% % bxy0=[0 0; z0(2,1) z0(2,2); z0(3,1) z0(3,2)]; %left
% 
% % bxy0=[0	    0 ; -0.7679    1.3683; -1.1933    1.4655]; %right acl=0
% % bxy0=[0	    0 ; -0.9175    2.0283;  -1.2442    3.2913 ];  %left acl=0
% % bxy0=[0	0; -0.33332	2.07501;-0.25834	3.16666]; %right acl=1
% % bxy0= [0	0;-0.46667	2.10833;-0.39999	3.60834	 ];%left acl=1
% 
% %enter subject+system tca here for one eye, redY redX, greenY grnX, BlueY
% %BlueX]
% %load tca and run  z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]
% % bxy1=[0 0;0.4167   -2.3333; -0.3333   -2.9167];
% % bxy1=[0 0;3.2500   -1.5000;  2.9167   -0.9167];
%    
% 
% 
% 
% ey='Stereo';ex='LCA'
% ms=10; 
% dly=[2 0.5]; %stim presentation time
% ts=60; %text size
% %[RR RG RB] =1.4010    4.1090    0.4064
% 
% %[LR LG LB]= 1.3480    3.9330    0.3604
% 
% 
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1];
% KbName('UnifyKeyNames');
% %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=ones(3,2);
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% ext=false;     chk=0;
% sz0=[screenYpixels,  screenXpixels];
% sz0=[1080 1080];
% sz=[1080 1920]; i00=zeros(sz);
% 
% sz2=round(sz0./2);
% sz4=round(sz0./4);
% bx=ones(ms.*w);
% i0=zeros(ms.*sz0);
% i1=embd(bx, i0);
% %xy=round(ms.*bxy);
% xy0=round(ms.*bxy0);
% xy1=round(ms.*bxy1);
% 
% %im0=ct8(dszf(i1 ,ms), dszf(i1 ,ms), dszf(i1 ,ms));
% im0=ct8(dszf(circshift(i1, xy0(1,:)),ms), dszf(circshift(i1, xy0(2,:)),ms), dszf(circshift(i1, xy0(3,:)),ms));
% im1=ct8(dszf(circshift(i1, xy1(1,:)),ms), dszf(circshift(i1, xy1(2,:)),ms), dszf(circshift(i1, xy1(3,:)),ms));
% tx={sprintf('Option 1'), sprintf('Option 2'), sprintf('Which option was \n more fringed?')}
% 
% % ib=insertText(ct8(i00, i00, i00), sz2.*[1.75 1], tx{3}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)
% 
% ic0=crc0(500, sz); ic1=crc0(400, sz); %circle 
% ib=insertText(ct8(i00, i00, ic0), sz2.*[1.75 1], tx{3}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)
% 
% rsp=zeros(1,ni);
% chk1=0;
% 
% 
% wn=cwin(ct8(i00, i00, ic0-ic1), ey, cf, window1, window2);
% 
% [secs, kc, deltaSecs] = KbStrokeWait;
% 
% for n=1:ni
%     chk0=0;
%     if rand(1)>=0.5
% %         c1=im1;
% %         c2=im0;
%         c1=insertText(im1, sz2.*[1 0.5], tx{1}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c2=insertText(im0, sz2.*[1 0.5], tx{2}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c=1;
% %         st0=n1m;
% %         st1=n1d;
%     else
%         c1=insertText(im0, sz2.*[1 0.5], tx{1}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c2=insertText(im1, sz2.*[1 0.5], tx{2}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c=2;
% %         st0=n2m;
% %         st1=n2d;
%     end
% 
%     wn=cwin(flipud(c1), ey, cf, window1, window2);
%     
%     pause(dly(1));
%     
%     wn=cwin(ct8(i00, i00, i00), ey, cf, window1, window2);
% 
%     pause(dly(2));
%     
%     wn=cwin(flipud(c2), ey, cf, window1, window2);
%     
%     pause(dly(1));
%     
%     wn=cwin(flipud(ib), ey, cf, window1, window2);
%     while chk0==0 & chk1==0;
%             [secs, kc, deltaSecs] = KbStrokeWait;
%             
%             if kc(KbName('1!')) | kc(KbName('1'))
%                 c10=1;
%             elseif kc(KbName('2@')) | kc(KbName('2'))
%                 c10=2;
%             end
% 
%         %if kc(st0) | kc(st1); keyCode(KbName('RightArrow'))
%         if c==c10; %check if keypress matches the fringed option
%             disp(1);
%             rsp(n)=1;
%             chk0=0;
%             c10=0;
%         elseif kc(KbName('0)')) | kc(KbName('0')); %kc(n0m) | kc(n0d) %zero 
%             chk0=1;
%         elseif kc(KbName('ESCAPE'))%  | kc(KbName('1')); kc(ek)
%             chk1=1; 
%         else
%             disp(0);
%             rsp(n)=0;
%             chk0=0;
%         end
%     end   
%     if chk1==1; break; end
% end
% 
% save(['data\FRNG_' tme], 'bxy0','bxy1', 'rsp'); 
% 
% sca



% %% 210331 Option 1 vs 2, which one looks fringed? 2AFC
% 
% % Natural TCA, Natural LCA
% % Natural LCA, TCA corrected
% % LCA corrected, natural TCA
% % LCA corrected, TCA corrected
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% global ek uk dk lk rk sp n0m n1m n2m n0d n1d n2d st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% 
% cls
% 
% w=130; %width of square % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% ni=10; % number of trials
% %bxy=[10 10; 0 0; -10 -10];
% 
% %SYSTEM TCA 
% % bxy0=[0	    0 ; -0.7679    1.3683; -1.1933    1.4655]; %right acl=0
% bxy0=[0	    0 ; -0.9175    2.0283;  -1.2442    3.2913 ];  %left acl=0
% % bxy0=[0	0; -0.33332	2.07501;-0.25834	3.16666]; %right acl=1
% % bxy0= [0	0;-0.46667	2.10833;-0.39999	3.60834	 ];%left acl=1
% 
% %enter subject+system tca here for one eye, redX redY, greenX grnY, BlueX
% %BlueY]
% %load tca and run  z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]
% % bxy1=[0 0;0.4167   -2.3333; -0.3333   -2.9167];
% bxy1=[0 0;3.2500   -1.5000;  2.9167   -0.9167];
%    
% 
% 
% 
% ey='Stereo';ex='LCA'
% ms=10; 
% dly=[2 0.5]; %stim presentation time
% ts=60; %text size
% %[RR RG RB] =1.4010    4.1090    0.4064
% 
% %[LR LG LB]= 1.3480    3.9330    0.3604
% 
% 
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1];
% KbName('UnifyKeyNames');
% %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=ones(3,2);
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% ext=false;     chk=0;
% sz0=[screenYpixels,  screenXpixels];
% sz0=[1080 1080];
% sz=[1080 1920]; i00=zeros(sz);
% 
% sz2=round(sz0./2);
% sz4=round(sz0./4);
% bx=ones(ms.*w);
% i0=zeros(ms.*sz0);
% i1=embd(bx, i0);
% %xy=round(ms.*bxy);
% xy0=round(ms.*bxy0);
% xy1=round(ms.*bxy1);
% 
% %im0=ct8(dszf(i1 ,ms), dszf(i1 ,ms), dszf(i1 ,ms));
% im0=ct8(dszf(circshift(i1, xy0(1,:)),ms), dszf(circshift(i1, xy0(2,:)),ms), dszf(circshift(i1, xy0(3,:)),ms));
% im1=ct8(dszf(circshift(i1, xy1(1,:)),ms), dszf(circshift(i1, xy1(2,:)),ms), dszf(circshift(i1, xy1(3,:)),ms));
% tx={sprintf('Option 1'), sprintf('Option 2'), sprintf('Which option was \n more fringed?')}
% 
% ib=insertText(ct8(i00, i00, i00), sz2.*[1.75 1], tx{3}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)
% rsp=zeros(1,ni);
% chk1=0;
% for n=1:ni
%     chk0=0;
%     if rand(1)>=0.5
% %         c1=im1;
% %         c2=im0;
%         c1=insertText(im1, sz2.*[1 0.5], tx{1}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c2=insertText(im0, sz2.*[1 0.5], tx{2}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c=1;
% %         st0=n1m;
% %         st1=n1d;
%     else
%         c1=insertText(im0, sz2.*[1 0.5], tx{1}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c2=insertText(im1, sz2.*[1 0.5], tx{2}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c=2;
% %         st0=n2m;
% %         st1=n2d;
%     end
% 
%     wn=cwin(flipud(c1), ey, cf, window1, window2);
%     
%     pause(dly(1));
%     
%     wn=cwin(ct8(i00, i00, i00), ey, cf, window1, window2);
% 
%     pause(dly(2));
%     
%     wn=cwin(flipud(c2), ey, cf, window1, window2);
%     
%     pause(dly(1));
%     
%     wn=cwin(flipud(ib), ey, cf, window1, window2);
%     while chk0==0 & chk1==0;
%             [secs, kc, deltaSecs] = KbStrokeWait;
%             
%             if kc(KbName('1!')) | kc(KbName('1'))
%                 c10=1;
%             elseif kc(KbName('2@')) | kc(KbName('2'))
%                 c10=2;
%             end
% 
%         %if kc(st0) | kc(st1); keyCode(KbName('RightArrow'))
%         if c==c10; %check if keypress matches the fringed option
%             disp(1);
%             rsp(n)=1;
%             chk0=0;
%             c10=0;
%         elseif kc(KbName('0)')) | kc(KbName('0')); %kc(n0m) | kc(n0d) %zero 
%             chk0=1;
%         elseif kc(KbName('ESCAPE'))%  | kc(KbName('1')); kc(ek)
%             chk1=1; 
%         else
%             disp(0);
%             rsp(n)=0;
%             chk0=0;
%         end
%     end   
%     if chk1==1; break; end
% end
% 
% save(['data\FRNG_' tme], 'bxy0','bxy1', 'rsp'); 
% 
% sca


% %% 210326 Option 1 vs 2, which one looks fringed? 2AFC
% 
% % Natural TCA, Natural LCA
% % Natural LCA, TCA corrected
% % LCA corrected, natural TCA
% % LCA corrected, TCA corrected
% % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% global ek uk dk lk rk sp n0m n1m n2m n0d n1d n2d st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% 
% cls
% 
% w=130; %width of square % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
% ni=10; % number of trials
% bxy=[10 10; 0 0; -10 -10];
% ey='Stereo';ex='LCA'
% ms=10; 
% dly=[2 0.5]; %stim presentation time
% ts=60; %text size
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
% sz0=[screenYpixels,  screenXpixels];
% sz0=[1080 1080];
% sz=[1080 1920]; i00=zeros(sz);
% 
% sz2=round(sz0./2);
% sz4=round(sz0./4);
% bx=ones(ms.*w);
% i0=zeros(ms.*sz0);
% i1=embd(bx, i0);
% xy=round(ms.*bxy);
% im0=ct8(dszf(i1 ,ms), dszf(i1 ,ms), dszf(i1 ,ms));
% im1=ct8(dszf(circshift(i1, xy(1,:)),ms), dszf(circshift(i1, xy(2,:)),ms), dszf(circshift(i1, xy(3,:)),ms));
% tx={sprintf('Option 1'), sprintf('Option 2'), sprintf('Which option was \n more fringed?')}
% 
% ib=insertText(ct8(i00, i00, i00), sz2.*[1.75 1], tx{3}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)
% rsp=zeros(1,ni);
% chk1=0;
% for n=1:ni
%     chk0=0;
%     if rand(1)>=0.5
% %         c1=im1;
% %         c2=im0;
%         c1=insertText(im1, sz2.*[1 0.5], tx{1}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c2=insertText(im0, sz2.*[1 0.5], tx{2}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c=1;
%         st0=n1m;
%         st1=n1d;
%     else
%         c1=insertText(im0, sz2.*[1 0.5], tx{1}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c2=insertText(im1, sz2.*[1 0.5], tx{2}, 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center');
%         c=2;
%         st0=n2m;
%         st1=n2d;
%     end
% 
%     wn=cwin(flipud(c1), ey, cf, window1, window2);
%     
%     pause(dly(1));
%     
%     wn=cwin(ct8(i00, i00, i00), ey, cf, window1, window2);
% 
%     pause(dly(2));
%     
%     wn=cwin(flipud(c2), ey, cf, window1, window2);
%     
%     pause(dly(1));
%     
%     wn=cwin(flipud(ib), ey, cf, window1, window2);
%     while chk0==0 & chk1==0;
%             [secs, kc, deltaSecs] = KbStrokeWait;
% 
%         if kc(st0) | kc(st1)
%             disp(1);
%             rsp(n)=1;
%         elseif kc(n0m) | kc(n0d) %zero 
%             chk0=1;
%         elseif kc(ek)
%             chk1=1; 
%         else
%             disp(0);
%             rsp(n)=0;
%         end
%     end   
%     if chk1==1; break; end
% end
% 
% sca

%% 201011
% %% Option 1 vs 2, which one looks fringed? 2AFC
% 
% % Natural TCA, Natural LCA
% % Natural LCA, TCA corrected
% % LCA corrected, natural TCA
% % LCA corrected, TCA corrected
% 
% 
% 
% cls
% 
% global ek uk dk lk rk sp n1m n2m st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% 
% w=200;
% ni=3;
% bxy=[10 10; 0 0; -10 -10];
% ey='Stereo';ex='LCA'
% ms=10;
% dly=10; %stim presentation time
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
% sz0=[screenYpixels,  screenXpixels];
% sz0=[1080 1080];
% sz=[1080 1920]; i00=zeros(sz);
% 
% sz2=round(sz0./2);
% sz4=round(sz0./4);
% bx=ones(ms.*w);
% i0=zeros(ms.*sz0);
% i1=embd(bx, i0);
% xy=round(ms.*bxy);
% im0=ct8(dszf(i1 ,ms), dszf(i1 ,ms), dszf(i1 ,ms));
% im1=ct8(dszf(circshift(i1, xy(1,:)),ms), dszf(circshift(i1, xy(2,:)),ms), dszf(circshift(i1, xy(3,:)),ms));
% 
% rsp=zeros(1,ni);
% chk1=0;
% for n=1:ni
%     chk0=0;
%     if rand(1)>=0.5
%         c1=im1;
%         c2=im0;
%         c=1;
%         st=n1m;
%         %st=rk;
%     else
%         c1=im0;
%         c2=im1;
%         c=2;
%         st=n2m;
%         %st=lk;
%     end
%     
%     
%     
%     
%     
%     Screen('TextSize', window1, 70);
%     Screen('TextSize', window2, 70);
% 
%     DrawFormattedText(window1, 'Option 1' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
%     DrawFormattedText(window2, 'Option 1' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
% 
%     wn=cwin(c1, ey, cf, window1, window2);
%     
%     pause(dly);
%     
%     
%     Screen('TextSize', window1, 70);
%     Screen('TextSize', window2, 70);
% 
%     DrawFormattedText(window1, 'Option 2' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
%     DrawFormattedText(window2, 'Option 2' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
% 
%     wn=cwin(c2, ey, cf, window1, window2);
%     
%     pause(dly);
%     
%     Screen('TextSize', window1, 70);
%     Screen('TextSize', window2, 70);
% 
%     DrawFormattedText(window1, 'Which option was more fringed?' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
%     DrawFormattedText(window2, 'Which option was more fringed?' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
% 
%     wn=cwin(zeros(sz(1), sz(2), 3), ey, cf, window1, window2);
%     
%     while chk0==0 & chk1==0;
%             [secs, kc, deltaSecs] = KbStrokeWait;
% 
%         if kc(st)
%             disp(1);
%             rsp(n)=1;
%         elseif kc(sp)
%             chk0=1;
%         elseif kc(ek)
%             chk1=1; 
%         else
%             disp(0);
%             rsp(n)=0;
%         end
%     end   
%     if chk1==1; break; end
% end
% 
% sca



%% 201011
% %% Option 1 vs 2, which one looks fringed? 2AFC
% 
% % Natural TCA, Natural LCA
% % Natural LCA, TCA corrected
% % LCA corrected, natural TCA
% % LCA corrected, TCA corrected
% 
% 
% 
% cls
% 
% global ek uk dk lk rk sp n1m n2m st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% 
% w=200;
% ni=3;
% bxy=[10 10; 0 0; -10 -10];
% ey='Stereo';ex='LCA'
% ms=10;
% dly=10; %stim presentation time
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
% sz0=[screenYpixels,  screenXpixels];
% sz0=[1080 1080];
% sz=[1080 1920]; i00=zeros(sz);
% 
% sz2=round(sz0./2);
% sz4=round(sz0./4);
% bx=ones(ms.*w);
% i0=zeros(ms.*sz0);
% i1=embd(bx, i0);
% xy=round(ms.*bxy);
% im0=ct8(dszf(i1 ,ms), dszf(i1 ,ms), dszf(i1 ,ms));
% im1=ct8(dszf(circshift(i1, xy(1,:)),ms), dszf(circshift(i1, xy(2,:)),ms), dszf(circshift(i1, xy(3,:)),ms));
% 
% rsp=zeros(1,ni);
% chk1=0;
% for n=1:ni
%     chk0=0;
%     if rand(1)>=0.5
%         c1=im1;
%         c2=im0;
%         c=1;
%         st=n1m;
%         %st=rk;
%     else
%         c1=im0;
%         c2=im1;
%         c=2;
%         st=n2m;
%         %st=lk;
%     end
%     
%     
%     
%     
%     
%     Screen('TextSize', window1, 70);
%     Screen('TextSize', window2, 70);
% 
%     DrawFormattedText(window1, 'Option 1' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
%     DrawFormattedText(window2, 'Option 1' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
% 
%     wn=cwin(c1, ey, cf, window1, window2);
%     
%     pause(dly);
%     
%     
%     Screen('TextSize', window1, 70);
%     Screen('TextSize', window2, 70);
% 
%     DrawFormattedText(window1, 'Option 2' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
%     DrawFormattedText(window2, 'Option 2' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
% 
%     wn=cwin(c2, ey, cf, window1, window2);
%     
%     pause(dly);
%     
%     Screen('TextSize', window1, 70);
%     Screen('TextSize', window2, 70);
% 
%     DrawFormattedText(window1, 'Which option was more fringed?' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
%     DrawFormattedText(window2, 'Which option was more fringed?' , 'center',...
%     screenYpixels * 0.2, [1 1 1]);
% 
%     wn=cwin(zeros(sz(1), sz(2), 3), ey, cf, window1, window2);
%     
%     while chk0==0 & chk1==0;
%             [secs, kc, deltaSecs] = KbStrokeWait;
% 
%         if kc(st)
%             disp(1);
%             rsp(n)=1;
%         elseif kc(sp)
%             chk0=1;
%         elseif kc(ek)
%             chk1=1; 
%         else
%             disp(0);
%             rsp(n)=0;
%         end
%     end   
%     if chk1==1; break; end
% end
% 
% sca12012000121201