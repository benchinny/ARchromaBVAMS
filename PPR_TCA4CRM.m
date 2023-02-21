%220304 TCA figure for paper with multiple  based on CVO21_TCA based on fgr_TCA_CSF
clr
CRMcnd=1
c0=0.00384;  c1=1./(c0.*60);
drc='>'; ttl=['AJR210804']
%% AJR
%20% contrast mark
AJR0R=["S10003Right_TCA_ACL0_2106251423.mat",...   %S10003Right_CSF_ACL0_2106251435
    "S10003Right_TCA_ACL0_2106291545.mat",...   %S10003Right_CSF_ACL0_2106291600
    "S10003Right_TCA_ACL0_2107091055.mat",...       %S10003Right_CSF_ACL0_2107091108
    "S10003Right_TCA_ACL0_2107131556.mat",...
    "S10003Right_TCA_ACL0_2107141452.mat",...
    "S10003Right_TCA_ACL0_2107211557.mat",...
    "S10003_TCA_RightACL0_2105211001.mat",...   %load('S10003_CNT_Stereo_ACL0_2105211009.mat'); load('S10003_CNT_Stereo_ACL0_2105211016.mat');
    ];

AJR0L="S10003_TCA_LeftACL0_2105210952.mat";

AJR1R=["S10003Right_TCA_ACL1_2106251330.mat",... %S10003Right_CSF_ACL1_2106251411.ma
    "S10003Right_TCA_ACL1_2106291622.mat",... %S10003Right_CSF_ACL1_2106291651
    "S10003Right_TCA_ACL1_2107091135.mat",... %S10003Right_CSF_ACL1_2107091148
    "S10003Right_TCA_ACL1_2107131515.mat",...
    "S10003Right_TCA_ACL1_2107141543.mat",...
    "S10003Right_TCA_ACL1_2107211526.mat",...
    "S10003_TCA_RightACL1_2105211056.mat",...    %load('S10003_CNT_Stereo_ACL1_2105211116.mat'); load('S10003_CNT_Stereo_ACL1_2105211122.mat'); 
     ];
AJR1L="S10003_TCA_LeftACL1_2105211107.mat";


%% MSB
%clr;
c0=0.00384;  c1=1./(c0.*60);
drc='<'; ttl=['MSB210910']
%MSB ACL0

MSB0R="S10004Right_TCA_ACL0_2106151047.mat";

%20% contrast mark
MSB0L=["S10004Left_TCA_ACL0_2106221413.mat",...   %S10004Left_CSF_ACL0_2106221511
    "S10004Left_TCA_ACL0_2106231318.mat",...   %S10004Left_CSF_ACL0_2106231422 
    "S10004Left_TCA_ACL0_2106281140.mat",...   %S10004Left_CSF_ACL0_2106281135
    "S10004Left_TCA_ACL0_2106300934.mat",...   %S10004Left_CSF_ACL0_2106300947
    "S10004Left_TCA_ACL0_2107131353.mat",...
    "S10004Left_TCA_ACL0_2107141233.mat",...
    "S10004Left_TCA_ACL0_2109101558.mat",...
    "S10004Left_TCA_ACL0_2106151053.mat",... %load('S10004B_CNT_ACL0_2106151108.mat'); load('S10004B_CNT_ACL0_2106151118.mat'); 
    ];


MSB1R="S10004Right_TCA_ACL1_2106141240.mat"; 

MSB1L=["S10004Left_TCA_ACL1_2106211536.mat"... %S10004Left_CSF_ACL1_2106211606_correct"]
    "S10004Left_TCA_ACL1_2106241432.mat",... %S10004Left_CSF_ACL1_2106241508.ma
    "S10004Left_TCA_ACL1_2106250812.mat",... %S10004Left_CSF_ACL1_2106250829.mat
    "S10004Left_TCA_ACL1_2107140948.mat",...
    "S10004Left_TCA_ACL1_2107141349.mat",...
    "S10004Left_TCA_ACL1_2109101521.mat",...
    "S10004Left_TCA_ACL1_2106141204.mat",...  %load('S10004B_CNT_ACL1_2106141148.mat'); load('S10004B_CNT_ACL1_2106141155.mat');
    ];


%% NHI
%clr
c0=0.00384;  c1=1./(c0.*60);
drc='>'; ttl=['NHI210722']

