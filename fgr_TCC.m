%210613 combined TCA CSF & CRM plot! plotting in pixel units!

%NHI210614 ACL0
% %CSF 
load('S10007Right_CSF_ACL0_2106091301.mat');
h00=h0; h11=h1;
load('S10007Right_CSF_ACL0_2106091320.mat');
h0=[h0 h00]; h1=[h11 h1];
[x y]=psf_CSF(h0, h1, g0(2), g1, 0);
y11=fit_CSF0(x,y);
figure; plot(x,y); hold on; plot(y11); hold off

%chromostereopsis
load('S10007B_CNT_ACL0_2106091232_Best.mat'); [rslt CI]=psf_CNT(y1, y2); 
 c0=0.00384;  c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S10007Left_TCA_ACL0_2106091116.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10007Right_TCA_ACL0_2106091102.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 



%NHI210614 ACL1
% %CSF 
load('S10007Right_CSF_ACL1_2106091449.mat');
h00=h0; h11=h1;
load('S10007Right_CSF_ACL1_2106091500.mat');
h0=[h0 h00]; h1=[h11 h1];
[x y]=psf_CSF(h0, h1, g0(2), g1, 0);
y11=fit_CSF00(x,y);
figure; plot(x,y); hold on; plot(y11); hold off

%chromostereopsis
load('S10007B_CNT_ACL1_2106091417BEST.mat'); [rslt CI]=psf_CNT(y1, y2); 
 c0=0.00384;  c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;


%%Left eye TCA
LT='S10007Left_TCA_ACL1_2106091512.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10007Right_TCA_ACL1_2106091435.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 


%%MSB210611 ACL1
%CSF 
load('S10004Left_CSF_ACL1_2106141218.mat');
[x y]=psf_CSF(h0, h1, g0(2), g1, 0);
y11=fit_CSF00(x,y);
figure; plot(x,y); hold on; plot(y11); hold off

%chromostereopsis
load('S10004B_CNT_ACL1_2106141148.mat'); y111=y1; y22=y2;
load('S10004B_CNT_ACL1_2106141155.mat'); y1=[y1 y111]; y2=[y2 y22];
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
[rslt CI]=psf_CNT(y1, y2); 
rslt=rslt./c1; CI=CI./c1;


%%Left eye TCA
LT='S10004Left_TCA_ACL1_2106141204.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10004Right_TCA_ACL1_2106141240.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4);


%%MSB210614 ACL0
%CSF 
load('S10004Left_CSF_ACL0_2106151140.mat');
[x y]=psf_CSF(h0, h1, g0(2), g1, 0);
y11=fit_CSF00(x,y);
figure; plot(x,y); hold on; plot(y11); hold off

%chromostereopsis
load('S10004B_CNT_ACL0_2106151108.mat'); 
y111=y1; y22=y2; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22];
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
[rslt CI]=psf_CNT(y1, y2); 
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S10004Left_TCA_ACL0_2106151053.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10004Right_TCA_ACL0_2106151047.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
drcn='<'; ttl=['MSB210615 ACL0']



%%AJR ACL0
%CSF 
load('S10004Left_CSF_ACL0_2106151140.mat');
[x y]=psf_CSF(h0, h1, g0(2), g1, 0);
y11=fit_CSF00(x,y);
figure; plot(x,y); hold on; plot(y11); hold off

%chromostereopsis
load('S10003_CNT_Stereo_ACL0_2105211009.mat'); 
y111=y1; y22=y2; load('S10003_CNT_Stereo_ACL0_2105211016.mat'); y1=[y1 y111]; y2=[y2 y22];
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
[rslt CI]=psf_CNT(y1, y2); 
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S10003_TCA_LeftACL0_2105210952.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10003_TCA_RightACL0_2105211001.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
drcn='<'; ttl=['MSB210615 ACL0']


