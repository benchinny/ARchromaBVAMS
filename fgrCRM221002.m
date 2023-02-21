%%220517 fgr_CRM corrected verctor sum stdv
        %y0 up/down responses
        %y1 disparities 
        %y2   invert responses
        %y3 up1 buttom0 blue/disparity
        
        
%%MaxGreen0 S4

%chromostereopsis
load('S1001V5_CNT_BincACL0_2203021608.mat'); 
%y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];

[rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S1001V5Left_TCA_ACL0_2203021557.mat'; load(LT)
yx0=TCAp.z1; sd0=TCAp.z2; 

%right eye TCA
RT='S1001V5Right_TCA_ACL0_2203021552.mat'; load(RT)
yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4); 
drcn='<'; ttl=['MG ACL0']

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
MG0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];

%%MG1
%chromostereopsis
% load('S1001V5_CNT_BincACL1_2203021641.mat'); 
% [rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 


load('S1001V5_CNT_BincACL1_2203021635.mat'); y111=CNTp.y1; y22=CNTp.y2; y333=CNTp.y3;
load('S1001V5_CNT_BincACL1_2203021641.mat'); y1=[CNTp.y1 y111]; y2=[CNTp.y2 y22]; y3=[CNTp.y3 y333];
[rslt CI]=psf_CNT0(y1, y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S1001V5Left_TCA_ACL1_2203021627.mat'; load(LT)
yx0=TCAp.z1; sd0=TCAp.z2; 

%right eye TCA
RT='S1001V5Right_TCA_ACL1_2203021621.mat'; load(RT)
yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4);

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
MG1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];          
        
                
%%FabioFeroldi0

%chromostereopsis
load('S1001V5_CNT_BincACL0_2202251601.mat'); 
%y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];

[rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S1001V5Left_TCA_ACL0_2202251548.mat'; load(LT)
yx0=TCAp.z1; sd0=TCAp.z2; 

%right eye TCA
RT='S1001V5Right_TCA_ACL0_2202251552.mat'; load(RT)
yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4); 
drcn='<'; ttl=['FF220225 ACL0']

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
FF0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];

%%FF1
%chromostereopsis
load('S1001V5_CNT_BincACL1_2202251624.mat'); y111=CNTp.y1; y22=CNTp.y2; y333=CNTp.y3;
load('S1001V5_CNT_BincACL1_2202251635.mat'); y1=[CNTp.y1 y111]; y2=[CNTp.y2 y22]; y3=[CNTp.y3 y333];

[rslt CI]=psf_CNT0(y1, y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S1001V5Left_TCA_ACL1_2202251615.mat'; load(LT)
yx0=TCAp.z1; sd0=TCAp.z2; 

%right eye TCA
RT='S1001V5Right_TCA_ACL1_2202251613.mat'; load(RT)
yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4);

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
FF1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];        
       
%%BenBackus0

%chromostereopsis
load('S1001V5_CNT_BincACL0_2202161658.mat'); 
%y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];

[rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S1001V5Left_TCA_ACL0_2202161634.mat'; load(LT)
yx0=TCAp.z1; sd0=TCAp.z2; 

%right eye TCA
RT='S1001V5Right_TCA_ACL0_2202161612.mat'; load(RT)
yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4); 
drcn='<'; ttl=['BB220216 ACL0']

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
BB0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];

%%BB1
%chromostereopsis
load('S1001V5_CNT_BincACL1_2202161732.mat'); y111=CNTp.y1; y22=CNTp.y2; y333=CNTp.y3;
load('S1001V5_CNT_BincACL1_2202161744.mat'); y1=[CNTp.y1 y111]; y2=[CNTp.y2 y22]; y3=[CNTp.y3 y333];

[rslt CI]=psf_CNT0(y1, y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S1001V5Left_TCA_ACL1_2202161719.mat'; load(LT)
yx0=TCAp.z1; sd0=TCAp.z2; 

%right eye TCA
RT='S1001V5Right_TCA_ACL1_2202161713.mat'; load(RT)
yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4);

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
BB1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];        
        
        
        
%%HaniFarid0

%chromostereopsis
load('S1001V5_CNT_BincACL0_2203011658.mat'); 
%y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];

[rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S1001V5Left_TCA_ACL0_2203011648.mat'; load(LT)
yx0=TCAp.z1; sd0=TCAp.z2; 

%right eye TCA
RT='S1001V5Right_TCA_ACL0_2203011644.mat'; load(RT)
yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4); 
drcn='<'; ttl=['HF220215 ACL0']

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
HF0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];

%%HF1
%chromostereopsis
load('S1001V5_CNT_BincACL1_2203011627.mat'); y111=CNTp.y1; y22=CNTp.y2; y333=CNTp.y3;
load('S1001V5_CNT_BincACL1_2203011633.mat'); y1=[CNTp.y1 y111]; y2=[CNTp.y2 y22]; y3=[CNTp.y3 y333];

[rslt CI]=psf_CNT0(y1, y2); 
c0=0.00384; c1=1./(c0.*60);
rslt=rslt./c1; CI=CI./c1;