%20% contrast mark
NHI0R=["S10007Right_TCA_ACL0_2107081240.mat",...   %S10007Right_CSF_ACL0_2107081310
    "S10007Right_TCA_ACL0_2107151622.mat",...   %S10007Right_CSF_ACL0_2107151702
    "S10007Right_TCA_ACL0_2107211231.mat",...   %S10007Right_CSF_ACL0_2107211213
    "S10007Right_TCA_ACL0_2107221536.mat",...
    "S10007Right_TCA_ACL0_2106091102.mat",...   %load('S10007B_CNT_ACL0_2106091232_Best.mat'); 
    ];


NHI0L="S10007Left_TCA_ACL0_2106091116.mat";

NHI1R=["S10007Right_TCA_ACL1_2107081501.mat",... %S10007Right_CSF_ACL1_2107081540
    "S10007Right_TCA_ACL1_2107151512.mat",... %S10007Right_CSF_ACL1_2107151427
    "S10007Right_TCA_ACL1_2107211356.mat",... %S10007Right_CSF_ACL1_2107211501
    "S10007Right_TCA_ACL1_2107221604.mat",...
    "S10007Right_TCA_ACL1_2106091435.mat",... %load('S10007B_CNT_ACL1_2106091417BEST.mat'); 
    ];

NHI1L="S10007Left_TCA_ACL1_2106091512.mat";

%MaxGreen
MG0L="S1001V5Left_TCA_ACL0_2203021557.mat";
MG0R="S1001V5Right_TCA_ACL0_2203021552.mat";
MG1L="S1001V5Left_TCA_ACL1_2203021627.mat";
MG1R="S1001V5Right_TCA_ACL1_2203021621.mat";


%FabioFeroldi
FF0L="S1001V5Left_TCA_ACL0_2202251548.mat";
FF0R="S1001V5Right_TCA_ACL0_2202251552.mat";
FF1L="S1001V5Left_TCA_ACL1_2202251615.mat";
FF1R="S1001V5Right_TCA_ACL1_2202251613.mat";

%BenBackus
BB0L="S1001V5Left_TCA_ACL0_2202161634.mat";
BB0R="S1001V5Right_TCA_ACL0_2202161612.mat";
BB1L="S1001V5Left_TCA_ACL1_2202161719.mat";
BB1R="S1001V5Right_TCA_ACL1_2202161713.mat";

%HaniFarid
HF0L="S1001V5Left_TCA_ACL0_2203011648.mat";
HF0R="S1001V5Right_TCA_ACL0_2203011644.mat";
HF1L="S1001V5Left_TCA_ACL1_2203011617.mat";
HF1R="S1001V5Right_TCA_ACL1_2203011612.mat";


if CRMcnd==1; 
    NHI0R=NHI0R(end); 
    NHI1R=NHI1R(end); 
    MSB0L=MSB0L(end); 
    MSB1L=MSB1L(end);
    AJR0R=AJR0R(end); 
    AJR1R=AJR1R(end);
end

% T1=[AJR1R MSB1R NHI1R]; C1=[ones(1, length(AJR1R)) 2.*ones(1, length(MSB1R)) 3.*ones(1, length(NHI1R))];
% T0=[AJR0R MSB0R NHI0R]; C0=[ones(1, length(AJR0R)) 2.*ones(1, length(MSB0R)) 3.*ones(1, length(NHI0R))];
% 
% T1=[AJR1L MSB1L NHI1L]; C1=[ones(1, length(AJR1L)) 2.*ones(1, length(MSB1L)) 3.*ones(1, length(NHI1L))];
% T0=[AJR0L MSB0L NHI0L]; C0=[ones(1, length(AJR0L)) 2.*ones(1, length(MSB0L)) 3.*ones(1, length(NHI0L))];


T1=[AJR1R MSB1R NHI1R HF1R BB1R FF1R MG1R]; C1=[ones(1, length(AJR1R)) 2.*ones(1, length(MSB1R)) 3.*ones(1, length(NHI1R)) 4.*ones(1, length(HF1R)) 5.*ones(1, length(BB1R)) 6.*ones(1, length(FF1R)) 7.*ones(1, length(MG1R))];
T0=[AJR0R MSB0R NHI0R HF0R BB0R FF0R MG0R]; C0=[ones(1, length(AJR0R)) 2.*ones(1, length(MSB0R)) 3.*ones(1, length(NHI0R)) 4.*ones(1, length(HF0R)) 5.*ones(1, length(BB0R)) 6.*ones(1, length(FF0R)) 7.*ones(1, length(MG0R))];