%%AJR ACL1
%chromostereopsis
%S10003_CNT_Left_ACL1_2104231615 EXCELLENT
%S10003_CNT_Left_ACL1_2104231623 EXCELLENT
%S10003_CNT_Stereo_ACL1_2104301247 BAD

 load('S10003_CNT_Stereo_ACL1_2105211116.mat'); 
y111=y1; y22=y2; load('S10003_CNT_Stereo_ACL1_2105211122.mat'); y1=[y1 y111]; y2=[y2 y22];


load('S10003_CNT_Left_ACL1_2104231615.mat'); 
y111=y1; y22=y2; load('S10003_CNT_Left_ACL1_2104231623.mat'); y1=[y1 y111]; y2=[y2 y22];
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
[rslt CI]=psf_CNT(y1, y2); 
rslt=rslt./c1; CI=CI./c1;


S10003_TCA_LeftACL1_2105211107
%%Left eye TCA
LT='S10003_TCA_LeftACL1_2105211107.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
S10003_TCA_RightACL0_2104301055
S10003_TCA_RightACL0_2105211001
RT='S10003_TCA_RightACL1_2105211056.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 
drcn='<'; ttl=['MSB210615 ACL0']

yx=-1.*yx0./c1; sd=sd0./c1;

%add green blue colors
r=2; c=4; xgR = yx(r,c); hgR = sd(r,c);
r=2; c=2; xgL = yx(r,c); hgL = sd(r,c);

r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r=2; c=3; ygR = yx(r,c); vgR = sd(r,c);
r=2; c=1; ygL = yx(r,c); vgL = sd(r,c);

r=3; c=3; ybR = yx(r,c); vbR = sd(r,c);
r=3; c=1; ybL = yx(r,c); vbL = sd(r,c);

errorbar(xgR, ygR, vgR, vgR, hgR, hgR, '>g');
hold on
errorbar(xbR, ybR, vbR, vbR, hbR, hbR, '>b');
hold on
errorbar(xgL, ygL, vgL, vgL, hgL, hgL, '<g');
hold on
errorbar(xbL, ybL, vbL, vbL, hbL, hbL, '<b');
hold on



%chromostereopsis CNT analysis
r0=(xbL+xbR)./2; r1=rslt(1); r2=[-r1 +r1]+r0;
rU=abs(CI(2)-r1); rL=abs(CI(1)-r1);
errorbar(r2, (ybL+ybR)./2+[0 0], [0 0], [0 0], [rU rL], [rL rU], 'ok-');
hold on

ylabel('Vertical offset (arcmin)');
%axv=axis; axis([axv(1:2) axv(1:2)])
%add CSFand sinewave fit

yyaxis right
%colororder({'b','m'})
plot(x, y, [drcn 'r']); hold on; plot(y11, 'r-')
ax=gca; ax.YColor=[1 0 0];
ylabel('Contrast Sensitivity')
%colororder({'m'})

xlabel('Horizontal offset (arcmin)')
title(ttl)

yyaxis left
axv=axis; axis([axv(1:2) axv(1:2)])

legend off







