%220508 oTCA accommodation images

clr
ms=10;
%wv=[1:13]+9; %JOL
wv=[1:13]+4; %210621 20%contrast

c0=0.00384; %deg/pixels
c1=1./(c0.*60);

b=2; s=5; %10; %8
L='E';
sz = [1080, 1080]; % size of screen
STK=b.^(wv./s);
c2=20.*STK./c1
STK00=round(5.*STK)./5;
20.*round(5.*STK)./(5.*c1)
ms=10; AFCim0=cell(ms, ms); AFCim1=AFCim0;
tic
        I0=imread('texture0_1080_newfill_malt.png'); I00=double(I0(:,:,1));
        I1=imread('texture1_1080_newfill_malt.png'); I11=double(I1(:,:,1));
%     img0=imread(im_path{1}); %% image to show
%     img1=imread(im_path{2}); %% image to show
    

%         i0=usz(o2i(b, w, s, L, k1, sz), ms);
        i1=usz(I11, ms)./255;
        i0=usz(I00, ms)./255;
        for r0=1:ms
            for c0=1:ms
            
                 %E10c(k0, k1, r0, c0)= {uint8(255.*dszf(circshift(i0, [r0-1 c0-1]),ms))};
                 AFCim0(r0, c0)= {uint8(255.*dszf(circshift(i0, [r0-1 c0-1]),ms))};
                 AFCim1(r0, c0)= {uint8(255.*dszf(circshift(i1, [r0-1 c0-1]),ms))};
%                 E10c(k0, r0, c0)= {uint8(255.*i6./mxa(i6))};

                disp([r0 c0]);
                
            
            end
        end
                %i4=usz(i0, ms); % i4=imgaussfilt(i4,3);


toc %60.43minutes 84.23minutes
% save('E_b3_p1_p13_o4_ms10_201123.mat', 'E10c', 'STK', '-v7.3');
%save('E_b2s4_p1_p13_o4_ms10_201130.mat', 'E10c', 'STK', '-v7.3');
%save('E_b2s10_p1_p13_o4_ms10_201207.mat', 'E10c', 'STK', '-v7.3');
%save('E_b2s8_p1_p13_o4_ms10_201207.mat', 'E10c', 'STK', '-v7.3'); %55minutes
%save('E_b2s10_p1_p13_o4_ms10_210316.mat', 'E10c', 'STK', '-v7.3'); %65minutes
%save('E_b2s6_p2_p14_o4_ms10_210318.mat', 'E10c', 'STK', '-v7.3'); %65minutes
%save('E_b2s2_p1_p11_o4_ms10_210319.mat', 'E10c', 'STK', '-v7.3'); %65minutes
%save('E_b2s5_p2_p14_o4_ms10_210320.mat', 'E10c', 'STK', '-v7.3'); %65minutes
%save('E_b2s4_p1_p13_o4_ms10_210415.mat', 'E10c', 'STK', '-v7.3');
% save('E_b2s5_p10_p22_o4_ms10_210608.mat', 'E10c', 'STK', 'STK00', '-v7.3'); %31minutes
save('E_b2s5_p5_p17_o4_ms10_210621.mat', 'E10c', 'STK', 'STK00', '-v7.3'); %31minutes
save('AFCim220510.mat', 'AFCim0', 'AFCim1', '-v7.3'); %31minutes




%220412
LCAp0=LCAp;
p0=[8               16                  17             0.9    1     1.4     -3       6];

powerR_min=opR(p0(6));  powerR_max=opR(p0(4)); 

powerL_min=opL(p0(6));  powerL_max=13.819067; 

% LCAp.Full.p3(:,2)=LCAp.Full.p3(:,2).*randn([3 1])
% 
% LCAp.Full.p2(:,2)=LCAp.Full.p2(:,2)+LCAp.Full.p3(:,2)

LCAp.Full.p3(:,1)=LCAp.Full.p3(:,1).*randn([3 1])

LCAp.Full.p2(:,1)=LCAp.Full.p2(:,1)+LCAp.Full.p3(:,1)

p2=LCAp.Full.p2

p3=LCAp.Full.p3

%%220113 script to code a cross
sz=[1080 1920];
i0=ones(sz);
s2=sz./2;
w=5;
i1=i0; i1(s2(1)-w+1:s2(1)+w, :)=0;
i1(:, s2(2)-w+1:s2(2)+w)=0;
i3=uint8(255.*cat(3,i1,i1,i1));
imshow(i1)



%220111 conver xls to mat file
ETMm0=table2array(readtable('VA_AccommodationDemand_30NOV2021.xlsx')); m0=ETMm0(:,[1 3 4 5 6 7 8 9 10 11])
AFCm0=table2array(readtable('response_AccommodationDemand_30NOV2021.xlsx')); a0=AFCm0; a0(:,2)=[] a00=table2array(a0(:,1:21)); a01=table2array(a0(:,22:end))

[r0 c0]=size(m0); m1=zeros(r0,c0);
for r=1:r0
    for c=1:c0
        if c==2; m0{r,c}=m0{r,c}(end); end
        m1(r,c)=str2num(m0{r,c});
    end
end


[r0 c0]=size(a00); a1=zeros(r0,c0);
for r=1:r0
    for c=1:c0
        if c==2; a00{r,c}=a00{r,c}(end); end
        a1(r,c)=str2num(a00{r,c});
    end
end

save('JnJrand211130', 'ETMm', 'AFCm', 'ETMm0', 'AFCm0'); %1st column subject number 2nd column visit number


%% 211202 ReticleCalibration 
LFT0=[...
0.9	963 593;
1   967 595;
1.1 970 597;
1.2 975 598;
1.3 980 600;
1.4 990 600];

LFT1=[...
0.9	944 597;
1   947 598;
1.1 946 598;
1.2 948 599;
1.3 955 602;
1.4 958 600];

RIT0=[...
0.9 901 565;
1   900 565;
1.1 896 566;
1.2 893 565;
1.3 890 565;
1.4 890 570];

RIT1=[...
0.9 905 580;
1   900 585;
1.1 897 584;
1.2 896 583;
1.3 895 582;
1.4 895 583];


L=[]; R=[];
for k0=1:length(LFT0(:,1));
L=[L opL(LFT0(k0,1))];
end

for k0=1:length(RIT0(:,1));
R=[R opR(RIT0(k0,1))];
end


cls; fXL0=fit(L', LFT0(:,2),'poly1'); plot(fXL0, L', LFT0(:,2)); lbl('TrombonePower', 'PixelShift', 'LeftX0');
cls; fYL0=fit(L', LFT0(:,3),'poly1'); plot(fYL0, L', LFT0(:,3)); lbl('TrombonePower', 'PixelShift', 'LeftY0');


cls; fXL1=fit(L', LFT1(:,2),'poly1'); plot(fXL1, L', LFT1(:,2)); lbl('TrombonePower', 'PixelShift', 'LeftX1');
cls; fYL1=fit(L', LFT1(:,3),'poly1'); plot(fYL1, L', LFT1(:,3)); lbl('TrombonePower', 'PixelShift', 'LeftY1');




cls; fXR0=fit(R', RIT0(:,2),'poly1'); plot(fXR0, R', RIT0(:,2)); lbl('TrombonePower', 'PixelShift', 'RightX0');
cls; fYR0=fit(R', RIT0(:,3),'poly1'); plot(fYR0, R', RIT0(:,3)); lbl('TrombonePower', 'PixelShift', 'RightY0');

cls; fXR1=fit(R', RIT1(:,2),'poly1'); plot(fXR1, R', RIT1(:,2)); lbl('TrombonePower', 'PixelShift', 'RightX1');
cls; fYR1=fit(R', RIT1(:,3),'poly1'); plot(fYR1, R', RIT1(:,3)); lbl('TrombonePower', 'PixelShift', 'RightY1');






%211124 images for Derek

%purple values
    %Left  0.6153    0.3982    1.0000
    %Right 0.6267    0.4279    1.0000  


