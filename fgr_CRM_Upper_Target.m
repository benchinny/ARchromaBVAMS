%%211027 fgr_CRM including top/bottom responses
        %y0 up/down responses
        %y1 disparities 
        %y2   invert responses
        %y3 up1 buttom0 blue/disparity
        
        y33=0; %-1all 1up 0bottom blue

%NHI0
%chromostereopsis
load('S10007B_CNT_ACL0_2106091232_Best.mat'); 

y0=(y2==y3); %top1 down0 responses
% if y33>=0; y1=y1(y2==y33); y2=y2(y2==y33); end %RedBlue
if y33>=0; y1=y1(y0==y33); y2=y2(y0==y33); y3=y3(y0==y33); end;  
y1=y1.*(-2.*(y3~=y33)+1);
%[y3; y3~=y33; -2.*(y3~=y33)+1; y1; y1.*(-2.*(y3~=y33)+1)]

[rslt CI]=psf_CNT(y1, y2); 
 c0=0.00384;  c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S10007Left_TCA_ACL0_2106091116.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10007Right_TCA_ACL0_2106091102.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
NHI0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];

%% NHI1
load('S10007B_CNT_ACL1_2106091417BEST.mat'); 


y0=(y2==y3); %top1 down0 responses
% if y33>=0; y1=y1(y2==y33); y2=y2(y2==y33); end %RedBlue
if y33>=0; y1=y1(y0==y33); y2=y2(y0==y33); y3=y3(y0==y33); end;  
y1=y1.*(-2.*(y3~=y33)+1);


[rslt CI]=psf_CNT(y1, y2); 
 c0=0.00384;  c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;


%%Left eye TCA
LT='S10007Left_TCA_ACL1_2106091512.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10007Right_TCA_ACL1_2106091435.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
NHI1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];

%%MSB0

%chromostereopsis
load('S10004B_CNT_ACL0_2106151108.mat'); 
y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];


y0=(y2==y3); %top1 down0 responses
% if y33>=0; y1=y1(y2==y33); y2=y2(y2==y33); end %RedBlue
if y33>=0; y1=y1(y0==y33); y2=y2(y0==y33); y3=y3(y0==y33); end;  
y1=y1.*(-2.*(y3~=y33)+1);


[rslt CI]=psf_CNT(y1, y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S10004Left_TCA_ACL0_2106151053.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10004Right_TCA_ACL0_2106151047.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
drcn='<'; ttl=['MSB210615 ACL0']

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
MSB0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];

