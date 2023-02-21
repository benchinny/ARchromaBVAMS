%210523 calculate data/figure for ETM/VA data
%NHI ACL0
STK00=[1.4000    1.6000    1.8000    2.0000    2.2000    2.6000    3.0000    3.4000    4.0000    4.6000    5.2000    6.0000    7.0000];
a0=["S10007_ETMg_RightACL0_2105271235.mat",...
        ]; [w2 y1 y0]=cmbn(a0); y0=zeros(size(y0)); d1=5; [r00 r11]=psf_ETM(y0, y1, w2, d1, STK00); %%step4 psignfit combined
      disp(r00); disp(r11); L0T0g=r00; 

a0=["S10007_ETMp_RightACL0_2105271243.mat",...
        ]; [w2 y1 y0]=cmbn(a0); d1=5; [r00 r11]=psf_ETM(y0, y1, w2, d1, STK00); %%step4 psignfit combined
      disp(r00); disp(r11); L0T0p=r00; L0T1p=r11;



a0=["S10007_ETMw_RightACL0_2105271225.mat",...
        ]; [w2 y1 y0]=cmbn(a0); d1=5; [r00 r11]=psf_ETM(y0, y1, w2, d1, STK00); %%step4 psignfit combined
      disp(r00); disp(r11); L0T0w=r00; L0T1w=r11;


%NHI ACL1
a0=["S10007_ETMg_RightACL1_2105271408.mat",...
        ]; [w2 y1 y0]=cmbn(a0); y0=zeros(size(y0)); d1=5; [r00 r11]=psf_ETM(y0, y1, w2, d1, STK00); %%step4 psignfit combined
      disp(r00); disp(r11); L1T0g=r00; 

a0=["S10007_ETMp_RightACL1_2105271401.mat",...
        ]; [w2 y1 y0]=cmbn(a0); d1=5; [r00 r11]=psf_ETM(y0, y1, w2, d1, STK00); %%step4 psignfit combined
      disp(r00); disp(r11); L1T0p=r00; L1T1p=r11; 



a0=["S10007_ETMw_RightACL1_2105271416.mat",...
        ]; [w2 y1 y0]=cmbn(a0); d1=5; [r00 r11]=psf_ETM(y0, y1, w2, d1, STK00); %%step4 psignfit combined
      disp(r00); disp(r11); L1T0w=r00; L1T1w=r11; 


%% plot histogram with errorbars
r=1, c=3; y =[L0T0g(r,c) L0T0p(r,c) L0T1p(r,c) L0T0w(r,c) L0T1w(r,c) 0 L1T0g(r,c) L1T0p(r,c) L1T1p(r,c) L1T0w(r,c)  L1T1w(r,c)];
r=4; c=2; yL=[L0T0g(r,c) L0T0p(r,c) L0T1p(r,c) L0T0w(r,c) L0T1w(r,c) 0 L1T0g(r,c) L1T0p(r,c) L1T1p(r,c) L1T0w(r,c)  L1T1w(r,c)];%low
r=4; c=3; yH=[L0T0g(r,c) L0T0p(r,c) L0T1p(r,c) L0T0w(r,c) L0T1w(r,c) 0 L1T0g(r,c) L1T0p(r,c) L1T1p(r,c) L1T0w(r,c)  L1T1w(r,c)]; %high    
r=1; c=1; yC=[L0T0g(r,c) L0T0p(r,c) L0T1p(r,c) L0T0w(r,c) L0T1w(r,c) 0 L1T0g(r,c) L1T0p(r,c) L1T1p(r,c) L1T0w(r,c)  L1T1w(r,c)]; %count
x=[1:length(y)];
X = categorical({'A0T0g', 'A0T0p', 'A0T1p', 'A0T0w','A0T1w', '0ACL1', 'A1T0g', 'A1T0p', 'A1T1p', 'A1T0w',  'A1T1w'});
X = reordercats(X,{'A0T0g', 'A0T0p', 'A0T1p', 'A0T0w','A0T1w', '0ACL1', 'A1T0g', 'A1T0p', 'A1T1p', 'A1T0w',  'A1T1w'});
%Y = [10 21 33 52];

b=bar(X, y);
%% setup bar colors
b.FaceColor = 'flat';
c=[0 1 0]; b.CData(1,:) = c./2; b.CData(7,:) = c;
% c=[1 0 1]; b.CData(2,:) = c./2; b.CData(3,:) = c./2; b.CData(8,:) = c; b.CData(9,:) = c; 
c=[1 0 1]; b.CData(2,:) = 0.25.*c; b.CData(3,:) = 0.5.*c; b.CData(8,:) = 0.75.*c; b.CData(9,:) = c; 
c=[1 1 1]; b.CData(4,:) = 0.25.*c; b.CData(5,:) = 0.5.*c; b.CData(10,:) = 0.75.*c; b.CData(11,:) = c; 



%% set up number of trials at top of bar
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(yC);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');

hold on

er = errorbar(x, y, y-yL, yH-y);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 

hold off







%                    d1=5; [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
                 %d1=5; y0=zeros(size(y0)); [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background