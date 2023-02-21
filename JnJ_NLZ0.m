%220120 JnJ_NLZ new struct file saving
%%LCA
R='S1004V2Right_LCA_ACL0_2203301509.mat'
L='S1004V2Left_LCA_ACL0_2203301516.mat'

R='S1002V2Right_LCA_ACL0_2112211023.mat'
L='S1002V2Left_LCA_ACL0_2112211038.mat'

R='S1002V2Right_LCA_ACL0_2112211023.mat'
L='S1002V2Left_LCA_ACL0_2112211038.mat'

R='S1002V2Right_LCA_ACL0_2204121020.mat'
L='S1002V2Left_LCA_ACL0_2204121028.mat'

load LCAflsL; L=LCAfls{sn-1000,2};
load LCAflsR; R=LCAfls{sn-1000,2};

%x=[468 533 616]; %blue green red
x=[616 533 468]; %red green blue

load(L); mrkL='<';
L0=LCAp.Full.p5(:,1); %chromatic difference of refraction, a14 Before
L1=LCAp.Full.p2(:,1); %mean display focus red green blue
L2=LCAp.Full.p3(:,1); %std  display focus red green blue

load(R);  mrkR='>'
R0=LCAp.Full.p5(:,2); %chromatic difference of refraction, a14 Before
R1=LCAp.Full.p2(:,2); %mean display focus red green blue
R2=LCAp.Full.p3(:,2); %std  display focus red green blue

x=[616 533 468]; %red green blue
eg0=errorbar(x, L1, L2, [mrkL 'c']); %, 'Color', [0 1 0]./cf);
hold on
eg0=errorbar(x, R1, R2, [mrkR 'm']); %, 'Color', [0 1 0]./cf);
xlabel('Wavelength (nm)'); ylabel('Display Focus'); %title('AJR220118 LCA')
 

figure
X = categorical({'Red-Blue','Green-Blue','Red-Green'});
X = reordercats(X,{'Red-Blue','Green-Blue','Red-Green'});

eg0=bar(X, [L0'; R0']); %, 'Color', [0 1 0]./cf);
xlabel('Primers'); ylabel('Chromatic Difference of Refraction (D)'); %title('AJR220118 LCA')


% figure
% eg0=errorbar(x, mean(L0,2), std(L0,0,2)./sqrt(size(L0,2)), [mrkL 'c']); %, 'Color', [0 1 0]./cf);
% hold on
% eg0=errorbar(x, mean(R0,2), std(R0,0,2)./sqrt(size(R0,2)), [mrkR 'm']); %, 'Color', [0 1 0]./cf);
% xlabel('Wavelength (nm)'); ylabel('Chromatic Difference of Refraction (D)'); title('AJR220118 LCA')

%[power_dispL power_dispR powerL powerR rot n4(k0)];
% a11 focus, a13:
%     p4(1,:)=(p2(1,:)-p2(3,:)); % red-blue
%     p4(2,:)=p2(2,:)-p2(3,:); % green-blue
%     p4(3,:)=p2(1,:)-p2(2,:); % red-green
 
 
%%TCA
% ttl='AJR220118TCA'
% L='S1001V5Left_TCA_ACL0_2201181653.mat'
% R='S1001V5Right_TCA_ACL0_2201181647.mat'

ttl='ACL2'
L='S1004V2Left_TCA_ACL1_2203301606.mat'
R='S1004V2Right_TCA_ACL1_2203301528.mat'


L='S1002V4Left_TCA_ACL2_2203310944.mat'
R='S1002V4Right_TCA_ACL2_2203310949.mat'

L='S1002V6Left_TCA_ACL1_2204121050.mat'
R='S1002V6Right_TCA_ACL1_2204121054.mat'

L='S1004V4Left_TCA_ACL2_2204121430.mat'
R='S1004V4Right_TCA_ACL2_2204121434.mat'



L='S1006V3Left_TCA_ACL1_2204201141.mat'
R='S1006V3Right_TCA_ACL1_2204201145.mat'


load TCAflsL; L=TCAfls{sn-1000,vs};
load TCAflsR; R=TCAfls{sn-1000,vs};

c0=0.00384;  c1=1./(c0.*60);

load(L); mrk='<'
    z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
    yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1; rb0=z1(3,2)./c1;
    
    r=2; c=2; xg0 = yx0(r,c); hg0 = sd0(r,c);
    r=3; c=2; xb0 = yx0(r,c); hb0 = sd0(r,c);
    r=2; c=1; yg0 = yx0(r,c); vg0 = sd0(r,c);
    r=3; c=1; yb0 = yx0(r,c); vb0 = sd0(r,c);