T1=[AJR1L MSB1L NHI1L HF1L BB1L FF1L MG1L]; C1=[ones(1, length(AJR1L)) 2.*ones(1, length(MSB1L)) 3.*ones(1, length(NHI1L)) 4.*ones(1, length(HF1L)) 5.*ones(1, length(BB1L)) 6.*ones(1, length(FF1L)) 7.*ones(1, length(MG1L))];
T0=[AJR0L MSB0L NHI0L HF0L BB0L FF0L MG0L]; C0=[ones(1, length(AJR0L)) 2.*ones(1, length(MSB0L)) 3.*ones(1, length(NHI0L)) 4.*ones(1, length(HF0L)) 5.*ones(1, length(BB0L)) 6.*ones(1, length(FF0L)) 7.*ones(1, length(MG0L))];

xg0=[]; yg0=[]; xg1=[]; yg1=[];
xb0=[]; yb0=[]; xb1=[]; yb1=[];
b0=[]; g0=[];

b1=[]; g1=[]; c1=[];
for k0=1:length(T1)
    clear bxy v0 TCAp; load(T1(k0)); if exist('bxy')==0; bxy=TCAp.bxy; v0=TCAp.v0; end
%     b1=[b1; bxy(v0==1, :) - repmat(TCAp.sysTCA(3,:), [size(bxy(v0==1, :), 1) 2])]; 
%     g1=[g1 ;bxy(v0==2,:)  - repmat(TCAp.sysTCA(2,:), [size(bxy(v0==2, :), 1) 2])]; 
    b1=[b1; bxy(v0==1, :)]; 
    g1=[g1 ;bxy(v0==2,:)];     
    
    %xg1=[xg1; bxy]
  c1=[c1; C1(k0).*ones(size(bxy(v0==1, :), 1),1)]
end


b0=[]; g0=[]; c0=[];
for k0=1:length(T0)
    clear bxy v0 TCAp; load(T0(k0)); if exist('bxy')==0; bxy=TCAp.bxy; v0=TCAp.v0; end
%     b0=[b0; bxy(v0==1, :) - repmat(TCAp.sysTCA(3,:), [size(bxy(v0==1, :), 1) 2])]; 
%     g0=[g0 ;bxy(v0==2,:)  - repmat(TCAp.sysTCA(2,:), [size(bxy(v0==2, :), 1) 2])]; 
    b0=[b0; bxy(v0==1, :)]; 
    g0=[g0 ;bxy(v0==2,:)]; 
    %xg1=[xg1; bxy]
    c0=[c0; C0(k0).*ones(size(bxy(v0==1, :), 1),1)]
end

c00=0.00384;  c11=1./(c00.*60);
for k0=1:7
    B0(k0,:)=mean(b0(c0==k0,1:2)); B00(k0,:)=std(b0(c0==k0,1:2), 0, 1)%./sqrt(sum(c0==k0)); %std(bxy(v0==1,:),0,1)
    B1(k0,:)=mean(b1(c1==k0,1:2)); B11(k0,:)=std(b1(c1==k0,1:2), 0, 1)%./sqrt(sum(c1==k0));
    
    G0(k0,:)=mean(g0(c0==k0,1:2)); G00(k0,:)=std(g0(c0==k0,1:2), 0, 1)%./sqrt(sum(c0==k0));
    G1(k0,:)=mean(g1(c1==k0,1:2)); G11(k0,:)=std(g1(c1==k0,1:2), 0, 1)%./sqrt(sum(c1==k0));
      
