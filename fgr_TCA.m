%210623 INCLUDE PREVIOUS DATA
clr
c0=0.00384;  c1=1./(c0.*60);
drc='>'; ttl=['AJR210714']
%% AJR
%20% contrast mark
T0=["S10003Right_TCA_ACL0_2106251423.mat",...   %S10003Right_CSF_ACL0_2106251435
    "S10003Right_TCA_ACL0_2106291545.mat",...   %S10003Right_CSF_ACL0_2106291600
    "S10003Right_TCA_ACL0_2107091055.mat",...       %S10003Right_CSF_ACL0_2107091108
    "S10003Right_TCA_ACL0_2107131556.mat",...
    "S10003Right_TCA_ACL0_2107141452.mat",...
    ];

T1=["S10003Right_TCA_ACL1_2106251330.mat",... %S10003Right_CSF_ACL1_2106251411.ma
    "S10003Right_TCA_ACL1_2106291622.mat",... %S10003Right_CSF_ACL1_2106291651
    "S10003Right_TCA_ACL1_2107091135.mat",... %S10003Right_CSF_ACL1_2107091148
    "S10003Right_TCA_ACL1_2107131515.mat",...
    "S10003Right_TCA_ACL1_2107141543.mat",...
    ];

%% MSB
clr
c0=0.00384;  c1=1./(c0.*60);
drc='<'; ttl=['MSB210714']
%MSB ACL0

%20% contrast mark
T0=["S10004Left_TCA_ACL0_2106221413.mat",...   %S10004Left_CSF_ACL0_2106221511
    "S10004Left_TCA_ACL0_2106231318.mat",...   %S10004Left_CSF_ACL0_2106231422 
    "S10004Left_TCA_ACL0_2106281140.mat",...   %S10004Left_CSF_ACL0_2106281135
    "S10004Left_TCA_ACL0_2106300934.mat",...   %S10004Left_CSF_ACL0_2106300947
    "S10004Left_TCA_ACL0_2107131353.mat",...
    "S10004Left_TCA_ACL0_2107141233.mat",...
    ];

T1=["S10004Left_TCA_ACL1_2106211536.mat"... %S10004Left_CSF_ACL1_2106211606_correct"]
    "S10004Left_TCA_ACL1_2106241432.mat",... %S10004Left_CSF_ACL1_2106241508.ma
    "S10004Left_TCA_ACL1_2106250812.mat",... %S10004Left_CSF_ACL1_2106250829.mat
    "S10004Left_TCA_ACL1_2107140948.mat",...
    "S10004Left_TCA_ACL1_2107141349.mat",...
    ];


%% NHI
clr
c0=0.00384;  c1=1./(c0.*60);
drc='>'; ttl=['NHI210708']

%20% contrast mark
T0=["S10007Right_TCA_ACL0_2107081240.mat",...   %S10007Right_CSF_ACL0_2107081310
    "S10007Right_TCA_ACL0_2107151622.mat",...   %S10007Right_CSF_ACL0_2107151702
    ];

T1=["S10007Right_TCA_ACL1_2107081501.mat",... %S10007Right_CSF_ACL1_2107081540
    "S10007Right_TCA_ACL1_2107151512.mat",... %S10007Right_CSF_ACL1_2107151427
    ];


mrk='o';
for k0=1:length(T0)
    load(T0(k0));
    z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
    yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1; rb0(k0)=z1(3,2)./c1;
    
    r=2; c=2; xg0 = yx0(r,c); hg0 = sd0(r,c);
    r=3; c=2; xb0 = yx0(r,c); hb0 = sd0(r,c);
    r=2; c=1; yg0 = yx0(r,c); vg0 = sd0(r,c);
    r=3; c=1; yb0 = yx0(r,c); vb0 = sd0(r,c);
    
    if k0==length(T0); mrk=drc; cf=1; end
    eg0=errorbar(xg0, yg0, vg0, vg0, hg0, hg0, [mrk 'g']); %, 'Color', [0 1 0]./cf);
    eg0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz0(2,2))
    eg0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('TsysTCA', -yz0(2,1))
    eg0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', {T0(k0)})
    
    
    hold on
    eb0=errorbar(xb0, yb0, vb0, vb0, hb0, hb0, [mrk 'b']); %, 'Color', [0 0 1]./cf);
    eb0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz0(3,2))
    eb0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('TsysTCA', -yz0(3,1))
    eb0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', {T0(k0)})
    
    hold on
    
