%210628 combine multiple sets/experiments

%AJR
cls
S0=["S10003Right_CSF_ACL0_2106251435.mat",...
    "S10003Right_CSF_ACL0_2106291600.mat",...
    "S10003Right_CSF_ACL0_2107091108",...
   ];

S1=["S10003Right_CSF_ACL1_2106251411.mat",...
    "S10003Right_CSF_ACL1_2106291651.mat",...
    "S10003Right_CSF_ACL1_2107091148.mat",...
];

%MSB
cls
S0=["S10004Left_CSF_ACL0_2106221511.mat",...
    "S10004Left_CSF_ACL0_2106231422.mat",...
    "S10004Left_CSF_ACL0_2106281135.mat",...
    "S10004Left_CSF_ACL0_2106300947.mat",...
   ];

S1=["S10004Left_CSF_ACL1_2106211606_correct.mat",...
    "S10004Left_CSF_ACL1_2106241508.mat",...
    "S10004Left_CSF_ACL1_2106250829.mat",...
];


%NHI
cls
S0=["S10007Right_CSF_ACL0_2107081310.mat",...   %S10007Right_CSF_ACL0_2107081310

    ];

S1=["S10007Right_CSF_ACL1_2107081540.mat"... %S10007Right_CSF_ACL1_2107081540

    ];

x0=[]; y0=[]; C0=[]; v0=[] 
for k0=1:length(S0)
load(S0(k0)); h1=round(1000.*h1)./1000;
[x y C]=psf_CSF2(h0, h1, g0(2), g1, 0);
x0=[x0 x-rb0(k0)]; y0=[y0 y]; C0=[C0; C];
v0=[v0 k0.*ones(1, length(x))];

end

[x00 i0]=sort(x0); y0=y0(i0); C0=C0(i0,:); F0=S0(v0(i0));
y00=fit_CSF0(x00,y0); %title


x1=[]; y1=[]; C1=[]; v1=[];
for k0=1:length(S1)
load(S1(k0)); h1=round(1000.*h1)./1000;
[x y C]=psf_CSF2(h0, h1, g0(2), g1, 0);
x1=[x1 x-rb1(k0)]; y1=[y1 y]; C1=[C1; C];
v1=[v1 k0.*ones(1, length(x))];
end
[x11 i1]=sort(x1); y1=y1(i1); C1=C1(i1,:); F1=S1(v1(i1));
y11=fit_CSF0(x11,y1); %title

%C0(C0<0)=0; C1(C1<0)=0
%figure; plot(x0,y0, '>r'); hold on; plot(y00, '--r'); hold off
%hold on; plot(x1,y1, '>r','MarkerFaceColor','red'); hold on; plot(y11, 'r'); hold off
cls; ec0=errorbar(x00, y0, y0-C0(:,1)', C0(:,2)'-y0, [drc 'r']); ec0.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', F0); hold on; plot(y00, 'r--'); %hold off
hold on; ec1=errorbar(x11,y1, y1-C1(:,1)', C1(:,2)'-y1, [drc 'r'],'MarkerFaceColor','red'); ec1.DataTipTemplate.DataTipRows(end+1)=dataTipTextRow('fnmTCA', F1); hold on; plot(y11, 'r'); hold off

legend off
lbl('TCA Corrected Phase shift (arcmin)', 'Contrast Thrshold', ttl)% 