end
mrkSz=12
mrk='os^dphv'
for k0=1:7
        eb0=errorbar(-1.*B0(k0,2)./c11, -1.*B0(k0,1)./c11, B00(k0,1)./c11, B00(k0,1)./c11, B00(k0,2)./c11, B00(k0,2)./c11, mrk(k0), 'color', 'b', 'MarkerSize', mrkSz)%'MarkerEdgeColor', 'b'); %, 'MarkerFaceColor', C3(C0(k0),:));% [mrk C3(C0(k0),:)]);% 'b']); %, 'Color', [0 0 1]./cf);
    hold on
        eb1=errorbar(-1.*B1(k0,2)./c11, -1.*B1(k0,1)./c11, B11(k0,1)./c11, B11(k0,1)./c11, B11(k0,2)./c11, B11(k0,2)./c11, mrk(k0), 'color', 'b', 'MarkerSize', mrkSz, 'MarkerFaceColor', 'b')%'MarkerEdgeColor', 'b'); %, 'MarkerFaceColor', C3(C0(k0),:));% [mrk C3(C0(k0),:)]);% 'b']); %, 'Color', [0 0 1]./cf);
    hold on
        eg0=errorbar(-1.*G0(k0,2)./c11, -1.*G0(k0,1)./c11, G00(k0,1)./c11, G00(k0,1)./c11, G00(k0,2)./c11, G00(k0,2)./c11, mrk(k0), 'color', 'g', 'MarkerSize', mrkSz)%'MarkerEdgeColor', 'b'); %, 'MarkerFaceColor', C3(C0(k0),:));% [mrk C3(C0(k0),:)]);% 'b']); %, 'Color', [0 0 1]./cf);
    hold on
        eg1=errorbar(-1.*G1(k0,2)./c11, -1.*G1(k0,1)./c11, G11(k0,1)./c11, G11(k0,1)./c11, G11(k0,2)./c11, G11(k0,2)./c11, mrk(k0), 'color', 'g', 'MarkerSize', mrkSz, 'MarkerFaceColor', 'g')%'MarkerEdgeColor', 'b'); %, 'MarkerFaceColor', C3(C0(k0),:));% [mrk C3(C0(k0),:)]);% 'b']); %, 'Color', [0 0 1]./cf);
    hold on
end

% axis([-2 5 -3 4]); %right eye standard deviation&error
% axis([-4.5 2.5 -3 4]) %Left eye standard deviation
% axis([-4.5 5 -3 4]); %right&left eye rectangular standard deviation&error

xlabel('Horizontal TCA (arcmin)')
ylabel('Vertical TCA (arcmin)') %, ttl)
axis square
axis tight
axis equal
axis image
axis normal
axis vis3d




