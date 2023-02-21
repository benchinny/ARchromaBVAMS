%% 210429 frngs1  half screen with gray gap fringed and no fringed together

% Natural TCA, Natural LCA
% Natural LCA, TCA corrected
% LCA corrected, natural TCA
% LCA corrected, TCA corrected
% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
global ek uk dk lk rk sp n0m n1m n2m n0d n1d n2d st snt black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])

cls

w=130; %width of square % 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
ni=40; % number of trials
rc00=[0 -8; 4 -7]; % updated april 20 2021, use this
bxy0=zeros(3,4)
%bxy1=10.*[-1 -1 -1 -1; 0 0 0 0; 1 1 1 1];
bxy1=10.*[0 0 0 0; 1 1 1 1; 2 2 2 2];

bxy1(:,1)=-1.*bxy1(:,1);
bxy0(:,1)=-1.*bxy0(:,1);

ey='Stereo';ex='LCA'
ms=10; 
dly=[2 0.5]; %[5 0.5]; %stim presentation time
ts=60; %text size
%[RR RG RB] =1.4010    4.1090    0.4064

%[LR LG LB]= 1.3480    3.9330    0.3604


load cal_val; %cf=[1 1];
%KbName('UnifyKeyNames');

  cf=[0.538 0.525; 0.538 0.525; 0.538 0.525];

sz0=[screenYpixels,  screenXpixels];
sz0=[1080 1080];

%sz=[1080 1920]; i0=zeros(sz); i00=zeros(ms.*sz); sz2=ms.*sz./2;
sz=[1080 1080]; i0=zeros(sz); i00=zeros(ms.*sz); sz2=ms.*sz./2; sz22=sz./2;
clear im
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

tx={sprintf('Option 1'), sprintf('Option 2'), sprintf('Which option was \n more fringed?')};

ic0=crc0(400, sz); ic1=crc0(400, sz); %circle 

i000=ct8(i0, i0, i0);
im2=cell(4,2); clear t1 t2
t0=[2 1 2 1]; %translate from half to merge side
t1{1,1}=[4 2]; t1{1,2}=[ 2 2];
t1{2,1}=[1 1]; t1{2,2}=[3 1];
t1{3,1}=[4 1]; t1{3,2}=[2 1];
t1{4,1}=[1 2]; t1{4,2}=[3 2];
n00=10; %gray pixels;


t2=[1 sz(1) sz22(2)-n00 sz22(2)+n00; sz22(1)-n00 sz22(1)+n00 1 sz(2); 1 sz(1) sz22(2)-n00 sz22(2)+n00; sz22(1)-n00 sz22(1)+n00 1 sz(2)];
% t2{1,1}=[1 sz] t2{1,2}=[sz22-n00 sz22+n00];
% t2{2,1}=[sz22-n00 sz22+n00]; t2{2,2}=[1 sz];

for k0=1:4
    im0=ct8(dszf(circshift(im{k0}, xy0(1,:)),ms), dszf(circshift(im{k0}, xy0(2,:)),ms), dszf(circshift(im{k0}, xy0(3,:)),ms));
    im1=ct8(dszf(circshift(im{k0}, xy1(1,:)),ms), dszf(circshift(im{k0}, xy1(2,:)),ms), dszf(circshift(im{k0}, xy1(3,:)),ms));
    
    [im21 im20]=mrg(im1, im0,t0(k0));
    
    %% add gray bar
    im21(t2(k0,1): t2(k0,2) , t2(k0,3):t2(k0, 4), :)=127;    
    im20(t2(k0,1): t2(k0,2) , t2(k0,3):t2(k0, 4), :)=127;    
    
    im2{t1{k0,1}(1),t1{k0,1}(2)}=im21; 
    im2{t1{k0,2}(1),t1{k0,2}(2)}=im20; 
    
end

ib=insertText(ct8(zeros(sz), zeros(sz), ic0), sz2./10, sprintf('Which side looks fringed?'), 'Fontsize', ts, 'BoxColor', 'black', 'TextColor', 'green', 'AnchorPoint', 'Center'); %imshow(ib)