% %210613 combined TCA CSF & CRM plot! plotting in pixel units!
% c0=0.00384; %deg/pixels
% c1=1./(c0.*60);
% 
% %CSF 
% load('S10007Right_CSF_ACL1_2106091449.mat');
% h00=h0; h11=h1;
% load('S10007Right_CSF_ACL1_2106091500.mat');
% h0=[h0 h00]; h1=[h11 h1];
% a0=0; [x y]=psf_CSF(h0, h1, g0(2), g1+a0, 0);
% 
% 
% %chromostereopsis
% load('S10007B_CNT_ACL1_2106091417BEST.mat'); [rslt CI]=psf_CNT(y1, y2);
% 
% 
% %%Left eye TCA
% LT='S10007Left_TCA_ACL1_2106091512.mat'; load(LT)
% yx0=z1; sd=z2; 
% 
% %right eye TCA
% RT='S10007Right_TCA_ACL1_2106091435.mat'; load(RT)
% yx0(:,3:4)=z1(:,3:4); sd(:,3:4)=z2(:,3:4); 
% 
% yx=-1.*yx0;
% 
% %add green blue colors
% r=2; c=4; xgR = yx(r,c); hgR = sd(r,c);
% r=2; c=2; xgL = yx(r,c); hgL = sd(r,c);
% 
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r=2; c=3; ygR = yx(r,c); vgR = sd(r,c);
% r=2; c=1; ygL = yx(r,c); vgL = sd(r,c);
% 
% r=3; c=3; ybR = yx(r,c); vbR = sd(r,c);
% r=3; c=1; ybL = yx(r,c); vbL = sd(r,c);
% 
% errorbar(xgR, ygR, vgR, vgR, hgR, hgR, '>g');
% hold on
% errorbar(xbR, ybR, vbR, vbR, hbR, hbR, '>b');
% hold on
% errorbar(xgL, ygL, vgL, vgL, hgL, hgL, '<g');
% hold on
% errorbar(xbL, ybL, vbL, vbL, hbL, hbL, '<b');
% hold on
% 
% 
% 
% %chromostereopsis CNT analysis
% r0=(xbL+xbR)./2; r1=rslt(1); r2=[-r1 +r1]+r0;
% rU=abs(CI(2)-r1); rL=abs(CI(1)-r1);
% errorbar(r2, (ybL+ybR)./2+[0 0], [0 0], [0 0], [rU rL], [rL rU], 'ok-');
% hold on
% 
% %add CSFand sinewave fit
% yyaxis right
% plot(x.*c1, y)
% 
% 
% 
% 
% 
% %fo=fitoptions('Method','NonlinearLeastSquares','StartPoint', [max(t0)-min(t0) 1/3 pi mean(t0)]);
% %ft=fittype('a*sinpi(b*x+b)+d', 'options', fo);
% ft=fittype('a*sinpi(b*x+c)+d');
% % 
% % % y=fit(x', t0', ft, 'StartPoint', [max(t0)-min(t0) 1/3 pi mean(t0)]);
%  a0=max(y)-min(t0);
% % b0=abs(x(find(t0==max(t0)))-x(find(t0==min(t0))))
% % 
%  y1=fit(c1.*x', y', ft); %, 'StartPoint', [max(t0)-min(t0) abs(x(find(t0==max(t0)))-x(find(t0==min(t0)))) 2 0.3]);
% hold on; plot(y1)


%cls; x0=[-1:0.01:1]; y0=sinpi(2.*x0+1); plot(x0, y0);

% %add green blue colors
% xg = [yx(2,2)' yx(2,4)']; xng = [sd(2,2)' sd(2,4)'];
% xb = [yx(3,2)' yx(3,4)']; xnb = [sd(3,2)' sd(3,4)'];
% 
% yg= [yx(2,1)' yx(2,3)']; yng = [sd(2,1)' sd(2,3)'];
% yb= [yx(3,1)' yx(3,3)']; ynb = [sd(3,1)' sd(3,3)'];
% 
% errorbar(xg,yg,yng,yng,xng,xng,'og')
% hold on
% errorbar(xb,yb,ynb,ynb,xnb,xnb,'ob')

%plot errorabrs
% x = [yx(:,2)' yx(:,4)'];
% y = [yx(:,1)' yx(:,3)'];
% yneg = [sd(:,1)' sd(:,3)'];
% ypos = yneg;
% xneg = [sd(:,2)' sd(:,4)'];
% xpos = xneg;
% errorbar(x,y,yneg,ypos,xneg,xpos,'o')



% x = 1:10:100;
% y = [20 30 45 40 60 65 80 75 95 90];
% yneg = [1 3 5 3 5 3 6 4 3 3];
% ypos = [2 5 3 5 2 5 2 2 5 5];
% xneg = [1 3 5 3 5 3 6 4 3 3];
% xpos = [2 5 3 5 2 5 2 2 5 5];
% errorbar(x,y,yneg,ypos,xneg,xpos,'o')