%[Right Left]
cf=[1 1; 0 0; 0 0];n0=4; cg='w'; %test
                                cf=[0 0;  0.605 0.583;  0 0]; cg='g'; n0=2; %green
                cf=[0.6267 0.6153; 0.4279 0.3982; 1 1]; n0=4; cg='p';  %210621 gamma corrected/purple background
        cf=[0.538 0.525; 0.538 0.525; 0.538 0.525]; n0=4; cg='w'; %cntrst=1; %white
%                  cf=ones(3,2); n0=4; cg='w'; %cntrst=1; %white
%                 cf=[0 0; 0 0; 1 1]; n0=4; cg='w'; %cntrst=1; %white
 %                 cf=[0 0; 0 0; 0.538 0.525]; n0=4; cg='w'; %cntrst=1; %white
%                cf=[0 0; 0.4279 0.3982; 0 0]; n0=4; cg='p';  %210621 gamma corrected/purple background
%        cf=[0 0; 0.538 0.525; 0 0]; n0=4; cg='w'; %cntrst=1; %white
%                cf=[0.6267 0.6153; 0 0; 0 0]; n0=4; cg='p';  %210621 gamma corrected/purple background
%        cf=[0.538 0.525; 0 0; 0 0]; n0=4; cg='w'; %cntrst=1; %white


1        2         3         4         5         6         7         8         9         10        11        12        13   
9.2160   10.5864   12.1606   13.9688   16.0460   18.4320   21.1728   24.3212   27.9377   32.0920   36.8640   42.3456   48.6423
    cls; 
    im0=E10c{13, 4, 1, 1};
    im1=cat(3, im0, im0, im0);
    im2=double(im1); cntrst=0.2; i30=im2-mxa(im2); i31=cntrst.*i30; im2=i31+mxa(im2);
    im3=imcal(im2, mean(cf,2));
    imshow(im3)


%% 211119 ReticleCalibration 
LFT0=[...
0.9	944 596;
1   947 600;
1.1 950 602;
1.2 950 602;
1.3 956 605;
1.4 960 605];

LFT1=[...
0.9	944 597;
1   947 598;
1.1 946 598;
1.2 948 599;
1.3 955 602;
1.4 958 600];

RIT0=[...
0.9 910 532;
1   907 531;
1.1 904 529;
1.2 902 527;
1.3 902 530;
1.4 902 533];

RIT1=[...
0.9 905 580;
1   900 585;
1.1 897 584;
1.2 896 583;
1.3 895 582;
1.4 895 583];


L=[]; R=[];
for k0=1:length(LFT0(:,1));
L=[L opL(LFT0(k0,1))];
end

for k0=1:length(RIT0(:,1));
R=[R opR(RIT0(k0,1))];
end


cls; fXL0=fit(L', LFT0(:,2),'poly1'); plot(fXL0, L', LFT0(:,2)); lbl('TrombonePower', 'PixelShift', 'LeftX0');
cls; fYL0=fit(L', LFT0(:,3),'poly1'); plot(fYL0, L', LFT0(:,3)); lbl('TrombonePower', 'PixelShift', 'LeftY0');


cls; fXL1=fit(L', LFT1(:,2),'poly1'); plot(fXL1, L', LFT1(:,2)); lbl('TrombonePower', 'PixelShift', 'LeftX1');
cls; fYL1=fit(L', LFT1(:,3),'poly1'); plot(fYL1, L', LFT1(:,3)); lbl('TrombonePower', 'PixelShift', 'LeftY1');




cls; fXR0=fit(R', RIT0(:,2),'poly1'); plot(fXR0, R', RIT0(:,2)); lbl('TrombonePower', 'PixelShift', 'RightX0');
cls; fYR0=fit(R', RIT0(:,3),'poly1'); plot(fYR0, R', RIT0(:,3)); lbl('TrombonePower', 'PixelShift', 'RightY0');

cls; fXR1=fit(R', RIT1(:,2),'poly1'); plot(fXR1, R', RIT1(:,2)); lbl('TrombonePower', 'PixelShift', 'RightX1');
cls; fYR1=fit(R', RIT1(:,3),'poly1'); plot(fYR1, R', RIT1(:,3)); lbl('TrombonePower', 'PixelShift', 'RightY1');










%% 211008 ReticleCalibration 
LFT0=[...
0.9	944 596;
1   947 600;
1.1 950 602;
1.2 950 602;
1.3 956 605;
1.4 960 605];

LFT1=[...
0.9	944 597;
1   947 598;
1.1 946 598;
1.2 948 599;
1.3 955 602;
1.4 958 600];

RIT0=[...
0.9 905 582;
1   902 580;
1.1 898 580;
1.2 895 579;
1.3 896 582;
1.4 897 584];

RIT1=[...
0.9 905 580;
1   900 585;
1.1 897 584;
1.2 896 583;
1.3 895 582;
1.4 895 583];


L=[]; R=[];
for k0=1:length(LFT0(:,1));
L=[L opL(LFT0(k0,1))];
end

for k0=1:length(RIT0(:,1));
R=[R opR(RIT0(k0,1))];
end


cls; fXL0=fit(L', LFT0(:,2),'poly1'); plot(fXL0, L', LFT0(:,2)); lbl('TrombonePower', 'PixelShift', 'LeftX0');
cls; fYL0=fit(L', LFT0(:,3),'poly1'); plot(fYL0, L', LFT0(:,3)); lbl('TrombonePower', 'PixelShift', 'LeftY0');


cls; fXL1=fit(L', LFT1(:,2),'poly1'); plot(fXL1, L', LFT1(:,2)); lbl('TrombonePower', 'PixelShift', 'LeftX1');
cls; fYL1=fit(L', LFT1(:,3),'poly1'); plot(fYL1, L', LFT1(:,3)); lbl('TrombonePower', 'PixelShift', 'LeftY1');




cls; fXR0=fit(R', RIT0(:,2),'poly1'); plot(fXR0, R', RIT0(:,2)); lbl('TrombonePower', 'PixelShift', 'RightX0');
cls; fYR0=fit(R', RIT0(:,3),'poly1'); plot(fYR0, R', RIT0(:,3)); lbl('TrombonePower', 'PixelShift', 'RightY0');

cls; fXR1=fit(R', RIT1(:,2),'poly1'); plot(fXR1, R', RIT1(:,2)); lbl('TrombonePower', 'PixelShift', 'RightX1');
cls; fYR1=fit(R', RIT1(:,3),'poly1'); plot(fYR1, R', RIT1(:,3)); lbl('TrombonePower', 'PixelShift', 'RightY1');







%% 210903 ReticleCalibration 
LFT=[...
0.8	995	 590;
0.9	1001 591;
1   1000 592;
1.1 999	 593;
1.2 1002 595;
1.3 1000 597;
1.4 995 600];

RIT=[...
0.9 917 663;
1   916 661;
1.1 908 659;
1.2 902 657;
1.3 901 657;
1.4 901 658];


L=[]; R=[];
for k0=1:length(LFT(:,1));
L=[L opL(LFT(k0,1))];
end

for k0=1:length(RIT(:,1));
R=[R opR(RIT(k0,1))];
end

cls; fXL=fit(L', LFT(:,2),'poly1'); plot(fXL, L', LFT(:,2)); lbl('TrombonePower', 'PixelShift', 'LeftX');
cls; fYL=fit(L', LFT(:,3),'poly1'); plot(fYL, L', LFT(:,3)); lbl('TrombonePower', 'PixelShift', 'LeftY');

cls; fXR=fit(R', RIT(:,2),'poly1'); plot(fXR, R', RIT(:,2)); lbl('TrombonePower', 'PixelShift', 'RightX');
cls; fYR=fit(R', RIT(:,3),'poly1'); plot(fYR, R', RIT(:,3)); lbl('TrombonePower', 'PixelShift', 'RightY');



%% 210818 ReticleCalibration 
LFT=[...
0.8	879	608;
0.85 878 608;
0.9	883	606;
0.95 886 608;
1 884 609;
1.05 885 608;
1.1 886 611;
1.15 886 609;
1.2 888 612;
1.25 889 612;
1.3 887 612;
1.35 886 614;
1.4 883 614]