end



mrk='o'
for k0=1:length(T1)
    load(T1(k0)); z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
    yx1=-1.*(z1-z0)./c1; yz1=z0./c1; sd1=z2./c1; rb1(k0)=z1(3,2)./c1;
    
    r=2; c=2; xg1 = yx1(r,c); hg1 = sd1(r,c);
    r=3; c=2; xb1 = yx1(r,c); hb1 = sd1(r,c);
    r=2; c=1; yg1 = yx1(r,c); vg1 = sd1(r,c);
    r=3; c=1; yb1 = yx1(r,c); vb1 = sd1(r,c);
    
    if k0==length(T1); mrk=drc; cf=1; end
    eg1=errorbar(xg1, yg1, vg1, vg1, hg1, hg1, [mrk 'g'], 'MarkerFaceColor','green');
    eg1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz1(2,2))
    eg1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('YsysTCA', -yz1(2,1))
    eg1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', {T1(k0)})
    
    hold on
    eb1=errorbar(xb1, yb1, vb1, vb1, hb1, hb1, [mrk 'b'], 'MarkerFaceColor','blue');
    eb1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz1(3,2))
    eb1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('YsysTCA', -yz1(3,1))
    eb1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', {T1(k0)})
    
    %hold off
end


%lm=axis;
if diff(xlim)<diff(ylim);
    lm=xlim;
    xlim([lm(1) lm(1)+diff(ylim)]);
elseif diff(ylim)<diff(xlim);
    lm=ylim;
    ylim([lm(1) lm(1)+diff(xlim)]);
end


lbl('Horizontal TCA (arcmin)', 'Vertical TCA (arcmin)', ttl)