%%MSB1
%chromostereopsis
load('S10004B_CNT_ACL1_2106141148.mat'); y111=y1; y22=y2; y333=y3;
load('S10004B_CNT_ACL1_2106141155.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];

y0=(y2==y3); %top1 down0 responses
% if y33>=0; y1=y1(y2==y33); y2=y2(y2==y33); end %RedBlue
if y33>=0; y1=y1(y0==y33); y2=y2(y0==y33); y3=y3(y0==y33); end;  
y1=y1.*(-2.*(y3~=y33)+1);


[rslt CI]=psf_CNT(y1, y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;


%%Left eye TCA
LT='S10004Left_TCA_ACL1_2106141204.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10004Right_TCA_ACL1_2106141240.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4);

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
MSB1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];


%%AJR0
%chromostereopsis
load('S10003_CNT_Stereo_ACL0_2105211009.mat'); y111=y1; y22=y2; y333=y3;
load('S10003_CNT_Stereo_ACL0_2105211016.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];

y0=(y2==y3); %top1 down0 responses
% if y33>=0; y1=y1(y2==y33); y2=y2(y2==y33); end %RedBlue
if y33>=0; y1=y1(y0==y33); y2=y2(y0==y33); y3=y3(y0==y33); end;  
y1=y1.*(-2.*(y3~=y33)+1);

[rslt CI]=psf_CNT(y1, y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S10003_TCA_LeftACL0_2105210952.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10003_TCA_RightACL0_2105211001.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
AJR0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];


%%AJR1
 load('S10003_CNT_Stereo_ACL1_2105211116.mat'); y111=y1; y22=y2; y333=y3;
 load('S10003_CNT_Stereo_ACL1_2105211122.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];
 
y0=(y2==y3); %top1 down0 responses
% if y33>=0; y1=y1(y2==y33); y2=y2(y2==y33); end %RedBlue
if y33>=0; y1=y1(y0==y33); y2=y2(y0==y33); y3=y3(y0==y33); end;  
y1=y1.*(-2.*(y3~=y33)+1); 

[rslt CI]=psf_CNT(y1, y2);
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S10003_TCA_LeftACL1_2105211107.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
% S10003_TCA_RightACL0_2104301055
% S10003_TCA_RightACL0_2105211001
RT='S10003_TCA_RightACL1_2105211056.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
AJR1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];

%save('CRM_TopBottomChoice211101', 'NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1')

cls; 
%close all
errorbar(NHI0(1), NHI0(2), NHI0(3),NHI0(4), NHI0(5), NHI0(6),'ob')
hold on; errorbar(NHI1(1), NHI1(2), NHI1(3),NHI1(4), NHI1(5), NHI1(6),'ob', 'MarkerFaceColor', 'b')
hold on; errorbar(MSB0(1), MSB0(2), MSB0(3),MSB0(4), MSB0(5), MSB0(6),'sg')
hold on; errorbar(MSB1(1), MSB1(2), MSB1(3),MSB1(4), MSB1(5), MSB1(6),'sg', 'MarkerFaceColor', 'g')
hold on; errorbar(AJR0(1), AJR0(2), AJR0(3),AJR0(4), AJR0(5), AJR0(6),'dr')
hold on; errorbar(AJR1(1), AJR1(2), AJR1(3),AJR1(4), AJR1(5), AJR1(6),'dr', 'MarkerFaceColor', 'r')
hold on; plot([-2 4], [-2 4], 'k--')
grid on
legend('NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1', 'corr=1')
lbl('TCA (ArcMins)', 'SubjectiveAlignment (ArcMins)', 'Chromostereopsis')
lbl('BlueTopRedBottom (ArcMins)', 'RedTopBlueBottom (ArcMins)', 'Chromostereopsis')

lbl('BottomChoice (ArcMins)', 'TopChoice (ArcMins)', 'Chromostereopsis')

% 
% %%211025 fgr_CRM including red/blue bottom option
%         %y0 up/down responses
%         %y1 disparities 
%         %y2   invert responses
%         %y3 up1 buttom0 blue/disparity
%         
%         y33=1; %-1all 1up 0bottom blue
% 
% %NHI0
% %chromostereopsis
% load('S10007B_CNT_ACL0_2106091232_Best.mat'); 
% 
% if y33>=0; y1=y1(y3==y33); y2=y2(y3==y33); end 
% 
% [rslt CI]=psf_CNT(y1, y2); 
%  c0=0.00384;  c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S10007Left_TCA_ACL0_2106091116.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10007Right_TCA_ACL0_2106091102.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% NHI0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %% NHI1
% load('S10007B_CNT_ACL1_2106091417BEST.mat'); 
% if y33>=0; y1=y1(y3==y33); y2=y2(y3==y33); end 
% [rslt CI]=psf_CNT(y1, y2); 
%  c0=0.00384;  c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% 
% %%Left eye TCA
% LT='S10007Left_TCA_ACL1_2106091512.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10007Right_TCA_ACL1_2106091435.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% NHI1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %%MSB0
% 
% %chromostereopsis
% load('S10004B_CNT_ACL0_2106151108.mat'); 
% y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];
% if y33>=0; y1=y1(y3==y33); y2=y2(y3==y33); end 
% [rslt CI]=psf_CNT(y1, y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S10004Left_TCA_ACL0_2106151053.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10004Right_TCA_ACL0_2106151047.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% drcn='<'; ttl=['MSB210615 ACL0']
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% MSB0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %%MSB1
% %chromostereopsis
% load('S10004B_CNT_ACL1_2106141148.mat'); y111=y1; y22=y2; y333=y3;
% load('S10004B_CNT_ACL1_2106141155.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];
% if y33>=0; y1=y1(y3==y33); y2=y2(y3==y33); end 
% [rslt CI]=psf_CNT(y1, y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% 
% %%Left eye TCA
% LT='S10004Left_TCA_ACL1_2106141204.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10004Right_TCA_ACL1_2106141240.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4);
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% MSB1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% 
% %%AJR0
% %chromostereopsis
% load('S10003_CNT_Stereo_ACL0_2105211009.mat'); y111=y1; y22=y2; y333=y3;
% load('S10003_CNT_Stereo_ACL0_2105211016.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];
% if y33>=0; y1=y1(y3==y33); y2=y2(y3==y33); end 
% [rslt CI]=psf_CNT(y1, y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S10003_TCA_LeftACL0_2105210952.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10003_TCA_RightACL0_2105211001.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% AJR0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% 
% %%AJR1
%  load('S10003_CNT_Stereo_ACL1_2105211116.mat'); y111=y1; y22=y2; y333=y3;
%  load('S10003_CNT_Stereo_ACL1_2105211122.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];
% if y33>=0; y1=y1(y3==y33); y2=y2(y3==y33); end 
% [rslt CI]=psf_CNT(y1, y2);
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S10003_TCA_LeftACL1_2105211107.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% % S10003_TCA_RightACL0_2104301055
% % S10003_TCA_RightACL0_2105211001
% RT='S10003_TCA_RightACL1_2105211056.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% AJR1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %save('CRM_RED_Bottom211025', 'NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1')
% 
% cls; 
% %close all
% errorbar(NHI0(1), NHI0(2), NHI0(3),NHI0(4), NHI0(5), NHI0(6),'ob')
% hold on; errorbar(NHI1(1), NHI1(2), NHI1(3),NHI1(4), NHI1(5), NHI1(6),'ob', 'MarkerFaceColor', 'b')
% hold on; errorbar(MSB0(1), MSB0(2), MSB0(3),MSB0(4), MSB0(5), MSB0(6),'sg')
% hold on; errorbar(MSB1(1), MSB1(2), MSB1(3),MSB1(4), MSB1(5), MSB1(6),'sg', 'MarkerFaceColor', 'g')
% hold on; errorbar(AJR0(1), AJR0(2), AJR0(3),AJR0(4), AJR0(5), AJR0(6),'dr')
% hold on; errorbar(AJR1(1), AJR1(2), AJR1(3),AJR1(4), AJR1(5), AJR1(6),'dr', 'MarkerFaceColor', 'r')
% hold on; plot([-2 4], [-2 4], 'k--')
% grid on
% legend('NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1', 'corr=1')
% lbl('TCA (ArcMins)', 'SubjectiveAlignment (ArcMins)', 'Chromostereopsis')
% 


% %%210818 fgr_CRM chromostereopsis using Austinn method
% 
% 
% %NHI0
% %chromostereopsis
% load('S10007B_CNT_ACL0_2106091232_Best.mat'); [rslt CI]=psf_CNT(y1, y2); 
%  c0=0.00384;  c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S10007Left_TCA_ACL0_2106091116.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10007Right_TCA_ACL0_2106091102.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% NHI0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %% NHI1
% load('S10007B_CNT_ACL1_2106091417BEST.mat'); [rslt CI]=psf_CNT(y1, y2); 
%  c0=0.00384;  c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% 
% %%Left eye TCA
% LT='S10007Left_TCA_ACL1_2106091512.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10007Right_TCA_ACL1_2106091435.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% NHI1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %%MSB0
% 
% %chromostereopsis
% load('S10004B_CNT_ACL0_2106151108.mat'); 
% y111=y1; y22=y2; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22];
% c0=0.00384; %deg/pixels
% c1=1./(c0.*60);
% [rslt CI]=psf_CNT(y1, y2); 
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S10004Left_TCA_ACL0_2106151053.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10004Right_TCA_ACL0_2106151047.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% drcn='<'; ttl=['MSB210615 ACL0']
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% MSB0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %%MSB1
% %chromostereopsis
% load('S10004B_CNT_ACL1_2106141148.mat'); y111=y1; y22=y2;
% load('S10004B_CNT_ACL1_2106141155.mat'); y1=[y1 y111]; y2=[y2 y22];
% c0=0.00384; %deg/pixels
% c1=1./(c0.*60);
% [rslt CI]=psf_CNT(y1, y2); 
% rslt=rslt./c1; CI=CI./c1;
% 
% 
% %%Left eye TCA
% LT='S10004Left_TCA_ACL1_2106141204.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10004Right_TCA_ACL1_2106141240.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4);
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% MSB1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% 
% %%AJR0
% %chromostereopsis
% load('S10003_CNT_Stereo_ACL0_2105211009.mat'); 
% y111=y1; y22=y2; load('S10003_CNT_Stereo_ACL0_2105211016.mat'); y1=[y1 y111]; y2=[y2 y22];
% c0=0.00384; %deg/pixels
% c1=1./(c0.*60);
% [rslt CI]=psf_CNT(y1, y2); 
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S10003_TCA_LeftACL0_2105210952.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% RT='S10003_TCA_RightACL0_2105211001.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% AJR0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% 
% %%AJR1
%  load('S10003_CNT_Stereo_ACL1_2105211116.mat'); 
% y111=y1; y22=y2; load('S10003_CNT_Stereo_ACL1_2105211122.mat'); y1=[y1 y111]; y2=[y2 y22];
% % load('S10003_CNT_Left_ACL1_2104231615.mat'); 
% % y111=y1; y22=y2; load('S10003_CNT_Left_ACL1_2104231623.mat'); y1=[y1 y111]; y2=[y2 y22];
% c0=0.00384; %deg/pixels
% c1=1./(c0.*60);
% [rslt CI]=psf_CNT(y1, y2); 
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S10003_TCA_LeftACL1_2105211107.mat'; load(LT)
% yx0=z1; sd0=z2; 
% 
% %right eye TCA
% % S10003_TCA_RightACL0_2104301055
% % S10003_TCA_RightACL0_2105211001
% RT='S10003_TCA_RightACL1_2105211056.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% AJR1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% 
% 
% cls; 
% Close all
% errorbar(NHI0(1), NHI0(2), NHI0(3),NHI0(4), NHI0(5), NHI0(6),'ob')
% hold on; errorbar(NHI1(1), NHI1(2), NHI1(3),NHI1(4), NHI1(5), NHI1(6),'ob', 'MarkerFaceColor', 'b')
% hold on; errorbar(MSB0(1), MSB0(2), MSB0(3),MSB0(4), MSB0(5), MSB0(6),'sg')
% hold on; errorbar(MSB1(1), MSB1(2), MSB1(3),MSB1(4), MSB1(5), MSB1(6),'sg', 'MarkerFaceColor', 'g')
% hold on; errorbar(AJR0(1), AJR0(2), AJR0(3),AJR0(4), AJR0(5), AJR0(6),'dr')
% hold on; errorbar(AJR1(1), AJR1(2), AJR1(3),AJR1(4), AJR1(5), AJR1(6),'dr', 'MarkerFaceColor', 'r')
% hold on; plot([-2 4], [-2 4], 'k--')
% grid on
% legend('NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1', 'corr=1')
% lbl('TCA (ArcMins)', 'SubjectiveAlignment (ArcMins)', 'Chromostereopsis')

%save('CRM210917', 'NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1')