RIT=[...
0.9 916 648;
0.95 916 647;
1 913 645;
1.05 911 645;
1.1 909 645;
1.15 906 644;
1.2 904 644;
1.25 903 644;
1.3 902 643;
1.35 900 643;
1.4 899 644];

L=[]; R=[];
for k0=1:length(LFT(:,1));
L=[L opL(LFT(k0,1))];
end

for k0=1:length(RIT(:,1));
R=[R opR(RIT(k0,1))];
end

cls; fXL=fit(L', LFT(:,2),'poly1'); plot(fXL, L', LFT(:,2)); lbl('TrombonePower', 'PixelShift', 'LeftX');
cls; fYL=fit(L', LFT(:,3),'poly1'); plot(fYL, L', LFT(:,3)); lbl('TrombonePower', 'PixelShift', 'LeftY');

cls; fXR=fit(R', RIT(:,2),'poly1'); plot(fXR, R', RIT(:,2)); lbl('TrombonePower', 'PixelShift', 'RightX');
cls; fYR=fit(R', RIT(:,3),'poly1'); plot(fYR, R', RIT(:,3)); lbl('TrombonePower', 'PixelShift', 'RightY');

hold on; plot(RIT(:,1), RIT(:,2))
figure; plot(LFT(:,1), LFT(:,3)); hold on; plot(RIT(:,1), RIT(:,3))


%% 210817 SysTca
Tp=[]; XB=[]; XBs=[]; YB=[]; YBs=[]; XG=[]; XGs=[]; YG=[]; YGs=[]; 

Tp=[Tp TCAp.near_pwr]
XB=[XB z1(3,2)]; XBs=[XBs z2(3,2)];
YB=[YB z1(3,1)]; YBs=[YBs z2(3,1)];

XG=[XG z1(2,2)]; XGs=[XGs z2(2,2)]; 
YG=[YG z1(2,1)]; YGs=[YGs z2(2,1)];

TpA1L=Tp;
XB1L=XB; XG1L=XG; XB1sL=XBs; XG1sL=XGs; 
YB1L=YB; YG1L=YG; YB1sL=YBs; YG1sL=YGs;


TpA0L=Tp;
XB0L=XB; XG0L=XG; XB0sL=XBs; XG0sL=XGs; 
YB0L=YB; YG0L=YG; YB0sL=YBs; YG0sL=YGs;


XB0R=XB0; XB1R=XB1; XG0R=XG0; XG1R=XG1; 
YB0R=YB0; YB1R=YB1; YG0R=YG0; YG1R=YG1;

XB0sR=XB0s; XB1sR=XB1s; XG0sR=XG0s; XG1sR=XG1s; 
YB0sR=YB0s; YB1sR=YB1s; YG0sR=YG0s; YG1sR=YG1s;
%XRight circle
%Yup square
cls
fXB0R=fit(TpA0R', XB0R','poly1'); plot(fXB0R, 'b'); hold on; errorbar(TpA0R, XB0R, XB0sR,'ob'); 
fYB0R=fit(TpA0R', YB0R','poly1'); plot(fYB0R, 'b'); hold on; errorbar(TpA0R, YB0R, YB0sR,'sb'); 
fXG0R=fit(TpA0R', XG0R','poly1'); plot(fXG0R, 'g'); hold on; errorbar(TpA0R, XG0R, XG0sR,'og'); 
fYG0R=fit(TpA0R', YG0R','poly1'); plot(fYG0R, 'g'); hold on; errorbar(TpA0R, YG0R, YG0sR,'sg'); 
lbl('Trombone power', 'TCA pixels', 'SysTca210817ACL0Right')

cls
fXB1R=fit(TpA1R', XB1R','poly1'); plot(fXB1R, 'b'); hold on; errorbar(TpA1R, XB1R, XB1sR,'ob', 'MarkerFaceColor','blue'); 
fYB1R=fit(TpA1R', YB1R','poly1'); plot(fYB1R, 'b'); hold on; errorbar(TpA1R, YB1R, YB1sR,'sb', 'MarkerFaceColor','blue'); 
fXG1R=fit(TpA1R', XG1R','poly1'); plot(fXG1R, 'g'); hold on; errorbar(TpA1R, XG1R, XG1sR,'og', 'MarkerFaceColor','green'); 
fYG1R=fit(TpA1R', YG1R','poly1'); plot(fYG1R, 'g'); hold on; errorbar(TpA1R, YG1R, YG1sR,'sg', 'MarkerFaceColor','green'); 
lbl('Trombone power', 'TCA pixels', 'SysTca210817ACL1Right')


cls
fXB1L=fit(TpA1L', XB1L','poly1'); plot(fXB1L, 'b'); hold on; errorbar(TpA1L, XB1L, XB1sL,'ob', 'MarkerFaceColor','blue'); 
fYB1L=fit(TpA1L', YB1L','poly1'); plot(fYB1L, 'b'); hold on; errorbar(TpA1L, YB1L, YB1sL,'sb', 'MarkerFaceColor','blue');
fXG1L=fit(TpA1L', XG1L','poly1'); plot(fXG1L, 'g'); hold on; errorbar(TpA1L, XG1L, XG1sL,'og', 'MarkerFaceColor','green'); 
fYG1L=fit(TpA1L', YG1L','poly1'); plot(fYG1L, 'g'); hold on; errorbar(TpA1L, YG1L, YG1sL,'sg', 'MarkerFaceColor','green');
lbl('Trombone power', 'TCA pixels', 'SysTca210817ACL1Left')


cls
fXB0L=fit(TpA0L', XB0L','poly1'); plot(fXB0L, 'b'); hold on; errorbar(TpA0L, XB0L, XB0sL,'ob', 'MarkerFaceColor','blue'); 
fYB0L=fit(TpA0L', YB0L','poly1'); plot(fYB0L, 'b'); hold on; errorbar(TpA0L, YB0L, YB0sL,'sb', 'MarkerFaceColor','blue');
fXG0L=fit(TpA0L', XG0L','poly1'); plot(fXG0L, 'g'); hold on; errorbar(TpA0L, XG0L, XG0sL,'og', 'MarkerFaceColor','green'); 
fYG0L=fit(TpA0L', YG0L','poly1'); plot(fYG0L, 'g'); hold on; errorbar(TpA0L, YG0L, YG0sL,'sg', 'MarkerFaceColor','green');
lbl('Trombone power', 'TCA pixels', 'SysTca210817ACL0Left')

save('SysTca210817', 'TpA0R', 'XB0R', 'XB0sR', 'YB0R', 'YB0sR', 'XG0R', 'XG0sR', 'YG0R', 'YG0sR', ... 
                     'TpA1R', 'XB1R', 'XB1sR', 'YB1R', 'YB1sR', 'XG1R', 'XG1sR', 'YG1R', 'YG1sR', ...
                     'TpA0L', 'XB0L', 'XB0sL', 'YB0L', 'YB0sL', 'XG0L', 'XG0sL', 'YG0L', 'YG0sL', ... 
                     'TpA1L', 'XB1L', 'XB1sL', 'YB1L', 'YB1sL', 'XG1L', 'XG1sL', 'YG1L', 'YG1sL');
%%210813 SysTcaRight side
XB0=[]; XB0s=[];
YB0=[]; YB0s=[];

XG0=[]; XG0s=[]; 
YG0=[]; YG0s=[];


XB0=[XB0 z1(3,4)]; XB0s=[XB0s z2(3,4)];
YB0=[YB0 z1(3,3)]; YB0s=[YB0s z2(3,3)];

XG0=[XG0 z1(2,4)]; XG0s=[XG0s z2(2,4)]; 
YG0=[YG0 z1(2,3)]; YG0s=[YG0s z2(2,3)];



XB0=[XB0 z1(3,4)]; %-3.0000   -2.8333   -3.3333   -3.8333   -4.5000   -4.5000 
XB0s=[XB0s z2(3,4)]; % 0    0.2887    0.2887    0.2887         0         0

YB0=[YB0 z1(3,3)];  0.5000         0    0.1667         0         0         0
YB0s=[YB0s z2(3,3)]; 0         0    0.2887         0         0         0


XG0=[XG0 z1(2,4)];  -1.5000   -1.5000   -1.8333   -1.8333   -2.0000   -2.0000
XG0s=[XG0s z2(2,4)]; 0         0    0.2887    0.2887         0         0