% 
% 
% %220211 TCA figure for paper based on CVO21_TCA based on fgr_TCA_CSF
% clr
% c0=0.00384;  c1=1./(c0.*60);
% drc='>'; ttl=['AJR210804']
% %% AJR
% %20% contrast mark
% AJR0=["S10003Right_TCA_ACL0_2106251423.mat",...   %S10003Right_CSF_ACL0_2106251435
%     "S10003Right_TCA_ACL0_2106291545.mat",...   %S10003Right_CSF_ACL0_2106291600
%     "S10003Right_TCA_ACL0_2107091055.mat",...       %S10003Right_CSF_ACL0_2107091108
%     "S10003Right_TCA_ACL0_2107131556.mat",...
%     "S10003Right_TCA_ACL0_2107141452.mat",...
%     "S10003Right_TCA_ACL0_2107211557.mat",...
%     ];
% 
% AJR1=["S10003Right_TCA_ACL1_2106251330.mat",... %S10003Right_CSF_ACL1_2106251411.ma
%     "S10003Right_TCA_ACL1_2106291622.mat",... %S10003Right_CSF_ACL1_2106291651
%     "S10003Right_TCA_ACL1_2107091135.mat",... %S10003Right_CSF_ACL1_2107091148
%     "S10003Right_TCA_ACL1_2107131515.mat",...
%     "S10003Right_TCA_ACL1_2107141543.mat",...
%     "S10003Right_TCA_ACL1_2107211526.mat",...
%     ];
% 
% %% MSB
% %clr;
% c0=0.00384;  c1=1./(c0.*60);
% drc='<'; ttl=['MSB210910']
% %MSB ACL0
% 
% %20% contrast mark
% MSB0=["S10004Left_TCA_ACL0_2106221413.mat",...   %S10004Left_CSF_ACL0_2106221511
%     "S10004Left_TCA_ACL0_2106231318.mat",...   %S10004Left_CSF_ACL0_2106231422 
%     "S10004Left_TCA_ACL0_2106281140.mat",...   %S10004Left_CSF_ACL0_2106281135
%     "S10004Left_TCA_ACL0_2106300934.mat",...   %S10004Left_CSF_ACL0_2106300947
%     "S10004Left_TCA_ACL0_2107131353.mat",...
%     "S10004Left_TCA_ACL0_2107141233.mat",...
%     "S10004Left_TCA_ACL0_2109101558.mat",...
%     ];
% 
% 
% MSB1=["S10004Left_TCA_ACL1_2106211536.mat"... %S10004Left_CSF_ACL1_2106211606_correct"]
%     "S10004Left_TCA_ACL1_2106241432.mat",... %S10004Left_CSF_ACL1_2106241508.ma
%     "S10004Left_TCA_ACL1_2106250812.mat",... %S10004Left_CSF_ACL1_2106250829.mat
%     "S10004Left_TCA_ACL1_2107140948.mat",...
%     "S10004Left_TCA_ACL1_2107141349.mat",...
%     "S10004Left_TCA_ACL1_2109101521.mat",...
%     ];
% 
% 
% %% NHI
% %clr
% c0=0.00384;  c1=1./(c0.*60);
% drc='>'; ttl=['NHI210722']
% 
% %20% contrast mark
% NHI0=["S10007Right_TCA_ACL0_2107081240.mat",...   %S10007Right_CSF_ACL0_2107081310
%     "S10007Right_TCA_ACL0_2107151622.mat",...   %S10007Right_CSF_ACL0_2107151702
%     "S10007Right_TCA_ACL0_2107211231.mat",...   %S10007Right_CSF_ACL0_2107211213
%     "S10007Right_TCA_ACL0_2107221536.mat",...
%     ];
% 
% 
% NHI1=["S10007Right_TCA_ACL1_2107081501.mat",... %S10007Right_CSF_ACL1_2107081540
%     "S10007Right_TCA_ACL1_2107151512.mat",... %S10007Right_CSF_ACL1_2107151427
%     "S10007Right_TCA_ACL1_2107211356.mat",... %S10007Right_CSF_ACL1_2107211501
%     "S10007Right_TCA_ACL1_2107221604.mat",...
%     ];
% 
% T1=[AJR1 MSB1 NHI1]; C1=[ones(1, length(AJR1)) 2.*ones(1, length(MSB1)) 3.*ones(1, length(NHI1))];
% T0=[AJR0 MSB0 NHI0]; C0=[ones(1, length(AJR0)) 2.*ones(1, length(MSB0)) 3.*ones(1, length(NHI0))];
% 
% 
% xg0=[]; yg0=[]; xg1=[]; yg1=[];
% xb0=[]; yb0=[]; xb1=[]; yb1=[];
% b0=[]; g0=[];
% 
% b1=[]; g1=[]; c1=[];
% for k0=1:length(T1)
%     load(T1(k0)); 
%     b1=[b1; bxy(v0==1, :) - repmat(TCAp.sysTCA(3,:), [size(bxy(v0==1, :), 1) 2])]; 
%     g1=[g1 ;bxy(v0==2,:)  - repmat(TCAp.sysTCA(2,:), [size(bxy(v0==2, :), 1) 2])]; 
%     %xg1=[xg1; bxy]
%   c1=[c1; C1(k0).*ones(size(bxy(v0==1, :), 1),1)]
% end
% 
% 
% b0=[]; g0=[]; c0=[];
% for k0=1:length(T0)
%     load(T0(k0)); 
%     b0=[b0; bxy(v0==1, :) - repmat(TCAp.sysTCA(3,:), [size(bxy(v0==1, :), 1) 2])]; 
%     g0=[g0 ;bxy(v0==2,:)  - repmat(TCAp.sysTCA(2,:), [size(bxy(v0==2, :), 1) 2])]; 
%     %xg1=[xg1; bxy]
%     c0=[c0; C0(k0).*ones(size(bxy(v0==1, :), 1),1)]
% end
% 
% c00=0.00384;  c11=1./(c00.*60);
% for k0=1:3
%     B0(k0,:)=mean(b0(c0==k0,1:2)); B00(k0,:)=std(b0(c0==k0,1:2), 0, 1)%./sqrt(sum(c0==k0)); %std(bxy(v0==1,:),0,1)
%     B1(k0,:)=mean(b1(c1==k0,1:2)); B11(k0,:)=std(b1(c1==k0,1:2), 0, 1)%./sqrt(sum(c1==k0));
%     
%     G0(k0,:)=mean(g0(c0==k0,1:2)); G00(k0,:)=std(g0(c0==k0,1:2), 0, 1)%./sqrt(sum(c0==k0));
%     G1(k0,:)=mean(g1(c1==k0,1:2)); G11(k0,:)=std(g1(c1==k0,1:2), 0, 1)%./sqrt(sum(c1==k0));
%       
% end
% mrk='os^'
% for k0=1:3
%         eb0=errorbar(-1.*B0(k0,2)./c11, -1.*B0(k0,1)./c11, B00(k0,1)./c11, B00(k0,1)./c11, B00(k0,2)./c11, B00(k0,2)./c11, mrk(k0), 'color', 'b', 'MarkerSize', 10)%'MarkerEdgeColor', 'b'); %, 'MarkerFaceColor', C3(C0(k0),:));% [mrk C3(C0(k0),:)]);% 'b']); %, 'Color', [0 0 1]./cf);
%     hold on
%         eb1=errorbar(-1.*B1(k0,2)./c11, -1.*B1(k0,1)./c11, B11(k0,1)./c11, B11(k0,1)./c11, B11(k0,2)./c11, B11(k0,2)./c11, mrk(k0), 'color', 'b', 'MarkerSize', 10, 'MarkerFaceColor', 'b')%'MarkerEdgeColor', 'b'); %, 'MarkerFaceColor', C3(C0(k0),:));% [mrk C3(C0(k0),:)]);% 'b']); %, 'Color', [0 0 1]./cf);
%     hold on
%         eg0=errorbar(-1.*G0(k0,2)./c11, -1.*G0(k0,1)./c11, G00(k0,1)./c11, G00(k0,1)./c11, G00(k0,2)./c11, G00(k0,2)./c11, mrk(k0), 'color', 'g', 'MarkerSize', 10)%'MarkerEdgeColor', 'b'); %, 'MarkerFaceColor', C3(C0(k0),:));% [mrk C3(C0(k0),:)]);% 'b']); %, 'Color', [0 0 1]./cf);
%     hold on
%         eg1=errorbar(-1.*G1(k0,2)./c11, -1.*G1(k0,1)./c11, G11(k0,1)./c11, G11(k0,1)./c11, G11(k0,2)./c11, G11(k0,2)./c11, mrk(k0), 'color', 'g', 'MarkerSize', 10, 'MarkerFaceColor', 'g')%'MarkerEdgeColor', 'b'); %, 'MarkerFaceColor', C3(C0(k0),:));% [mrk C3(C0(k0),:)]);% 'b']); %, 'Color', [0 0 1]./cf);
%     hold on
% end
% 
% axis([-1.5 3 -1.5 3]) % common across subject axis
% axis([-0.6 2.5 -0.6 2.5]) % common across subject axis
% 
% xlabel('Horizontal TCA (arcmin)')
% ylabel('Vertical TCA (arcmin)') %, ttl)
% axis square





