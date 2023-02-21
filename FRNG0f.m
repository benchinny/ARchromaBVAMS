%%210517 function to run fringe experiment

function rsp=FRNG0f(rsd, bxy0, bxy1, window1, window2)




% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec

global black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00


addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])

%cls

%w=130; %width of square % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
%ni=40; % number of trials
%rc00=[0 -8; 4 -7]; % updated april 20 2021, use this
ni=length(rsd); %number of trials


bxy1(:,1)=-1.*bxy1(:,1);
bxy0(:,1)=-1.*bxy0(:,1);

ms=10;
dly=2; %10 for Jim larimer; %2 [5 0.5]; %stim presentation time
ts=60; %text size
%[RR RG RB] =1.4010    4.1090    0.4064

%[LR LG LB]= 1.3480    3.9330    0.3604

load cal_val; %cf=[1 1];
KbName('UnifyKeyNames');
%cf=[RB./RR LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=ones(3,2);
%cf=[0.538 0.525; 0.538 0.525; 0.538 0.525];
ext=false;     chk=0;

%sz=[1080 1920]; i0=zeros(sz); i00=zeros(ms.*sz); sz2=ms.*sz./2;
sz=[1080 1080]; i0=zeros(sz); i00=zeros(ms.*sz); sz2=ms.*sz./2; sz22=sz./2;

load('FRNGS_210512.mat', 'im_frng');
%tp=[1 1.5; 0.5 1; 1 0.5; 1.5 1]; %text position
% tp=[1 1.25; 0.75 1; 1 0.75; 1.25 1]; %text position
%tp=[1 1.25; 0.65 1; 1 0.75; 1.35 1]; %text position

%im0=ct8(dszf(i1 ,ms), dszf(i1 ,ms), dszf(i1 ,ms));

%tx={sprintf('Option 1'), sprintf('Option 2'), sprintf('Which option was \n more fringed?')};

ic0=crc0(400, sz); %ic1=crc0(400, sz); %circle
cwin1(ct8(zeros(sz), zeros(sz), ic0), ct8(zeros(sz), zeros(sz), ic0), cf, rc00, window1, window2);

i000=ct8(i0, i0, i0);
im2=cell(4,2); clear t1 t2
t0=[2 1 2 1]; %translate from half to merge side
t1{1,1}=[4 2]; t1{1,2}=[2 2];
t1{2,1}=[1 1]; t1{2,2}=[3 1];
t1{3,1}=[4 1]; t1{3,2}=[2 1];
t1{4,1}=[1 2]; t1{4,2}=[3 2];
n00=10; %gray pixels;

t2=[1 sz(1) sz22(2)-n00 sz22(2)+n00; sz22(1)-n00 sz22(1)+n00 1 sz(2); 1 sz(1) sz22(2)-n00 sz22(2)+n00; sz22(1)-n00 sz22(1)+n00 1 sz(2)]; %gray strip location



[j04 j03 j02 j01 j00]=d4i(bxy0, ms); % system+subject TCA
[j14 j13 j12 j11 j10]=d4i(bxy1, ms); % system+subject TCA


for k0=1:4
     if k0==1 | k0==3
     ir0= circshift(im_frng{k0, j03(1,1)}    ,[j01(1,1)-j04(1,1) 0] ); %window2 LFT screen RED
     ig0= circshift(im_frng{k0, j03(2,1)}    ,[j01(2,1)-j04(2,1) 0] ); %window2 LFT screen GREEN
     ib0= circshift(im_frng{k0, j03(3,1)}    ,[j01(3,1)-j04(3,1) 0] ); %window2 LFT screen BLUE
     
     ir1= circshift(im_frng{k0, j13(1,1)}    ,[j11(1,1)-j14(1,1) 0] ); %window2 LFT screen RED
     ig1= circshift(im_frng{k0, j13(2,1)}    ,[j11(2,1)-j14(2,1) 0] ); %window2 LFT screen GREEN
     ib1= circshift(im_frng{k0, j13(3,1)}    ,[j11(3,1)-j14(3,1) 0] ); %window2 LFT screen BLUE
     
       elseif k0==2 | k0==4
     
     ir0= circshift(im_frng{k0, j03(1,2)}    ,[0 j01(1,2)-j04(1,2)] ); %window2 LFT screen RED
     ig0= circshift(im_frng{k0, j03(2,2)}    ,[0 j01(2,2)-j04(2,2)] ); %window2 LFT screen GREEN
     ib0= circshift(im_frng{k0, j03(3,2)}    ,[0 j01(3,2)-j04(3,2)] ); %window2 LFT screen BLUE

     ir1= circshift(im_frng{k0, j13(1,2)}    ,[0 j11(1,2)-j14(1,2)] ); %window2 LFT screen RED
     ig1= circshift(im_frng{k0, j13(2,2)}    ,[0 j11(2,2)-j14(2,2)] ); %window2 LFT screen GREEN
     ib1= circshift(im_frng{k0, j13(3,2)}    ,[0 j11(3,2)-j14(3,2)] ); %window2 LFT screen BLUE 
     
     end
    
     im0=cat(3, ir0, ig0, ib0);
     im1=cat(3, ir1, ig1, ib1);
     
    [im21 im20]=mrg(im1, im0,t0(k0));
    
    %% add gray bar
    im21(t2(k0,1): t2(k0,2) , t2(k0,3):t2(k0, 4), :)=127;
    im20(t2(k0,1): t2(k0,2) , t2(k0,3):t2(k0, 4), :)=127;
    
    im2{t1{k0,1}(1),t1{k0,1}(2)}=im21;
    im2{t1{k0,2}(1),t1{k0,2}(2)}=im20;
    
end

t00=[1 2 3 4 1 2 3 4; 1 1 1 1 2 2 2 2]; %transform rsd
rsp=-1.*ones(1,ni);
drc=rsp; %response direction;
rsd0=mod(rsd,4); rsd0=rsd0+4.*(rsd0==0); %correct for the 8 conditions to become 4
ib=insertText(ct8(zeros(sz), zeros(sz), ic0), sz2./10, sprintf('Which side looks fringed?'), 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)

chk1=0;

disp('READY')
KbWait([], 2);
for n=1:ni
    chk0=0;

    im4=im2{t00(1,rsd(n)), t00(2,rsd(n))};

    cwin1(flipud(im4),flipud(im4), cf, rc00, window1, window2);
    
    pause(dly(1));

    cwin1(flipud(ib),flipud(ib), cf, rc00, window1, window2);

    while chk0==0 & chk1==0;
        [secs, kc, deltaSecs] = KbStrokeWait;
        
        if kc(KbName('UpArrow')) 
             drc(n)=3;
        elseif kc(KbName('RightArrow')) 
            drc(n)=4;
        elseif kc(KbName('DownArrow'))
            drc(n)=1;
        elseif kc(KbName('LeftArrow'))
              drc(n)=2;
        elseif kc(KbName('0'))
            chk0=1;
        elseif kc(KbName('ESCAPE'))
            chk1=1;
        end
        
        rsp(n)=(drc(n)==rsd0(1,n)); %compare responses

        disp([rsd(drc~=-1); rsp(drc~=-1)]); %display TCA direction 1UP2RIGHT3DOWN4LEFT5UP6RIGHT7DOWN8LEFT and correct/wrong response
    end
    if chk1==1; break; end
    
    save(['data\FRNGtmp'], 'bxy0','bxy1', 'rsp', 'rsd');
end

sca