%%Left eye TCA
LT='S1001V5Left_TCA_ACL1_2203011617.mat'; load(LT)
yx0=TCAp.z1; sd0=TCAp.z2; 

%right eye TCA
RT='S1001V5Right_TCA_ACL1_2203011612.mat'; load(RT)
yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4);

yx=-1.*yx0./c1; sd=sd0./c1;
r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);

r1=2.*rslt(1)
HF1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
        
        
        

%NHI0
%chromostereopsis
load('S10007B_CNT_ACL0_2106091232_Best.mat'); 

[rslt CI]=psf_CNT0(y1, y2); 
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

[rslt CI]=psf_CNT0(y1, y2); 
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

[rslt CI]=psf_CNT0(y1, y2); 
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

[rslt CI]=psf_CNT0(y1, y2); 
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

[rslt CI]=psf_CNT0(y1, y2); 
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

[rslt CI]=psf_CNT0(y1, y2);
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




%line fit
n=1; rx0=[NHI0(n) MSB0(n) AJR0(n) HF0(n) BB0(n) FF0(n) MG0(n)]
n=2; ry0=[NHI0(n) MSB0(n) AJR0(n) HF0(n) BB0(n) FF0(n) MG0(n)]
[rho0, pval0]=corr(rx0', ry0')
n=1; rx1=[NHI1(n) MSB1(n) AJR1(n) HF1(n) BB1(n) FF1(n) MG1(n)]
n=2; ry1=[NHI1(n) MSB1(n) AJR1(n) HF1(n) BB1(n) FF1(n) MG1(n)]
[rho1, pval1]=corr(rx1', ry1')

rx=[rx0 rx1]
ry=[ry0 ry1]
[rho, pval]=corr(rx', ry')