YG0=[YG0 z1(2,3)]; 0.5000         0    0.3333    0.5000    0.5000    0.5000
YG0s=[YG0s z2(2,3)]; 0         0    0.2887         0         0         0

cls
errorbar(v, XB0, XB0s,'xb'); 
hold on; errorbar(v, YB0, YB0s,'db'); 

hold on; errorbar(v, XG0, XG0s,'xg'); 
hold on; errorbar(v, YG0, YG0s,'dg'); 

lbl('Magnification', 'TCA pixels', 'SysTca210813ACL0')


XB1=[]; XB1s=[];
YB1=[]; YB1s=[];

XG1=[]; XG1s=[]; 
YG1=[]; YG1s=[];


XB1=[XB1 z1(3,4)]; XB1s=[XB1s z2(3,4)];
YB1=[YB1 z1(3,3)]; YB1s=[YB1s z2(3,3)];

XG1=[XG1 z1(2,4)]; XG1s=[XG1s z2(2,4)]; 
YG1=[YG1 z1(2,3)]; YG1s=[YG1s z2(2,3)];

cls
errorbar(v, XB1, XB1s,'xb'); 
hold on; errorbar(v, YB1, YB1s,'db'); 

hold on; errorbar(v, XG1, XG1s,'xg'); 
hold on; errorbar(v, YG1, YG1s,'dg'); 

lbl('Magnification', 'TCA pixels', 'SysTca210813ACL1')

%% 210509 remind myself of gamma correction
v=[0:0.1:1]
a1=[56.42 164.1 17.89]; %a gamma correcion
n1=[2.458 2.611 2.482]; %ones(1,3).*2.33;
for k0=1:3; 
    v0(k0,:)=(a1(k0).*v.^n1(k0)); 
    v1(k0,:)=(v0(k0,:)./a1(k0)).^(1./n1(k0))
    v2(k0,:)=(v).^(1./n1(k0))
    v3(k0,:)=(v).^n1(k0)

end
plot(v,v0)

% plot(v,[v2; v3; (v2+v3)./2])


n2=(a1.*1.^n1); n3= 255.*((n2./a1).^(1./n1));
n2=n2(3).*ones(1,3); %set equiluminance 1RED 2GREEN 3BLUE
n4= ((n2./a1).^(1./n1));
n5=255.*n4



%%210507 figure out sinpi
f=1; p=0.5
t=vct(sz(2))
t0=sinpi(2.*f.*t); %imshow(v0)
t1=sinpi(2.*f.*t-p);

plot(t, [t0; t1])

%%210429 open varichrome/optotune/trombone
global name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto

addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); addpath([pwd '\data\System TCA\Data Processing']);
    addpath(genpath(fullfile('toolboxes')));

%%210503 generate pix for Austin


    
    
    
 %%210501 control varichrome
%display_optotune 8 to 25
%trombone 9 to 13

OPNT %%start optotune&trombone getting all the variables 
% 
p0(2,:)=[ 11.28   12.3500];%nadav power_display
p0(5,:)=[8.7838            8.9288]; % trombone power_L
opto(name_map('l_disp')).control.setFocalPower(10);
opto(name_map('r_disp')).control.setFocalPower(20);
opto(name_map('l_t_near')).control.getFocalPower
opto(name_map('l_disp')).control.getFocalPower


zaber(name_map('l_trombone')).move(l_trombone_f(10));
zaber(name_map('r_trombone')).move(r_trombone_f(9));
zaber(name_map('rotation')).move_deg(3); %%6400


zaber(name_map('l_trombone')).control.getposition
zaber(name_map('r_trombone')).control.getposition;


opto(name_map('l_t_near')).control.getFocalPower
opto(name_map('l_disp')).control.getFocalPower

zaber(name_map('rotation')).control.getposition



%%210323 figure out psignfit individual versus all
k0=1
     3     3    11
     4    17    19
     5     6     6
     6     2     2
     7     2     2
    
k0=2
     3     1     6
     4    15    20
     5    11    11
     6     2     2
     7     1     1
     
     
     d10 =

     3     4    15
     4    27    37
     5    22    22
     6     4     4
     7     2     2
     
     d20 =
     3     6    21
     4    33    38
     5    14    14
     6     4     4
     7     3     3




%% 210218 fit curves for swati

x=[8.55	921.5132	652.3569
8.73	918.2743	651.8873
8.91	921.3371	651.4937
9.09	921.2706	653.5567
9.27	920.2693	651.7382
9.45	920.0299	651.1405
9.63	920.3095	653.7709
9.81	917.8599	652.8007
9.99	914.3148	651.6154
10.17	919.59	    653.2825
10.35	913.6552	653.6738
10.53	915.059	    654.2933
10.71	913.1707	651.9892
10.89	915.1006	652.9464
11.07	911.5475	653.0837
11.25	913.9475	653.0565
11.43	911.4158	650.135
11.61	912.7652	653.0366
11.79	912.0265	654.4911
11.97	911.0567	652.6805
12.15	912.1623	654.4331
12.33	907.4758	653.2462
12.51	908.6308	654.4466
12.69	911.4359	653.7833
12.87	909.6312	652.7752
13.05	910.5663	655.2351
13.23	911.8555	654.1871
13.41	909.6734	653.2022
13.59	911.5067	653.2633
13.62	909.6936	655.9425]

n=3 %2=CenterX_pixels 3=CenterY_pixels
f=fit(x(:,1), x(:,n), 'poly1')
plot(f, x(:,1), x(:,n))


%gamma correction 210106 for right screen based on https://docs.google.com/spreadsheets/d/1maOUYWGFCDSlVECT5PGDsaGbWPvUkG15hLOZvJLpwFo/edit?usp=sharing
clr
x=[5 25 30   35   55   105   155   205   255];
y=[0 0  0    0.58 1.58 6.69  16.67 32.57 56.6;...
   0 0  0.85 1.22 3.68 17.43 45.1  91.27 164.67;...
   0 0  0.1  0.14 0.42 2.01  5.18  10.4  17.9];
%'a*x^b'
%RED   a=56.42 b=2.458
%GREEN a=164.1 b=2.611
%BLUE  a=17.89 b=2.482

y0=y(2,:);
x0=x./255; x0(y0==0)=[]; x0=x0';
y0(y0==0)=[]; y0=y0';

fo = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0,0],...
               'Upper',[Inf,mxa(x)],...
               'StartPoint',[1 1]);
ft = fittype('a*x^b','options',fo);
[c0,gof2] = fit(x0,y0,ft)
plot(x0,y0, 'o')
hold on
plot(c0)


%% 201222figure out luminance values for equal luminance
a1=[56.42 164.1 17.89]; %a gamma correcion
n1=[2.458 2.611 2.482]; %ones(1,3).*2.33;
n2=(a1.*1.^n1); n3= 255.*((n2./a1).^(1./n1));
n2=n2(3).*ones(1,3); %set equiluminance 1RED 2GREEN 3BLUE
n4= ((n2./a1).^(1./n1));
n5=255.*n4
% luminance of max ratios
% %LEFT_RGB  3.7403   10.9129    1.0000
% %RIGHT_RGB 3.4473   10.1107    1.0000
% %GAMMA     3.3228   10.0057    1.0000



% %% 201223 generate RGB squres 
% s=6 %2 3 4 5 6 8 9 108 54
% s0=1080; %image size
% s1=s0./s; %2 3 4 5 6 8 9
% s2 = randi(3,s1);
% for k0=1:3; 
%     s3(:,:,k0)=embd(kron(s2==k0, ones(s)), zeros([1080, 1920]));
% end
% 
% imshow(uint8(255.*s3))
% 


%% 201223 surf matrix for marty
clear c20 r20 r2 c2
%load first data set
c20=c2; r20=r2;
%load 2nd data set
c2=[c20 c2]; r2=[r20 r2];
%clac psignfit
d0=0; t0=psfs(r2, c2, s2, d0);