eg0=errorbar(xg0, yg0, vg0, vg0, hg0, hg0, [mrk 'g']); %, 'Color', [0 1 0]./cf);
hold on
eb0=errorbar(xb0, yb0, vb0, vb0, hb0, hb0, [mrk 'b']); %, 'Color', [0 0 1]./cf);


load(R); mrk='>'
    z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
    yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1; rb0=z1(3,2)./c1;
    
    r=2; c=2; xg0 = yx0(r,c); hg0 = sd0(r,c);
    r=3; c=2; xb0 = yx0(r,c); hb0 = sd0(r,c);
    r=2; c=1; yg0 = yx0(r,c); vg0 = sd0(r,c);
    r=3; c=1; yb0 = yx0(r,c); vb0 = sd0(r,c);
hold on
eg0=errorbar(xg0, yg0, vg0, vg0, hg0, hg0, [mrk 'g']); %, 'Color', [0 1 0]./cf);
hold on
eb0=errorbar(xb0, yb0, vb0, vb0, hb0, hb0, [mrk 'b']); %, 'Color', [0 0 1]./cf);

if diff(xlim)<diff(ylim);
    lm=xlim;
    xlim([lm(1) lm(1)+diff(ylim)]);
elseif diff(ylim)<diff(xlim);
    lm=ylim;
    ylim([lm(1) lm(1)+diff(xlim)]);
end


lbl('Horizontal TCA (arcmin)', 'Vertical TCA (arcmin)', 'ACL1')



%%ETM tumbling E
%load S10102Binc_ETMw_ACL1_C100_2112211200.mat
%load S1001V2Binc_ETMw_ACL1_C100_2201111608
%load S1001V5Right_ETMw_ACL0_C100_2201181710
load S1002V3Binc_ETMw_ACL2_C100_2203231034
load S1002V3Right_ETMw_ACL2_C100_2203230957
load S1002V2Binc_ETMw_ACL1_C100_2112211200
load S1002V2Right_ETMw_ACL1_C100_2112211218
load S1004V2Right_ETMw_ACL1_C100_2203301545
load S1004V2Binc_ETMw_ACL1_C100_2203301624
load S1002V4Binc_ETMw_ACL2_C100_2203311007
load S1002V4Right_ETMw_ACL2_C100_2203311022

load S1004V3Right_ETMw_ACL0_C100_2204061004
load S1004V3Binc_ETMw_ACL0_C100_2204061019

load S1002V5Right_ETMw_ACL0_C100_2204071028
load S1002V5Binc_ETMw_ACL0_C100_2204071044

load S1002V6Binc_ETMw_ACL1_C100_2204121109
load S1002V6Right_ETMw_ACL1_C100_2204121124

load S1004V4Right_ETMw_ACL2_C100_2204121449
load S1004V4Binc_ETMw_ACL2_C100_2204121503

load S1006V2Binc_ETMw_ACL2_C100_2204131236
load S1006V2Right_ETMw_ACL2_C100_2204131253

load S1004V5Binc_ETMw_ACL2_C100_2204191440
load S1007V2Binc_ETMw_ACL1_C100_2204221102


sn=input('Subject Number? ')
vs=input('Visit Number? ')
ey=input('Binc/Right? ')
load('JnJrand211130', 'TCAm')
c0=TCAm(sn, vs-1);
if ey(1)=='B'
    load ETMflsB.mat; c1=2;
elseif ey(1)=='R'
    load ETMflsR.mat; c1=1;
end
fnm=ETMfls{sn, vs}; load(fnm)


drp=5; w2=ETMp.w2; y0=ETMp.y0; 
y1=ETMp.y1; sz=size(w2)
w2(:,1:drp)=[]; y1(:,1:drp)=[];
v=[]; vL=[]; vH=[];

for k0=1:length(y0)
  d1=hst2(w2(k0,:), y1(k0,:));
  r01=psfe3(y0(k0), y1(k0,:), w2(k0,:));
  r01(1,2)=sz(2); disp(r01)
  v=[v r01(1,4)]; vL=[vL r01(3,3)]; vH=[vH r01(3,4)];
end
%plot(y0, v, '*')
errorbar(y0, v, v-vL, vH-v, '*')
xlabel('Demand')
ylabel('VA (MAR)')
title(fnm)

