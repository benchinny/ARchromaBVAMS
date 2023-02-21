%210613 combined TCA CSF & CRM plot! plotting in pixel units!
c0=0.00384; %deg/pixels
c1=1./(c0.*60);

%CSF 
load('S10007Right_CSF_ACL1_2106091449.mat');
h00=h0; h11=h1;
load('S10007Right_CSF_ACL1_2106091500.mat');
h0=[h0 h00]; h1=[h11 h1];
[x y]=psf_CSF(h0, h1, g0(2), g1, 0);
y11=fit_CSF(x,y);

%chromostereopsis
load('S10007B_CNT_ACL1_2106091417BEST.mat'); [rslt CI]=psf_CNT(y1, y2); 
rslt=rslt./c1; CI=CI./c1;


%%Left eye TCA
LT='S10007Left_TCA_ACL1_2106091512.mat'; load(LT)
yx0=z1; sd0=z2; 

%right eye TCA
RT='S10007Right_TCA_ACL1_2106091435.mat'; load(RT)
yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4); 

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

ylabel('Vertical offset (arcmin)')
%add CSFand sinewave fit

yyaxis right
%colororder({'b','m'})
plot(x, y, '>r'); hold on; plot(y11, 'r-')
ax=gca; ax.YColor=[1 0 0];
ylabel('Contrast Sensitivity')
%colororder({'m'})

xlabel('Horizontal offset (arcmin)')
title(['NHI ' tme])
legend off