%t1=[] [t8.619 t9.8896  
t1=[t1; t0]

Z=t1;
Y=[0 0.5 1]
X=s2;
surf(X, Y, Z)
xlabel('Pixel shift')
ylabel('LCA corrected')
zlabel('contrast threshold')
%save('AJR_CSF', 'X', 'Y', 'Z')

Z=t1;
Y=[8.619 9.8896 10.9];
X=s2
surf(X, Y, Z)
xlabel('Pixel shift')
ylabel('Tromobone power')
zlabel('contrast threshold')
%save('MSB_CSF', 'X', 'Y', 'Z')


% %% 201222figure out luminance values for equal luminance
% a1=[58.05 174.8 17.47]; %a gamma correcion
% n1=[2.473 2.501 2.431]; %ones(1,3).*2.33;
% n2=(a1.*1.^n1); n3= 255.*((n2./a1).^(1./n1));
% n2=n2(3).*ones(1,3); %set equiluminance 1RED 2GREEN 3BLUE
% n4= ((n2./a1).^(1./n1));
% n5=255.*n4
% % luminance of max ratios
% % %LEFT_RGB  3.7403   10.9129    1.0000
% % %RIGHT_RGB 3.4473   10.1107    1.0000
% % %GAMMA     3.3228   10.0057    1.0000




% %gamma correction 201217 based on https://docs.google.com/spreadsheets/d/1AfCZMJ4BcOzrZWbITKsAnwJ1GJ5su8aEANp-F04XGhA/edit?usp=sharing
% clr
% x=[5 25   35   55   105  155  205  255];
% y=[0 0    0.54 1.51 6.75 17   33.5 58.2;...
%    0 0.71 1.52 4.34 19.9 49.8 101  175;...
%    0 0    0.17 0.46 2.1  5.2  10.2 17.5];
% %'a*x^b'
% %RED a=58.05 b=2.473
% %GREEN a=174.8 b=2.501
% %BLUE a=17.47 b=2.431
% 
% y0=y(3,:);
% x0=x./255; x0(y0==0)=[]; x0=x0';
% y0(y0==0)=[]; y0=y0';
% 
% fo = fitoptions('Method','NonlinearLeastSquares',...
%                'Lower',[0,0],...
%                'Upper',[Inf,mxa(x)],...
%                'StartPoint',[1 1]);
% ft = fittype('a*x^b','options',fo);
% [c0,gof2] = fit(x0,y0,ft)
% plot(x0,y0, 'o')
% hold on
% plot(c0)


% % gamma correction 
% clr
% n=2.33
% a=[0.000144 0.00042 0.000045];
% x=[0:255]./255;
% y(1,:)=a(1).*x.^n;
% y(2,:)=a(2).*x.^n;
% y(3,:)=a(1).*x.^n;
% 
% % y0=y(1,:)./max(y(1,:));
% % y1=(a(1)./max(y(1,:))).*x.^(1/n);
% 
% y0=y(1,:);
% y1=(a(1)).*x.^(1/n);
% y2=y0+y1;
% %y1=a(1).*x.^(-n);
% 
% 
% 
% plot(x, [y0; y1; y2./2])


% 
% subplot(2,2,1)
% plot(x, yR)
% subplot(2,2,2)
% plot(x, yG)
% subplot(2,2,3)
% plot(x,yB)
% subplot(2,2,4)
% plot(x,[yR; yB])


% %normalize and add gray background to gabor 201213
% clr
% 
% f=73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
% s= 100; %gaussian sigma
% %sz = [1080, 1920]; % size of screen
% sz = [1, 1920]; % size of screen
% 
% t=repmat(vct(sz(2)), [sz(1) 1]); t=sinpi(2.*f.*t); %imshow(v0)
% h=repmat(normpdf([1:sz(2)], round(sz(2)./2), s), [sz(1) 1]); h=h./mxa(h);
% v=repmat(normpdf([1:sz(1)], round(sz(1)./2), s)', [1 sz(2)]); v=v./mxa(v);
% 
% 
% 
% m0=h.*v; %raise background to 1;
% m1=0.5.*(1-m0); %0.5.*(m0<0.01); 
% m=t.*m0+m1; %imshow(m)


% clear all
% %% calculate loan repayments 201121
% 
% clr
% p0=90000; 
% i0=0.0325./12;
% n0=12.*5;
% %m0=1627.2 m1=97,632.0
% 
% clr
% p0=175000; 
% i0=0.0325./12;
% n0=12.*15;
% %m0=1,229.67 m1=221,340.66 m2=46,340.66
% 
% clr
% p0=1E6; 
% i0=0.03./12;
% n0=12.*30;
% %m0=4,216.04 m1=1,517,774.52 m2=517,774.52
% 
% clr
% p0=1E6; 
% i0=0.02./12;
% n0=12.*30;
% %m0=3,696.19 m1=1,330,630.10 m2=330,630.10
% 
% clr
% p0=1E6; 
% i0=0.01./12;
% n0=12.*30;
% %m0=3216.39 m1=1,157,902.27 m2=157,902.27
% 
% clr
% p0=150000; 
% i0=0.02./12;
% n0=36;
% %'m0=4296.38 m1=154669.92 i2=4669.92'
% 
% 
% clr
% p0=150000; 
% i0=0.022./12;
% n0=48;
% %'m0=3267.37 m1=156834.15 i2=6834.15'
% 
% clr
% p0=150000; 
% i0=0.0255./12;
% n0=60;
% %'m0=2665.41 m1=159924.75 i2=9924.75'
% 
% clr
% p0=150000; 
% i0=0.0295./12;
% n0=84; % number of months
% %'m0=1978.6166 m1=166203.7965 i2=16203.7965'
% 
% clr
% p0=90000; 
% i0=0.0255./12;
% n0=12.*5;
% %'m0=1599.2475 m1=95954.8508 i2=5954.8508'
% 
% m0=(p0.*i0.*(1+i0).^n0)./((1+i0).^n0-1) % 1627.2
% m1=n0*m0; %loan+interest total
% i2= m1-p0  % total interest
% %(i0/12)*p0
% p1=m1; i1=[]; p2=[];
% for k0=1:60
%     p1=[p1 p1(end)-m0]; %loan+interest remaining
%     i1=p0(end).*i0; %interest payment
%     p2=[p2 m0-i1(end)]; %loan payment
%     p0=[p0 p0(end)-p2(end)]; %remaining loan
%     %i1=(m0-p0(end).*i0)    
% end
% 
% ['m0=' n2s(m0) ' m1=' n2s(m1) ' i2=' n2s(i2)]
% %1920by1200 pixels
% w=10;
% sz=[1920 1200];
% sz1=5.86.*sz./1000 %11.2512    7.0320 mm sensor size
% sz0=[1200 1200];
% r=170.*[2 3 4 5 6]./2; % multiply by number of pixels/mm and divide by 2 to get radius
% ir= r-w; %% inner radius
% or=r+w; %outer radius
% 
% i0=zeros(sz0); i1=i0;
% for k0=1:length(r);
%     i0=crc0(or(k0),sz0)-crc0(ir(k0), sz0);
%     i1=i1+i0;
% end
% 
% i1=binv(embd(i1, zeros(sz)));  
% i11=ct8(i1, i1, i1);
% imshow(i11)
% %imwrite(i11, 'imgs\rtclV10i.bmp')
% %imwrite(i1', 'imgs\rtclH.bmp')
% 
% %imwrite(i1, 'imgs\rtclV.png')
% %imwrite(i1', 'imgs\rtclH.png')


% %% check green square size
% clr
% im=imread('grn_box_1000.png');
% i0=im(:,:,2);
% sz=size(i0);
% sz2=sz./2;
% n=200;
% i1=i0(n:end-n,sz2(2)+10);
% [r c]=find(round(double(i1))==255);


% %% generate reticle
% %imaging sensor pixel size 5.86by5.86 micrometer
% %170.9402 pixels/mm
% %3.8mm pupil 
% %circles of 2,3,4,5,6 mm
% 
% 
% clear all
% %1920by1200 pixels
% w=10;
% sz=[1920 1200];
% sz1=5.86.*sz./1000 %11.2512    7.0320 mm sensor size
% sz0=[1200 1200];
% r=170.*[2 3 4 5 6]./2; % multiply by number of pixels/mm and divide by 2 to get radius
% ir= r-w; %% inner radius
% or=r+w; %outer radius
% 
% i0=zeros(sz0); i1=i0;
% for k0=1:length(r);
%     i0=crc0(or(k0),sz0)-crc0(ir(k0), sz0);
%     i1=i1+i0;
% end
% 
% i1=binv(embd(i1, zeros(sz)));  
% i11=ct8(i1, i1, i1);
% imshow(i11)
% %imwrite(i11, 'imgs\rtclV10i.bmp')
% %imwrite(i1', 'imgs\rtclH.bmp')
% 
% %imwrite(i1, 'imgs\rtclV.png')
% %imwrite(i1', 'imgs\rtclH.png')












% sqrt(r.^2 +c.^2)



%% test downsampling algorithm

% p0=[2 4 8 10];
% 
% n0=[40 400 4000 40000] ;
% 
% tm=zeros(length(p0), length(n0)); 
% 
% tm0=tm; tm1=tm;
% %row=downsampling, column=matrix size
% for pi=1:length(p0)
%    for ni=1:length(n0) 
% 
%        i1=rand(n0(ni));
%        tic;
%        out1=dsz(i1, p0(pi));
%        tm0(pi, ni)=toc;
%        tic
%        out1=dszf(i1, p0(pi));
%        tm1(pi, ni)=toc;
%       
%    end
% end


% tic
% %i1=usz(i0,p);
% out1=dsz(i1, p); % 0.0413 2.8471   5.3745 21.3603 3.6323
% %out2=dszf(i1, p); % 0.0178 0.0351   0.1316 23.6877 0.8518
% 
% t1=toc
% %0.7 ms



% i1=rand(4); p=2;
% 
% 
% 
% tic
% %i1=usz(i0,p);
% out1=dsz(i1, p); % 0.0413 2.8471   5.3745 21.3603 3.6323
% %out2=dszf(i1, p); % 0.0178 0.0351   0.1316 23.6877 0.8518
% 
% t1=toc
% %0.7 ms

%% comparing optotype generation with dsz and dszf

%% resizem takes about 1 sec for a 10000 by 10000 to reduce to 1000 by 1000 too long for a 10 by 10 = 100 operations 
% clr
% b=2; %base
% p=16; %power
% L='E'; %optotype
% o=0; %orientation R0 U1 L2 D3 
% sz=[1000 1000];
% tic
% i0=o2i(b, p, L, o, sz);
% toc 
%p=1 dsz=0.088998, dszf=0.12
%p=3 dsz=0.096449, dszf=0.0675
%p=5 dsz=0.082552, dszf=0.0789
%p=9 dsz=0.165, dszf=0.068945
%p=15 dsz=2.611470, dszf=0.249115 15 is the biggest power I can generate

% imshow(i0)
% round(5.*b.^(p./2))
%% comparing dsz and dszf
% 
% %% resizem takes about 1 sec for a 10000 by 10000 to reduce to 1000 by 1000 too long for a 10 by 10 = 100 operations 
% clr
% %n=2; p=7;
% %n=1000; p=2;
% %n=1000; p=10;
% n=1000; p=50; 
% n=1000; p=10; %time including usz
% 
% i0=100.*rand(n);
% 
% 
% tic
% i1=usz(i0,p);
% %out1=dsz(i1, p); % 0.0413 2.8471   5.3745 21.3603 3.6323
% out2=dszf(i1, p); % 0.0178 0.0351   0.1316 23.6877 0.8518
% 
% t0=toc




% %% improved dsz function works for all
% clr
% n=1000; p=10;
% i0=100.*rand(n);
% K=usz(i0,p);
% 
% sz=size(K);
% rc=sz./p; 
% v=[1:p:sz(1)-p+1];
% m=zeros(rc);
% 
% for r=1:p
%     for c=1:p
%     m= m+K(v+r-1,v+c-1);            
%     end 
% end
% m0=m./(p.^2);
% 
% m0
% i0
% m0-i0








% %% comparing dsz and dszf
% 
% %% resizem takes about 1 sec for a 10000 by 10000 to reduce to 1000 by 1000 too long for a 10 by 10 = 100 operations 
% clr
% %n=2; p=7;
% n=1000; p=2;
% 
% i0=100.*rand(n);
% i1=usz(i0,p);
% tic 
% %out1=dsz(i1, p); % 0.0658 3.2403
% %out2=dszf(i1, p); % 0.1522 4.0061
% %resizem(i1, [1000 1000]); %??? 1.0319
% circshift(i1, [1000 1000]); %??? 0.0039
% 
% t0=toc





% %% improved dsz function works for all
% clr
% n=2; p=7;
% i0=100.*rand(n);
% i1=usz(i0,p);
% 
% v=[1:p.^2]; m=reshape(v, p, p);
% 
% m0=repmat(m, [n n]);
% 
% 
% m2=zeros(n);
% f=floor((p-1)./2);
% for r=1:p
%     for c=1:p
%     m1=i1.*(m0==m(r, c));
%     %m2=resizem(m1, [n n])    
%     m2=m2+resizem(circshift(m1, [p-r-f p-c-f]), [n n]);
%     %m3=m3+m2;
%     end
% end
% i0
% 
% m3=m2./(p.^2)
% 
% m3-i0

%% improved dsz function works for downsample/p=3
% clr
% n=4; p=3;
% i0=rand(n);
% i1=usz(i0,p);
% 
% v=[1:p.^2]; m=reshape(v, p, p);
% 
% m0=repmat(m, [n n]);
% 
% 
% m3=zeros(n);
% for r=1:p
%     for c=1:p
%     m1=i1.*(m0==m(r, c))
%     %m2=resizem(m1, [n n])
%     
%     m2=resizem(circshift(m1, [p-r-1 p-c-1]), [n n])
%     %m3=m3+m2;
%     end
% end

%m4=m3./(p.^2);

%m4-i0

% %% improved dsz function works for upsampling by 2
% clr
% n=10; p=2;
% i0=rand(n);
% i1=usz(i0,p);
% 
% v=[1:p.^2]; m=reshape(v, p, p);
% 
% m0=repmat(m, [n n]);
% 
% 
% m3=zeros(n);
% for r=1:p
%     for c=1:p
%     m1=i1.*(m0==m(r, c));
%     m2=resizem(circshift(m1, [p-r p-c]), [n n]);
%     %m2(:,:)=resizem(circshift(m1, [1 1]), [n n])
%     m3=m3+m2;
%     end
% end
% 
% m4=m3./(p.^2);
% 
% m4-i0


%% vertical and horizontal gratings
%  clr
% % 
%  sz = [1080, 1920]; % size of screen
% i0=zeros(sz);
%  i1=ones(500);
%  i2=ones(498);
% 
% i3=circshift(255.*(embd(i1, i0)-embd(i2,i0)), [100 0]);
% i4=uint8(cat(3, i0, i3, i0));
% 
% imshow(i4)

 
%% vertical and horizontal gratings
% clr
% 
% sz = [1080, 1920]; % size of screen
% sz3=sz./3;
% 
% i0=zeros(sz);
% h=i0; v=i0; w=3;
% 
% 
% for k=1:sz3(1)./2
%     h(  w.*(2.*k-1)+1:w.*2.*k, :)=1;
% end
% 
% for k=1:sz3(2)./2
%     v(:,  w.*(2.*k-1)+1:w.*2.*k)=1;
% end
% 
% v6=usz(v,3);
% v6r=circshift(v6, [0 1]);
% v6l=circshift(v6, [0 -1]);
% 
% vr=dsz(v6r, 3);
% vl=dsz(v6l, 3);
% %FWHM = 2sqrt(2log(2))sigma = 2.355 sigma
% s=0;%1.4.*2.355./4;
% 
% i1=uint8(255.*cat(3, imgf(v, s), imgf(v, s), imgf(v,s)));
% i2=uint8(255.*cat(3, imgf(vr, s), imgf(vl, s), imgf(v,s)));
% i3=uint8(255.*cat(3, imgf(vl, s), imgf(vr, s), imgf(v,s)));
% 
% 
% 
% %imshow(h)






%% gamma correction

%clr


% %% fit the gamma curves
% x=[35 55 105 155 205 255];
% y=[0.54 1.51 6.75 17 33.5 58.2; 1.52 4.34 19.9 49.8 101 175; 0.17 0.46 2.1 5.2 10.2 17.5 ]
% fo = fitoptions('Method','NonlinearLeastSquares',...
%                'Lower',[0,0],...
%                'Upper',[Inf,Inf],...
%                'StartPoint',[0.000144 2.33]);
% ft = fittype('a*x^n','options',fo);
% 
% [curve2,gof2]=fit(x', y(1,:)', ft)
% 
% plot(x, y)
% hold on
% plot(curve2)
% 
% %R a=0.0006504 n=2.473  RMSE= 0.2606 
% %G a=0.0001674 n=2.501  RMSE= 0.6535
% %B a=0.00002459 n=2.431 RMSE=0.0626 
% 
% a=[0.000144, 0.00042, 0.000045];
% n=2.33
% 
% 
% k=3
% sqrt(mean(((a(k).*x.^n)-y(k,:)).^2))
% MSB
% %R RMSE=0.8618
% %G RMSE=2.6278
% %B RMSE=0.4809
% 

%% w/out logs

% %load RGB_0_5
% s=125;
% a=[0.0006504, 0.0001674, 0.00002459];
% %a=[1 1 1];
% 
% %b=log10(a);
% n=[2.473, 2.501, 2.431];
% v0=255.*ones(1, 1E6); v0(1,500000-2000:502000)=0; v=v0;
% g=a(2).*v.^n(2);
% r=a(1).*circshift(v, [0 s]).^n(1);
% b=a(3).*circshift(v, [0 -s]).^n(3);
% 
% v1=[r; g; b];
% v2=zeros(3,1000);
% 
% for k=1:1000
%    v2(:,k)=mean(v1(:   , 1000.*(k-1)+1:1000.*k   ), 2);    
% end
% 
% v3=v2;
% v3(1,:)=(v3(1,:)./a(1)).^(1./n(1));
% v3(2,:)=(v3(2,:)./a(2)).^(1./n(2));
% v3(3,:)=(v3(3,:)./a(3)).^(1./n(3));
% v4=uint8(v3);
% imshow([repmat(v4(1,:), [400 1]); repmat(v4(2,:), [400 1]   ); repmat(v4(3,:), [400 1])])

%v0_325=v4; save('RGB_all', 'v0_325', '-append');


% %% w/out logs using MSB params
% 
% %load RGB_0_5
% s=325;
% a=[0.000144, 0.00042, 0.000045];
% %a=[1 1 1];
% 
% %b=log10(a);
% n=2.33;
% v0=255.*ones(1, 1E6); v0(1,500000-2000:502000)=0; v=v0.^n; %log10(v0);
% g=a(2).*v;
% r=a(1).*circshift(v, [0 s]);
% b=a(3).*circshift(v, [0 -s]);
% 
% v1=[r; g; b];
% v2=zeros(3,1000);
% 
% for k=1:1000
%    v2(:,k)=mean(v1(:   , 1000.*(k-1)+1:1000.*k   ), 2);    
% end
% 
% v3=v2;
% v3(1,:)=(v3(1,:)./a(1)).^(1./n);
% v3(2,:)=(v3(2,:)./a(2)).^(1./n);
% v3(3,:)=(v3(3,:)./a(3)).^(1./n);
% v4=uint8(v3);
% imshow([repmat(v4(1,:), [400 1]); repmat(v4(2,:), [400 1]   ); repmat(v4(3,:), [400 1])])
% 
% %v0_325=v4; save('RGB_all', 'v0_325', '-append');


%% using log laws
% %load RGB_0_5
% s=10000;
% % a=[0.000144, 0.00042, 0.000045];
% a=[1 1 1];
% 
% b=log10(a);
% n=1; %2.33;
% v0=255.*ones(1, 1E6); v0(1,500000-1000:502000)=0; v=log10(v0);
% g=b(2)+n.*v;
% r=b(1)+n.*circshift(v, [0 s]);
% b=b(3)+n.*circshift(v, [0 -s]);
% 
% v1=[r; g; b];
% v2=zeros(3,1000);
% 
% for k=1:1000
%    v2(:,k)=mean(v1(:   , 1000.*(k-1)+1:1000.*k   ), 2);    
% end
% 
% v3=v2;
% v3(1,:)=(v3(1,:)-b(1))./n;
% v3(2,:)=(v3(2,:)-b(2))./n;
% v3(3,:)=(v3(3,:)-b(3))./n;
% 
% v4=10.^v3;
% 
% imshow([repmat(v2(1,:), [400 1]); repmat(v2(2,:), [400 1]   ); repmat(v2(3,:), [400 1])])
% 




%v0=usz(v, 100);


%% prepare figs for 200917 meeting
%imgf
%%clr
%% upsample - gaussian - downsample
% 
% e5=binv(opt('E', 0));
% e10=embd(e5, ones(11)); %usz(e5, 10)
% e100=usz(e10, 10);%embd(e10, ones(101));
% e101=imgf(e100,1)
% e111=dsz(e101, 10)
% 
% 
% imshow(e101)
% truesize([400, 400])

%% apply gaussian
% 
% e5=binv(opt('E', 0));
% e10=usz(e5, 10)
% e100=embd(e10, ones(101));
% e101=imgf(e100,1)
% 
% 
% imshow(e101)
% truesize([400, 400])



%% half a pixel shift
% e5=binv(opt('E', 0));
% e10=embd(e5, ones(11));
% e20=usz(e10, 10);
% e21=circshift(e20, [1, 1]);
% e11=dsz(e21, 10);
% 
% imshow(e11)
% truesize([400, 400])


%% up/down sample
% e5=binv(opt('E', 0));
% e35=usz(e5, 7);
% e7=dsz(e35, 5)
% imshow(e5)
% truesize([400, 400])
%% red green blue horizontal stripes with moving black bar in the middle
% 
% 
% clear all
% close all
% clc
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% %108 pix/degree
% %0.0093 visual degrees/pixel
% %0.5556 arcmin/pixel
% %3.333 arcsec/pixel
% %display =10 degrees
% %FOV=5degrees
% % bkg=127; %background luminance 
% % w=10; % width of line
% msv=[2 4 8 10]; %up/downsmapling
% ms=msv(1);
% ey='Right';ex='LCA'
% 
% %[RR RG RB] =1.4010    4.1090    0.4064
% 
% %[LR LG LB]= 1.3480    3.9330    0.3604
% 
% 
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1]; 
% %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=ones(3,2);
% %[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% ext=false;     chk=0;
%     sz0=[1080 1920];
%     sz2=round(sz0./2);
%     sz3=round(sz0./3);
%     i0=zeros(sz0);
%     ir=i0; ir(1:sz3(1),:)=255; ir0=ir; 
%     ig=i0; ig(sz3(1)+1: 2.*sz3(1),:)=255; %ig0=ig;
%     ib=i0; ib(2.*sz3(1)+1: 3.*sz3(1), :)=255; ib0=ib;
%     i1=ones(sz0); i1(:, sz2(2)-1 : sz2(2)+2)=0; i11=usz(i1, ms); 
%     ir1=usz(i1.*ir, ms); ib1=usz(i1.*ib, ms); ig0=ig.*i1;
%     %imshow(uint8(cat(3, i1.*ir, i1.*ig, i1.*ib)));
%     
%     r=0; b=0; % set intial position of red background and vertical bar
% while ext == false; %find(KeyCode)~=ek
% %      i0=bkg.*ones(sz0);
% %      i0(sz2(1)+[0:w-1],:)=255;
% %      i0(:,sz2(2)+[0:w-1])=255;
% %      for k0=1:sz0(1); i0(k0, k0)=255; end;
%      tic; if chk==1; ib1=usz(ib0, ms); ir1=usz(ir0, ms);
%           elseif chk==0; ib0=dsz(ib1, ms); ir0=dsz(ir1, ms); end
% 
%      img=uint8(cat(3, ir0, ig0, ib0));
%     %img=imread(b,'png'); %% image to show
%     disp([b ms toc]); %[b toc]); % bar and red background position/offset
%     %wn=cwin(img, ey, cf, window1, window2);
%     imshow(img);
%     ky=input('ky?');
%     %[keyIsDown,secs, kc] = KbCheck;
%     %[secs, kc, deltaSecs] = KbStrokeWait;
%     if ky==0; %kc(ek); %find(KeyCode)==ek
%         ext=true;
% %    elseif kc(uk);
% % %         bkg=bkg+1;
% %            ir1=circshift(ir1, [0 1]);
% %            r=r+1./ms;
% %     elseif kc(dk);
% %         %bkg=bkg-1;
% %            ir1=circshift(ir1, [0 -1]);
% %            r=r-1./ms;
%     elseif ky==1; %kc(rk);
%         %w=w+1;
%         ir1=circshift(ir1, [0 1]);
%         ib1=circshift(ib1, [0 -1]);
%         b=b+1./ms;
%         chk=0;
%     elseif ky==2; %kc(lk);
%         %w=w-1;
%         ir1=circshift(ir1, [0 -1]);
%         ib1=circshift(ib1, [0  1]);
%         b=b-1./ms;
%         chk=0;
%     elseif ky==3; %kc(sp) & chk==0;
%         msv=circshift(msv, [0 -1]);
%         ms=msv(1);
%         chk=1;
%     end
%     %KbWait; %% wait for keystroke
% end
% 
% sca


% %% red green blue horizontal stripes with black bar in the middle
% 
% clear all
% close all
% clc
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% %108 pix/degree
% %0.0093 visual degrees/pixel
% %0.5556 arcmin/pixel
% %3.333 arcsec/pixel
% %display =10 degrees
% %FOV=5degrees
% % bkg=127; %background luminance 
% % w=10; % width of line
% ms=2; %up/downsmapling
% ey='Right';ex='LCA'
% 
% %[RR RG RB] =1.4010    4.1090    0.4064
% 
% %[LR LG LB]= 1.3480    3.9330    0.3604
% 
% 
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1]; 
% %cf=[RB./RR LB./LR];
% %cf=[RR./RG LR./LG; 1 1; RB./RG LB./LG];
% cf=ones(3,2);
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% ext=false;     chk=0;
%     sz0=[screenYpixels,  screenXpixels];
%     sz2=round(sz0./2);
%     sz3=round(sz0./3);
%     i0=zeros(sz0);
%     ir=i0; ir(1:sz3(1),:)=255; ir0=ir; ir1=usz(ir, ms);
%     ig=i0; ig(sz3(1)+1: 2.*sz3(1),:)=255; ig0=ig;
%     ib=i0; ib(2.*sz3(1)+1: 3.*sz3(1), :)=255; ib0=ib;
%     i1=ones(sz0); i1(:, sz2(2)-1 : sz2(2)+2)=0; i11=usz(i1, ms); 
%     %imshow(uint8(cat(3, i1.*ir, i1.*ig, i1.*ib)));
%     
%     r=0; b=0; % set intial position of red background and vertical bar
% while ext == false; %find(KeyCode)~=ek
% %      i0=bkg.*ones(sz0);
% %      i0(sz2(1)+[0:w-1],:)=255;
% %      i0(:,sz2(2)+[0:w-1])=255;
% %      for k0=1:sz0(1); i0(k0, k0)=255; end;
%      tic; i2=dsz(i11, ms); ir=dsz(ir1, ms);
%      
%      img=uint8(cat(3, i2.*ir, i2.*ig, i2.*ib));
%     %img=imread(b,'png'); %% image to show
%     disp([b r toc]); % bar and red background position/offset
%     wn=cwin(img, ey, cf, window1, window2);
%     
%     %[keyIsDown,secs, kc] = KbCheck;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     if kc(ek); %find(KeyCode)==ek
%         ext=true;
%     elseif kc(uk);
% %         bkg=bkg+1;
%            ir1=circshift(ir1, [0 1]);
%            r=r+1./ms;
%     elseif kc(dk);
%         %bkg=bkg-1;
%            ir1=circshift(ir1, [0 -1]);
%            r=r-1./ms;
%     elseif kc(rk);
%         %w=w+1;
%         i11=circshift(i11, [0 1]);
%         b=b+1./ms;
%     elseif kc(lk);
%         %w=w-1;
%         i11=circshift(i11, [0 -1]);
%         b=b-1./ms;
%     end
%     %KbWait; %% wait for keystroke
% end
% 
% sca


%% figure out optotype position after rotation
% %tic; load('E_b2_m2_p10_ms10.mat'); toc % 5secs to load
% rc=[500 0];
% v=[1:10];
% z=[10:-1:1];
% 
% if r==1 & c==1
%     m=rot90(E10c{w, r, c}, p);
% elseif (r~=1 | c~=1) & p~=0;
%     if p==1 & r==1
%            m=rot90(E10c{w, c, r}, p);
%     elseif p==1 & c==1
%            m=rot90(E10c{w, z(c), r}, p);
% 
% 
%         
%         
%     
% 
% 
% 
% rc=[0 500]; imshow(circshift(rot90(circshift(E10c{10,1,1}, rc), 1), [540 0]))
% 



%% generate crosshairs
% clr
% sz = [1080, 1920]; % size of screen
% sz2=sz./2;
% i0=zeros(sz);
% i0(1:sz2(1), 1:sz2(2))=1;
% i0(sz2(1)+1:end, sz2(2)+1:end)=1;
% i1=uint8(255.*i0);
% i2=cat(3, i1, i1, i1);
% imshow(i2)


%% extract maltese cross
% clr
% i0=imread('texture3_1080_newfill_malt.png');
% i1=crc0(30, [1080 1080]);
% i20=i0.*uint8(i1);
% %i02=uint8(255.*((i20-255)==0));
% % i02=uint8(255.*((double(i20)./255-i1)<0));
% i02=uint8(255.*i1)-i20;
% i3=cat(3, i20(:,:,1), uint8(zeros([1080 1080])), i02(:,:,1));
% 
% 
% imshow(i02)
% figure; imshow(i20)
% figure; imshow(i3)
% 


%% images for JJVC report
% clr
% 
% i0=imread('vrn10_RB_sd1.png');
% i1=i0; i1(:,:,3)=imgf(i0(:,:,3), 0);
% imshow(i1)

% %% horizontal/vertical lines/stripes/gratings
% 
% clear all
% sz = [1080, 1920]; % size of screen
% i0=zeros(sz);
% sz2=sz./4;
% 
% i10=i0;
% for k0=1:sz2(1)
%    i10(4.*k0+[-1 0], :)=1; 
% end
% 
% i01=i0;
% for k0=1:sz2(2)
%    i01(:, 4.*k0+[-1 0])=1; 
% end
% i0=uint8(i0);
% i10=uint8(255.*i10);
% i01=uint8(255.*i01);
% 
% imshow(cat(3, i10, i10, i10)); %horizontal
% 
% imshow(cat(3, i01, i01, i01)); % vertical






% clear all
% sz = [1080, 1920]; % size of screen
% i0=zeros(sz);
% sz2=sz./2;
% i10=i0;
% for k0=1:sz2(1)
%    i10(2.*k0, :)=1; 
% end
% 
% i01=i0;
% for k0=1:sz2(2)
%    i01(:, 2.*k0)=1; 
% end
% i0=uint8(i0);
% i10=uint8(255.*i10);
% i01=uint8(255.*i01);
% 
% imshow(cat(3, i10, i0, i0)); %horizontal
% 
% imshow(cat(3, i01, i0, i0)); % vertical




% 
% imshow(i10)
% 
% 
% i0=imread('lns_x.png');
% 
% 














% %% show optotype subpixaleted
% 
% 
% %clear all
% close all
% clc
% addpath([pwd '\fcns']); addpath([pwd '\imgs']);
% figure;
% cnt=1;
% for k0=1:10
%     for k1=1:10
%         
%         subplot(10, 10, cnt)
%         imshow(E10c{22,1, k0, k1});
%         cnt=cnt+1;
%     end
% end