% %210623 INCLUDE PREVIOUS DATA
% clr
% c0=0.00384;  c1=1./(c0.*60);
% drc='<'; ttl=['MSB' n2s(tme)]
% %MSB ACL0
% 
% %T0='S10004Left_TCA_ACL0_2106071400.mat';   %S10004Left_CSF_ACL0_2106071407
% %T0='S10004Left_TCA_ACL0_2106101231.mat';   %S10004Left_CSF_ACL0_2106101307
% %T0='S10004Left_TCA_ACL0_2106151053.mat';   %S10004Left_CSF_ACL0_2106151140
% %20% contrast mark
% T0=["S10004Left_TCA_ACL0_2106221413.mat",...   %S10004Left_CSF_ACL0_2106221511
%     "S10004Left_TCA_ACL0_2106231318.mat",...   %S10004Left_CSF_ACL0_2106231422
%     ];
% 
% %load(T0); z0=VRCMp.sysTCA; z1=z1(:,3:4); z2=z2(:,3:4);
% %load(T0); z0=z0(:,1:2); z1=z1(:,1:2); z2=z2(:,1:2);
% %z0=VRCMp.sysTCA; z1=VRCMp.sbjTCA; z2=VRCMp.sbjTCAsd;
% mrk='o';
% for k0=1:length(T0)
%     load(T0(k0));
%     z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
%     yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1; rb0(k0)=z1(3,2)./c1;
%     
%     r=2; c=2; xg0 = yx0(r,c); hg0 = sd0(r,c);
%     r=3; c=2; xb0 = yx0(r,c); hb0 = sd0(r,c);
%     r=2; c=1; yg0 = yx0(r,c); vg0 = sd0(r,c);
%     r=3; c=1; yb0 = yx0(r,c); vb0 = sd0(r,c);
%     
%     if k0==length(T0); mrk=drc; cf=1; end
%     eg0=errorbar(xg0, yg0, vg0, vg0, hg0, hg0, [mrk 'g']); %, 'Color', [0 1 0]./cf);
%     eg0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz0(2,2))
%     eg0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('TsysTCA', -yz0(2,1))
%     eg0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', {T0(k0)})
%     
%     
%     hold on
%     eb0=errorbar(xb0, yb0, vb0, vb0, hb0, hb0, [mrk 'b']); %, 'Color', [0 0 1]./cf);
%     eb0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz0(3,2))
%     eb0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('TsysTCA', -yz0(3,1))
%     eb0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', {T0(k0)})
%     
%     hold on
%     
% end
% %MSB ACL1
% %T1='S10004Left_TCA_ACL1_2106071428.mat'; %S10004Left_CSF_ACL1_2106071435
% %T1='S10004Left_TCA_ACL1_2106141204.mat'; %S10004Left_CSF_ACL1_2106141218
% %20% CONTRAST MARK
% T1=["S10004Left_TCA_ACL1_2106211536.mat"... %S10004Left_CSF_ACL1_2106211606_correct"]
%     "S10004Left_TCA_ACL1_2106241432.mat"]
% %load(T1); z0=z0(:,1:2); z1=z1(:,1:2); z2=z2(:,1:2);
% %load(T1); z0=VRCMp.sysTCA; z1=VRCMp.sbjTCA; z2=VRCMp.sbjTCAsd;
% mrk='o'
% for k0=1:length(T1)
%     load(T1(k0)); z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
%     yx1=-1.*(z1-z0)./c1; yz1=z0./c1; sd1=z2./c1; rb1(k0)=z1(3,2)./c1;
%     
%     r=2; c=2; xg1 = yx1(r,c); hg1 = sd1(r,c);
%     r=3; c=2; xb1 = yx1(r,c); hb1 = sd1(r,c);
%     r=2; c=1; yg1 = yx1(r,c); vg1 = sd1(r,c);
%     r=3; c=1; yb1 = yx1(r,c); vb1 = sd1(r,c);
%     
%     if k0==length(T1); mrk=drc; cf=1; end
%     eg1=errorbar(xg1, yg1, vg1, vg1, hg1, hg1, [mrk 'g'], 'MarkerFaceColor','green');
%     eg1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz1(2,2))
%     eg1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('YsysTCA', -yz1(2,1))
%     eg1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', {T1(k0)})
%     
%     hold on
%     eb1=errorbar(xb1, yb1, vb1, vb1, hb1, hb1, [mrk 'b'], 'MarkerFaceColor','blue');
%     eb1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz1(3,2))
%     eb1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('YsysTCA', -yz1(3,1))
%     eb1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', {T1(k0)})
%     
%     %hold off
% end
% 
% 
% %lm=axis;
% if diff(xlim)<diff(ylim);
%     lm=xlim;
%     xlim([lm(1) lm(1)+diff(ylim)]);
% elseif diff(ylim)<diff(xlim);
%     lm=ylim;
%     ylim([lm(1) lm(1)+diff(xlim)]);
% end
% 
% 
% lbl('Horizontal TCA (arcmin)', 'Vertical TCA (arcmin)', ttl)
% 