% save('TCA_AJR210804', 'T0', 'T1', 'ttl', 'drc',...
% 'xg0', 'hg0', 'xb0', 'hb0', 'yg0', 'vg0', 'yb0', 'vb0', 'yz022', 'yz021', 'yz032', 'yz031',...
% 'xg1', 'hg1', 'xb1', 'hb1', 'yg1', 'vg1', 'yb1', 'vb1', 'yz122', 'yz121', 'yz132', 'yz131');
% 


% %%210715 plot CSF
% 
% x0=[]; y0=[]; C0=[]; v0=[] 
% for k0=1:length(S0)
% load(S0(k0)); h1=round(1000.*h1)./1000;
% [x y C]=psf_CSF2(h0, h1, g0(2), g1, 0);
% x0=[x0 x-rb0(k0)]; y0=[y0 y]; C0=[C0; C];
% v0=[v0 k0.*ones(1, length(x))];
% 
% end
% 
% [x00 i0]=sort(x0); y0=y0(i0); C0=C0(i0,:); F0=S0(v0(i0));
% y00=fit_CSF0(x00,y0); %title
% 
% 
% x1=[]; y1=[]; C1=[]; v1=[];
% for k0=1:length(S1)
% load(S1(k0)); h1=round(1000.*h1)./1000;
% [x y C]=psf_CSF2(h0, h1, g0(2), g1, 0);
% x1=[x1 x-rb1(k0)]; y1=[y1 y]; C1=[C1; C];
% v1=[v1 k0.*ones(1, length(x))];
% end
% [x11 i1]=sort(x1); y1=y1(i1); C1=C1(i1,:); F1=S1(v1(i1));
% y11=fit_CSF0(x11,y1); %title
% 
% %C0(C0<0)=0; C1(C1<0)=0
% %figure; plot(x0,y0, '>r'); hold on; plot(y00, '--r'); hold off
% %hold on; plot(x1,y1, '>r','MarkerFaceColor','red'); hold on; plot(y11, 'r'); hold off
% cls; ec0=errorbar(x00, y0, y0-C0(:,1)', C0(:,2)'-y0, [drc 'r']); ec0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', F0); hold on; plot(y00, 'r--'); %hold off
% hold on; ec1=errorbar(x11,y1, y1-C1(:,1)', C1(:,2)'-y1, [drc 'r'],'MarkerFaceColor','red'); ec1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', F1); hold on; plot(y11, 'r'); hold off
% 
% legend off
% lbl('TCA Corrected Phase shift (arcmin)', 'Contrast Thrshold', ttl)% 
% 
% set(gca, 'YScale', 'log')