nms={'NHI'; 'MSB'; 'AJR'; 'HF'; 'BB'; 'FF'; 'MG'}
m=[NHI0(1:2) NHI1(1:2); MSB0(1:2) MSB1(1:2); AJR0(1:2) AJR1(1:2); HF0(1:2) HF1(1:2); BB0(1:2) BB1(1:2); FF0(1:2) FF1(1:2); MG0(1:2) MG1(1:2);]
t = table(nms,m(:,1),m(:,2),m(:,3),m(:,4),...
'VariableNames',{'sbj','m1','m2','m3','m4'});
M = table([1 2 3 4]','VariableNames',{'Measurements'});
rm = fitrm(t,'m1-m4~sbj','WithinDesign',M)




nms={'NHI'; 'NHI'; 'MSB'; 'MSB'; 'AJR'; 'AJR'; 'HF'; 'HF'; 'BB'; 'BB'; 'FF'; 'FF'; 'MG'; 'MG'}
m=[NHI0(1:2) ;NHI1(1:2); MSB0(1:2); MSB1(1:2); AJR0(1:2); AJR1(1:2); HF0(1:2); HF1(1:2); BB0(1:2); BB1(1:2); FF0(1:2); FF1(1:2); MG0(1:2); MG1(1:2)]
t = table(nms,m(:,1),m(:,2),...
'VariableNames',{'sbj','m1','m2'});
M = table([1 2]','VariableNames',{'Measurements'});
rm = fitrm(t,'m1-m2~sbj','WithinDesign',M)



%save('CRM_TopBottomChoice211101', 'NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1')
C3=[237 125 49; 112 48 160; 112 173 71]./255;
cls; 
%close all
mrkSz=10; lnWd=1
         errorbar(NHI0(1), NHI0(2), NHI0(3),NHI0(4), sqrt(NHI0(5).^2+NHI0(6).^2), sqrt(NHI0(5).^2+NHI0(6).^2), '^b', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(NHI1(1), NHI1(2), NHI1(3),NHI1(4), sqrt(NHI1(5).^2+NHI1(6).^2), sqrt(NHI1(5).^2+NHI1(6).^2),'^b', 'MarkerFaceColor', 'b', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(MSB0(1), MSB0(2), MSB0(3),MSB0(4), sqrt(MSB0(5).^2+MSB0(6).^2), sqrt(MSB0(5).^2+MSB0(6).^2),'sg', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(MSB1(1), MSB1(2), MSB1(3),MSB1(4), sqrt(MSB1(5).^2+MSB1(6).^2), sqrt(MSB1(5).^2+MSB1(6).^2),'sg', 'MarkerFaceColor', 'g', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(AJR0(1), AJR0(2), AJR0(3),AJR0(4), sqrt(AJR0(5).^2+AJR0(6).^2), sqrt(AJR0(5).^2+AJR0(6).^2),'or', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(AJR1(1), AJR1(2), AJR1(3),AJR1(4), sqrt(AJR1(5).^2+AJR1(6).^2), sqrt(AJR1(5).^2+AJR1(6).^2),'or', 'MarkerFaceColor', 'r', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(HF0(1), HF0(2), HF0(3), HF0(4), sqrt(HF0(5).^2+HF0(6).^2), sqrt(HF0(5).^2+HF0(6).^2),'dm', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(HF1(1), HF1(2), HF1(3), HF1(4),  sqrt(HF1(5).^2+HF1(6).^2), sqrt(HF1(5).^2+HF1(6).^2),'dm', 'MarkerFaceColor', 'm', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(BB0(1), BB0(2), BB0(3), BB0(4), sqrt(BB0(5).^2+BB0(6).^2), sqrt(BB0(5).^2+BB0(6).^2),'pc', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(BB1(1), BB1(2), BB1(3), BB1(4), sqrt(BB1(5).^2+BB1(6).^2), sqrt(BB1(5).^2+BB1(6).^2),'pc', 'MarkerFaceColor', 'c', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(FF0(1), FF0(2), FF0(3), FF0(4), sqrt(FF0(5).^2+FF0(6).^2), sqrt(FF0(5).^2+FF0(6).^2), 'Marker', 'h', 'Color', C3(1,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(FF1(1), FF1(2), FF1(3), FF1(4), sqrt(FF1(5).^2+FF1(6).^2), sqrt(FF1(5).^2+FF1(6).^2), 'Marker', 'h', 'Color', C3(1,:), 'MarkerFaceColor', C3(1,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(MG0(1), MG0(2), MG0(3), MG0(4), sqrt(MG0(5).^2+MG0(6).^2), sqrt(MG0(5).^2+MG0(6).^2), 'Marker', 'v', 'Color', C3(3,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(MG1(1), MG1(2), MG1(3), MG1(4), sqrt(MG1(5).^2+MG1(6).^2), sqrt(MG1(5).^2+MG1(6).^2), 'Marker', 'v', 'Color', C3(3,:), 'MarkerFaceColor', C3(3,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
%hold on; plot([-4 8], [-4 8], 'k--')
hold on; plot([-2 6], [-2 6], 'k--')
grid on
legend('NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1', 'HF0', 'HF1', 'BB0', 'BB1', 'FF0', 'FF1', 'MG0', 'MG1', 'corr=1')
lbl('TCA (ArcMins)', 'SubjectiveAlignment (ArcMins)', 'Chromostereopsis')
axis square


%remove line inside symbols.
cls; 
%close all
mrkSz=10; lnWd=1
         errorbar(NHI0(1), NHI0(2), NHI0(3),NHI0(4), sqrt(NHI0(5).^2+NHI0(6).^2), sqrt(NHI0(5).^2+NHI0(6).^2),'^b', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(NHI1(1), NHI1(2), NHI1(3),NHI1(4), sqrt(NHI1(5).^2+NHI1(6).^2), sqrt(NHI1(5).^2+NHI1(6).^2),'^b', 'MarkerFaceColor', 'b', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(MSB0(1), MSB0(2), MSB0(3),MSB0(4), sqrt(MSB0(5).^2+MSB0(6).^2), sqrt(MSB0(5).^2+MSB0(6).^2),'sg', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(MSB1(1), MSB1(2), MSB1(3),MSB1(4), sqrt(MSB1(5).^2+MSB1(6).^2), sqrt(MSB1(5).^2+MSB1(6).^2),'sg', 'MarkerFaceColor', 'g', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(AJR0(1), AJR0(2), AJR0(3),AJR0(4), sqrt(AJR0(5).^2+AJR0(6).^2), sqrt(AJR0(5).^2+AJR0(6).^2),'or', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(AJR1(1), AJR1(2), AJR1(3),AJR1(4), sqrt(AJR1(5).^2+AJR1(6).^2), sqrt(AJR1(5).^2+AJR1(6).^2),'or', 'MarkerFaceColor', 'r', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(HF0(1), HF0(2), HF0(3), HF0(4), sqrt(HF0(5).^2+HF0(6).^2), sqrt(HF0(5).^2+HF0(6).^2),'dm', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(HF1(1), HF1(2), HF1(3), HF1(4), sqrt(HF1(5).^2+HF1(6).^2), sqrt(HF1(5).^2+HF1(6).^2),'dm', 'MarkerFaceColor', 'm', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(BB0(1), BB0(2), BB0(3), BB0(4), sqrt(BB0(5).^2+BB0(6).^2), sqrt(BB0(5).^2+BB0(6).^2),'pc', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(BB1(1), BB1(2), BB1(3), BB1(4), sqrt(BB1(5).^2+BB1(6).^2), sqrt(BB1(5).^2+BB1(6).^2),'pc', 'MarkerFaceColor', 'c', 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(FF0(1), FF0(2), FF0(3), FF0(4), sqrt(FF0(5).^2+FF0(6).^2), sqrt(FF0(5).^2+FF0(6).^2), 'Marker', 'h', 'Color', C3(1,:), 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(FF1(1), FF1(2), FF1(3), FF1(4), sqrt(FF1(5).^2+FF1(6).^2), sqrt(FF1(5).^2+FF1(6).^2), 'Marker', 'h', 'Color', C3(1,:), 'MarkerFaceColor', C3(1,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(MG0(1), MG0(2), MG0(3), MG0(4), sqrt(MG0(5).^2+MG0(6).^2), sqrt(MG0(5).^2+MG0(6).^2), 'Marker', 'v', 'Color', C3(3,:), 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; errorbar(MG1(1), MG1(2), MG1(3), MG1(4), sqrt(MG1(5).^2+MG1(6).^2), sqrt(MG1(5).^2+MG1(6).^2), 'Marker', 'v', 'Color', C3(3,:), 'MarkerFaceColor', C3(3,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
hold on; plot([-2 6], [-2 6], 'k--')
grid on
legend('NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1', 'HF0', 'HF1', 'BB0', 'BB1', 'FF0', 'FF1', 'MG0', 'MG1', 'corr=1')
lbl('TCA (ArcMins)', 'SubjectiveAlignment (ArcMins)', 'Chromostereopsis')
axis square


figure
         errorbar(1, 1, 0.1, 0.1, 0.1, 0.1,'^b') %NHI
hold on; errorbar(2, 2, 0.1, 0.1, 0.1, 0.1,'sb') %MSB
hold on; errorbar(3, 3, 0.1, 0.1, 0.1, 0.1,'ob') %AJR
hold on; errorbar(4, 4,0.1, 0.1, 0.1, 0.1,'db') %HF
hold on; errorbar(5, 5, 0.1, 0.1, 0.1, 0.1,'pb') %BB
hold on; errorbar(6, 6, 0.1, 0.1, 0.1, 0.1, 'hb') %'Marker', 'h', 'Color', C3(1,:)) %FF
hold on; errorbar(7, 7, 0.1, 0.1, 0.1, 0.1, 'vb') %'Marker', 'v', 'Color', C3(3,:)) %MG
%legend('NHI0', 'MSB0', 'AJR0', 'HF0', 'BB0', 'FF0', 'MG0')


hold on; errorbar(3, 1, 0.1, 0.1, 0.1, 0.1,'^g') %NHI
hold on; errorbar(4, 2, 0.1, 0.1, 0.1, 0.1,'sg') %MSB
hold on; errorbar(5, 3, 0.1, 0.1, 0.1, 0.1,'og') %AJR
hold on; errorbar(6, 4, 0.1, 0.1, 0.1, 0.1,'dg') %HF
hold on; errorbar(7, 5, 0.1, 0.1, 0.1, 0.1,'pg') %BB
hold on; errorbar(8, 6, 0.1, 0.1, 0.1, 0.1, 'hg') %'Marker', 'h', 'Color', C3(1,:)) %FF
hold on; errorbar(9, 7, 0.1, 0.1, 0.1, 0.1, 'vg') %'Marker', 'v', 'Color', C3(3,:)) %MG

legend('NHI0', 'MSB0', 'AJR0', 'HF0', 'BB0', 'FF0', 'MG0', 'NHI0', 'MSB0', 'AJR0', 'HF0', 'BB0', 'FF0', 'MG0')

figure;
hold on; errorbar(5, 1, 0.1, 0.1, 0.1, 0.1,'^b', 'MarkerFaceColor', 'b') %NHI
hold on; errorbar(6, 2, 0.1, 0.1, 0.1, 0.1,'sb', 'MarkerFaceColor', 'b') %MSB
hold on; errorbar(7, 3, 0.1, 0.1, 0.1, 0.1,'ob', 'MarkerFaceColor', 'b') %AJR
hold on; errorbar(8, 4,0.1, 0.1, 0.1, 0.1,'db', 'MarkerFaceColor', 'b') %HF
hold on; errorbar(9, 5, 0.1, 0.1, 0.1, 0.1,'pb', 'MarkerFaceColor', 'b') %BB
hold on; errorbar(10, 6, 0.1, 0.1, 0.1, 0.1, 'hb', 'MarkerFaceColor', 'b') %'Marker', 'h', 'Color', C3(1,:)) %FF
hold on; errorbar(11, 7, 0.1, 0.1, 0.1, 0.1, 'vb', 'MarkerFaceColor', 'b') %'Marker', 'v', 'Color', C3(3,:)) %MG
%legend('NHI0', 'MSB0', 'AJR0', 'HF0', 'BB0', 'FF0', 'MG0')


hold on; errorbar(7, 1, 0.1, 0.1, 0.1, 0.1,'^g', 'MarkerFaceColor', 'g') %NHI
hold on; errorbar(8, 2, 0.1, 0.1, 0.1, 0.1,'sg', 'MarkerFaceColor', 'g') %MSB
hold on; errorbar(9, 3, 0.1, 0.1, 0.1, 0.1,'og', 'MarkerFaceColor', 'g') %AJR
hold on; errorbar(10, 4, 0.1, 0.1, 0.1, 0.1,'dg', 'MarkerFaceColor', 'g') %HF
hold on; errorbar(11, 5, 0.1, 0.1, 0.1, 0.1,'pg', 'MarkerFaceColor', 'g') %BB
hold on; errorbar(12, 6, 0.1, 0.1, 0.1, 0.1, 'hg', 'MarkerFaceColor', 'g') %'Marker', 'h', 'Color', C3(1,:)) %FF
hold on; errorbar(13, 7, 0.1, 0.1, 0.1, 0.1, 'vg', 'MarkerFaceColor', 'g') %'Marker', 'v', 'Color', C3(3,:)) %MG


legend('NHI1', 'MSB1', 'AJR1', 'HF1', 'BB1', 'FF1', 'MG1', 'NHI1', 'MSB1', 'AJR1', 'HF1', 'BB1', 'FF1', 'MG1')





% %%211027 fgr_CRM including top/bottom responses
%         %y0 up/down responses
%         %y1 disparities 
%         %y2   invert responses
%         %y3 up1 buttom0 blue/disparity
%         
%         
% %%MaxGreen0
% 
% %chromostereopsis
% load('S1001V5_CNT_BincACL0_2203021608.mat'); 
% %y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];
% 
% [rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S1001V5Left_TCA_ACL0_2203021557.mat'; load(LT)
% yx0=TCAp.z1; sd0=TCAp.z2; 
% 
% %right eye TCA
% RT='S1001V5Right_TCA_ACL0_2203021552.mat'; load(RT)
% yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4); 
% drcn='<'; ttl=['MG ACL0']
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% MG0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %%MG1
% %chromostereopsis
% % load('S1001V5_CNT_BincACL1_2203021641.mat'); 
% % [rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 
% 
% 
% load('S1001V5_CNT_BincACL1_2203021635.mat'); y111=CNTp.y1; y22=CNTp.y2; y333=CNTp.y3;
% load('S1001V5_CNT_BincACL1_2203021641.mat'); y1=[CNTp.y1 y111]; y2=[CNTp.y2 y22]; y3=[CNTp.y3 y333];
% [rslt CI]=psf_CNT0(y1, y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S1001V5Left_TCA_ACL1_2203021627.mat'; load(LT)
% yx0=TCAp.z1; sd0=TCAp.z2; 
% 
% %right eye TCA
% RT='S1001V5Right_TCA_ACL1_2203021621.mat'; load(RT)
% yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4);
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% MG1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];          
%         
%                 
% %%FabioFeroldi0
% 
% %chromostereopsis
% load('S1001V5_CNT_BincACL0_2202251601.mat'); 
% %y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];
% 
% [rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S1001V5Left_TCA_ACL0_2202251548.mat'; load(LT)
% yx0=TCAp.z1; sd0=TCAp.z2; 
% 
% %right eye TCA
% RT='S1001V5Right_TCA_ACL0_2202251552.mat'; load(RT)
% yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4); 
% drcn='<'; ttl=['FF220225 ACL0']
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% FF0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %%FF1
% %chromostereopsis
% load('S1001V5_CNT_BincACL1_2202251624.mat'); y111=CNTp.y1; y22=CNTp.y2; y333=CNTp.y3;
% load('S1001V5_CNT_BincACL1_2202251635.mat'); y1=[CNTp.y1 y111]; y2=[CNTp.y2 y22]; y3=[CNTp.y3 y333];
% 
% [rslt CI]=psf_CNT0(y1, y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S1001V5Left_TCA_ACL1_2202251615.mat'; load(LT)
% yx0=TCAp.z1; sd0=TCAp.z2; 
% 
% %right eye TCA
% RT='S1001V5Right_TCA_ACL1_2202251613.mat'; load(RT)
% yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4);
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% FF1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];        
%        
% %%BenBackus0
% 
% %chromostereopsis
% load('S1001V5_CNT_BincACL0_2202161658.mat'); 
% %y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];
% 
% [rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S1001V5Left_TCA_ACL0_2202161634.mat'; load(LT)
% yx0=TCAp.z1; sd0=TCAp.z2; 
% 
% %right eye TCA
% RT='S1001V5Right_TCA_ACL0_2202161612.mat'; load(RT)
% yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4); 
% drcn='<'; ttl=['BB220216 ACL0']
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% BB0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %%BB1
% %chromostereopsis
% load('S1001V5_CNT_BincACL1_2202161732.mat'); y111=CNTp.y1; y22=CNTp.y2; y333=CNTp.y3;
% load('S1001V5_CNT_BincACL1_2202161744.mat'); y1=[CNTp.y1 y111]; y2=[CNTp.y2 y22]; y3=[CNTp.y3 y333];
% 
% [rslt CI]=psf_CNT0(y1, y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S1001V5Left_TCA_ACL1_2202161719.mat'; load(LT)
% yx0=TCAp.z1; sd0=TCAp.z2; 
% 
% %right eye TCA
% RT='S1001V5Right_TCA_ACL1_2202161713.mat'; load(RT)
% yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4);
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% BB1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];        
%         
%         
%         
% %%HaniFarid0
% 
% %chromostereopsis
% load('S1001V5_CNT_BincACL0_2203011658.mat'); 
% %y111=y1; y22=y2; y333=y3; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22]; y3=[y3 y333];
% 
% [rslt CI]=psf_CNT0(CNTp.y1, CNTp.y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S1001V5Left_TCA_ACL0_2203011648.mat'; load(LT)
% yx0=TCAp.z1; sd0=TCAp.z2; 
% 
% %right eye TCA
% RT='S1001V5Right_TCA_ACL0_2203011644.mat'; load(RT)
% yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4); 
% drcn='<'; ttl=['HF220215 ACL0']
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% HF0=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
% 
% %%HF1
% %chromostereopsis
% load('S1001V5_CNT_BincACL1_2203011627.mat'); y111=CNTp.y1; y22=CNTp.y2; y333=CNTp.y3;
% load('S1001V5_CNT_BincACL1_2203011633.mat'); y1=[CNTp.y1 y111]; y2=[CNTp.y2 y22]; y3=[CNTp.y3 y333];
% 
% [rslt CI]=psf_CNT0(y1, y2); 
% c0=0.00384; c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
% 
% %%Left eye TCA
% LT='S1001V5Left_TCA_ACL1_2203011617.mat'; load(LT)
% yx0=TCAp.z1; sd0=TCAp.z2; 
% 
% %right eye TCA
% RT='S1001V5Right_TCA_ACL1_2203011612.mat'; load(RT)
% yx0(:,3:4)=TCAp.z1(:,3:4); sd0(:,3:4)=TCAp.z2(:,3:4);
% 
% yx=-1.*yx0./c1; sd=sd0./c1;
% r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% 
% r1=2.*rslt(1)
% HF1=[xbR-xbL, r1, r1-2.*CI(1),2.*CI(2)-r1, hbL, hbR];
%         
%         
%         
% 
% %NHI0
% %chromostereopsis
% load('S10007B_CNT_ACL0_2106091232_Best.mat'); 
% 
% [rslt CI]=psf_CNT0(y1, y2); 
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
% 
% [rslt CI]=psf_CNT0(y1, y2); 
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
% 
% [rslt CI]=psf_CNT0(y1, y2); 
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
% 
% [rslt CI]=psf_CNT0(y1, y2); 
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
% 
% [rslt CI]=psf_CNT0(y1, y2); 
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
% 
% [rslt CI]=psf_CNT0(y1, y2);
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
% 
% 
% 
% %line fit
% n=1; rx0=[NHI0(n) MSB0(n) AJR0(n) HF0(n) BB0(n) FF0(n) MG0(n)]
% n=2; ry0=[NHI0(n) MSB0(n) AJR0(n) HF0(n) BB0(n) FF0(n) MG0(n)]
% [rho0, pval0]=corr(rx0', ry0')
% n=1; rx1=[NHI1(n) MSB1(n) AJR1(n) HF1(n) BB1(n) FF1(n) MG1(n)]
% n=2; ry1=[NHI1(n) MSB1(n) AJR1(n) HF1(n) BB1(n) FF1(n) MG1(n)]
% [rho1, pval1]=corr(rx1', ry1')
% 
% rx=[rx0 rx1]
% ry=[ry0 ry1]
% [rho, pval]=corr(rx', ry')
% 
% 
% 
% nms={'NHI'; 'MSB'; 'AJR'; 'HF'; 'BB'; 'FF'; 'MG'}
% m=[NHI0(1:2) NHI1(1:2); MSB0(1:2) MSB1(1:2); AJR0(1:2) AJR1(1:2); HF0(1:2) HF1(1:2); BB0(1:2) BB1(1:2); FF0(1:2) FF1(1:2); MG0(1:2) MG1(1:2);]
% t = table(nms,m(:,1),m(:,2),m(:,3),m(:,4),...
% 'VariableNames',{'sbj','m1','m2','m3','m4'});
% M = table([1 2 3 4]','VariableNames',{'Measurements'});
% rm = fitrm(t,'m1-m4~sbj','WithinDesign',M)
% 
% 
% 
% 
% nms={'NHI'; 'NHI'; 'MSB'; 'MSB'; 'AJR'; 'AJR'; 'HF'; 'HF'; 'BB'; 'BB'; 'FF'; 'FF'; 'MG'; 'MG'}
% m=[NHI0(1:2) ;NHI1(1:2); MSB0(1:2); MSB1(1:2); AJR0(1:2); AJR1(1:2); HF0(1:2); HF1(1:2); BB0(1:2); BB1(1:2); FF0(1:2); FF1(1:2); MG0(1:2); MG1(1:2)]
% t = table(nms,m(:,1),m(:,2),...
% 'VariableNames',{'sbj','m1','m2'});
% M = table([1 2]','VariableNames',{'Measurements'});
% rm = fitrm(t,'m1-m2~sbj','WithinDesign',M)
% 
% 
% 
% %save('CRM_TopBottomChoice211101', 'NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1')
% C3=[237 125 49; 112 48 160; 112 173 71]./255;
% cls; 
% %close all
% mrkSz=10; lnWd=1
%          errorbar(NHI0(1), NHI0(2), NHI0(3),NHI0(4), NHI0(5), NHI0(6),'^b', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(NHI1(1), NHI1(2), NHI1(3),NHI1(4), NHI1(5), NHI1(6),'^b', 'MarkerFaceColor', 'b', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(MSB0(1), MSB0(2), MSB0(3),MSB0(4), MSB0(5), MSB0(6),'sg', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(MSB1(1), MSB1(2), MSB1(3),MSB1(4), MSB1(5), MSB1(6),'sg', 'MarkerFaceColor', 'g', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(AJR0(1), AJR0(2), AJR0(3),AJR0(4), AJR0(5), AJR0(6),'or', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(AJR1(1), AJR1(2), AJR1(3),AJR1(4), AJR1(5), AJR1(6),'or', 'MarkerFaceColor', 'r', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(HF0(1), HF0(2), HF0(3), HF0(4), HF0(5), HF0(6),'dm', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(HF1(1), HF1(2), HF1(3), HF1(4),  HF1(5), HF1(6),'dm', 'MarkerFaceColor', 'm', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(BB0(1), BB0(2), BB0(3), BB0(4), BB0(5), BB0(6),'pc', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(BB1(1), BB1(2), BB1(3), BB1(4), BB1(5), BB1(6),'pc', 'MarkerFaceColor', 'c', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(FF0(1), FF0(2), FF0(3), FF0(4), FF0(5), FF0(6), 'Marker', 'h', 'Color', C3(1,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(FF1(1), FF1(2), FF1(3), FF1(4), FF1(5), FF1(6), 'Marker', 'h', 'Color', C3(1,:), 'MarkerFaceColor', C3(1,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(MG0(1), MG0(2), MG0(3), MG0(4), MG0(5), MG0(6), 'Marker', 'v', 'Color', C3(3,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(MG1(1), MG1(2), MG1(3), MG1(4), MG1(5), MG1(6), 'Marker', 'v', 'Color', C3(3,:), 'MarkerFaceColor', C3(3,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; plot([-4 8], [-4 8], 'k--')
% grid on
% legend('NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1', 'HF0', 'HF1', 'BB0', 'BB1', 'FF0', 'FF1', 'MG0', 'MG1', 'corr=1')
% lbl('TCA (ArcMins)', 'SubjectiveAlignment (ArcMins)', 'Chromostereopsis')
% axis square
% 
% 
% 
% cls; 
% %close all
% mrkSz=10; lnWd=1
%          errorbar(NHI0(1), NHI0(2), NHI0(3),NHI0(4), NHI0(5), NHI0(6),'^b', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(NHI1(1), NHI1(2), NHI1(3),NHI1(4), NHI1(5), NHI1(6),'^b', 'MarkerFaceColor', 'b', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(MSB0(1), MSB0(2), MSB0(3),MSB0(4), MSB0(5), MSB0(6),'sg', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(MSB1(1), MSB1(2), MSB1(3),MSB1(4), MSB1(5), MSB1(6),'sg', 'MarkerFaceColor', 'g', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(AJR0(1), AJR0(2), AJR0(3),AJR0(4), AJR0(5), AJR0(6),'or', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(AJR1(1), AJR1(2), AJR1(3),AJR1(4), AJR1(5), AJR1(6),'or', 'MarkerFaceColor', 'r', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(HF0(1), HF0(2), HF0(3), HF0(4), HF0(5), HF0(6),'dm', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(HF1(1), HF1(2), HF1(3), HF1(4),  HF1(5), HF1(6),'dm', 'MarkerFaceColor', 'm', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(BB0(1), BB0(2), BB0(3), BB0(4), BB0(5), BB0(6),'pc', 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(BB1(1), BB1(2), BB1(3), BB1(4), BB1(5), BB1(6),'pc', 'MarkerFaceColor', 'c', 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(FF0(1), FF0(2), FF0(3), FF0(4), FF0(5), FF0(6), 'Marker', 'h', 'Color', C3(1,:), 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(FF1(1), FF1(2), FF1(3), FF1(4), FF1(5), FF1(6), 'Marker', 'h', 'Color', C3(1,:), 'MarkerFaceColor', C3(1,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(MG0(1), MG0(2), MG0(3), MG0(4), MG0(5), MG0(6), 'Marker', 'v', 'Color', C3(3,:), 'MarkerFaceColor', 'w','MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; errorbar(MG1(1), MG1(2), MG1(3), MG1(4), MG1(5), MG1(6), 'Marker', 'v', 'Color', C3(3,:), 'MarkerFaceColor', C3(3,:), 'MarkerSize', mrkSz, 'linewidth',lnWd);
% hold on; plot([-4 8], [-4 8], 'k--')
% grid on
% legend('NHI0', 'NHI1', 'MSB0', 'MSB1', 'AJR0', 'AJR1', 'HF0', 'HF1', 'BB0', 'BB1', 'FF0', 'FF1', 'MG0', 'MG1', 'corr=1')
% lbl('TCA (ArcMins)', 'SubjectiveAlignment (ArcMins)', 'Chromostereopsis')
% axis square
% 
% 
% figure
%          errorbar(1, 1, 0.1, 0.1, 0.1, 0.1,'^b') %NHI
% hold on; errorbar(2, 2, 0.1, 0.1, 0.1, 0.1,'sb') %MSB
% hold on; errorbar(3, 3, 0.1, 0.1, 0.1, 0.1,'ob') %AJR
% hold on; errorbar(4, 4,0.1, 0.1, 0.1, 0.1,'db') %HF
% hold on; errorbar(5, 5, 0.1, 0.1, 0.1, 0.1,'pb') %BB
% hold on; errorbar(6, 6, 0.1, 0.1, 0.1, 0.1, 'hb') %'Marker', 'h', 'Color', C3(1,:)) %FF
% hold on; errorbar(7, 7, 0.1, 0.1, 0.1, 0.1, 'vb') %'Marker', 'v', 'Color', C3(3,:)) %MG
% %legend('NHI0', 'MSB0', 'AJR0', 'HF0', 'BB0', 'FF0', 'MG0')
% 
% 
% hold on; errorbar(3, 1, 0.1, 0.1, 0.1, 0.1,'^g') %NHI
% hold on; errorbar(4, 2, 0.1, 0.1, 0.1, 0.1,'sg') %MSB
% hold on; errorbar(5, 3, 0.1, 0.1, 0.1, 0.1,'og') %AJR
% hold on; errorbar(6, 4, 0.1, 0.1, 0.1, 0.1,'dg') %HF
% hold on; errorbar(7, 5, 0.1, 0.1, 0.1, 0.1,'pg') %BB
% hold on; errorbar(8, 6, 0.1, 0.1, 0.1, 0.1, 'hg') %'Marker', 'h', 'Color', C3(1,:)) %FF
% hold on; errorbar(9, 7, 0.1, 0.1, 0.1, 0.1, 'vg') %'Marker', 'v', 'Color', C3(3,:)) %MG
% 
% legend('NHI0', 'MSB0', 'AJR0', 'HF0', 'BB0', 'FF0', 'MG0', 'NHI0', 'MSB0', 'AJR0', 'HF0', 'BB0', 'FF0', 'MG0')
% 
% figure;
% hold on; errorbar(5, 1, 0.1, 0.1, 0.1, 0.1,'^b', 'MarkerFaceColor', 'b') %NHI
% hold on; errorbar(6, 2, 0.1, 0.1, 0.1, 0.1,'sb', 'MarkerFaceColor', 'b') %MSB
% hold on; errorbar(7, 3, 0.1, 0.1, 0.1, 0.1,'ob', 'MarkerFaceColor', 'b') %AJR
% hold on; errorbar(8, 4,0.1, 0.1, 0.1, 0.1,'db', 'MarkerFaceColor', 'b') %HF
% hold on; errorbar(9, 5, 0.1, 0.1, 0.1, 0.1,'pb', 'MarkerFaceColor', 'b') %BB
% hold on; errorbar(10, 6, 0.1, 0.1, 0.1, 0.1, 'hb', 'MarkerFaceColor', 'b') %'Marker', 'h', 'Color', C3(1,:)) %FF
% hold on; errorbar(11, 7, 0.1, 0.1, 0.1, 0.1, 'vb', 'MarkerFaceColor', 'b') %'Marker', 'v', 'Color', C3(3,:)) %MG
% %legend('NHI0', 'MSB0', 'AJR0', 'HF0', 'BB0', 'FF0', 'MG0')
% 
% 
% hold on; errorbar(7, 1, 0.1, 0.1, 0.1, 0.1,'^g', 'MarkerFaceColor', 'g') %NHI
% hold on; errorbar(8, 2, 0.1, 0.1, 0.1, 0.1,'sg', 'MarkerFaceColor', 'g') %MSB
% hold on; errorbar(9, 3, 0.1, 0.1, 0.1, 0.1,'og', 'MarkerFaceColor', 'g') %AJR
% hold on; errorbar(10, 4, 0.1, 0.1, 0.1, 0.1,'dg', 'MarkerFaceColor', 'g') %HF
% hold on; errorbar(11, 5, 0.1, 0.1, 0.1, 0.1,'pg', 'MarkerFaceColor', 'g') %BB
% hold on; errorbar(12, 6, 0.1, 0.1, 0.1, 0.1, 'hg', 'MarkerFaceColor', 'g') %'Marker', 'h', 'Color', C3(1,:)) %FF
% hold on; errorbar(13, 7, 0.1, 0.1, 0.1, 0.1, 'vg', 'MarkerFaceColor', 'g') %'Marker', 'v', 'Color', C3(3,:)) %MG
% 
% 
% legend('NHI1', 'MSB1', 'AJR1', 'HF1', 'BB1', 'FF1', 'MG1', 'NHI1', 'MSB1', 'AJR1', 'HF1', 'BB1', 'FF1', 'MG1')



% lbl('BlueTopRedBottom (ArcMins)', 'RedTopBlueBottom (ArcMins)', 'Chromostereopsis')
% 
% lbl('BottomChoice (ArcMins)', 'TopChoice (ArcMins)', 'Chromostereopsis')

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