% %210613 combined TCA CSF & CRM plot! plotting in pixel units!
%
% %NHI210614 ACL0
% % %CSF
% load('S10007Right_CSF_ACL0_2106091301.mat');
% h00=h0; h11=h1;
% load('S10007Right_CSF_ACL0_2106091320.mat');
% h0=[h0 h00]; h1=[h11 h1];
% [x y]=psf_CSF(h0, h1, g0(2), g1, 0);
% y11=fit_CSF0(x,y);
% figure; plot(x,y); hold on; plot(y11); hold off
%
% %chromostereopsis
% load('S10007B_CNT_ACL0_2106091232_Best.mat'); [rslt CI]=psf_CNT(y1, y2);
%  c0=0.00384;  c1=1./(c0.*60);
% rslt=rslt./c1; CI=CI./c1;
%
%
% %%Left eye TCA
% LT='S10007Left_TCA_ACL0_2106091116.mat';
% load(LT); yx0=z1-z0; sd0=z2;
%
% %right eye TCA
% %RT='S10007Right_TCA_ACL0_2106091102.mat';
% RT='S10007Right_TCA_ACL0_2106161238.mat';
% RT='S10007Right_LCA_ACL0_2106161205.mat'
%
% load(RT); yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4);
%
%
%
% %NHI210614 ACL1
% % %CSF
% load('S10007Right_CSF_ACL1_2106091449.mat');
% h00=h0; h11=h1;
% load('S10007Right_CSF_ACL1_2106091500.mat');
% h0=[h0 h00]; h1=[h11 h1];
% [x y]=psf_CSF(h0, h1, g0(2), g1, 0);
% y11=fit_CSF0(x,y);
% figure; plot(x,y); hold on; plot(y11); hold off
%
%
% %NHI;
%
% %right eye TCA ACL0
% RT='S10007Right_TCA_ACL1_2106091435.mat'; load(RT)
%
%
% c0=0.00384;  c1=1./(c0.*60);
% T0='S10007Right_TCA_ACL0_2106161238.mat';
% load(T0); z0=VRCMp.sysTCA; z1=z1(:,3:4); z2=z2(:,3:4);
%
% yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1;
% %corrected offset    correction  standard deviation
%
%
% T1='S10007Right_TCA_ACL1_2106161328.mat';
% load(T1); z0=VRCMp.sysTCA; z1=z1(:,3:4); z2=z2(:,3:4);
%
% yx1=-1.*(z1-z0)./c1; yz1=z0./c1; sd1=z2./c1;
%
%
% %AJR ACL0;
% c0=0.00384;  c1=1./(c0.*60);
% T0='S10003Right_TCA_ACL1_2106181307.mat';
% load(T0); z0=VRCMp.sysTCA; z1=z1(:,3:4); z2=z2(:,3:4);
%
% yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1;
% %corrected offset    correction  standard deviation
% %AJR ACL1
% T1='S10003Right_TCA_ACL1_2106181307.mat';
% %load(T1); z0=VRCMp.sysTCA; z1=z1(:,3:4); z2=z2(:,3:4);
% load(T1); z0=VRCMp.sysTCA; z1=VRCMp.sbjTCA; z2=VRCMp.sbjTCAsd;
%
%
% c0=0.00384;  c1=1./(c0.*60);
%
% %MSB ACL0
%
% %T0='S10004Left_TCA_ACL0_2106071400.mat';   %S10004Left_CSF_ACL0_2106071407
% %T0='S10004Left_TCA_ACL0_2106101231.mat';   %S10004Left_CSF_ACL0_2106101307
% %T0='S10004Left_TCA_ACL0_2106151053.mat';   %S10004Left_CSF_ACL0_2106151140
% %20% contrast mark
% %T0='S10004Left_TCA_ACL0_2106221413.mat';   %S10004Left_CSF_ACL0_2106221511
% T0='S10004Left_TCA_ACL0_2106221413.mat';   %S10004Left_CSF_ACL0_2106231422
%
%
% %load(T0); z0=VRCMp.sysTCA; z1=z1(:,3:4); z2=z2(:,3:4);
% %load(T0); z0=z0(:,1:2); z1=z1(:,1:2); z2=z2(:,1:2);
% %z0=VRCMp.sysTCA; z1=VRCMp.sbjTCA; z2=VRCMp.sbjTCAsd;
% load(T0); z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
% yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1; rb0=z1(3,2)./c1;
%
% %MSB ACL1
% %T1='S10004Left_TCA_ACL1_2106071428.mat'; %S10004Left_CSF_ACL1_2106071435
% %T1='S10004Left_TCA_ACL1_2106141204.mat'; %S10004Left_CSF_ACL1_2106141218
% T1='S10004Left_TCA_ACL1_2106211536.mat'; %S10004Left_CSF_ACL1_2106211606_correct
% %load(T1); z0=z0(:,1:2); z1=z1(:,1:2); z2=z2(:,1:2);
% %load(T1); z0=VRCMp.sysTCA; z1=VRCMp.sbjTCA; z2=VRCMp.sbjTCAsd;
% load(T1); z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
% yx1=-1.*(z1-z0)./c1; yz1=z0./c1; sd1=z2./c1; rb1=z1(3,2)./c1;
%
% drc='<'; ttl=['MSB' n2s(tme)]
%
%
% %add green blue colors
% r=2; c=2; xg0 = yx0(r,c); hg0 = sd0(r,c);
% r=3; c=2; xb0 = yx0(r,c); hb0 = sd0(r,c);
% r=2; c=1; yg0 = yx0(r,c); vg0 = sd0(r,c);
% r=3; c=1; yb0 = yx0(r,c); vb0 = sd0(r,c);
%
%
% eg0=errorbar(xg0, yg0, vg0, vg0, hg0, hg0, [drc 'g']);
% eg0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz0(2,2))
% eg0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('TsysTCA', -yz0(2,1))
% hold on
% eb0=errorbar(xb0, yb0, vb0, vb0, hb0, hb0, [drc 'b']);
% eb0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz0(3,2))
% eb0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('TsysTCA', -yz0(3,1))
% hold on
%
%
% r=2; c=2; xg1 = yx1(r,c); hg1 = sd1(r,c);
% r=3; c=2; xb1 = yx1(r,c); hb1 = sd1(r,c);
% r=2; c=1; yg1 = yx1(r,c); vg1 = sd1(r,c);
% r=3; c=1; yb1 = yx1(r,c); vb1 = sd1(r,c);
%
% eg1=errorbar(xg1, yg1, vg1, vg1, hg1, hg1, [drc 'g'], 'MarkerFaceColor','green');
% eg1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz1(2,2))
% eg1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('YsysTCA', -yz1(2,1))
% hold on
% eb1=errorbar(xb1, yb1, vb1, vb1, hb1, hb1, [drc 'b'], 'MarkerFaceColor','blue');
% eb1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('XsysTCA', -yz1(3,2))
% eb1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('YsysTCA', -yz1(3,1))
% hold off
%
% %lm=axis;
% if diff(xlim)<diff(ylim);
%   lm=xlim;
%   xlim([lm(1) lm(1)+diff(ylim)]);
% elseif diff(ylim)<diff(xlim);
%       lm=ylim;
%   ylim([lm(1) lm(1)+diff(xlim)]);
% end
%
%
% lbl('Horizontal TCA (arcmin)', 'Vertical TCA (arcmin)', ttl)
%
%
%
%
% % load('S10007Right_CSF_ACL0_2106161505.mat');
% % [x0 y0 CI]=psf_CSF0(h0, h1, g0(2), g1-yx0(3,2)+3, 0);
% % y00=fit_CSF0(x0,y0);
% %
% %
% % load('S10003Right_CSF_ACL1_2106181403.mat');
% % [x1 y1 CI]=psf_CSF0(h0, round(1000.*h1)./1000, g0(2), g1, 0);
% % y11=fit_CSF0(x1-z1(3,2)./c1, y1);
% %
% % %figure; plot(x0,y0, '>r'); hold on; plot(y00, '--r'); hold off
% % %hold on; plot(x1,y1, '>r','MarkerFaceColor','red'); hold on; plot(y11, 'r'); hold off
% % hold on; errorbar(x1-z1(3,2)./c1,y1, y1-CI(:,1)', CI(:,2)'-y1, '>r','MarkerFaceColor','red'); hold on; plot(y11, 'r'); hold off
% %
% % legend off
% % lbl('Phase shift (arcmin)', 'Contrast sensitivity', 'AJR210618')
%
% % %210613 combined TCA CSF & CRM plot! plotting in pixel units!
% %
% % %NHI210614 ACL0
% % % %CSF
% % load('S10007Right_CSF_ACL0_2106091301.mat');
% % h00=h0; h11=h1;
% % load('S10007Right_CSF_ACL0_2106091320.mat');
% % h0=[h0 h00]; h1=[h11 h1];
% % [x y]=psf_CSF(h0, h1, g0(2), g1, 0);
% % y11=fit_CSF0(x,y);
% % figure; plot(x,y); hold on; plot(y11); hold off
% %
% % %chromostereopsis
% % load('S10007B_CNT_ACL0_2106091232_Best.mat'); [rslt CI]=psf_CNT(y1, y2);
% %  c0=0.00384;  c1=1./(c0.*60);
% % rslt=rslt./c1; CI=CI./c1;
% %
% %
% % %%Left eye TCA
% % LT='S10007Left_TCA_ACL0_2106091116.mat';
% % load(LT); yx0=z1-z0; sd0=z2;
% %
% % %right eye TCA
% % %RT='S10007Right_TCA_ACL0_2106091102.mat';
% % RT='S10007Right_TCA_ACL0_2106161238.mat';
% % RT='S10007Right_LCA_ACL0_2106161205.mat'
% %
% % load(RT); yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4);
% %
% %
% %
% % %NHI210614 ACL1
% % % %CSF
% % load('S10007Right_CSF_ACL1_2106091449.mat');
% % h00=h0; h11=h1;
% % load('S10007Right_CSF_ACL1_2106091500.mat');
% % h0=[h0 h00]; h1=[h11 h1];
% % [x y]=psf_CSF(h0, h1, g0(2), g1, 0);
% % y11=fit_CSF0(x,y);
% % figure; plot(x,y); hold on; plot(y11); hold off
% %
% % %chromostereopsis
% % load('S10007B_CNT_ACL1_2106091417BEST.mat'); [rslt CI]=psf_CNT(y1, y2);
% %  c0=0.00384;  c1=1./(c0.*60);
% % rslt=rslt./c1; CI=CI./c1;
% %
% %
% % %%Left eye TCA
% % LT='S10007Left_TCA_ACL1_2106091512.mat'; load(LT)
% % yx0=z1; sd0=z2;
% %
% % %right eye TCA
% % RT='S10007Right_TCA_ACL1_2106091435.mat'; load(RT)
% % yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4);
% %
% %
% % %%MSB210611 ACL1
% % %CSF
% % load('S10004Left_CSF_ACL1_2106141218.mat');
% % [x y]=psf_CSF(h0, h1, g0(2), g1, 0);
% % y11=fit_CSF0(x,y);
% % figure; plot(x,y); hold on; plot(y11); hold off
% %
% % %chromostereopsis
% % load('S10004B_CNT_ACL1_2106141148.mat'); y111=y1; y22=y2;
% % load('S10004B_CNT_ACL1_2106141155.mat'); y1=[y1 y111]; y2=[y2 y22];
% % c0=0.00384; %deg/pixels
% % c1=1./(c0.*60);
% % [rslt CI]=psf_CNT(y1, y2);
% % rslt=rslt./c1; CI=CI./c1;
% %
% %
% % %%Left eye TCA
% % LT='S10004Left_TCA_ACL1_2106141204.mat'; load(LT)
% % yx0=z1; sd0=z2;
% %
% % %right eye TCA
% % RT='S10004Right_TCA_ACL1_2106141240.mat'; load(RT)
% % yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4);
% %
% %
% % %%MSB210614 ACL0
% % %CSF
% % load('S10004Left_CSF_ACL0_2106151140.mat');
% % [x y]=psf_CSF(h0, h1, g0(2), g1, 0);
% % y11=fit_CSF0(x,y);
% % figure; plot(x,y); hold on; plot(y11); hold off
% %
% % %chromostereopsis
% % load('S10004B_CNT_ACL0_2106151108.mat');
% % y111=y1; y22=y2; load('S10004B_CNT_ACL0_2106151118.mat'); y1=[y1 y111]; y2=[y2 y22];
% % c0=0.00384; %deg/pixels
% % c1=1./(c0.*60);
% % [rslt CI]=psf_CNT(y1, y2);
% % rslt=rslt./c1; CI=CI./c1;
% %
% % %%Left eye TCA
% % LT='S10004Left_TCA_ACL0_2106151053.mat'; load(LT)
% % yx0=z1; sd0=z2;
% %
% % %right eye TCA
% % RT='S10004Right_TCA_ACL0_2106151047.mat'; load(RT)
% % yx0(:,3:4)=z1(:,3:4); sd0(:,3:4)=z2(:,3:4);
% % drcn='<'; ttl=['MSB210615 ACL0']
% %
% %
% %
% % yx=-1.*yx0./c1; sd=sd0./c1;
% %
% % %add green blue colors
% % r=2; c=4; xgR = yx(r,c); hgR = sd(r,c);
% % r=2; c=2; xgL = yx(r,c); hgL = sd(r,c);
% %
% % r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% % r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% %
% % r=2; c=3; ygR = yx(r,c); vgR = sd(r,c);
% % r=2; c=1; ygL = yx(r,c); vgL = sd(r,c);
% %
% % r=3; c=3; ybR = yx(r,c); vbR = sd(r,c);
% % r=3; c=1; ybL = yx(r,c); vbL = sd(r,c);
% %
% % errorbar(xgR, ygR, vgR, vgR, hgR, hgR, '>g');
% % hold on
% % errorbar(xbR, ybR, vbR, vbR, hbR, hbR, '>b');
% % hold on
% % errorbar(xgL, ygL, vgL, vgL, hgL, hgL, '<g');
% % hold on
% % errorbar(xbL, ybL, vbL, vbL, hbL, hbL, '<b');
% % hold on
% %
% %
% %
% % %chromostereopsis CNT analysis
% % r0=(xbL+xbR)./2; r1=rslt(1); r2=[-r1 +r1]+r0;
% % rU=abs(CI(2)-r1); rL=abs(CI(1)-r1);
% % errorbar(r2, (ybL+ybR)./2+[0 0], [0 0], [0 0], [rU rL], [rL rU], 'ok-');
% % hold on
% %
% % ylabel('Vertical offset (arcmin)');
% % %axv=axis; axis([axv(1:2) axv(1:2)])
% % %add CSFand sinewave fit
% %
% % yyaxis right
% % %colororder({'b','m'})
% % plot(x, y, [drcn 'r']); hold on; plot(y11, 'r-')
% % ax=gca; ax.YColor=[1 0 0];
% % ylabel('Contrast Sensitivity')
% % %colororder({'m'})
% %
% % xlabel('Horizontal offset (arcmin)')
% % title(ttl)
% %
% % yyaxis left
% % axv=axis; axis([axv(1:2) axv(1:2)])
% %
% % legend off
%
%
%
%
%
%
%
% % %210613 combined TCA CSF & CRM plot! plotting in pixel units!
% % c0=0.00384; %deg/pixels
% % c1=1./(c0.*60);
% %
% % %CSF
% % load('S10007Right_CSF_ACL1_2106091449.mat');
% % h00=h0; h11=h1;
% % load('S10007Right_CSF_ACL1_2106091500.mat');
% % h0=[h0 h00]; h1=[h11 h1];
% % a0=0; [x y]=psf_CSF(h0, h1, g0(2), g1+a0, 0);
% %
% %
% % %chromostereopsis
% % load('S10007B_CNT_ACL1_2106091417BEST.mat'); [rslt CI]=psf_CNT(y1, y2);
% %
% %
% % %%Left eye TCA
% % LT='S10007Left_TCA_ACL1_2106091512.mat'; load(LT)
% % yx0=z1; sd=z2;
% %
% % %right eye TCA
% % RT='S10007Right_TCA_ACL1_2106091435.mat'; load(RT)
% % yx0(:,3:4)=z1(:,3:4); sd(:,3:4)=z2(:,3:4);
% %
% % yx=-1.*yx0;
% %
% % %add green blue colors
% % r=2; c=4; xgR = yx(r,c); hgR = sd(r,c);
% % r=2; c=2; xgL = yx(r,c); hgL = sd(r,c);
% %
% % r=3; c=4; xbR = yx(r,c); hbR = sd(r,c);
% % r=3; c=2; xbL = yx(r,c); hbL = sd(r,c);
% %
% % r=2; c=3; ygR = yx(r,c); vgR = sd(r,c);
% % r=2; c=1; ygL = yx(r,c); vgL = sd(r,c);
% %
% % r=3; c=3; ybR = yx(r,c); vbR = sd(r,c);
% % r=3; c=1; ybL = yx(r,c); vbL = sd(r,c);
% %
% % errorbar(xgR, ygR, vgR, vgR, hgR, hgR, '>g');
% % hold on
% % errorbar(xbR, ybR, vbR, vbR, hbR, hbR, '>b');
% % hold on
% % errorbar(xgL, ygL, vgL, vgL, hgL, hgL, '<g');
% % hold on
% % errorbar(xbL, ybL, vbL, vbL, hbL, hbL, '<b');
% % hold on
% %
% %
% %
% % %chromostereopsis CNT analysis
% % r0=(xbL+xbR)./2; r1=rslt(1); r2=[-r1 +r1]+r0;
% % rU=abs(CI(2)-r1); rL=abs(CI(1)-r1);
% % errorbar(r2, (ybL+ybR)./2+[0 0], [0 0], [0 0], [rU rL], [rL rU], 'ok-');
% % hold on
% %
% % %add CSFand sinewave fit
% % yyaxis right
% % plot(x.*c1, y)
% %
% %
% %
% %
% %
% % %fo=fitoptions('Method','NonlinearLeastSquares','StartPoint', [max(t0)-min(t0) 1/3 pi mean(t0)]);
% % %ft=fittype('a*sinpi(b*x+b)+d', 'options', fo);
% % ft=fittype('a*sinpi(b*x+c)+d');
% % %
% % % % y=fit(x', t0', ft, 'StartPoint', [max(t0)-min(t0) 1/3 pi mean(t0)]);
% %  a0=max(y)-min(t0);
% % % b0=abs(x(find(t0==max(t0)))-x(find(t0==min(t0))))
% % %
% %  y1=fit(c1.*x', y', ft); %, 'StartPoint', [max(t0)-min(t0) abs(x(find(t0==max(t0)))-x(find(t0==min(t0)))) 2 0.3]);
% % hold on; plot(y1)
%
%
% %cls; x0=[-1:0.01:1]; y0=sinpi(2.*x0+1); plot(x0, y0);
%
% % %add green blue colors
% % xg = [yx(2,2)' yx(2,4)']; xng = [sd(2,2)' sd(2,4)'];
% % xb = [yx(3,2)' yx(3,4)']; xnb = [sd(3,2)' sd(3,4)'];
% %
% % yg= [yx(2,1)' yx(2,3)']; yng = [sd(2,1)' sd(2,3)'];
% % yb= [yx(3,1)' yx(3,3)']; ynb = [sd(3,1)' sd(3,3)'];
% %
% % errorbar(xg,yg,yng,yng,xng,xng,'og')
% % hold on
% % errorbar(xb,yb,ynb,ynb,xnb,xnb,'ob')
%
% %plot errorabrs
% % x = [yx(:,2)' yx(:,4)'];
% % y = [yx(:,1)' yx(:,3)'];
% % yneg = [sd(:,1)' sd(:,3)'];
% % ypos = yneg;
% % xneg = [sd(:,2)' sd(:,4)'];
% % xpos = xneg;
% % errorbar(x,y,yneg,ypos,xneg,xpos,'o')
%
%
%
% % x = 1:10:100;
% % y = [20 30 45 40 60 65 80 75 95 90];
% % yneg = [1 3 5 3 5 3 6 4 3 3];
% % ypos = [2 5 3 5 2 5 2 2 5 5];
% % xneg = [1 3 5 3 5 3 6 4 3 3];
% % xpos = [2 5 3 5 2 5 2 2 5 5];
% % errorbar(x,y,yneg,ypos,xneg,xpos,'o')
%
%
%
%