m=[repmat([sn vs c0 c1], [8 1]) [1:8]' y0' v' vL' vH']
a=repmat(uint32(str2num(fnm(end-9:end))), [8 1])
m=[repmat([sn vs c0 c1], [8 1]) [1:8]' y0' v' vL' vH' repmat(double(a), [8 1])]
xlswrite('tstX.xlsx', m)
m0=xlsread('Sample_VA.xlsx');
% xlswrite('tstX.xlsx', m, 'A10:I18')

xlswrite('sample_VA.xlsx', m, ['A' n2s(size(m0,1)+3) ':I' n2s(size(m0,1)+10)])
xlswrite('sample_VA.xlsx', a, ['J' n2s(size(m0,1)+3) ':J' n2s(size(m0,1)+10)])
copyfile('Sample_VA.xlsx', ['Sample_VA' fnm(end-9:end) '.xlsx'])
%%Autorefractor
%% G:\My Drive\m-wamvideocapture\videos\processed\alwaysrecord_notcp


            %220118 Austin
         load('S1001V5_AFC_BincACL0_2201181746.mat')
         filetext = fileread('2022-01-18 17.36.json');
         
         %220122
         load('S1001V5_AFC_BincACL2_2201211022.mat')
         filetext = fileread('2022-01-21 10.07.json');
         
                  %220124 Daneil Rho
         load('S1001V5_AFC_RightACL0_2201241647.mat')
         filetext = fileread('2022-01-24 16.35.json');
         
                           %220203 Max Green
         load('S1001V5_AFC_RightACL0_2202031313.mat')
         filetext = fileread('2022-02-03 13.00.json');
         
         load('S1002V3_AFC_RightACL2_2203231012.mat')
         filetext = fileread('2022-03-23 09.59.json');
         
         load('S1002V3_AFC_BincACL2_2203231046.mat')
         filetext = fileread('2022-03-23 10.35.json');
         
         load('S1004V2_AFC_RightACL1_2203301559.mat')
         filetext = fileread('2022-03-30 15.46.json');
         
         load('S1004V2_AFC_BincACL1_2203301635.mat')
         filetext = fileread('2022-03-30 16.25.json');
         
         load('S1002V4_AFC_bincACL2_2203310937.mat')
         filetext = fileread('2022-03-31 09.25.json');
         
                  load('S1002V4_AFC_RightACL2_2203311035.mat')
         filetext = fileread('2022-03-31 10.23.json');
         
                           load('S1004V3_AFC_RightACL0_2204060947.mat')
         filetext = fileread('2022-04-06 09.37.json');
         
         load('S1004V3_AFC_BincACL0_2204061030.mat')
         filetext = fileread('2022-04-06 10.20.json');
         
         load('S1002V5_AFC_RightACL0_2204071011.mat');
         filetext = fileread('2022-04-07 09.58.json');
         
         load('S1002V5_AFC_BincACL0_2204071059.mat');
         filetext = fileread('2022-04-07 10.45.json');
         
         load('S1002V6_AFC_BincACL1_2204121042.mat');
         filetext = fileread('2022-04-12 10.27.json');
         
         load('S1002V6_AFC_RightACL1_2204121139.mat');
         filetext = fileread('2022-04-12 11.25.json');
         
         load('S1004V4_AFC_RightACL2_2204121425.mat');
         filetext = fileread('2022-04-12 14.15.json');
         
         load('S1004V4_AFC_BincACL2_2204121515.mat');
         filetext = fileread('2022-04-12 15.04.json');
         
         load('S1006V2_AFC_BincACL2_2204131206.mat');
         filetext = fileread('2022-04-13 11.54.json');
         
         load('S1006V2_AFC_RightACL2_2204131304.mat');
         filetext = fileread('2022-04-13 12.54.json');
         
         load('S1001V2_AFC_BincACL0_2204141439.mat');
         filetext = fileread('2022-04-14 14.23.json');
         
                  load('S1004V5_AFC_BincACL2_2204191423.mat');
         filetext = fileread('2022-04-19 14.13.json');
         
         
         
         sn=input('Subject Number? ')
vs=input('Visit Number? ')
ey=input('Binc/Right? ')
load('JnJrand211130', 'TCAm')
c0=TCAm(sn, vs-1);
if ey(1)=='B'
    load AFCflsB.mat; c1=2;
elseif ey(1)=='R'
    load AFCflsR.mat; c1=1;
end
         fnm=ETMfls{sn, vs}; load(fnm)
         

         [jsonFile,jsonPath] = uigetfile('*.json','' , 'G:\.shortcut-targets-by-id\17-MjlIMJ6eySxBl-1ikM1jyh1UQiX26y\code_repo\JnJ')
         [jsonFile,jsonPath] = uigetfile('*.json','' , 'G:\My Drive\m-wamvideocapture\videos\processed\alwaysrecord_notcp') %stim conputer
         
         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           t3=cell2mat(struct2cell(dt.time_totalsecs))
           v0=[find(diff(t3)>1); length(t3)];
           i0=1;
           for k0=1:length(v0);
               v1=i0:v0(k0);
               x0{k0}=x(v1);
               y0{k0}=y(v1);
               i0=v0(k0)+1;
           end
             
           %i0=find(AFCv==3);
           i0=find(AFCp.v00==0);

           
           x1=[]; y1=[];
           for k0=1:length(i0)
             x1=[x1 x0{i0(k0)}'];
             y1=[y1 y0{i0(k0)}'];  
           end
           
           %x3=[]; y3=[]; v1=[-0.5:0.25:4]; v2=v1(AFCv); v3=[];
           clear x2 y2
           x3=[]; y3=[]; v1=[-0.5:0.25:4]; v2=AFCp.v00; v3=[]; x4=ones(1,19); x5=zeros(length(v1), 4); y5=x5; 

           for k0=1:length(v2)
              x2{k0}=x0{k0}-mean(x1);
              y2{k0}=y0{k0}-mean(y1);
           x3=[x3 x2{k0}'];
           y3=[y3 y2{k0}'];
           v3=[v3 v2(k0).*ones(1,length(x2{k0}))];
           i1=find(v2(k0)==v1)
           x5(i1, x4(i1))=mean(x2{k0}./-3.59);
           y5(i1, x4(i1))=mean(y2{k0}./-3.33);
           x6(k0)=mean(x2{k0}./-3.59);
           y6(k0)=mean(y2{k0}./-3.33);
           x4(i1)=x4(i1)+1;
           
           end
           x3=x3./-3.59; y3=y3./-3.33;
           plot([1:length(x3)], [v3; x3; y3])
           xlabel('Frame'); ylabel('Power (Diopters)'); title('Autorefractor measurement'); legend('Demand', 'Horizontal', 'Vertical')
           
           
           %figure; plot(v1, mean(x5,2))
           figure; errorbar(v1, mean(x5,2), std(x5,0, 2)./sqrt(4))
           hold on;
           errorbar(v1, mean(y5,2), std(y5,0, 2)./sqrt(4))
           xlabel('Demand'); ylabel('Response measured'); legend('Horizontal', 'Vertical') 

           v2' 
           x7=(x6+y6)./2
           
           m=[repmat([sn vs c0 c1], [76 1]) [1:76]' v2' x7' x6' y6']
a=repmat(uint32(str2num(fnm(end-9:end))), [76 1])
m=[repmat([sn vs c0 c1], [8 1]) [1:8]' y0' v' vL' vH' repmat(double(a), [8 1])]
xlswrite('tstX.xlsx', m)
m0=xlsread('Sample_VA.xlsx');
% xlswrite('tstX.xlsx', m, 'A10:I18')

xlswrite('sample_VA.xlsx', m, ['A' n2s(size(m0,1)+3) ':I' n2s(size(m0,1)+10)])
xlswrite('sample_VA.xlsx', a, ['J' n2s(size(m0,1)+3) ':J' n2s(size(m0,1)+10)])
copyfile('Sample_VA.xlsx', ['Sample_VA' fnm(end-9:end) '.xlsx'])
           
           
           figure
           
            %x1=x0./-3.59; y1=y0./-3.33;
           
               
           
           
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 
           
           v0=find(diff(t2)>1)
           v1=[v0 [0; diff(v0)] t2(v0) t2(v0+1)]
           
           diff(find(diff(t2)>1))




%%Autorefractor


            %211112 Max Greene

         
         load('S1001V5_AFC_BincACL0_2201181746.mat')
         filetext = fileread('2022-01-18 17.36.json');

         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 
           diff(find(diff(t2)>2))
           for k0=1:length(v000)
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           t4=circshift(t3(:,1),[-1 0]); t4(end)=length(x); %t3(end, end)
           x0=x; y0=y; a0=zeros(1, length(x0)); k1=1;
%            for k0=1:76
           for k0=1:length(v000)

%                if k0==1;
                x0(k1:t4(k0)-1)=x0(k1:t4(k0)-1)-mean(x0(k1+44:k1+90));
                y0(k1:t4(k0)-1)=y0(k1:t4(k0)-1)-mean(y0(k1+44:k1+90));

%               x0(k1:t3(k0,3)-1)=x0(k1:t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(k1:t3(k0,3)-1)=y0(k1:t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                else
%                x0(t3(k0,1):t3(k0-1,3)-1)=x0(t3(k0-1,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(t3(k0,1):t3(k0-1,3)-1)=y0(t3(k0-1,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                end
%                a0(t3(k0,2):t4(k0)-1)=v000(k0);
                 %a0(k1+[90:180]-1)=v000(k0);
                 a0(k1+90:t4(k0)-1)=v000(k0);
               k1=t4(k0);
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
%            for k0=1:76;
%               x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
%               y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
%            end

          for k0=1:76;
              x2(k0)=mean(x1(t4(k0)-44:t4(k0))); 
              y2(k0)=mean(y1(t4(k0)-44:t4(k0)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           plot([0:length(x1)-1]./30, [x1'; y1'; a0])
                      plot(t2, [x1'; y1'; a0])

           plot([1:length(x1)], [x1'; y1'; a0])
xlabel('Frame'); ylabel('Accommodative response'); legend('Horizontal', 'Vertical', 'Accommodative demand'); title('S2V2MONO')
           x5=[]; y5=[];
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
               x5=[x5; x2(v00==k0)];
               y5=[y5; y2(v00==k0)]; 
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           xlabel('Accommodative Demand'); ylabel('Accommodative response'); title('S2V2MONO')
           ax=axis; axis([min([ax(1) ax(3)]) max([ax(2) ax(4)]) min([ax(1) ax(3)]) max([ax(2) ax(4)])])
           hold on; plot([min([ax(1) ax(3)]) max([ax(2) ax(4)])], [min([ax(1) ax(3)]) max([ax(2) ax(4)])], '--k')
           legend('Horizontal','Vertical', 'r=1')





%211223 JnJ_NLZ
%%LCA
R='S10102Right_LCA_ACL0_2112211023.mat'
L='S10102Left_LCA_ACL0_2112211038.mat'
x=[468 533 616]
load(L); mrk='<'
eg0=errorbar(x, mean(a14,2), std(a14,0,2)./sqrt(size(a14,2)), [mrk 'c']); %, 'Color', [0 1 0]./cf);
load(R); mrk='>'
hold on
eg0=errorbar(x, mean(a14,2), std(a14,0,2)./sqrt(size(a14,2)), [mrk 'm']); %, 'Color', [0 1 0]./cf);

 xlabel('Wavelength (nm)'); ylabel('Chromatic Difference of Refraction (D)'); title('S2V2 LCA')

%[power_dispL power_dispR powerL powerR rot n4(k0)];
% a11 focus, a13:
%     p4(1,:)=(p2(1,:)-p2(3,:)); % red-blue
%     p4(2,:)=p2(2,:)-p2(3,:); % green-blue
%     p4(3,:)=p2(1,:)-p2(2,:); % red-green
 
 
%%TCA
ttl='s2v2'
L='S10102Left_TCA_ACL1_2112211057.mat'
R='S10102Right_TCA_ACL1_2112211104.mat'

c0=0.00384;  c1=1./(c0.*60);

load(L); mrk='<'
    z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
    yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1; rb0=z1(3,2)./c1;
    
    r=2; c=2; xg0 = yx0(r,c); hg0 = sd0(r,c);
    r=3; c=2; xb0 = yx0(r,c); hb0 = sd0(r,c);
    r=2; c=1; yg0 = yx0(r,c); vg0 = sd0(r,c);
    r=3; c=1; yb0 = yx0(r,c); vb0 = sd0(r,c);

eg0=errorbar(xg0, yg0, vg0, vg0, hg0, hg0, [mrk 'g']); %, 'Color', [0 1 0]./cf);
hold on
eb0=errorbar(xb0, yb0, vb0, vb0, hb0, hb0, [mrk 'b']); %, 'Color', [0 0 1]./cf);


load(R); mrk='>'
    z0=TCAp.sysTCA; z1=TCAp.sbjTCA; z2=TCAp.stdTCA;
    yx0=-1.*(z1-z0)./c1; yz0=z0./c1; sd0=z2./c1; rb0=z1(3,2)./c1;
    
    r=2; c=2; xg0 = yx0(r,c); hg0 = sd0(r,c);
    r=3; c=2; xb0 = yx0(r,c); hb0 = sd0(r,c);
    r=2; c=1; yg0 = yx0(r,c); vg0 = sd0(r,c);
    r=3; c=1; yb0 = yx0(r,c); vb0 = sd0(r,c);
hold on
eg0=errorbar(xg0, yg0, vg0, vg0, hg0, hg0, [mrk 'g']); %, 'Color', [0 1 0]./cf);
hold on
eb0=errorbar(xb0, yb0, vb0, vb0, hb0, hb0, [mrk 'b']); %, 'Color', [0 0 1]./cf);

if diff(xlim)<diff(ylim);
    lm=xlim;
    xlim([lm(1) lm(1)+diff(ylim)]);
elseif diff(ylim)<diff(xlim);
    lm=ylim;
    ylim([lm(1) lm(1)+diff(xlim)]);
end


lbl('Horizontal TCA (arcmin)', 'Vertical TCA (arcmin)', ttl)



%%ETM tumbling E
%load S10102Binc_ETMw_ACL1_C100_2112211200.mat
load S1001V2Binc_ETMw_ACL1_C100_2201111608
drp=5; sz=size(w2)
w2(:,1:drp)=[]; y1(:,1:drp)=[];

for k0=1:length(y0)
  d1=hst2(w2(k0,:), y1(k0,:));
  r01=psfe3(y0(k0), y1(k0,:), w2(k0,:));
  r01(1,2)=sz(2); disp(r01)
end


%%Autorefractor


            %211112 Max Greene
         load('S10102_AFC_BincACL1_2112211123.mat')
         filetext = fileread('2021-12-21 11.10.json');
         
         load('S10102_AFC_RightACL1_2112211138.mat')
         filetext = fileread('2021-12-21 11.25.json');

         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:length(v000)
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           t4=circshift(t3(:,1),[-1 0]); t4(end)=length(x); %t3(end, end)
           x0=x; y0=y; a0=zeros(1, length(x0)); k1=1;
%            for k0=1:76
           for k0=1:length(v000)

%                if k0==1;
                x0(k1:t4(k0)-1)=x0(k1:t4(k0)-1)-mean(x0(k1+44:k1+90));
                y0(k1:t4(k0)-1)=y0(k1:t4(k0)-1)-mean(y0(k1+44:k1+90));

%               x0(k1:t3(k0,3)-1)=x0(k1:t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(k1:t3(k0,3)-1)=y0(k1:t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                else
%                x0(t3(k0,1):t3(k0-1,3)-1)=x0(t3(k0-1,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(t3(k0,1):t3(k0-1,3)-1)=y0(t3(k0-1,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                end
%                a0(t3(k0,2):t4(k0)-1)=v000(k0);
                 %a0(k1+[90:180]-1)=v000(k0);
                 a0(k1+90:t4(k0)-1)=v000(k0);
               k1=t4(k0);
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
%            for k0=1:76;
%               x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
%               y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
%            end

          for k0=1:76;
              x2(k0)=mean(x1(t4(k0)-44:t4(k0))); 
              y2(k0)=mean(y1(t4(k0)-44:t4(k0)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           plot([0:length(x1)-1]./30, [x1'; y1'; a0])
                      plot(t2, [x1'; y1'; a0])

           plot([1:length(x1)], [x1'; y1'; a0])
xlabel('Frame'); ylabel('Accommodative response'); legend('Horizontal', 'Vertical', 'Accommodative demand'); title('S2V2MONO')
           x5=[]; y5=[];
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
               x5=[x5; x2(v00==k0)];
               y5=[y5; y2(v00==k0)]; 
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           xlabel('Accommodative Demand'); ylabel('Accommodative response'); title('S2V2MONO')
           ax=axis; axis([min([ax(1) ax(3)]) max([ax(2) ax(4)]) min([ax(1) ax(3)]) max([ax(2) ax(4)])])
           hold on; plot([min([ax(1) ax(3)]) max([ax(2) ax(4)])], [min([ax(1) ax(3)]) max([ax(2) ax(4)])], '--k')
           legend('Horizontal','Vertical', 'r=1')

v000=v0(v00); v000'
[(x2+y2)./2]'
(x)

  
  