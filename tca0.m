%% show tca stimulus, same code as TCA6f
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']);
cls
ms=10;
% rgb=[3   1];  %3=blue 1=red background
rgb=[3      1]; %2=green 1=red background
rc00=[0 0; 0 0];
sz = [1080, 1920]; 
i0=uint8(zeros(sz)); 
xy=[0 0   0 0]; % [+isDown +isRight]
% xy=[1.1 -1.7 -0.4 2.3]; %[row_LeftDisp col_LeftDisp row_right col_right] set offsets
load('c130_b145to540_w10_ms10_sd1_6.mat');
i1=uint8(255.*ones(size(m_bkg)));
b=uint8(zeros([sz 3])); b1=b; b2=b;

load cal_val; %cf=[RB./RR  LB./LR];
%cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1];
cf=[RB./RR LB./LR; 0.3 0.3 ; 1 1];

xr=xy(1,3); yr=xy(1,4);
xl=xy(1,1); yl=xy(1,2);
% decimal integer correct
[x1r x2r x3r]=d2i(xr, ms);
[y1r y2r y3r]=d2i(yr, ms);

[x1l x2l x3l]=d2i(xl, ms);
[y1l y2l y3l]=d2i(yl, ms);


%correct decimal for negative values
%v0=[1 10 9 8 7 6 5 4 3 2];
v0=[10:-1:1];

x1r=x1r+1; if x3r<0; x1r=v0(x1r); end
y1r=y1r+1; if y3r<0; y1r=v0(y1r); end

x1l=x1l+1; if x3l<0; x1l=v0(x1l); end
y1l=y1l+1; if y3l<0; y1l=v0(y1l); end

xy(1,1)=x3r; xy(1,2)=y3r;
xy(2,1)=x3l; xy(2,2)=y3l;

s2=['R' 'L'];
disp(['LEFT r' n2s(x3l) ' c' n2s(y3l) ' RIGHT r' n2s(x3r) ' c' n2s(y3r) ]);


bcr=circshift(m_crc{x1r, y1r}, [x2r y2r]);
bcl=circshift(m_crc{x1l, y1l}, [x2l y2l]);

bsr=circshift(i1-m_crs{x1r, y1r}, [x2r y2r]);
bsl=circshift(i1-m_crs{x1l, y1l}, [x2l y2l]);

bgr= m_bkg-bcr;
bgl= m_bkg-bcl;

bcr=(bcr-bsr).*uint8(bcr~=0);
bcl=(bcl-bsl).*uint8(bcl~=0);


b1(:, :, rgb(1))=embd(bcr, i0); %right front circle
b1(:, :, rgb(2))=embd(bgr, i0); %right background circle

b2(:, :, rgb(1))=embd(bcl, i0); %left front circle
b2(:, :, rgb(2))=embd(bgl, i0); %left background circle

screens = Screen('Screens');
screenNumber = max(screens);
[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0); %add background parameter!


cwin1(b1, b2, cf, rc00, window1, window2);

KbWait;

sca

 