%save('CSF_AJR210804', 'drc', 'ttl',...
% 'rb0', 'x00', 'y00', 'y0', 'C0', 'F0', 'T0', 'S0',...
% 'rb1', 'x11', 'y11', 'y1', 'C1', 'F1', 'T1', 'S1')


% %210722 manage TCA and CSF in the same code 
% clr
% c0=0.00384;  c1=1./(c0.*60);
% drc='>'; ttl=['AJR210804']
% %% AJR
% %20% contrast mark
% T0=["S10003Right_TCA_ACL0_2106251423.mat",...   %S10003Right_CSF_ACL0_2106251435
%     "S10003Right_TCA_ACL0_2106291545.mat",...   %S10003Right_CSF_ACL0_2106291600
%     "S10003Right_TCA_ACL0_2107091055.mat",...       %S10003Right_CSF_ACL0_2107091108
%     "S10003Right_TCA_ACL0_2107131556.mat",...
%     "S10003Right_TCA_ACL0_2107141452.mat",...
%     "S10003Right_TCA_ACL0_2107211557.mat",...
%     ];
% 
% T0=T0([1 2 3])
% S0=["S10003Right_CSF_ACL0_2106251435.mat",...
%     "S10003Right_CSF_ACL0_2106291600.mat",...
%     "S10003Right_CSF_ACL0_2107091108",...
%    ];
% 
% T1=["S10003Right_TCA_ACL1_2106251330.mat",... %S10003Right_CSF_ACL1_2106251411.ma
%     "S10003Right_TCA_ACL1_2106291622.mat",... %S10003Right_CSF_ACL1_2106291651
%     "S10003Right_TCA_ACL1_2107091135.mat",... %S10003Right_CSF_ACL1_2107091148
%     "S10003Right_TCA_ACL1_2107131515.mat",...
%     "S10003Right_TCA_ACL1_2107141543.mat",...
%     "S10003Right_TCA_ACL1_2107211526.mat",...
%     ];
% 
% T1=T1([1 2 3]);
% S1=["S10003Right_CSF_ACL1_2106251411.mat",...
%     "S10003Right_CSF_ACL1_2106291651.mat",...
%     "S10003Right_CSF_ACL1_2107091148.mat",...
% ];
% 
% 
% 
% 
% %% MSB
% clr;
% c0=0.00384;  c1=1./(c0.*60);
% drc='<'; ttl=['MSB210910']
% %MSB ACL0
% 
% %20% contrast mark
% T0=["S10004Left_TCA_ACL0_2106221413.mat",...   %S10004Left_CSF_ACL0_2106221511
%     "S10004Left_TCA_ACL0_2106231318.mat",...   %S10004Left_CSF_ACL0_2106231422 
%     "S10004Left_TCA_ACL0_2106281140.mat",...   %S10004Left_CSF_ACL0_2106281135
%     "S10004Left_TCA_ACL0_2106300934.mat",...   %S10004Left_CSF_ACL0_2106300947
%     "S10004Left_TCA_ACL0_2107131353.mat",...
%     "S10004Left_TCA_ACL0_2107141233.mat",...
%     "S10004Left_TCA_ACL0_2109101558.mat",...
%     ];
% 
% T0=T0([1 2 4]); %T0([1 2 3 4]);
% S0=["S10004Left_CSF_ACL0_2106221511.mat",...
%     "S10004Left_CSF_ACL0_2106231422.mat",...
%     "S10004Left_CSF_ACL0_2106281135.mat",...
%     "S10004Left_CSF_ACL0_2106300947.mat",...
%    ];
% S0=S0([1 2 4]);
% 
% T1=["S10004Left_TCA_ACL1_2106211536.mat"... %S10004Left_CSF_ACL1_2106211606_correct"]
%     "S10004Left_TCA_ACL1_2106241432.mat",... %S10004Left_CSF_ACL1_2106241508.ma
%     "S10004Left_TCA_ACL1_2106250812.mat",... %S10004Left_CSF_ACL1_2106250829.mat
%     "S10004Left_TCA_ACL1_2107140948.mat",...
%     "S10004Left_TCA_ACL1_2107141349.mat",...
%     "S10004Left_TCA_ACL1_2109101521.mat",...
%     ];
% 
% T1=T1([1 2 3]);
% S1=["S10004Left_CSF_ACL1_2106211606_correct.mat",...
%     "S10004Left_CSF_ACL1_2106241508.mat",...
%     "S10004Left_CSF_ACL1_2106250829.mat",...
% ];
% 
% 
% 
% %% NHI
% clr
% c0=0.00384;  c1=1./(c0.*60);
% drc='>'; ttl=['NHI210722']
% 
% %20% contrast mark
% T0=["S10007Right_TCA_ACL0_2107081240.mat",...   %S10007Right_CSF_ACL0_2107081310
%     "S10007Right_TCA_ACL0_2107151622.mat",...   %S10007Right_CSF_ACL0_2107151702
%     "S10007Right_TCA_ACL0_2107211231.mat",...   %S10007Right_CSF_ACL0_2107211213
%     "S10007Right_TCA_ACL0_2107221536.mat",...
%     ];
% 
% T0=T0([1 2 3]);
% S0=["S10007Right_CSF_ACL0_2107081310.mat",...  
%     "S10007Right_CSF_ACL0_2107151702.mat",...
%     "S10007Right_CSF_ACL0_2107211213.mat",...
%     ];
% 
% T1=["S10007Right_TCA_ACL1_2107081501.mat",... %S10007Right_CSF_ACL1_2107081540
%     "S10007Right_TCA_ACL1_2107151512.mat",... %S10007Right_CSF_ACL1_2107151427
%     "S10007Right_TCA_ACL1_2107211356.mat",... %S10007Right_CSF_ACL1_2107211501
%     "S10007Right_TCA_ACL1_2107221604.mat",...
%     ];
% 
% T1=T1([1 2 3]);
% S1=["S10007Right_CSF_ACL1_2107081540.mat"... %S10007Right_CSF_ACL1_2107081540
%     "S10007Right_CSF_ACL1_2107151427.mat",...
%     "S10007Right_CSF_ACL1_2107211501.mat",...
%     ];
% 
% 
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
% 
% 
% 
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
% axis([-1.5 3 -1.5 3]) % common across subject axis
% lbl('Horizontal TCA (arcmin)', 'Vertical TCA (arcmin)', ttl)
% 
% 
% 
% %%210715 plot CSF
% 
% x0=[]; y0=[]; C0=[]; v0=[] 
% for k0=1:length(S0)
% load(S0(k0)); h1=round(1000.*h1)./1000;
% [x y C]=psf_CSF2(h0, h1, g0(2), g1, 0);
% x0=[x0 x-rb0(k0)]; y0=[y0 y]; C0=[C0; C];
% v0=[v0 k0.*ones(1, length(x))];
% 
% end
% 
% [x00 i0]=sort(x0); y0=y0(i0); C0=C0(i0,:); F0=S0(v0(i0));
% y00=fit_CSF0(x00,y0); %title
% 
% 
% x1=[]; y1=[]; C1=[]; v1=[];
% for k0=1:length(S1)
% load(S1(k0)); h1=round(1000.*h1)./1000;
% [x y C]=psf_CSF2(h0, h1, g0(2), g1, 0);
% x1=[x1 x-rb1(k0)]; y1=[y1 y]; C1=[C1; C];
% v1=[v1 k0.*ones(1, length(x))];
% end
% [x11 i1]=sort(x1); y1=y1(i1); C1=C1(i1,:); F1=S1(v1(i1));
% y11=fit_CSF0(x11,y1); %title
% 
% %C0(C0<0)=0; C1(C1<0)=0
% %figure; plot(x0,y0, '>r'); hold on; plot(y00, '--r'); hold off
% %hold on; plot(x1,y1, '>r','MarkerFaceColor','red'); hold on; plot(y11, 'r'); hold off
% cls; ec0=errorbar(x00, y0, y0-C0(:,1)', C0(:,2)'-y0, [drc 'r']); ec0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', F0); hold on; plot(y00, 'r--'); %hold off
% hold on; ec1=errorbar(x11,y1, y1-C1(:,1)', C1(:,2)'-y1, [drc 'r'],'MarkerFaceColor','red'); ec1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', F1); hold on; plot(y11, 'r'); hold off
% 
% legend off
% lbl('TCA Corrected Phase shift (arcmin)', 'Contrast Thrshold', ttl)% 
% 
% %set(gca, 'YScale', 'log')
% 
% 
% 
% 
% 
% 
% 