% %210624 combine multiple sets/experiments
% %MSB
% %load('S10004Left_CSF_ACL0_2106071407.mat');
% %load('S10004Left_CSF_ACL0_2106151140.mat');
% % 20% contrast mark
% cls
% S0=["S10004Left_CSF_ACL0_2106221511.mat",...
%     "S10004Left_CSF_ACL0_2106231422.mat",...
%      "S10004Left_CSF_ACL0_2106281135.mat",...
%    ];
% 
% x0=[]; y0=[]; C0=[];
% for k0=1:length(S0)
% load(S0(k0))
% [x y C]=psf_CSF1(h0, h1, g0(2), g1, 0);
% x0=[x0 x-rb0(k0)]; y0=[y0 y]; C0=[C0; C];
% end
% [x00 i0]=sort(x0); y0=y0(i0); C0=C0(i0,:)
% y00=fit_CSF0(x00,y0); %title
% 
% %load('S10004Left_CSF_ACL1_2106071435.mat');
% %load('S10004Left_CSF_ACL1_2106141218.mat');
% %20
% S1=["S10004Left_CSF_ACL1_2106211606_correct.mat",...
%     "S10004Left_CSF_ACL1_2106241508.mat",...
%     "S10004Left_CSF_ACL1_2106250829.mat",...
% ];
% x1=[]; y1=[]; C1=[];
% for k0=1:length(S1)
% load(S1(k0))
% [x y C]=psf_CSF1(h0, h1, g0(2), g1, 0);
% x1=[x1 x-rb1(k0)]; y1=[y1 y]; C1=[C1; C];
% end
% [x11 i1]=sort(x1); y1=y1(i1); C1=C1(i1,:)
% y11=fit_CSF0(x11,y1); %title
% 
% %C0(C0<0)=0; C1(C1<0)=0
% %figure; plot(x0,y0, '>r'); hold on; plot(y00, '--r'); hold off
% %hold on; plot(x1,y1, '>r','MarkerFaceColor','red'); hold on; plot(y11, 'r'); hold off
% cls; errorbar(x00, y0, y0-C0(:,1)', C0(:,2)'-y0, [drc 'r']); hold on; plot(y00, 'r--'); %hold off
% hold on; errorbar(x11,y1, y1-C1(:,1)', C1(:,2)'-y1, [drc 'r'],'MarkerFaceColor','red'); hold on; plot(y11, 'r'); hold off
% 
% legend off
% lbl('TCA Corrected Phase shift (arcmin)', 'Contrast Thrshold', ['MSB210624'])% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%JOL ACL0
% load('S10005Right_CSF_ACL0_2106081304.mat')
% a0=0; a9=psf_CSF(h0, h1, g0(2), g1+a0, 0);
% 
% %%JOL ACL1
% load('S10005Right_CSF_ACL1_2106081507.mat')
% a0=0; a9=psf_CSF(h0, h1, g0(2), g1+a0, 0);
% 
% 
% 
% %%NHI ACL0
% 
% load('S10007Right_CSF_ACL0_2106091301.mat');
% h00=h0; h11=h1;
% load('S10007Right_CSF_ACL0_2106091320.mat');
% h0=[h0 h00]; h1=[h11 h1]; 
% a0=0; a9=psf_CSF(h0, h1, g0(2), g1+a0, 0);
% 
% %%NHI ACL1
% 
% load('S10007Right_CSF_ACL1_2106091449.mat');
% h00=h0; h11=h1;
% load('S10007Right_CSF_ACL1_2106091500.mat');
% h0=[h0 h00]; h1=[h11 h1];
% a0=0; a9=psf_CSF(h0, h1, g0(2), g1+a0, 0);
% 
% 
% %AJR ACL0
% load S10003Right_CSF_ACL0_2106111552.mat
% 
% %AJR ACL1
% S10003Right_CSF_ACL1_2106111531
% 
% 
% 
% 
% %AJR
% load('S10007Right_CSF_ACL0_2106161505.mat');
% [x0 y0 CI]=psf_CSF0(h0, h1, g0(2), g1-yx0(3,2)+3, 0);
% y00=fit_CSF0(x0,y0);
% 
% 
% load('S10003Right_CSF_ACL1_2106181403.mat');
% [x1 y1 CI]=psf_CSF0(h0, round(1000.*h1)./1000, g0(2), g1, 0);
% y11=fit_CSF0(x1-z1(3,2)./c1, y1);
% 
% 
% 
% 
% %MSB
% %load('S10004Left_CSF_ACL0_2106071407.mat');
% %load('S10004Left_CSF_ACL0_2106151140.mat');
% load('S10004Left_CSF_ACL0_2106221511.mat');
% load('S10004Left_CSF_ACL0_2106231422.mat');
% 
% 
% [x0 y0 C0]=psf_CSF0(h0, h1, g0(2), g1, 0);
% y00=fit_CSF0(x0-rb0,y0); %title
% %
% %load('S10004Left_CSF_ACL1_2106071435.mat');
% %load('S10004Left_CSF_ACL1_2106141218.mat');
% %20
% load('S10004Left_CSF_ACL1_2106211606_correct.mat');
% 
% [x1 y1 C1]=psf_CSF0(h0, round(1000.*h1)./1000, g0(2), g1, 0);
% y11=fit_CSF0(x1-rb1, y1);
% 
% %figure; plot(x0,y0, '>r'); hold on; plot(y00, '--r'); hold off
% %hold on; plot(x1,y1, '>r','MarkerFaceColor','red'); hold on; plot(y11, 'r'); hold off
% errorbar(x0-rb0, y0, y0-C0(:,1)', C0(:,2)'-y0, [drc 'r']); hold on; plot(y00, 'r'); %hold off
% hold on; errorbar(x1-rb1,y1, y1-C1(:,1)', C1(:,2)'-y1, [drc 'r'],'MarkerFaceColor','red'); hold on; plot(y11, 'r'); hold off
% 
% legend off
% lbl('TCA Corrected Phase shift (arcmin)', 'Contrast sensitivity', ['MSB' n2s(tme)])
